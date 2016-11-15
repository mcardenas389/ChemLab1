/**
 * Helper.java
 * 
 * A class that contains various functions that are repeatedly used by
 * DataPersister.java and DataLoader.java among other classes.
 * 
 */
package Labs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.List;
import java.util.ListIterator;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import blackboard.data.course.Course;
import blackboard.data.course.CourseMembership;
import blackboard.db.BbDatabase;
import blackboard.db.ConnectionManager;
import blackboard.db.ConnectionNotAvailableException;
import blackboard.persist.BbPersistenceManager;
import blackboard.persist.Id;
import blackboard.persist.KeyNotFoundException;
import blackboard.persist.PersistenceException;
import blackboard.persist.course.CourseMembershipDbLoader;
import blackboard.platform.context.Context;
import blackboard.platform.persistence.PersistenceService;
import blackboard.platform.persistence.PersistenceServiceFactory;

/**
 * @author SJ
 *
 */
public class Helper {
	private static final Logger LOGGER = LoggerFactory.getLogger(Helper.class.getName() );
    
	public Helper()
	{		
		
	}

    //public String getUserIdFromCourseMembershipId(Context ctx, String userId)
    public String getUserID(Context ctx, String userId)
    {
    	String userid = "";
    	Helper h = new Helper();
    	List<CourseMembership> cm_list = h.fetchRoster(ctx);
    	ListIterator<CourseMembership> cList = cm_list.listIterator();
    	while (cList.hasNext()) {
			CourseMembership cm = cList.next();
			if(cm.getId().toExternalString().equals(userId))
			{
				userid = cm.getUserId().toExternalString();
				//LOGGER.info("Match Input=" + userId + " courseMembershipId=" + cm.getId().toExternalString() + " userid=" + userId);
				break;
			}
			//LOGGER.info("No match membership id=" + cm.getId().toExternalString() + " userId=" + userId);

    	}
    	return userid;
    }
    
    //gets roster for the course from a given context and returns the roster as a list
	public List<CourseMembership> fetchRoster(Context ctx) 
	{
		PersistenceService bpService = PersistenceServiceFactory.getInstance();
		BbPersistenceManager bpManager = bpService.getDbPersistenceManager();
		Course courseIdentity = ctx.getCourse();

		// get the course id from the course object
		Id courseId = courseIdentity.getId();

		// get the membership data to determine the User's Role
		List<CourseMembership> crsMembership = null;
		CourseMembershipDbLoader crsMembershipLoader = null;
		String errMsg = null;
		// LOGGER.info("Course name : " + courseName);
		
		try 
		{
			crsMembershipLoader = (CourseMembershipDbLoader) bpManager
					.getLoader(CourseMembershipDbLoader.TYPE);
			
			crsMembership = crsMembershipLoader.loadByCourseId(courseId);
		} 
		catch(KeyNotFoundException e)
		{
			// There is no membership record.
			errMsg = "There is no membership record. Better check this out:" + e;
			
			LOGGER.error(errMsg);
		} 
		catch(PersistenceException pe)
		{
			// There is no membership record.
			errMsg = "An error occured while loading the User. Better check this out:" + pe;
			
			LOGGER.error(errMsg);
		}

		return crsMembership;
	}

	//performs a query to see if a specific row exists within the database
	public ResultSet exists(Connection conn, int labNumber, String userid, String courseid, String tableName)
	{
		StringBuffer queryString = new StringBuffer("");
		PreparedStatement selectQuery = null;
		ResultSet rSet = null;	 		
			 
		queryString.append("SELECT * ");
		queryString.append("FROM ");
		queryString.append(tableName);
		queryString.append(" WHERE user_id = ? AND course_id = ? AND lab_number = ?");
			//LOGGER.info(queryString.toString());
		try
		{
			selectQuery = conn.prepareStatement(queryString.toString(), ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY);			
			selectQuery.setString(1, userid);
			selectQuery.setString(2, courseid);
			selectQuery.setInt(3, labNumber);
			rSet = selectQuery.executeQuery();			
	 	}
		catch(java.sql.SQLException sE)
		{
			LOGGER.info(sE.getMessage());
			sE.printStackTrace();
		}
	    	
	   	return rSet;
	}

	//returns a string of '?' marks to be used in a PreparedStatement
	public StringBuilder qMarks(int length, int start)
	{
		StringBuilder q = new StringBuilder();
		
		for(int i = start; i < length; i++) 
		{
			if(i == length - 1)
			{
				q.append("?)");
			}
			else 
			{
				q.append("?, ");
			}
		}
		
		return q;
	}
		
	//returns a String of the names of all the columns
	public StringBuilder buildColumnString(ResultSetMetaData rsMeta, String except) throws SQLException
	{
 		StringBuilder columns = new StringBuilder();

		int columnCount = rsMeta.getColumnCount();
		
		for (int i = 1; i <= columnCount; i++)
		{
			if(!rsMeta.getColumnName(i).contains(except))
			{
				columns.append(rsMeta.getColumnName(i));
					
				if (i != columnCount)
					columns.append(",");
			}
		}
			
		return columns;
	}

	//returns a String of names of all columns
	//Use this for insert -- 
	public StringBuilder buildColumnString(ResultSetMetaData rsMeta) throws SQLException 
	{
		StringBuilder columns = new StringBuilder();

		int columnCount = rsMeta.getColumnCount();
			
		for(int i = 1; i <= columnCount ; i++)
	    { 
			columns.append(rsMeta.getColumnName(i));
			
			if (i != columnCount)
			{
				columns.append(",");
			}
		}
	          
		return columns;
	}
	
	//returns a String of names of all columns
	//Use this for update -- 
	public StringBuilder buildColumnString(ResultSetMetaData rsMeta, int start) throws SQLException 
	{
		StringBuilder columns = new StringBuilder();
		int columnCount = rsMeta.getColumnCount();
			
		for(int i = start; i <= columnCount ; i++)
	    { 
			columns.append(rsMeta.getColumnName(i));
			
			if (i != columnCount)
			{
				columns.append("=?,");
			}
		}
		
		columns.append("=?");
	          
		return columns;
	}

	//gets the next value for the primary key in the table
   public int nextVal(String tableName)
   {
	   ConnectionManager cManager = null;
	   Connection conn = null;
	   //int value = 101;
	   int value = 0;
	   
	   try 
	   {
		   cManager = BbDatabase.getDefaultInstance().getConnectionManager();
		   conn = cManager.getConnection();
		   StringBuffer queryString = new StringBuffer("");
		   queryString.append("SELECT " + tableName + "_seq.nextval FROM dual");
		   //queryString.append("SELECT MAX(pk1) FROM " + tableName);

		   PreparedStatement query = conn.prepareStatement(queryString.toString());
		   ResultSet rs = query.executeQuery();
		   
		   if(rs.next())
			   value = rs.getInt(1) + 1;
	              
		   LOGGER.info("query executed value is " + value);
	   }
	   catch (java.sql.SQLException sE) {
		   LOGGER.error( sE.getMessage());
		   sE.printStackTrace();
		        		
	   } catch (ConnectionNotAvailableException cE){
		                	
		   LOGGER.error( cE.getMessage() );
		   cE.printStackTrace();
		           
	   } finally {
		   if(conn != null){
			   cManager.releaseConnection(conn);
		   }
	   }
			   
	   return value;
   }
   
   //converts a comma delimited string into a 2D array
   public String[][] convertTo2DArray(int x, int y, String inData)
   {
	   int k = 0;
	   String str = "";
	   String[][] data = new String[x][y];
	   
	   for(int i = 0; i < x; i++)
	   {
		   for(int j = 0; j < y; j++)
		   {
			   while(k != inData.length() && inData.charAt(k) != ',')
			   {
				   str += inData.charAt(k++);
			   }
			   
			   data[i][j] = str;
			   str = "";
			   
			   ++k; //skip over the comma
		   }
	   }
	   
	   return data;
   }
}
