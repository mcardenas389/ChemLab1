/*
 * DataPersister.java
 * 
 * This class is responsible for storing data into the database
 * that is hosted on Blackboard. 
 */

package Labs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import blackboard.data.ValidationException;
import blackboard.data.gradebook.Lineitem;
import blackboard.db.BbDatabase;
import blackboard.db.ConnectionManager;
import blackboard.db.ConnectionNotAvailableException;
import blackboard.persist.PersistenceException;
import blackboard.platform.context.Context;
 
public class DataPersister {
   
   private static final Logger LOGGER = LoggerFactory.getLogger(DataPersister.class.getName() );
    
   //empty constructor 
   public DataPersister()
   {
 
   }
   
   //when user selects "save" from the front end, the lab data is stored in the database   
   public boolean saveData(String tableName, int labNumber, String userid, String courseid, String inData) 
   {
	   	boolean saveResult = true; //flag that keeps track of data was saved or not
	   	StringBuilder columns = new StringBuilder();
 		StringBuffer queryString = new StringBuffer("");
        ConnectionManager cManager = null;
        Connection conn = null;
        StringBuffer debugString = new StringBuffer("");
        int status = 0; //lab is saved without any data given
        
        LOGGER.info("Input is " + inData);
        
        try 
        {
        	Helper h = new Helper();
            cManager = BbDatabase.getDefaultInstance().getConnectionManager();
            conn = cManager.getConnection(); //establish connection to Blackboard database
            ResultSet rSet = h.exists(conn, labNumber, userid, courseid, tableName);
			ResultSetMetaData rsMeta = rSet.getMetaData();
			int columnCount = rsMeta.getColumnCount();
			
			if(!(rSet.next())) //creates a new entry
            {
            	int pk1 = h.nextVal(tableName);
               	/*
            	//We should never have to insert because the roster should be already uploaded. 
	            queryString.append("INSERT INTO " +  tableName  + " ( ");
	            columns = h.buildColumnString(rsMeta, "GRADES");
	           //Insert blank for PK1
	            queryString.append(columns.toString() + " ) VALUES ( ");      
	            String qmarks = h.qMarks(columnCount,0).toString() ; 
	            
	  //          LOGGER.info(qmarks);
	    			
 	            queryString.append(qmarks);
	            
	//            LOGGER.info(queryString.toString());
	            */
            	
            	columns = h.buildColumnString(rsMeta);
            	queryString.append("INSERT INTO " + tableName + " (" 
            			+ columns.toString() + ") VALUES (");
            	String qmarks = h.qMarks(columnCount,0).toString();
            	queryString.append(qmarks);
            	
	            PreparedStatement insertQuery = conn.prepareStatement(queryString.toString());
	            
	            if(inData != null)
	            {
	            	status = 1; //lab is saved with data
	            }
	            
	            //must be modified if columns are ever altered
	            insertQuery.setInt(1, pk1);
	            insertQuery.setInt(2, labNumber);
	            insertQuery.setString(3, userid);
	            insertQuery.setString(4, courseid);
	            insertQuery.setInt(5, status);
	            insertQuery.setString(6, inData);
	            insertQuery.setString(7, null);
	            insertQuery.setString(8, null);
	            insertQuery.setString(9, null);
	            insertQuery.setString(10, null);
	          	
	            LOGGER.info(insertQuery.toString());
	            
	            int insertResult = insertQuery.executeUpdate();
	            
	            if(insertResult != 1)
	            {	            	
	            	saveResult = false ;	            	
	            }
	            
	            insertQuery.close();
            }
            else //updates all columns for a given row
            {
            	queryString.append("UPDATE " + tableName + " SET ");

            	String nextColumn = "";
            	//LOGGER.info("token size is " + tokens.length);
            	
            	//read all column names in the table starting at "status"
            	for(int j = 5; j <= rsMeta.getColumnCount(); ++j)
                {	 
                	nextColumn = rsMeta.getColumnName(j);
                	
                	queryString.append(nextColumn + " = ?");            
                }
            	
                 //insert where PK1 matches. 
 	            queryString.append(" WHERE " + rsMeta.getColumnName(1) + " = " + rSet.getString(1));

//                 queryString.append(" WHERE " + rsMeta.getColumnName(2) + "= ? AND " + rsMeta.getColumnName(3) + "= ? ");
	        //    LOGGER.info(queryString.toString());
	
				
	            PreparedStatement updateQuery = conn.prepareStatement(queryString.toString());
	            int updateResult = updateQuery.executeUpdate();
	            
	            if(updateResult != 1)
	            {	            	
	            	saveResult = false ;	            	
	            }
	            
	            updateQuery.close();
            	
            }
        } catch (java.sql.SQLException sE) {        	
        	saveResult = false ;

           	LOGGER.error( sE.getMessage());
           	LOGGER.error( debugString.toString());
            
           	sE.printStackTrace();
        } catch (ConnectionNotAvailableException cE) {        	
        	saveResult = false ;
        	
        	LOGGER.error( cE.getMessage() );
            cE.printStackTrace();
        } finally {
            if(conn != null){
                cManager.releaseConnection(conn);
            }
        }
        
        return saveResult;
	}

	public boolean submitGrades (String indata) {
        boolean saveResult = true;
/*		StringBuffer queryString = new StringBuffer("");
		String[] tokens = indata.split(",");
        ConnectionManager cManager = null;
        Connection conn = null;
        String columns = labs.getColumns();
        StringBuilder q = new StringBuilder();
        
        q = qMarks(columns.length()-1);
        
        String qmarks = q.toString();
		LOGGER.info(qmarks);

        try {
            cManager = BbDatabase.getDefaultInstance().getConnectionManager();
            conn = cManager.getConnection();

            queryString.append("INSERT INTO " + labname + " (");
            columns = columns.substring(rsMeta.getColumnName(1).length(), columns.length() );
            queryString.append(columns + " )");

            queryString.append(" VALUES ");
            queryString.append(qmarks);
			LOGGER.info(queryString.toString());

            PreparedStatement insertQuery = conn.prepareStatement(queryString.toString());
            
            for (int i=0; i < tokens.length; i++) {
                insertQuery.setString((i + 1), tokens[i]);
            }          

            int insertResult = insertQuery.executeUpdate();
            
            if(insertResult != 1){
                
            	saveResult = false ;
            	
            }
            
            insertQuery.close();

        } catch (java.sql.SQLException sE){
        	
        	saveResult = false ;
        	
        	LOGGER.error( sE.getMessage());
        	sE.printStackTrace();
        } catch (ConnectionNotAvailableException cE){
        	
        	saveResult = false ;
        	
        	LOGGER.error( cE.getMessage() );
        	cE.printStackTrace();
           
        } finally {
            if(conn != null){
                cManager.releaseConnection(conn);
            }
        }
  */      
		return saveResult;
	}

	//submits lab data and relevant metadata
	public boolean submitData(String tableName, int labNumber, String userid, String courseid, String inData, 
			String isCorrect, String errorMsgs, String scores, String answers)
	{
	   	boolean saveResult = true; //flag that keeps track of data was saved or not
		StringBuilder columns = new StringBuilder();
 		StringBuffer queryString = new StringBuffer("");
        ConnectionManager cManager = null;
        Connection conn = null;
        StringBuffer debugString = new StringBuffer("");
        int status = 2; //user has submitted data for grading
        
        LOGGER.info("Input is " + inData);
        
        try 
        {
        	Helper h = new Helper();
            cManager = BbDatabase.getDefaultInstance().getConnectionManager();
            conn = cManager.getConnection(); //establish connection to Blackboard database
            ResultSet rSet = h.exists(conn, labNumber, userid, courseid, tableName);
			ResultSetMetaData rsMeta = rSet.getMetaData();
			int columnCount = rsMeta.getColumnCount();
			
			if(!(rSet.next())) //creates a new entry
            {
            	int pk1 =  h.nextVal(tableName);

            	columns = h.buildColumnString(rsMeta);
            	queryString.append("INSERT INTO " + tableName + " (" 
            			+ columns.toString() + ") VALUES (");
            	String qmarks = h.qMarks(columnCount,0).toString();
            	queryString.append(qmarks);
            	
	            PreparedStatement insertQuery = conn.prepareStatement(queryString.toString());
	            
	            //must be modified if columns are ever altered
	            insertQuery.setInt(1, pk1);
	            insertQuery.setInt(2, labNumber);
	            insertQuery.setString(3, userid);
	            insertQuery.setString(4, courseid);
	            insertQuery.setInt(5, status);
	            insertQuery.setString(6, inData);
	            insertQuery.setString(7, isCorrect);
	            insertQuery.setString(8, errorMsgs);
	            insertQuery.setString(9, scores);
	            insertQuery.setString(10, answers);
	          	
	            LOGGER.info(insertQuery.toString());
	            
	            int insertResult = insertQuery.executeUpdate();
	            
	            if(insertResult != 1)
	            {	            	
	            	saveResult = false ;	            	
	            }
	            
	            insertQuery.close();
            }
            else //updates saved data for a given row
            {
            	columns = h.buildColumnString(rsMeta, 5);
            	
            	queryString.append("UPDATE " + tableName + " SET ");
            	queryString.append(columns.toString());
            	queryString.append("WHERE ");
            	queryString.append(rsMeta.getColumnName(1) + " = " + rSet.getInt(1)); //insert where the primary key matches          	
            	
 	            PreparedStatement updateQuery = conn.prepareStatement(queryString.toString());
 	            
 	            //must be modified if columns are ever altered
 	            updateQuery.setInt(1, status);
 	            updateQuery.setString(2, inData);
 	            updateQuery.setString(3, isCorrect);
 	            updateQuery.setString(4, errorMsgs);
 	            updateQuery.setString(5, scores);
 	            updateQuery.setString(6, answers);
 	  
	            int updateResult = updateQuery.executeUpdate();
	            
	            if(updateResult != 1)
	            {	            	
	            	saveResult = false ;	            	
	            }
	            
	            updateQuery.close();
            	
            }
        } catch (java.sql.SQLException sE) {        	
        	saveResult = false ;

           	LOGGER.error( sE.getMessage());
           	LOGGER.error( debugString.toString());
            
           	sE.printStackTrace();
        } catch (ConnectionNotAvailableException cE) {        	
        	saveResult = false ;
        	
        	LOGGER.error( cE.getMessage() );
            cE.printStackTrace();
        } finally {
            if(conn != null){
                cManager.releaseConnection(conn);
            }
        }
        
        return saveResult;
	}


	public void submitted(Context ctx, String labname, int labNumber, String jspname)
	{ 		
		GradeLogistics gl = new GradeLogistics();
		Lineitem l = gl.getLineItem(labname, ctx.getCourseId());
		if (l != null)
			try {
				gl.addStudentAttempts(ctx, labNumber, jspname, l);
			} catch (PersistenceException | ValidationException e) {
 				e.printStackTrace();
			}
		else
			LOGGER.error("This should not happen: cant find lineitem for this assignment");		 
	}

	protected void clearAttempt(Context ctx, String userid, String tableName) {
		// TODO Auto-generated method stub
		GradeLogistics gl = new GradeLogistics();
		Lineitem l = gl.getLineItem(tableName, ctx.getCourseId());
		if (l != null)
			try {
				gl.clearAttempt(ctx, userid, l);
			} catch (PersistenceException | ValidationException e) {
 				e.printStackTrace();
			}
		else
			LOGGER.error("This should not happen: cant find lineitem for this assignment");

	}
}