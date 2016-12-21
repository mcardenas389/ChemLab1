<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Labs.lab0_1Checks" %>
<%@ page import="Labs.GradeLogistics" %>
<%@ page import="Labs.Helper" %>
<%@ page import="Labs.DataLoader" %>
<%@ page import="blackboard.platform.context.Context" %>
<%@ page import="blackboard.platform.context.ContextManager" %>
<%@ page import="blackboard.platform.context.ContextManagerFactory" %>
<%@ page import="blackboard.data.user.User" %>
<%@ page import="blackboard.data.course.*" %>
<%@ page import="blackboard.persist.course.*" %>
<%@ page import="blackboard.platform.persistence.PersistenceService" %>
<%@ page import="blackboard.platform.persistence.PersistenceServiceFactory" %>
<%@ page import="blackboard.persist.BbPersistenceManager"%>
 <%@ page import="blackboard.persist.*"%>
 
<%@ page import="blackboard.data.gradebook.Lineitem" %>
<%@ page import="blackboard.persist.gradebook.LineitemDbPersister" %>
 
 <%@ taglib uri="/bbUI" prefix="bbUI" %> 
 <%@ taglib uri="/bbData" prefix="bbData"%> 
 <%@ taglib uri="/bbNG" prefix="bbNG"%>
 <bbNG:learningSystemPage 
	title="LAB 1"
	ctxId="ctx">

	<bbNG:pageHeader>
		<bbNG:breadcrumbBar environment="COURSE"
			navItem="ycdb-chem109-nav-LabDebug" >
				<bbNG:breadcrumb title="Home" href="lab0_1i.jsp?course_id=@X@course.pk_string@X@&user_id=@X@user.pk_string@X@" />
			<bbNG:breadcrumb> Lab 1 </bbNG:breadcrumb>
		</bbNG:breadcrumbBar>
		<bbNG:pageTitleBar>
			Welcome to Chem 109 Lab 1
		</bbNG:pageTitleBar>
	</bbNG:pageHeader>


<!DOCTYPE html>

 <%
	int dataX = 12;
 	int dataY = 3;
  	User u = ctx.getUser();
 	String userid = "";
 	DataLoader loader = new DataLoader();
	lab0_1Checks checks;
	Helper h = new Helper();
  	String courseid = request.getParameter("course_id");
  	String button = null;
  	String tableName = "ycdb_lab_data";
	
  	CourseMembership crsMembership = null;
	CourseMembershipDbLoader crsMembershipLoader = null;
	PersistenceService bbPm = PersistenceServiceFactory.getInstance() ;
    BbPersistenceManager bpManager = bbPm.getDbPersistenceManager();
 
	String errMsg = null;
	crsMembershipLoader = (CourseMembershipDbLoader)bpManager.getLoader(CourseMembershipDbLoader.TYPE);
	
	try {
		crsMembership = crsMembershipLoader.loadByCourseAndUserId(ctx.getCourse().getId(), u.getId());
	} catch (KeyNotFoundException e) {
			// There is no membership record.
			errMsg = "There is no membership record. Better check this out:" + e;
	} catch (PersistenceException pe) {
			// There is no membership record.
			errMsg = "An error occured while loading the User. Better check this out:" + pe;
	}
	
	CourseMembership.Role crsMembershipRole = crsMembership.getRole();
	 
 	if (crsMembershipRole == CourseMembership.Role.INSTRUCTOR)
	{
 		String cid = request.getParameter("courseMembershipId");
 		userid = h.getUserId(ctx, cid);	 	
	}
	else
	{
		userid = u.getId().toExternalString();
    }
 	
 	//load lab data to be used to populate the form
 	String[] labData = loader.loadData(tableName, 1, userid, courseid);
 	String[][] data = h.convertTo2DArray(dataX, dataY, labData[0]);
 	String[][] isCorrect = h.convertTo2DArray(dataX, dataY, labData[1]);
 	String[][] error = h.convertTo2DArray(dataX, dataY, labData[2]);
 	String[][] scores = h.convertTo2DArray(dataX + 1, dataY, labData[3]); //dataX + 1 is used in order to include the total score
 	String[][] key = h.convertTo2DArray(dataX, dataY, labData[4]);
 %>
 
<html>
    <head>
    	<title>
            Lab 1: Weighing Measurements: The Balance
    	</title>
    	<link rel="stylesheet" href="labs_css.css">
    </head>
    <body>
    <p>User Information</p>  
  	<p style="margin-left:10px">
   			Student Id: <%= userid%> <br />   
   	</p>    
    	<fieldset class="fieldset-auto-width">
            <legend>Lab 1: Weighing Measurements: The Balance</legend>
            <%
	            
            %>
        
            <fieldset>
                <legend>Basic info</legend>
                <table>
                    <tr>
                        <th>
                            Unknown number of metal rod:
                        </th>
                        <th>
                            <%=data[0][0]%>
                        </th>
                    </tr>
                    <tr>
                        <th>
                        </th>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[0][0] != "") 
                                	{
                                		out.print(error[0][0] + " " + isCorrect[0][0]);
                                	} 
                                %>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            Unknown number of metal wire:
                        </th>
                        <th>
                            <%=data[1][0]%>
                        </th>
                    </tr>
                    <tr>
                        <th>
                        </th>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[1][0] != "") 
                                	{
                                		out.print(error[1][0] + " " + isCorrect[1][0]);
                                	} 
                                %>
                            </div>
                        </td>
                    </tr>
                </table>
            </fieldset>
            <br>
            <fieldset>
                <legend>I. DATA</legend>
		<table>
                    <tr>
                        <th>
                        </th>
                        <th>
                            Weight
                        </th>
                        <th>
                            Unit
                        </th>
                        <th>
                            Num of Sig Fig
                        </th>
                    </tr>
                    <tr>
                        <td>
                        <b>Quadruple beam balance</b>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Metal rod
                        </td>
                        <td>
                            <%=data[2][0]%>
                        </td>
                        <td>
                            <%=data[2][1]%>
                        </td>
                        <td>
                            <%=data[2][2]%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[2][0] != "") 
                                	{
                                		out.print(error[2][0] + " " + scores[2][0] + " " + isCorrect[2][0]);
                                	} 
                                %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[2][1] != "") 
                                	{
                                		out.print(error[2][1] + " " + scores[2][1] + " " + isCorrect[2][1]);
                                	} 
                                %>
                            </div>
                            <div style="color: green" >
                            </div>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[2][2] != "") 
                                	{
                                		out.print(error[2][2] + " " + scores[2][2] + " " + isCorrect[2][2]);
                                	} 
                                %>
                            </div>
                            <div style="color: green" >
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Vial + Sodium chloride
                        </td>
                        <td>
                            <%=data[3][0]%>
                        </td>
                        <td>
                            <%=data[3][1]%>"
                        </td>
                        <td>
                            <%=data[3][2]%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[3][0] != "") 
                                	{
                                		out.print(error[3][0] + " " + scores[3][0] + " " + isCorrect[3][0]);
                                	} 
                                %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[3][1] != "") 
                                	{
                                		out.print(error[3][1] + " " + scores[3][1] + " " + isCorrect[3][1]);
                                	} 
                                %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[3][2] != "") 
                                	{
                                		out.print(error[3][2] + " " + scores[3][2] + " " + isCorrect[3][2]);
                                	} 
                                %>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b>Analytical balance</b>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Metal rod
                        </td>
                        <td>
                            <%=data[4][0]%>
                        </td>
                        <td>
                            <%=data[4][1]%>"
                        </td>
                        <td>
                            <%=data[4][2]%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[4][0] != "") 
                                	{
                                		out.print(error[4][0] + " " + scores[4][0] + " " + isCorrect[4][0]);
                                	} 
                                %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[4][1] != "") 
                                	{
                                		out.print(error[4][1] + " " + scores[4][1] + " " + isCorrect[4][1]);
                                	} 
                                %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[4][2] != "") 
                                	{
                                		out.print(error[4][2] + " " + scores[4][2] + " " + isCorrect[4][2]);
                                	} 
                                %>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Metal wire - Trial 1
                        </td>
                        <td>
                            <%=data[5][0]%>
                        </td>
                        <td>
                            <%=data[5][1]%>
                        </td>
                        <td>
                            <%=data[5][2]%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[5][0] != "") 
                                	{
                                		out.print(error[5][0] + " " + scores[5][0] + " " + isCorrect[5][0]);
                                	} 
                                %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[5][1] != "") 
                                	{
                                		out.print(error[5][1] + " " + scores[5][1] + " " + isCorrect[5][1]);
                                	} 
                                %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[5][2] != "") 
                                	{
                                		out.print(error[5][2] + " " + scores[5][2] + " " + isCorrect[5][2]);
                                	} 
                                %>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Trial 2
                        </td>
                        <td>
                            <%=data[6][0]%>
                        </td>
                        <td>
                            <%=data[6][1]%>
                        </td>
                        <td>
                            <%=data[6][2]%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[6][0] != "") 
                                	{
                                		out.print(error[6][0] + " " + scores[6][0] + " " + isCorrect[6][0]);
                                	} 
                                %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[6][1] != "") 
                                	{
                                		out.print(error[6][1] + " " + scores[6][1] + " " + isCorrect[6][1]);
                                	} 
                                %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[6][2] != "") 
                                	{
                                		out.print(error[6][2] + " " + scores[6][2] + " " + isCorrect[6][2]);
                                	} 
                                %>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Trial 3
			</td>
			<td>
                            <%=data[7][0]%>
                        </td>
                        <td>
                            <%=data[7][1]%>
                        </td>
                        <td>
                            <%=data[7][2]%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[7][0] != "") 
                                	{
                                		out.print(error[7][0] + " " + scores[7][0] + " " + isCorrect[7][0]);
                                	} 
                                %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[7][1] != "") 
                                	{
                                		out.print(error[7][1] + " " + scores[7][1] + " " + isCorrect[7][1]);
                                	} 
                                %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[7][2] != "") 
                                	{
                                		out.print(error[7][2] + " " + scores[7][2] + " " + isCorrect[7][2]);
                                	} 
                                %>
                            </div>
                        </td>
                    </tr>
                    <tr>
			<td>
                            Weighing paper and sodium chloride
			</td>
			<td>
                            <%=data[8][0]%>
                        </td>
                        <td>
                            <%=data[8][1]%>
                        </td>
                        <td>
                            <%=data[8][2]%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[8][0] != "") 
                                	{
                                		out.print(error[8][0] + " " + scores[8][0] + " " + isCorrect[8][0]);
                                	} 
                                %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[8][1] != "") 
                                	{
                                		out.print(error[8][1] + " " + scores[8][1] + " " + isCorrect[8][1]);
                                	} 
                                %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[8][2] != "") 
                                	{
                                		out.print(error[8][2] + " " + scores[8][2] + " " + isCorrect[8][2]);
                                	} 
                                %>
                            </div>
                        </td>
                    </tr>
                    <tr>
			<td>
                            Weighing paper
			</td>
			<td>
                            <%=data[9][0]%>
                        </td>
                        <td>
                            <%=data[9][1]%>
                        </td>
                        <td>
                            <%=data[9][2]%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[9][0] != "") 
                                	{
                                		out.print(error[9][0] + " " + scores[9][0] + " " + isCorrect[9][0]);
                                	} 
                                %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[9][1] != "") 
                                	{
                                		out.print(error[9][1] + " " + scores[9][1] + " " + isCorrect[9][1]);
                                	} 
                                %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[9][2] != "") 
                                	{
                                		out.print(error[9][2] + " " + scores[9][2] + " " + isCorrect[9][2]);
                                	} 
                                %>
                            </div>
                        </td>
                    </tr>
                    
		</table>
            </fieldset>
            <br>
            <fieldset>
                <legend>II. RESULTS</legend>
                <table>
                    <tr>
                        <th>
                        </th>
                        <th>
                            Weight
                        </th>
                        <th>
                            Unit
                        </th>
                        <th>
                            Num of Sig Fig
                        </th>
                    	</tr>
                        <tr>
                        <td>
                            Average weight of metal wire
                        </td>
                        <td>
                            <%=data[10][0]%>
                        </td>
                        <td>
                            <%=data[10][1]%>
                        </td>
                        <td>
                            <%=data[10][2]%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[10][0] != "") 
                                	{
                                		out.print(error[10][0] + " " + scores[10][0] + " " + isCorrect[10][0]);
                                	} 
                                %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[10][1] != "") 
                                	{
                                		out.print(error[10][1] + " " + scores[10][1] + " " + isCorrect[10][1]);
                                	} 
                                %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[10][2] != "") 
                                	{
                                		out.print(error[10][2] + " " + scores[10][2] + " " + isCorrect[10][2]);
                                	} 
                                %>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Weight of sodium chloride sample 
                            <br>
                            removed from vial 
                        </td>
			<td>
                            <%=data[11][0]%>
                        </td>
                        <td>
                            <%=data[11][1]%>
                        </td>
                        <td>
                            <%=data[11][2]%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[11][0] != "") 
                                	{
                                		out.print(error[11][0] + " " + scores[11][0] + " " + isCorrect[11][0]);
                                	} 
                                %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[11][1] != "") 
                                	{
                                		out.print(error[11][1] + " " + scores[11][1] + " " + isCorrect[11][1]);
                                	} 
                                %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[11][2] != "") 
                                	{
                                		out.print(error[11][2] + " " + scores[11][2] + " " + isCorrect[11][2]);
                                	} 
                                %>
                            </div>
                        </td>
                    </tr>
 		</table>
 		<br>
        <p> 
        Total Score: <%=scores[dataX+1][0]%> 
        </p>
            </fieldset>
            <br>
            <table>
	            <tr>
	            	<td></td>
		            <td style="width:50%">
		            	<div style="text-align: center" id="btns">
                			
                			<p>Instructor View [Test Page]</p>
            			</div>
		            </td>
		            <td></td>
	            </tr>     
            </table>
            <br>
        </fieldset>
    <br>
    </body>
</html>
</bbNG:learningSystemPage>