/**
 * 
 */

package Labs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.Calendar;
import java.util.List;
import java.util.ListIterator;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import blackboard.data.ValidationException;
import blackboard.data.course.CourseMembership;
import blackboard.data.gradebook.Lineitem;
import blackboard.data.gradebook.Lineitem.AssessmentLocation;
import blackboard.data.gradebook.Score;
import blackboard.data.gradebook.impl.Attempt;
import blackboard.data.gradebook.impl.Outcome;
import blackboard.persist.gradebook.ext.AttemptDbPersister;
import blackboard.persist.gradebook.impl.AttemptDbLoader;
import blackboard.db.BbDatabase;
import blackboard.db.ConnectionManager;
import blackboard.db.ConnectionNotAvailableException;
import blackboard.persist.BbPersistenceManager;
import blackboard.persist.Id;
import blackboard.persist.KeyNotFoundException;
import blackboard.persist.PersistenceException;
import blackboard.persist.gradebook.LineitemDbLoader;
import blackboard.persist.gradebook.LineitemDbPersister;
import blackboard.persist.gradebook.ScoreDbLoader;
import blackboard.persist.gradebook.ScoreDbPersister;
import blackboard.platform.context.Context;
import blackboard.platform.persistence.PersistenceService;
import blackboard.platform.persistence.PersistenceServiceFactory;
import blackboard.platform.plugin.PlugInUtil;

/**
 * @author SJ
 *
 */
 public class GradeLogistics 
 {
	private static final Logger LOGGER = LoggerFactory.getLogger(GradeLogistics.class.getName());

	public GradeLogistics()
	{

	}

	//delete an entire table
	// Use this function only if you know what you are doing
	public void delete(String tableName)
	{
		ConnectionManager cManager = null;
		Connection conn = null;

		try
		{
			cManager = BbDatabase.getDefaultInstance().getConnectionManager();
			conn = cManager.getConnection();
			StringBuffer queryString = new StringBuffer("");
			
			queryString.append("DROP TABLE " + tableName + " PURGE");

			PreparedStatement deleteQuery = conn.prepareStatement(queryString
					.toString());
			
			deleteQuery.executeUpdate();
			
			PreparedStatement deleteSeq = conn
					.prepareStatement("DROP SEQUENCE " + tableName + "_seq");
			
			deleteSeq.executeUpdate();

			LOGGER.info("dropped all tables");
		} 
		catch(java.sql.SQLException sE) 
		{
			LOGGER.error(sE.getMessage());
			sE.printStackTrace();
		}
		catch(ConnectionNotAvailableException cE) 
		{
			LOGGER.error(cE.getMessage());
			cE.printStackTrace();
		}
		finally
		{
			if (conn != null)
			{
				cManager.releaseConnection(conn);
			}
		}
	}

	//commented out because it is not supported in the database
	//creates a trigger in the table that creates a new primary key when a new insert occurs
	/*
	public void createTrigger(String tableName) 
	{
		ConnectionManager cManager = null;
		Connection conn = null;

		try 
		{
			cManager = BbDatabase.getDefaultInstance().getConnectionManager();
			conn = cManager.getConnection();
			StringBuffer queryString = new StringBuffer("");
			/*
			 * queryString.append("CREATE OR REPLACE TRIGGER  " + labname +
			 * "_trig BEFORE INSERT ON " + labname +
			 * " FOR EACH ROW WHEN (new.pk1 IS NULL) ");
			 * queryString.append("BEGIN SELECT " + labname +
			 * "_seq.NEXTVAL INTO :new.pk1 FROM dual; END;" +
			 * "	 / ALTER TRIGGER " + labname + "_trig ENABLE" );
			 *
			queryString.append("CREATE OR REPLACE TRIGGER  " + tableName
					+ "_trig BEFORE INSERT ON " + tableName + " FOR EACH ROW ");
			queryString.append("BEGIN :new.pk1 := " + tableName
					+ "_seq.nextval;  END;" + "	 / ALTER TRIGGER " + tableName
					+ "_trig ENABLE");

			LOGGER.info(queryString.toString());
			Statement trigQuery = conn.createStatement();
			trigQuery.executeQuery(queryString.toString());
			LOGGER.info("make trigger " + tableName);

		} 
		catch(java.sql.SQLException sE) 
		{
			LOGGER.error(sE.getMessage());
			sE.printStackTrace();

		}
		catch(ConnectionNotAvailableException cE)
		{
			LOGGER.error(cE.getMessage());
			cE.printStackTrace();

		}
		finally
		{
			if(conn != null) 
			{
				cManager.releaseConnection(conn);
			}
		}
	}
	*/

	//initializes by loading the course membership
	public void initGradeLogistics(Context ctx, String tableName, String labComment, int labNumber)
	{
		Helper h = new Helper();
		loadCourseMembership(ctx, labNumber, h.fetchRoster(ctx), tableName, labComment);
	}

	private void loadCourseMembership(Context ctx, int labNumber,
			List<CourseMembership> roster, String tableName, String labComment)
	{
		ConnectionManager cManager = null;
		Connection conn = null;

		StringBuilder q = new StringBuilder();
		String columns;
		
		try
		{
			cManager = BbDatabase.getDefaultInstance().getConnectionManager();
			conn = cManager.getConnection();
			ResultSet rSet = null;
			ResultSetMetaData rsMeta = null;
			int columnCount = 0;
			Helper h = new Helper();

			for(int i = 0; i < roster.size(); ++i)
			{
				String uid = "";
				uid = roster.get(i).getUserId().toExternalString();
				StringBuffer queryString = new StringBuffer("");
				rSet = h.exists(conn, labNumber, uid, ctx.getCourse().getId().toExternalString(), 
						tableName);
				rsMeta = rSet.getMetaData();

				if(!(rSet.next())) //user id not found
				{
					LOGGER.info("Did not find userid " + uid);
					int pk1 = h.nextVal(tableName);
					queryString.append("INSERT INTO " + tableName + " ( ");
					columns = h.buildColumnString(rsMeta).toString();

					queryString.append(columns + " ) " + "VALUES ( ");
					// String pk = labname.trim()+"_seq.nextval";
					// queryString.append(pk);

					columnCount = rsMeta.getColumnCount();
					q = h.qMarks(columnCount, 0);// Start from 0 or 1
					
					queryString.append(q);					
					LOGGER.info("INSERT string " + queryString.toString());
					
					PreparedStatement insertQuery = conn.prepareStatement(
							queryString.toString(),
							PreparedStatement.RETURN_GENERATED_KEYS);
					
					insertQuery.setInt(1, pk1);
					insertQuery.setString(2, uid);
					insertQuery.setString(3, ctx.getCourse().getId()
							.toExternalString());
					
					String temp = "0";
					
					for(int j = 4; j <= columnCount; j++)
					{
						insertQuery.setString(j, temp);
					}

					insertQuery.executeUpdate();
					insertQuery.close();

				} 
				else
				{
					StringBuilder debug = new StringBuilder();
					
					for (int j = 1; j < rsMeta.getColumnCount(); ++j)
					{
						debug.append(rSet.getString(j) + ",");
					}

					// LOGGER.info("membership " + debug.toString());
				}
			}
		} 
		catch(java.sql.SQLException sE)
		{
			LOGGER.error(sE.getMessage());
			sE.printStackTrace();
		}
		catch(ConnectionNotAvailableException cE)
		{
			LOGGER.error(cE.getMessage());
			cE.printStackTrace();
		}
		finally
		{
			if(conn != null) 
			{
				cManager.releaseConnection(conn);
			}
		}
	}

	//add a grade column for a lab in the grade center
	public Id makeLineItem(String labComment, String jspname,  int pointsPossible,
			Context ctx) throws KeyNotFoundException, PersistenceException {
		Lineitem assignment = null;
		try {
			String url = PlugInUtil.getUri("ycdb", "LabDebug", jspname); 
			assignment = getLineItem(labComment, ctx.getCourseId());

			if (assignment == null) {
				LOGGER.info("No matching lineitem, create a new one url " + url);
				assignment = new Lineitem();
				assignment.setCourseId(ctx.getCourseId());
				assignment.setName(labComment);
				assignment.setPointsPossible(pointsPossible);
				assignment.setType(labComment);
				assignment.setIsAvailable(true);
				assignment.setDateAdded();
				assignment.setAssessmentId(labComment, AssessmentLocation.EXTERNAL);
				assignment.setAttemptHandlerUrl(url);
				LineitemDbPersister linePersister = LineitemDbPersister.Default
						.getInstance();
				linePersister.persist(assignment);
				 LOGGER.info("LineItem id is " + assignment.getId());

			} else {
 				LOGGER.info("Found lineItem " + assignment.getName());

			}
		} catch (Exception e) {
			LOGGER.info(e.getMessage());
			e.printStackTrace();

		}
		if (assignment != null)
			return assignment.getId();
		else
			return null;
	}
	
	//delete a grade column for a lab
	public void deleteLineItem(String labComment, Id courseId)
	{
		Lineitem l = getLineItem(labComment, courseId);
		
		if(l == null)
		{
			LOGGER.info("Cannot find line item");
			return;
		}
			
		try 
		{
			LineitemDbPersister linePersister = LineitemDbPersister.Default.getInstance(); 
			LOGGER.info("Deleting lineitem="+l.getId());
			linePersister.deleteById(l.getId());

		} 
		catch(PersistenceException e)
		{
 			e.printStackTrace();
		}
		
		return;
	}
	
	//get a grade column from the grade center
	public Lineitem getLineItem(String labComment, Id courseId) 
	{
		PersistenceService bpService = PersistenceServiceFactory.getInstance();
 		BbPersistenceManager bpManager = bpService.getDbPersistenceManager();
		LineitemDbLoader loader = null;
		try {
			loader = (LineitemDbLoader) bpManager
					.getLoader(LineitemDbLoader.TYPE);
		} catch (PersistenceException e) {
 			e.printStackTrace();
		}
		
		List<Lineitem> lItems = null;
		try {
			lItems = loader.loadByCourseId(courseId);
		} catch (PersistenceException e) {
 			e.printStackTrace();
		}
 		ListIterator<Lineitem> listIterator = lItems.listIterator();
		Lineitem l = null;
		while (listIterator.hasNext()) {
			l = listIterator.next();
//			 LOGGER.info("lineitem id " + l.getId() );
	//		 LOGGER.info("lineitem assessment id " + l.getAssessmentId());
		//	 LOGGER.info("labname " + labname);
			
			/*
			if (l != null && l.getAssessmentId() != null
					&& l.getAssessmentId().toString().equals(labname))
			{
				return l;
		
			}*/
		}
		return null;
	}

	private CourseMembership getCourseMembership(Context ctx, Id userId)
	{
		// TODO Auto-generated method stub
		return getCourseMembership(ctx,userId.toExternalString());
	}

	private CourseMembership getCourseMembership(Context ctx, String uid)
    {
	   List<CourseMembership> crsMembership; 
	   Helper h = new Helper();
	   crsMembership = h.fetchRoster(ctx);
	   ListIterator<CourseMembership> cList = crsMembership.listIterator();
	   CourseMembership cm = null;
	   while (cList.hasNext()) 
	   {

		   cm = cList.next();
		   if (cm.getUserId().toExternalString()
					.equals(uid))
			{
			  break;
			}
	   }
	   return cm;
    }
	
	//instructor clears student's attempt so that the student can re-submit the lab
	protected void clearAttempt(Context ctx, String uid, 	
			Lineitem lineitem) throws KeyNotFoundException,
			PersistenceException, ValidationException 
	{
		Score s = null;
 	   	CourseMembership cm = getCourseMembership(ctx, uid);
 	   	LOGGER.info("clearStudentAttempt for " + cm.getId().toExternalString() + " lineitem " + lineitem.getId().toExternalString());
 	  
 	   	try { 
 	   		s = ScoreDbLoader.Default.getInstance().loadByCourseMembershipIdAndLineitemId(cm.getId(), lineitem.getId());
 	  
 	   		if (s == null)
 	   		{	
 	   			LOGGER.info("clearStudentAttempt - NO score to clear");
 	   		}
 	   		else
 	   		{
 	   			ScoreDbPersister.Default.getInstance().deleteById(s.getId());
 	   			LOGGER.info("clearedStudentAttempt - success");
 	   		}
 	   	} catch(KeyNotFoundException k) {
 	   		LOGGER.info("clearStudentAttempt - NO score to clear"); 		  
 	   	}	   
	}
	
	//when students submit the lab report, this method is called
	protected void addStudentAttempts(Context ctx, int labNumber, String jspname,
			Lineitem lineitem) throws KeyNotFoundException,
			PersistenceException, ValidationException 
	{
		Score s = null;
  		CourseMembership cm = getCourseMembership(ctx, ctx.getUserId());
		 	
		String url = PlugInUtil.getUri("ycdb", "LabDebug",
				jspname+"?course_id=" + cm.getCourseId().toExternalString() + "&user_id="
				+ cm.getUserId().toExternalString());
	   
		LOGGER.info("addStudentAttempt " + labNumber + " " + url);
	   
		try {
			s = ScoreDbLoader.Default.getInstance().loadByCourseMembershipIdAndLineitemId(cm.getId(), lineitem.getId());
	   
			if (s == null)
			{	
				s = new Score();
				s.setDateAdded();
			}
		} catch(KeyNotFoundException k) {
			s = new Score();
			s.setDateAdded();

		}
			Outcome outcome = s.getOutcome();
			Attempt attempt;

			if (outcome.getAttemptCount() == 0) 
			{
				lineitem.setAttemptHandlerUrl(url);
				lineitem.setAssessmentId("user_id="
						+ ctx.getUser().getId().toExternalString(), Lineitem.AssessmentLocation.EXTERNAL);

				s.setLineitemId(lineitem.getId());
				// LOGGER.info("Course is " + cm.getCourseId());
					 
				s.setCourseMembershipId(cm.getId());

				attempt = outcome.createAttempt();
			
				if (attempt == null) 
				{
					throw new IllegalStateException(
							"could not create attempt");
				}
				
				attempt.setOutcomeId(outcome.getId());

				attempt.setStatus(Attempt.Status.NEEDS_GRADING);
				attempt.setAttemptedDate(Calendar.getInstance());
				s.setAttemptId(attempt.getId().toExternalString(), Score.AttemptLocation.EXTERNAL);
				ScoreDbPersister.Default.getInstance().persist(s);

				AttemptDbPersister.Default.getInstance().persist(attempt);
				LOGGER.info("New attempt created for " + cm.getId().toExternalString());
			} 
			else 
			{
				attempt = AttemptDbLoader.Default.getInstance().loadById(
						outcome.getLastAttemptId());//highest score etc.
				LOGGER.info("Cannot create duplicate attempts");					
			}
	}
}