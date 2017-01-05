<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Labs.lab0_4Checks" %>
<%@ page import="Labs.Helper" %>
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
				<bbNG:breadcrumb title="Home" href="lab0_2.jsp?course_id=@X@course.pk_string@X@&user_id=@X@user.pk_string@X@" />
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
	lab0_4Checks checks;
  	String courseid = request.getParameter("course_id");
  	String tableName = "ycdb_lab_data";
  	int labNumber = 4;

    String button = "";
   	String c = request.getParameter("course_id");
 	
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
 		Helper h = new Helper();
 		userid = h.getUserId(ctx, cid);
 	 	
	}
	else
	{
		userid = u.getId().toExternalString();
	}

	checks = new lab0_4Checks(tableName, dataX, dataY, userid, courseid, labNumber);
	button = request.getParameter("button");
		
    if (button == null)
    {
        button = "";        
    }    
    else 
    {
    	if(button.equals("Save") || button.equals("Check") || button.equals("Submit"))
         {
            for (int i = 0; i < dataX; i++)
            {
                for (int j = 0; j < dataY; j++)
                {
                    checks.setData(i, j, request.getParameter("" + i + j));
                }
            }
        }

        else if (button.equals("Clear"))
        {
            checks.clear();
        }
        
        if (button.equals("Save"))
        {
              
            //perform save
            checks.save(2, userid, courseid);
        }
        else if (button.equals("Check"))
        {
            //get data from form
             
            //perform checks
            checks.gradeLab(labNumber, userid, courseid);
        }
        else if (button.equals("Submit"))
        {
             
            //perform save
            checks.save(labNumber, userid, courseid);
            
            //perform submit
            checks.submit(labNumber, userid, courseid, 100);
        }
        else
        {
            button = "";
        }
    }
 %>
<html>
    <head>
        <title>Lab 4: Ionic and Covalent Compounds</title>
        <link rel="stylesheet" href="labs_css.css">
        <datalist id="color" >
            <option value="clear" >clear</option>	
            <option value="blue" >blue</option>
            <option value="red" >red</option>
            <option value="green" >green</option>
            <option value="opaque" >opaque</option>
            <option value="white" >white</option>
            <option value="black" >black</option>
        </datalist>
        <datalist id="light" >
            <option value="light" >light</option>	
            <option value="no light" >no light</option>
            <option value="dim light" >dim light</option>
        </datalist>
        <datalist id="iorc" >
            <option value="ionic" >ionic</option>	
            <option value="covalent" >covalent</option>
        </datalist>
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
                                <input list="color" name="00" <% if (checks.getData(0,0) != null){out.print("value=\"" + checks.getData(0,0) + "\"");}%> size="10" required/>
                            </td>
                            <td>
                                <input list="light" name="01" <% if (checks.getData(0,1) != null){out.print("value=\"" + checks.getData(0,1) + "\"");}%> size="10" required/>
                            </td>
                            <td>
                                <input list="iorc" name="02" <% if (checks.getData(0,2) != null){out.print("value=\"" + checks.getData(0,2) + "\"");}%> size="10" required/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <div style="color: red" >
                                    <% if (checks.getError(0,0) != null){out.print(checks.getError(0, 0));} %>
                                </div>
                            </td>
                            <td>
                                <div style="color: red" >
                                    <% if (checks.getError(0,1) != null){out.print(checks.getError(0, 1));} %>
                                </div>
                            </td>
                            <td>
                                <div style="color: red" >
                                    <% if (checks.getError(0,2) != null){out.print(checks.getError(0, 2));} %>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Solution B:
                            </td>
                            <td>
                                <input list="color" name="10" <% if (checks.getData(1,0) != null){out.print("value=\"" + checks.getData(1,0) + "\"");}%> size="10" required/>
                            </td>
                            <td>
                                <input list="light" name="11" <% if (checks.getData(1,1) != null){out.print("value=\"" + checks.getData(1,1) + "\"");}%> size="10" required/>
                            </td>
                            <td>
                                <input list="iorc" name="12" <% if (checks.getData(1,2) != null){out.print("value=\"" + checks.getData(1,2) + "\"");}%> size="10" required/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <div style="color: red" >
                                    <% if (checks.getError(1,0) != null){out.print(checks.getError(1, 0));} %>
                                </div>
                            </td>
                            <td>
                                <div style="color: red" >
                                    <% if (checks.getError(1,1) != null){out.print(checks.getError(1, 1));} %>
                                </div>
                            </td>
                            <td>
                                <div style="color: red" >
                                    <% if (checks.getError(1,2) != null){out.print(checks.getError(1, 2));} %>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Solution C:
                            </td>
                            <td>
                                <input list="color" name="20" <% if (checks.getData(2,0) != null){out.print("value=\"" + checks.getData(2,0) + "\"");}%> size="10" required/>
                            </td>
                            <td>
                                <input list="light" name="21" <% if (checks.getData(2,1) != null){out.print("value=\"" + checks.getData(2,1) + "\"");}%> size="10" required/>
                            </td>
                            <td>
                                <input list="iorc" name="22" <% if (checks.getData(2,2) != null){out.print("value=\"" + checks.getData(2,2) + "\"");}%> size="10" required/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <div style="color: red" >
                                    <% if (checks.getError(2,0) != null){out.print(checks.getError(2, 0));} %>
                                </div>
                            </td>
                            <td>
                                <div style="color: red" >
                                    <% if (checks.getError(2,1) != null){out.print(checks.getError(2, 1));} %>
                                </div>
                            </td>
                            <td>
                                <div style="color: red" >
                                    <% if (checks.getError(2,2) != null){out.print(checks.getError(2, 2));} %>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Solution D:
                            </td>
                            <td>
                                <input list="color" name="30" <% if (checks.getData(3,0) != null){out.print("value=\"" + checks.getData(3,0) + "\"");}%> size="10" required/>
                            </td>
                            <td>
                                <input list="light" name="31" <% if (checks.getData(3,1) != null){out.print("value=\"" + checks.getData(3,1) + "\"");}%> size="10" required/>
                            </td>
                            <td>
                                <input list="iorc" name="32" <% if (checks.getData(3,2) != null){out.print("value=\"" + checks.getData(3,2) + "\"");}%> size="10" required/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <div style="color: red" >
                                    <% if (checks.getError(3,0) != null){out.print(checks.getError(3, 0));} %>
                                </div>
                            </td>
                            <td>
                                <div style="color: red" >
                                    <% if (checks.getError(3,1) != null){out.print(checks.getError(3, 1));} %>
                                </div>
                            </td>
                            <td>
                                <div style="color: red" >
                                    <% if (checks.getError(3,2) != null){out.print(checks.getError(3, 2));} %>
                                </div>
                            </td>
                        </tr>
                    </table>
                </fieldset>
                <div style="text-align: center">
                    <input type="submit" name="button" value="Check" />
                    <input type="submit" name="button" value="Clear" />
                    <input type="submit" name="button" value="Save" />
                    <input type="submit" name="button" value="Submit" />
                </div>
                <br>
            </form>
        </fieldset>
    </body>
</html>
</bbNG:learningSystemPage>