/*
 * DataLoader.java
 * 
 * This class is responsible for loading data from the database.
 * It will either load an entire row derived from a given userid,
 * courseid, and labNumber. Or it will return the saved student
 * data to repopulate the front end, so that it can be completed
 * by the student.
 * 
 */


package Labs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Arrays;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import blackboard.db.ConnectionManager;
import blackboard.db.BbDatabase;
import blackboard.db.ConnectionNotAvailableException;
 
public class DataLoader {
    private static final Logger LOGGER = LoggerFactory.getLogger(DataLoader.class.getName());
	    
	public DataLoader()
    {     
    	
    }
	
	//returns an array of lab data and metadata using given userid, courseid, and labNumber
	//returns null if an exception is thrown
	public String[] loadData(String tableName, int labNumber, String userid, String courseid)
	{
 		StringBuffer queryString = new StringBuffer("");
 		ConnectionManager cManager = null;
		Connection conn = null;
		PreparedStatement selectQuery = null;
		String[] returnData = null;
		
		try {
			cManager = BbDatabase.getDefaultInstance().getConnectionManager();
			conn = cManager.getConnection();
			
			queryString.append("SELECT * ");
			queryString.append("FROM ");
			queryString.append(tableName);
			queryString.append(" WHERE user_id = ? AND course_id = ? AND lab_number = ?");
			LOGGER.info(queryString.toString());
			
			selectQuery = conn.prepareStatement(queryString.toString(), ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY);
			selectQuery.setString(1, userid);
			selectQuery.setString(2, courseid);		
			selectQuery.setInt(3, labNumber);

			ResultSet rSet = selectQuery.executeQuery();
 			//ResultSetMetaData rsMetaData = rSet.getMetaData(); //not necessary
 			
			//LOGGER.info( "column count is: " + rsMetaData.getColumnCount());

			if (rSet.next() && userid == rSet.getString(3)) {
				LOGGER.info("user id is " + userid + " rSet string at 1 is: " + rSet.getString(1));
				//sb = labSpecificFix(rSet, rsMetaData, tableName);
			}
			LOGGER.info("user id is " + userid + " selectQuery is: " + selectQuery.toString());
			
			//data_set, is_correct, error_messages, scores, answers 
			String[] temp = {
				rSet.getString(6), rSet.getString(7), 
				rSet.getString(8), rSet.getString(9), rSet.getString(10) 
			};
			
			returnData = temp;
			
			rSet.close();
			selectQuery.close();
		} catch (java.sql.SQLException sE) {
			
			LOGGER.error("MARKER 1: " + sE.getMessage());
			sE.printStackTrace();
		} catch (ConnectionNotAvailableException cE) {
			
			LOGGER.error("MARKER 2" + cE.getMessage());
		}finally {
			if (conn != null){
				cManager.releaseConnection(conn);
			}
		}
		
		LOGGER.info("returnData " + Arrays.toString(returnData));
		return returnData;
	}

	//returns the saved data for a student's lab that has not yet been submitted
	//returns null if an exception is thrown
	public String restoreLab(String tableName, int labNumber, String userid, String courseid) {
 		StringBuffer queryString = new StringBuffer("");
 		ConnectionManager cManager = null;
		Connection conn = null;
		PreparedStatement selectQuery = null;
		String returnData = null;
		String columnName = "data_set";
		
		try {
			cManager = BbDatabase.getDefaultInstance().getConnectionManager();
			conn = cManager.getConnection();
			
			queryString.append("SELECT " + columnName);
			queryString.append(" FROM ");
			queryString.append(tableName);
			queryString.append(" WHERE user_id = ? AND course_id = ? AND lab_number = ?");
			
			LOGGER.info(queryString.toString());
			
			selectQuery = conn.prepareStatement(queryString.toString(), ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY);
			selectQuery.setString(1, userid);
			selectQuery.setString(2, courseid);		
			selectQuery.setInt(3, labNumber);

			ResultSet rSet = selectQuery.executeQuery();
 			//ResultSetMetaData rsMetaData = rSet.getMetaData();
 			
			//LOGGER.info( "column count is: " + rsMetaData.getColumnCount());

			if (rSet.next() && userid == rSet.getString(3)) {
				LOGGER.info("user id is " + userid + " rSet string at 1 is: " + rSet.getString(1));
				//sb = labSpecificFix(rSet, rsMetaData, tableName);
			}
			LOGGER.info("user id is " + userid + " selectQuery is: " + selectQuery.toString());
			
			returnData = rSet.toString();
			
			rSet.close();
			selectQuery.close();
		} catch (java.sql.SQLException sE) {
			
			LOGGER.error("MARKER 1: " + sE.getMessage());
			sE.printStackTrace();
		} catch (ConnectionNotAvailableException cE) {
			
			LOGGER.error("MARKER 2" + cE.getMessage());
		}finally {
			if (conn != null){
				cManager.releaseConnection(conn);
			}
		}
		
		//returnData = sb.toString();
		LOGGER.info("returnData " + returnData);
		
		return returnData;
	}
	
	/*
	private StringBuilder labSpecificFix(ResultSet rSet,
		ResultSetMetaData rsMetaData, String labname) throws SQLException {
		StringBuilder s = new StringBuilder();
		
		if(labname.contains("ycdb_chemistrylab1"))
		{
			s = lab1Fix(rSet, rsMetaData, labname);
		}
		else if(labname.contains("ycdb_chemistrylab2"))
		{
			s = lab2Fix(rSet, rsMetaData, labname);
		}
		
		return s;		
	}
	
	private StringBuilder lab1Fix(ResultSet rSet, ResultSetMetaData rsMeta, String labname) throws SQLException {
 		StringBuilder sb = new StringBuilder();
		int columnCount = rsMeta.getColumnCount();
		int count = 0;
		for (int j=4; j <= columnCount; j++)
		{
			
			while (count == 1 || count == 2 || count == 4 || count == 5)
			{
				sb.append("null,");
				++count;
 			}
		
			while(rsMeta.getColumnName(j).contains("GRADE"))
				++j;
			if(rSet!=null && rSet.getString(j)!=null)
			{
				sb.append(rSet.getString(j).trim());
			
				LOGGER.info("sb looks like: " + sb.toString());
				++count;
			}
			if (count < 36)
				sb.append(",");
			else
				break;

			++j;
		}
		
		LOGGER.info("loadData returns this " + sb.toString());
		return sb;
	}
	
	//- Input is 1,null,1,null,1,null,1,null,1,null,1,1,1,1,1,1,1,1,1,1,1,null,1,null,1,1,1,1,1,1,0,1,1,null
	private StringBuilder lab2Fix(ResultSet rSet, ResultSetMetaData rsMeta,   String labname) throws SQLException {
 		StringBuilder sb = new StringBuilder();
		int columnCount = rsMeta.getColumnCount();
		int count = 0;
		for (int j=4; j <= columnCount; j++)
		{
			
			while ((count <= 9 && count % 2 == 1)|| count == 21 || count == 23)
			{
				sb.append("null,");
				++count;
 			}
		
			while(rsMeta.getColumnName(j).contains("GRADE"))
				++j;
			if(rSet!=null && rSet.getString(j)!=null)
			{
				sb.append(rSet.getString(j).trim());
			
				LOGGER.info("sb looks like: " + sb.toString());
				++count;
			}
			if (count < 33)
				sb.append(",");
			else if(count == 33)
			{
				sb.append(",null");
				break;
			}
 
			++j;
		}
		LOGGER.info("loadData returns this " + sb.toString());
		return sb;
	}
	*/
}