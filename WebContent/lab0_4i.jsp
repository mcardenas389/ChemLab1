<%@ page contentType="text/html" pageEncoding="UTF-8"%>
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
	title="LAB 4"
	ctxId="ctx">

	<bbNG:pageHeader>
		<bbNG:breadcrumbBar environment="COURSE"
			navItem="ycdb-chem109-nav-LabDebug" >
				<bbNG:breadcrumb title="Home" href="lab0_1i.jsp?course_id=@X@course.pk_string@X@&user_id=@X@user.pk_string@X@" />
			<bbNG:breadcrumb> Lab 4 </bbNG:breadcrumb>
		</bbNG:breadcrumbBar>
		<bbNG:pageTitleBar>
			Welcome to Chem 109 Lab 4
		</bbNG:pageTitleBar>
	</bbNG:pageHeader>


<!DOCTYPE html>

 <%
	int dataX = 4;
 	int dataY = 3;
  	User u = ctx.getUser();
 	String userid = "";
 	DataLoader loader = new DataLoader();
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
 	String[] labData = loader.loadData(tableName, 4, userid, courseid);
 	String[][] data = h.convertTo2DArray(dataX, dataY, labData[0]);
 	String[][] isCorrect = h.convertTo2DArray(dataX, dataY, labData[1]);
 	String[][] error = h.convertTo2DArray(dataX, dataY, labData[2]);
 	String[][] scores = h.convertTo2DArray(dataX + 1, dataY, labData[3]); //dataX + 1 is used in order to include the total score
 	String[][] key = h.convertTo2DArray(dataX, dataY, labData[4]);
 %>
 
<html>
    <head>
        <title>Lab 4: Ionic and Covalent Compounds</title>
        <link rel="stylesheet" href="labs_css.css">
    </head>
    <body>
        <fieldset class="fieldset-auto-width">
            <legend>Lab 4: Ionic and Covalent Compounds</legend>
            <form method="POST" action="lab0_4.jsp">
                <fieldset>
                    <legend>I. DATA and RESULTS</legend>
                    <table>
                        <tr>
                            <th>
                            </th>
                            <th>
                                Color of Solution 
                            </th>
                            <th>
                                Result of Conductivity Test
                            </th>
                            <th>
                                Type of Compound: <br>Ionic or Covalent
                            </th>
                        </tr>
                        <tr>
                            <td>
                                Solution A:
                            </td>
                            <td>
                                <%=data[0][0]%>
                            </td>
                            <td>
                                <%=data[0][1]%>
                            </td>
                            <td>
                                <%=data[0][2]%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <div style="color: red" >
                                    <% 
										if (error[0][0] != "") 
										{
											out.print(error[0][0] + " " + scores[0][0] + " " + isCorrect[0][0]);
										}
									%>
                                </div>
                            </td>
                            <td>
                                <div style="color: red" >
                                    <% 
										if (error[0][1] != "") 
										{
											out.print(error[0][1] + " " + scores[0][1] + " " + isCorrect[0][1]);
										}
									%>
                                </div>
                            </td>
                            <td>
                                <div style="color: red" >
                                    <% 
										if (error[0][2] != "") 
										{
											out.print(error[0][2] + " " + scores[0][2] + " " + isCorrect[0][2]);
										}
									%>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Solution B:
                            </td>
                            <td>
                                <%=data[1][0]%>
                            </td>
                            <td>
                                <%=data[1][1]%>
                            </td>
                            <td>
                                <%=data[1][2]%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <div style="color: red" >
                                    <% 
										if (error[1][0] != "") 
										{
											out.print(error[1][0] + " " + scores[1][0] + " " + isCorrect[1][0]);
										}
									%>
                                </div>
                            </td>
                            <td>
                                <div style="color: red" >
                                    <% 
										if (error[1][1] != "") 
										{
											out.print(error[1][1] + " " + scores[1][1] + " " + isCorrect[1][1]);
										}
									%>
                                </div>
                            </td>
                            <td>
                                <div style="color: red" >
                                    <% 
										if (error[1][2] != "") 
										{
											out.print(error[1][2] + " " + scores[1][2] + " " + isCorrect[1][2]);
										}
									%>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Solution C:
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
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Solution D:
                            </td>
                            <td>
                                <%=data[3][0]%>
                            </td>
                            <td>
                                <%=data[3][1]%>
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
                    </table>
                </fieldset>
            </form>
			<p>Total Score: <%=scores[dataX+1][0]%></p>
        </fieldset>
    </body>
</html>
</bbNG:learningSystemPage>