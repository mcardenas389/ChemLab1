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
	title="LAB 2"
	ctxId="ctx">

	<bbNG:pageHeader>
		<bbNG:breadcrumbBar environment="COURSE"
			navItem="ycdb-chem109-nav-LabDebug" >
				<bbNG:breadcrumb title="Home" href="lab0_1i.jsp?course_id=@X@course.pk_string@X@&user_id=@X@user.pk_string@X@" />
			<bbNG:breadcrumb> Lab 2 </bbNG:breadcrumb>
		</bbNG:breadcrumbBar>
		<bbNG:pageTitleBar>
			Welcome to Chem 109 Lab 2
		</bbNG:pageTitleBar>
	</bbNG:pageHeader>


<!DOCTYPE html>

 <%
	int dataX = 12;
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
 	String[] labData = loader.loadData(tableName, 2, userid, courseid);
 	String[][] data = h.convertTo2DArray(dataX, dataY, labData[0]);
 	String[][] isCorrect = h.convertTo2DArray(dataX, dataY, labData[1]);
 	String[][] error = h.convertTo2DArray(dataX, dataY, labData[2]);
 	String[][] scores = h.convertTo2DArray(dataX + 1, dataY, labData[3]); //dataX + 1 is used in order to include the total score
 	String[][] key = h.convertTo2DArray(dataX, dataY, labData[4]);
 %>
 
<html>
	<head>
	</head>
	<body>
		<fieldset class="fieldset-auto-width">
            <legend>Lab 2: Volume Measurements and the Determination of Density</legend>
            <%
	            
            %>
        
            <fieldset>
                <legend>I. DATA</legend>
				<fieldset>
					<legend>A. Determination of the density of an unknown metal</legend>
					<table>							
							<tr>
							</tr>
							<tr>
								<td>
								</td>
								<td>
								</td>
								<td>
								</td>
							</tr>
							<tr>
								<td>
									Unknown Number
								</td>
								<td>
									<%=data[0][0]%>
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
							</tr>
							<th>
							</th>
							<th>Measurement</th>
							<th>Unit</th>
							<tr>
								<td>
									Weight of unknown metal
								</td>
								<td>
									<%=data[1][0]%>
								</td>
								<td>
									<%=data[1][1]%>
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
							</tr>
							<tr>
								<td>
								</td>
								<td>
								</td>
								<td>
								</td>
							</tr>
							<tr>
								<td>
									Initial graduate cylinder reading (without unknown metal)
								</td>
								<td>
									<%=data[2][0]%>
								</td>
								<td>
									<%=data[2][1]%>"
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
											if (error[2][1] != "") 
											{
												out.print(error[2][1] + " " + scores[2][1] + " " + isCorrect[2][1]);
											} 
										%>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									Final graduate cylinder reading (with unknown metal)
								</td>
								<td>
									<%=data[3][0]%>
								</td>
								<td>
									<%=data[3][1]%>
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
												out.print(error[5][0] + " " + scores[3][0] + " " + isCorrect[3][0]);
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
							</tr>
							</table>
					</fieldset>
					<fieldset>					
						<legend>B. Determination of the density of an unkown liquid</legend>
						<table>
							<tr>
								<td>
									Unknown Number
								</td>
								<td>
									<%=data[4][0]%>
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
							</tr>
							<th>
							</th>
							<th>Measurement</th>
							<th>Unit</th>
							<th>
							</th>
							<th>Measurement</th>
							<th>Unit</th>
							<tr>
								<td>
									Initial buret reading
					</td>
					<td>
									<%=data[5][0]%>
								</td>
								<td>
									<%=data[5][1]%>
								</td>
								<td>
									Weight of beaker
								</td>
								<td>
									<%=data[10][0]%>
								</td>
								<td>
									<%=data[10][1]%>
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
							</tr>
							<tr>
					<td>
									Buret reading after 1st liquid sample removed
					</td>
					<td>
									<%=data[6][0]%>
								</td>
								<td>
									<%=data[6][1]%>
								</td>
								<td>
									Weight of beaker + liquid after 1st sample added
								</td>
								<td>
									<%=data[11][0]%>
								</td>
								<td>
									<%=data[11][1]%>
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
												out.print(error[12][1] + " " + scores[12][1] + " " + isCorrect[12][1]);
											} 
										%>
									</div>
								</td>
							</tr>
							<tr>
					<td>
									Buret reading after 2nd liquid sample removed
					</td>
					<td>
									<%=data[7][0]%>
								</td>
								<td>
									<%=data[7][1]%>
								</td>
								<td>
									Weight of beaker + liquid after 2nd sample added
								</td>
								<td>
									<%=data[12][0]%>
								</td>
								<td>
									<%=data[12][1]%>
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
								</td>
								<td>
									<div style="color: red" >
										<% 
											if (error[12][0] != "") 
											{
												out.print(error[12][0] + " " + scores[12][0] + " " + isCorrect[12][0]);
											} 
										%>
									</div>
								</td>
								<td>
									<div style="color: red" >
										<% 
											if (error[12][1] != "") 
											{
												out.print(error[12][1] + " " + scores[12][1] + " " + isCorrect[12][1]);
											} 
										%>
									</div>
								</td>
							</tr>
												<td>
									Buret reading after 3rd liquid sample removed
					</td>
					<td>
									<%=data[8][0]%>
								</td>
								<td>
									<%=data[8][1]%>
								</td>
								<td>
									Weight of beaker + liquid after 3rd sample added
								</td>
								<td>
									<%=data[13][0]%>
								</td>
								<td>
									<%=data[13][1]%>
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
								</td>
								<td>
									<div style="color: red" >
										<% 
											if (error[13][0] != "") 
											{
												out.print(error[13][0] + " " + scores[13][0] + " " + isCorrect[13][0]);
											} 
										%>
									</div>
								</td>
								<td>
									<div style="color: red" >
										<% 
											if (error[13][1] != "") 
											{
												out.print(error[13][1] + " " + scores[13][1] + " " + isCorrect[13][1]);
											} 
										%>
									</div>
								</td>
							</tr>
												<td>
									Buret reading after 4th liquid sample removed
					</td>
					<td>
									<%=data[9][0]%>
								</td>
								<td>
									<%=data[9][1]%>
								</td>
								<td>
									Weight of beaker + liquid after 4th sample added
								</td>
								<td>
									<%=data[14][0]%>
								</td>
								<td>
									<%=data[14][1]%>
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
								</td>
								<td>
									<div style="color: red" >
										<% 
											if (error[14][0] != "") 
											{
												out.print(error[14][0] + " " + scores[14][0] + " " + isCorrect[14][0]);
											} 
										%>
									</div>
								</td>
								<td>
									<div style="color: red" >
										<% 
											if (error[14][1] != "") 
											{
												out.print(error[14][1] + " " + scores[14][1] + " " + isCorrect[14][1]);
											} 
										%>
									</div>
								</td>
							</tr>
							
				</table>
					</fieldset>
			</fieldset>
				<fieldset>
					<legend>II. RESULTS</legend>
					<fieldset>
					<legend>A. Determination of the density of an unknown metal</legend>
					<table>
                    <tr>
                        <th>
                        </th>
                        <th>
                            Measurement
                        </th>
                        <th>
                            Unit
                        </th>
                    	</tr>
                        <tr>
                        <td>
                            Volume of metal
                        </td>
                        <td>
                            <%=data[15][0]%>
                        </td>
                        <td>
                            <%=data[15][1]%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[15][0] != "") 
                                	{
                                		out.print(error[15][0] + " " + scores[15][0] + " " + isCorrect[15][0]);
                                	} 
                                %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[15][1] != "") 
                                	{
                                		out.print(error[15][1] + " " + scores[15][1] + " " + isCorrect[15][1]);
                                	} 
                                %>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Density of metal
                        </td>
			<td>
                            <%=data[16][0]%>
                        </td>
                        <td>
                            <%=data[16][1]%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[16][0] != "") 
                                	{
                                		out.print(error[16][0] + " " + scores[16][0] + " " + isCorrect[16][0]);
                                	} 
                                %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red" >
                                <% 
                                	if (error[16][1] != "") 
                                	{
                                		out.print(error[16][1] + " " + scores[16][1] + " " + isCorrect[16][1]);
                                	} 
                                %>
                            </div>
                        </td>
                    </tr>
 		</table>
					</fieldset>
					<fieldset>
						<legend>B. Determination of the density of an unkown liquid</legend>
						<table>
						<th></th>
						<th>
							Total Volume of <br>
							Liquid in Beaker
						</th>
						<th>Unit</th>
						<th>
							Total Weight of <br>
							Liquid in Beaker
						</th>
						<th>Unit</th>
						<tr>
							<td>After 1st sample added to beaker</td>
							<td><%=data[17][0]%></td>
							<td><%=data[17][1]%></td>
							<td><%=data[21][0]%></td>
							<td><%=data[21][1]%></td>
						</tr>
						<tr>
							<td></td>
							<td>
								<div style="color: red" >
									<% if (error[17][0] != "") { out.print(error[17][0] + " " + scores[17][0] + " " + isCorrect[17][0]); } %>
								</div>
							</td>
							<td>
								<div style="color: red" >
									<% if (error[17][1] != "") { out.print(error[17][1] + " " + scores[17][1] + " " + isCorrect[17][1]); } %>
								</div>
							</td>
							<td>
								<div style="color: red" >
									<% if (error[21][0] != "") { out.print(error[21][0] + " " + scores[21][0] + " " + isCorrect[21][0]); } %>
								</div>
							</td>
							<td>
								<div style="color: red" >
									<% if (error[21][1] != "") { out.print(error[21][1] + " " + scores[21][1] + " " + isCorrect[21][1]); } %>
								</div>
							</td>
						</tr>
						<tr>
							<td>After 2nd sample added to beaker</td>
							<td><%=data[18][0]%></td>
							<td><%=data[18][1]%></td>
							<td><%=data[22][0]%></td>
							<td><%=data[22][1]%></td>
						</tr>
						<tr>
							<td></td>
							<td>
								<div style="color: red" >
									<% if (error[18][0] != "") { out.print(error[18][0] + " " + scores[18][0] + " " + isCorrect[18][0]); } %>
								</div>
							</td>
							<td>
								<div style="color: red" >
									<% if (error[18][1] != "") { out.print(error[18][1] + " " + scores[18][1] + " " + isCorrect[18][1]); } %>
								</div>
							</td>
							<td>
								<div style="color: red" >
									<% if (error[22][0] != "") { out.print(error[22][0] + " " + scores[22][0] + " " + isCorrect[22][0]); } %>
								</div>
							</td>
							<td>
								<div style="color: red" >
									<% if (error[22][1] != "") { out.print(error[22][1] + " " + scores[22][1] + " " + isCorrect[22][1]); } %>
								</div>
							</td>
						</tr>
						<tr>
							<td>After 3rd sample added to beaker</td>
							<td><%=data[19][0]%></td>
							<td><%=data[19][1]%></td>
							<td><%=data[23][0]%></td>
							<td><%=data[23][1]%></td>
						</tr>
						<tr>
							<td></td>
							<td>
								<div style="color: red" >
									<% if (error[19][0] != "") { out.print(error[19][0] + " " + scores[19][0] + " " + isCorrect[19][0]); } %>
								</div>
							</td>
							<td>
								<div style="color: red" >
									<% if (error[19][1] != "") { out.print(error[19][1] + " " + scores[19][1] + " " + isCorrect[19][1]); } %>
								</div>
							</td>
							<td>
								<div style="color: red" >
									<% if (error[23][0] != "") { out.print(error[23][0] + " " + scores[23][0] + " " + isCorrect[23][0]); } %>
								</div>
							</td>
							<td>
								<div style="color: red" >
									<% if (error[23][1] != "") { out.print(error[23][1] + " " + scores[23][1] + " " + isCorrect[23][1]); } %>
								</div>
							</td>
						</tr>
						<tr>
							<td>After 4th sample added to beaker</td>
							<td><%=data[20][0]%></td>
							<td><%=data[20][1]%></td>
							<td><%=data[24][0]%></td>
							<td><%=data[24][1]%></td>
						</tr>
						<tr>
							<td></td>
							<td>
								<div style="color: red" >
									<% if (error[20][0] != "") { out.print(error[20][0] + " " + scores[20][0] + " " + isCorrect[20][0]); } %>
								</div>
							</td>
							<td>
								<div style="color: red" >
									<% if (error[20][1] != "") { out.print(error[20][1] + " " + scores[20][1] + " " + isCorrect[20][1]); } %>
								</div>
							</td>
							<td>
								<div style="color: red" >
									<% if (error[24][0] != "") { out.print(error[24][0] + " " + scores[24][0] + " " + isCorrect[24][0]); } %>
								</div>
							</td>
							<td>
								<div style="color: red" >
									<% if (error[24][1] != "") { out.print(error[24][1] + " " + scores[24][1] + " " + isCorrect[24][1]); } %>
								</div>
							</td>
						</tr>
						<tr>
							<td>Density of unknown liquid</td>
						</tr>
						<tr>
							<td>(slope of the line resulting from the plot of M versus V)</td >
							<td><%=data[25][0]%></td>
							<td><%=data[25][1]%></td>
						</tr>
						<tr>
							<td></td>
							<td>
							<div style="color: red" >
								<% if (error[25][0] != "") { out.print(error[25][0] + " " + scores[25][0] + " " + isCorrect[25][0]); } %>
							</div>
							</td>
							<td>
								<div style="color: red" >
									<% if (error[25][1] != "") { out.print(error[25][1] + " " + scores[25][1] + " " + isCorrect[25][1]); } %>
								</div>
							</td>
						</tr>
						</table>
					</fieldset>
				</fieldset>
			 <p> 
				Total Score: <%=scores[dataX+1][0]%> 
			</p>
		</fieldset>
	</body>
</html>
</bbNG:learningSystemPage>