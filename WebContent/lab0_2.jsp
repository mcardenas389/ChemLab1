<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Labs.lab0_2Checks" %>
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
	title="LAB 2"
	ctxId="ctx">

	<bbNG:pageHeader>
		<bbNG:breadcrumbBar environment="COURSE"
			navItem="ycdb-chem109-nav-LabDebug" >
				<bbNG:breadcrumb title="Home" href="lab0_2.jsp?course_id=@X@course.pk_string@X@&user_id=@X@user.pk_string@X@" />
			<bbNG:breadcrumb> Lab 2 </bbNG:breadcrumb>
		</bbNG:breadcrumbBar>
		<bbNG:pageTitleBar>
			Welcome to Chem 109 Lab 2
		</bbNG:pageTitleBar>
	</bbNG:pageHeader>

<!DOCTYPE html>

<%
    int dataX = 25;
    int dataY = 2;
	User u = ctx.getUser();
 	String userid = "";
	lab0_2Checks checks;
  	String courseid = request.getParameter("course_id");
  	String tableName = "ycdb_lab_data";

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

	checks = new lab0_2Checks(tableName, dataX, dataY, userid, courseid, 2);
	button = request.getParameter("button");
		
    if (button == null)
    {
        button = "";
            
        //set type
        for (int i = 0; i < dataX; i++)
        {
            for (int j = 0; j < dataY; j++)
            {
                checks.setType(i, j,"double");
            }
        }
        
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
            checks.check();
        }
        else if (button.equals("Submit"))
        {
             
            //perform save
            checks.save(2, userid, courseid);
            
            //perform submit
            checks.submit(2, userid, courseid, 100);
        }
        else
        {
            button = "";
        }
    }
    
 %>
<html>
    <head>
        <title>Lab 2: Volume Measurements and the Determination of Density</title>
        <link rel="stylesheet" href="labs_css.css">
        <script>
        	function loadUnitData()
        	{
        		loadUnit1();
        		loadUnit2();
        		loadUnit3();
        		loadUnit4();
        		loadUnit5();
        		loadUnit6();
        		loadUnit7();
        		loadUnit8();
        		loadUnit9();
        		loadUnit10();
        		loadUnit11();
        		loadUnit12();
        		loadUnit13();
        		loadUnit14();
        		loadUnit15();
        		loadUnit16();
        		loadUnit17();
        		loadUnit18();
        		loadUnit19();
        		loadUnit20();
        		loadUnit21();
        		loadUnit22();
        		loadUnit23();
        		loadUnit24();
        	}
        	
        	function loadUnit1()
        	{
        		var element = document.getElementById('unit1');
	     		element.value = '<%=checks.getData(1,1)%>';
        	}
        	
        	function loadUnit2()
        	{
        		var element = document.getElementById('unit2');
	     		element.value = '<%=checks.getData(2,1)%>';
        	}
        	
        	function loadUnit3()
        	{
        		var element = document.getElementById('unit3');
	     		element.value = '<%=checks.getData(3,1)%>';
        	}
        	
        	function loadUnit4()
        	{
        		var element = document.getElementById('unit4');
	     		element.value = '<%=checks.getData(5,1)%>';
        	}
        	
        	function loadUnit5()
        	{
        		var element = document.getElementById('unit5');
	     		element.value = '<%=checks.getData(6,1)%>';
        	}
        	
        	function loadUnit6()
        	{
        		var element = document.getElementById('unit6');
	     		element.value = '<%=checks.getData(7,1)%>';
        	}
        	
        	function loadUnit7()
        	{
        		var element = document.getElementById('unit7');
	     		element.value = '<%=checks.getData(8,1)%>';
        	}
        	
        	function loadUnit8()
        	{
        		var element = document.getElementById('unit8');
	     		element.value = '<%=checks.getData(9,1)%>';
        	}
        	
        	function loadUnit9()
        	{
        		var element = document.getElementById('unit9');
	     		element.value = '<%=checks.getData(10,1)%>';
        	}
        	
        	function loadUnit10()
        	{
        		var element = document.getElementById('unit10');
	     		element.value = '<%=checks.getData(11,1)%>';
        	}
        	
        	function loadUnit11()
        	{
        		var element = document.getElementById('unit11');
	     		element.value = '<%=checks.getData(12,1)%>';
        	}
        	
        	function loadUnit12()
        	{
        		var element = document.getElementById('unit12');
	     		element.value = '<%=checks.getData(13,1)%>';
        	}
        	
        	function loadUnit13()
        	{
        		var element = document.getElementById('unit13');
	     		element.value = '<%=checks.getData(14,1)%>';
        	}
        	
        	function loadUnit14()
        	{
        		var element = document.getElementById('unit14');
	     		element.value = '<%=checks.getData(15,1)%>';
        	}
        	
        	function loadUnit15()
        	{
        		var element = document.getElementById('unit15');
	     		element.value = '<%=checks.getData(16,1)%>';
        	}
        	
        	function loadUnit16()
        	{
        		var element = document.getElementById('unit16');
	     		element.value = '<%=checks.getData(17,1)%>';
        	}
        	
        	function loadUnit17()
        	{
        		var element = document.getElementById('unit17');
	     		element.value = '<%=checks.getData(18,1)%>';
        	}
        	
        	function loadUnit18()
        	{
        		var element = document.getElementById('unit18');
	     		element.value = '<%=checks.getData(19,1)%>';
        	}
        	
        	function loadUnit19()
        	{
        		var element = document.getElementById('unit19');
	     		element.value = '<%=checks.getData(20,1)%>';
        	}
        	
        	function loadUnit20()
        	{
        		var element = document.getElementById('unit20');
	     		element.value = '<%=checks.getData(21,1)%>';
        	}
        	
        	function loadUnit21()
        	{
        		var element = document.getElementById('unit21');
	     		element.value = '<%=checks.getData(22,1)%>';
        	}
        	
        	function loadUnit22()
        	{
        		var element = document.getElementById('unit22');
	     		element.value = '<%=checks.getData(23,1)%>';
        	}
        	
        	function loadUnit23()
        	{
        		var element = document.getElementById('unit23');
	     		element.value = '<%=checks.getData(24,1)%>';
        	}
        	
        	function loadUnit24()
        	{
        		var element = document.getElementById('unit24');
	     		element.value = '<%=checks.getData(25,1)%>';
        	}
        </script>
    </head>
    <body onload="loadUnitData()">
        <fieldset class="fieldset-auto-width">
            <legend>Lab 2: Volume Measurements and the Determination of Density</legend>
            <form method="POST">
                <fieldset>
                    <legend>I. DATA</legend>
                    <fieldset>
                        <legend>A. Determination of the Density of an Unknown Metal</legend>
                        <table>
                            <tr>
                                <td>
                                    Unknown Number:
                                </td>
                                <td>
                                    <input type="text" name="00" pattern="[0-9]+" title="only whole numbers" required <% if (checks.getData(0,0) != null){out.print("value=\"" + checks.getData(0,0) + "\"");}%> />
                                </td>
                            </tr>
                            <tr>
                            </tr>
                            <tr>
                                <td>
                                    Weight of unknown metal:
                                </td>
                                <td>
                                    <input type="text" name="10" pattern="\d+\.\d+" title="only decimals" required <% if (checks.getData(1,0) != null){out.print("value=\"" + checks.getData(1,0) + "\"");}%> /><!-- 4 decimal places -->
                                </td>
								<td>
									<select name="11" id="unit1" required <% if (checks.getData(1,1) != null){out.print("value=\"" + checks.getData(1,1) + "\"");}%> >
										<option value=""></option>
										<option value="g">g</option>
										<option value="kg">kg</option>
										<option value="mL">mL</option>
										<option value="cm3">cm&#x00B3</option>
										<option value="g/mL">g/mL</option>
										<option value="g/cm3">g/cm&#x00B3</option>
									</select>
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
                            </tr>
                            <tr>
                                <td>
                                    Initial graduate cylinder reading <br>(without unknown metal):
                                </td>
                                <td>
                                    <input type="text" name="20" pattern="\d+\.\d+" title="only decimals" required <% if (checks.getData(2,0) != null){out.print("value=\"" + checks.getData(2,0) + "\"");}%> /><!-- 1 decimal places -->
								</td>
                                <td>	
									<select name="21" id="unit2" required <% if (checks.getData(2,1) != null){out.print("value=\"" + checks.getData(2,1) + "\"");}%> >
										<option value=""></option>
										<option value="g">g</option>
										<option value="kg">kg</option>
										<option value="mL">mL</option>
										<option value="cm3">cm&#x00B3</option>
										<option value="g/mL">g/mL</option>
										<option value="g/cm3">g/cm&#x00B3</option>
									</select>
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
                            </tr>
                            <tr>
                                <td>
                                    Final graduate cylinder reading <br>(with unknown metal):
                                </td>
                                <td>
                                    <input type="text" name="30" pattern="\d+\.\d+" title="only decimals" required <% if (checks.getData(3,0) != null){out.print("value=\"" + checks.getData(3,0) + "\"");}%> /><!-- 1 decimal places -->
								</td>
                                <td>
									<select name="31" id="unit3" required <% if (checks.getData(3,1) != null){out.print("value=\"" + checks.getData(3,1) + "\"");}%> >
										<option value=""></option>
										<option value="g">g</option>
										<option value="kg">kg</option>
										<option value="mL">mL</option>
										<option value="cm3">cm&#x00B3</option>
										<option value="g/mL">g/mL</option>
										<option value="g/cm3">g/cm&#x00B3</option>
									</select>
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
                            </tr>
                        </table>
                    </fieldset>  
                    <fieldset>
                        <legend>B. Determination of the Density of an Unknown Liquid</legend>
                        <table>
                            <tr>
                                <td>
                                    Unknown Number:
                                </td>
                                <td>
                                    <input type="text" name="40" pattern="[0-9]+" title="only whole numbers" required <% if (checks.getData(4,0) != null){out.print("value=\"" + checks.getData(4,0) + "\"");}%> />
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <div style="color: red" >
                                        <% if (checks.getError(4,0) != null){out.print(checks.getError(4, 0));} %>
                                    </div>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Initial buret reading:
                                </td>
                                <td>
                                    <input type="text" name="50" pattern="\d+\.\d+" title="only decimals" required <% if (checks.getData(5,0) != null){out.print("value=\"" + checks.getData(5,0) + "\"");}%> /><!-- 2 decimal places -->
								</td>
                                <td>	
									<select name="51" id="unit4" required <% if (checks.getData(5,1) != null){out.print("value=\"" + checks.getData(5,1) + "\"");}%> >
										<option value=""></option>
										<option value="g">g</option>
										<option value="kg">kg</option>
										<option value="mL">mL</option>
										<option value="cm3">cm&#x00B3</option>
										<option value="g/mL">g/mL</option>
										<option value="g/cm3">g/cm&#x00B3</option>
									</select>
                                </td>
                                <td>
                                    Weight of beaker:
                                </td>
                                <td>
                                    <input type="text" name="100" pattern="\d+\.\d+" title="only decimals" required <% if (checks.getData(10,0) != null){out.print("value=\"" + checks.getData(10,0) + "\"");}%> /><!-- 4 decimal places -->
									<select name="101" id="unit9" required <% if (checks.getData(10,1) != null){out.print("value=\"" + checks.getData(10,1) + "\"");}%> >
										<option value=""></option>
										<option value="g">g</option>
										<option value="kg">kg</option>
										<option value="mL">mL</option>
										<option value="cm3">cm&#x00B3</option>
										<option value="g/mL">g/mL</option>
										<option value="g/cm3">g/cm&#x00B3</option>
									</select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <div style="color: red" >
                                        <% if (checks.getError(5,0) != null){out.print(checks.getError(5, 0));} %>
                                    </div>
                                </td>
								<td>
                                    <div style="color: red" >
                                        <% if (checks.getError(5,1) != null){out.print(checks.getError(5, 1));} %>
                                    </div>
                                </td>
                                <td>
                                </td>
                                <td>
                                    <div style="color: red" >
                                        <% if (checks.getError(10,0) != null){out.print(checks.getError(10, 0));} %>
                                    </div>
                                </td>
								<td>
                                    <div style="color: red" >
                                        <% if (checks.getError(10,1) != null){out.print(checks.getError(10, 1));} %>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Buret reading after 1st liquid sample removed:
                                </td>
                                <td>
                                    <input type="text" name="60" pattern="\d+\.\d+" title="only decimals" required <% if (checks.getData(6,0) != null){out.print("value=\"" + checks.getData(6,0) + "\"");}%> /><!-- 2 decimal places -->
								</td>
                                <td>	
									<select name="61" id="unit5" required <% if (checks.getData(6,1) != null){out.print("value=\"" + checks.getData(6,1) + "\"");}%> >
										<option value=""></option>
										<option value="g">g</option>
										<option value="kg">kg</option>
										<option value="mL">mL</option>
										<option value="cm3">cm&#x00B3</option>
										<option value="g/mL">g/mL</option>
										<option value="g/cm3">g/cm&#x00B3</option>
									</select>
                                </td>
                                <td>
                                    Weight of beaker + liquid after 1st sample added:
                                </td>
                                <td>
                                    <input type="text" name="110" pattern="\d+\.\d+" title="only decimals" required <% if (checks.getData(11,0) != null){out.print("value=\"" + checks.getData(11,0) + "\"");}%> /><!-- 4 decimal places -->
									<select name="111" id="unit10" required <% if (checks.getData(11,1) != null){out.print("value=\"" + checks.getData(11,1) + "\"");}%> >
										<option value=""></option>
										<option value="g">g</option>
										<option value="kg">kg</option>
										<option value="mL">mL</option>
										<option value="cm3">cm&#x00B3</option>
										<option value="g/mL">g/mL</option>
										<option value="g/cm3">g/cm&#x00B3</option>
									</select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <div style="color: red" >
                                        <% if (checks.getError(6,0) != null){out.print(checks.getError(6, 0));} %>
                                    </div>
                                </td>
								<td>
                                    <div style="color: red" >
                                        <% if (checks.getError(6,1) != null){out.print(checks.getError(6, 1));} %>
                                    </div>
                                </td>
                                <td>
                                </td>
                                <td>
                                    <div style="color: red" >
                                        <% if (checks.getError(11,0) != null){out.print(checks.getError(11, 0));} %>
                                    </div>
                                </td>
								<td>
                                    <div style="color: red" >
                                        <% if (checks.getError(11,1) != null){out.print(checks.getError(11, 1));} %>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Buret reading after 2nd liquid sample removed:
                                </td>
                                <td>
                                    <input type="text" name="70" pattern="\d+\.\d+" title="only decimals" required <% if (checks.getData(7,0) != null){out.print("value=\"" + checks.getData(7,0) + "\"");}%> /><!-- 2 decimal places -->
								</td>
                                <td>	
									<select name="71" id="unit6" required <% if (checks.getData(7,1) != null){out.print("value=\"" + checks.getData(7,1) + "\"");}%> >
										<option value=""></option>
										<option value="g">g</option>
										<option value="kg">kg</option>
										<option value="mL">mL</option>
										<option value="cm3">cm&#x00B3</option>
										<option value="g/mL">g/mL</option>
										<option value="g/cm3">g/cm&#x00B3</option>
									</select>
                                </td>
                                <td>
                                    Weight of beaker + liquid after 2nd sample added:
                                </td>
                                <td>
                                    <input type="text" name="120" pattern="\d+\.\d+" title="only decimals" required <% if (checks.getData(12,0) != null){out.print("value=\"" + checks.getData(12,0) + "\"");}%> /><!-- 4 decimal places -->
									<select name="121" id="unit11" required <% if (checks.getData(12,1) != null){out.print("value=\"" + checks.getData(12,1) + "\"");}%> >
										<option value=""></option>
										<option value="g">g</option>
										<option value="kg">kg</option>
										<option value="mL">mL</option>
										<option value="cm3">cm&#x00B3</option>
										<option value="g/mL">g/mL</option>
										<option value="g/cm3">g/cm&#x00B3</option>
									</select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <div style="color: red" >
                                        <% if (checks.getError(7,0) != null){out.print(checks.getError(7, 0));} %>
                                    </div>
                                </td>
								<td>
                                    <div style="color: red" >
                                        <% if (checks.getError(7,1) != null){out.print(checks.getError(7, 1));} %>
                                    </div>
                                </td>
                                <td>
                                </td>
                                <td>
                                    <div style="color: red" >
                                        <% if (checks.getError(12,0) != null){out.print(checks.getError(12, 0));} %>
                                    </div>
                                </td><td>
                                    <div style="color: red" >
                                        <% if (checks.getError(12,1) != null){out.print(checks.getError(12, 1));} %>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Buret reading after 3rd liquid sample removed:
                                </td>
                                <td>
                                    <input type="text" name="80" pattern="\d+\.\d+" title="only decimals" required <% if (checks.getData(8,0) != null){out.print("value=\"" + checks.getData(8,0) + "\"");}%> /><!-- 2 decimal places -->
								</td>
                                <td>	
									<select name="81" id="unit7" required <% if (checks.getData(8,1) != null){out.print("value=\"" + checks.getData(8,1) + "\"");}%> >
										<option value=""></option>
										<option value="g">g</option>
										<option value="kg">kg</option>
										<option value="mL">mL</option>
										<option value="cm3">cm&#x00B3</option>
										<option value="g/mL">g/mL</option>
										<option value="g/cm3">g/cm&#x00B3</option>
									</select>
                                </td>
                                <td>
                                    Weight of beaker + liquid after 3rd sample added:
                                </td>
                                <td>
                                    <input type="text" name="130" pattern="\d+\.\d+" title="only decimals" required <% if (checks.getData(13,0) != null){out.print("value=\"" + checks.getData(13,0) + "\"");}%> /><!-- 4 decimal places -->
									<select name="131" id="unit12" required <% if (checks.getData(13,1) != null){out.print("value=\"" + checks.getData(13,1) + "\"");}%> >
										<option value=""></option>
										<option value="g">g</option>
										<option value="kg">kg</option>
										<option value="mL">mL</option>
										<option value="cm3">cm&#x00B3</option>
										<option value="g/mL">g/mL</option>
										<option value="g/cm3">g/cm&#x00B3</option>
									</select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <div style="color: red" >
                                        <% if (checks.getError(8,0) != null){out.print(checks.getError(8, 0));} %>
                                    </div>
                                </td>
								<td>
                                    <div style="color: red" >
                                        <% if (checks.getError(8,1) != null){out.print(checks.getError(8, 1));} %>
                                    </div>
                                </td>
                                <td>
                                </td>
                                <td>
                                    <div style="color: red" >
                                        <% if (checks.getError(13,0) != null){out.print(checks.getError(13, 0));} %>
                                    </div>
                                </td>
								<td>
                                    <div style="color: red" >
                                        <% if (checks.getError(13,1) != null){out.print(checks.getError(13, 1));} %>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Buret reading after 4th liquid sample removed:
                                </td>
                                <td>
                                    <input type="text" name="90" pattern="\d+\.\d+" title="only decimals" required <% if (checks.getData(9,0) != null){out.print("value=\"" + checks.getData(9,0) + "\"");}%> /><!-- 2 decimal places -->
								</td>
                                <td>	
									<select name="91" id="unit8" required <% if (checks.getData(9,1) != null){out.print("value=\"" + checks.getData(9,1) + "\"");}%> >
										<option value=""></option>
										<option value="g">g</option>
										<option value="kg">kg</option>
										<option value="mL">mL</option>
										<option value="cm3">cm&#x00B3</option>
										<option value="g/mL">g/mL</option>
										<option value="g/cm3">g/cm&#x00B3</option>
									</select>
                                </td>
                                <td>
                                    Weight of beaker + liquid:
                                </td>
                                <td>
                                    <input type="text" name="140" pattern="\d+\.\d+" title="only decimals" required <% if (checks.getData(14,0) != null){out.print("value=\"" + checks.getData(14,0) + "\"");}%> /><!-- 4 decimal places -->
									<select name="141" id="unit13" required <% if (checks.getData(14,1) != null){out.print("value=\"" + checks.getData(14,1) + "\"");}%> >
										<option value=""></option>
										<option value="g">g</option>
										<option value="kg">kg</option>
										<option value="mL">mL</option>
										<option value="cm3">cm&#x00B3</option>
										<option value="g/mL">g/mL</option>
										<option value="g/cm3">g/cm&#x00B3</option>
									</select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <div style="color: red" >
                                        <% if (checks.getError(9,0) != null){out.print(checks.getError(9, 0));} %>
                                    </div>
                                </td>
								<td>
                                    <div style="color: red" >
                                        <% if (checks.getError(9,1) != null){out.print(checks.getError(9, 1));} %>
                                    </div>
                                </td>
                                <td>
                                </td>
                                <td>
                                    <div style="color: red" >
                                        <% if (checks.getError(14,0) != null){out.print(checks.getError(14, 0));} %>
                                    </div>
                                </td>
								<td>
                                    <div style="color: red" >
                                        <% if (checks.getError(14,1) != null){out.print(checks.getError(14, 1));} %>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </fieldset>
                <fieldset>
                    <legend>II. RESULTS</legend>
                    <fieldset>
                        <legend>A. Determination of the Density of an Unknown Metal</legend>
                        <table>
                            <tr>
                                <td>
                                    Volume of metal:
                                </td>
                                <td>
                                    <input type="text" name="150" pattern="\d+\.\d+" title="only decimals" required <% if (checks.getData(15,0) != null){out.print("value=\"" + checks.getData(15,0) + "\"");}%> /><!-- 1 decimal places -->
								</td>
                                <td>	
									<select name="151" id="unit14" required <% if (checks.getData(15,1) != null){out.print("value=\"" + checks.getData(15,1) + "\"");}%> >
										<option value=""></option>
										<option value="g">g</option>
										<option value="kg">kg</option>
										<option value="mL">mL</option>
										<option value="cm3">cm&#x00B3</option>
										<option value="g/mL">g/mL</option>
										<option value="g/cm3">g/cm&#x00B3</option>
									</select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <div style="color: red" >
                                        <% if (checks.getError(15,0) != null){out.print(checks.getError(15, 0));} %>
                                    </div>
                                </td>
								<td>
                                    <div style="color: red" >
                                        <% if (checks.getError(15,1) != null){out.print(checks.getError(15, 1));} %>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Density of metal:
                                </td>
                                <td>
                                    <input type="text" name="160" pattern="\d+\.\d+" title="only decimals" required <% if (checks.getData(16,0) != null){out.print("value=\"" + checks.getData(16,0) + "\"");}%> /><!-- 3 significant figures, 2 decimal places -->
								</td>
                                <td>	
									<select name="161" id="unit15" required <% if (checks.getData(16,1) != null){out.print("value=\"" + checks.getData(16,1) + "\"");}%> >
										<option value=""></option>
										<option value="g">g</option>
										<option value="kg">kg</option>
										<option value="mL">mL</option>
										<option value="cm3">cm&#x00B3</option>
										<option value="g/mL">g/mL</option>
										<option value="g/cm3">g/cm&#x00B3</option>
									</select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <div style="color: red" >
                                        <% if (checks.getError(16,0) != null){out.print(checks.getError(16, 0));} %>
                                    </div>
                                </td>
								<td>
                                    <div style="color: red" >
                                        <% if (checks.getError(16,1) != null){out.print(checks.getError(16, 1));} %>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                    <fieldset>
                        <legend>B. Determination of the Density of an Unknown Liquid</legend>
                        <table>
                            <tr>
                                <th>
                                </th>
                                <th>
                                    Total Volume of <br>
                                    Liquid in Beaker
                                </th>
                                <th>
                                </th>
                                <th>
                                    Total Weight of <br>
                                    Liquid in Beaker
                                </th>
                            </tr>
                            <tr>
                                <td>
                                    After 1st sample added to beaker:
                                </td>
                                <td>
                                    <input type="text" name="170" pattern="\d+\.\d+" title="only decimals" required <% if (checks.getData(17,0) != null){out.print("value=\"" + checks.getData(17,0) + "\"");}%> /><!-- 2 decimal places -->
								</td>
                                <td>	
									<select name="171" id="unit16" required <% if (checks.getData(17,1) != null){out.print("value=\"" + checks.getData(17,1) + "\"");}%> >
										<option value=""></option>
										<option value="g">g</option>
										<option value="kg">kg</option>
										<option value="mL">mL</option>
										<option value="cm3">cm&#x00B3</option>
										<option value="g/mL">g/mL</option>
										<option value="g/cm3">g/cm&#x00B3</option>
									</select>
                                </td>
                                <td>
                                    <input type="text" name="210" pattern="\d+\.\d+" title="only decimals" required <% if (checks.getData(21,0) != null){out.print("value=\"" + checks.getData(21,0) + "\"");}%> /><!-- 4 decimal places -->
								</td>
                                <td>	
									<select name="211" id="unit20" required <% if (checks.getData(21,1) != null){out.print("value=\"" + checks.getData(21,1) + "\"");}%> >
										<option value=""></option>
										<option value="g">g</option>
										<option value="kg">kg</option>
										<option value="mL">mL</option>
										<option value="cm3">cm&#x00B3</option>
										<option value="g/mL">g/mL</option>
										<option value="g/cm3">g/cm&#x00B3</option>
									</select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <div style="color: red" >
                                        <% if (checks.getError(17,0) != null){out.print(checks.getError(17, 0));} %>
                                    </div>
                                </td>
								<td>
                                    <div style="color: red" >
                                        <% if (checks.getError(17,1) != null){out.print(checks.getError(17, 1));} %>
                                    </div>
                                </td>
                                <td>
                                    <div style="color: red" >
                                        <% if (checks.getError(21,0) != null){out.print(checks.getError(21, 0));} %>
                                    </div>
                                </td>
								<td>
                                    <div style="color: red" >
                                        <% if (checks.getError(21,1) != null){out.print(checks.getError(21, 1));} %>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    After 2nd sample added to beaker:
                                </td>
                                <td>
                                    <input type="text" name="180" pattern="\d+\.\d+" title="only decimals" required <% if (checks.getData(18,0) != null){out.print("value=\"" + checks.getData(18,0) + "\"");}%> /><!-- 2 decimal places -->
								</td>
                                <td>	
									<select name="181" id="unit17" required <% if (checks.getData(18,1) != null){out.print("value=\"" + checks.getData(18,1) + "\"");}%> >
										<option value=""></option>
										<option value="g">g</option>
										<option value="kg">kg</option>
										<option value="mL">mL</option>
										<option value="cm3">cm&#x00B3</option>
										<option value="g/mL">g/mL</option>
										<option value="g/cm3">g/cm&#x00B3</option>
									</select>
                                </td>
                                <td>
                                    <input type="text" name="220" pattern="\d+\.\d+" title="only decimals" required <% if (checks.getData(22,0) != null){out.print("value=\"" + checks.getData(22,0) + "\"");}%> /><!-- 4 decimal places -->
								</td>
                                <td>	
									<select name="221" id="unit21" required <% if (checks.getData(22,1) != null){out.print("value=\"" + checks.getData(22,1) + "\"");}%> >
										<option value=""></option>
										<option value="g">g</option>
										<option value="kg">kg</option>
										<option value="mL">mL</option>
										<option value="cm3">cm&#x00B3</option>
										<option value="g/mL">g/mL</option>
										<option value="g/cm3">g/cm&#x00B3</option>
									</select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <div style="color: red" >
                                        <% if (checks.getError(18,0) != null){out.print(checks.getError(18, 0));} %>
                                    </div>
                                </td>
								<td>
                                    <div style="color: red" >
                                        <% if (checks.getError(18,1) != null){out.print(checks.getError(18, 1));} %>
                                    </div>
                                </td>
                                <td>
                                    <div style="color: red" >
                                        <% if (checks.getError(22,0) != null){out.print(checks.getError(22, 0));} %>
                                    </div>
                                </td>
								<td>
                                    <div style="color: red" >
                                        <% if (checks.getError(22,1) != null){out.print(checks.getError(22, 1));} %>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    After 3rd sample added to beaker:
                                </td>
                                <td>
                                    <input type="text" name="190" pattern="\d+\.\d+" title="only decimals" required <% if (checks.getData(19,0) != null){out.print("value=\"" + checks.getData(19,0) + "\"");}%> /><!-- 2 decimal places -->
								</td>
                                <td>	
									<select name="191" id="unit18" required <% if (checks.getData(19,1) != null){out.print("value=\"" + checks.getData(19,1) + "\"");}%> >
										<option value=""></option>
										<option value="g">g</option>
										<option value="kg">kg</option>
										<option value="mL">mL</option>
										<option value="cm3">cm&#x00B3</option>
										<option value="g/mL">g/mL</option>
										<option value="g/cm3">g/cm&#x00B3</option>
									</select>
                                </td>
                                <td>
                                    <input type="text" name="230" pattern="\d+\.\d+" title="only decimals" required <% if (checks.getData(23,0) != null){out.print("value=\"" + checks.getData(23,0) + "\"");}%> /><!-- 4 decimal places -->
								</td>
                                <td>	
									<select name="231" id="unit22" required <% if (checks.getData(23,1) != null){out.print("value=\"" + checks.getData(23,1) + "\"");}%> >
										<option value=""></option>
										<option value="g">g</option>
										<option value="kg">kg</option>
										<option value="mL">mL</option>
										<option value="cm3">cm&#x00B3</option>
										<option value="g/mL">g/mL</option>
										<option value="g/cm3">g/cm&#x00B3</option>
									</select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <div style="color: red" >
                                        <% if (checks.getError(19,0) != null){out.print(checks.getError(19, 0));} %>
                                    </div>
                                </td>
								<td>
                                    <div style="color: red" >
                                        <% if (checks.getError(19,1) != null){out.print(checks.getError(19, 1));} %>
                                    </div>
                                </td>
                                <td>
                                    <div style="color: red" >
                                        <% if (checks.getError(23,0) != null){out.print(checks.getError(23, 0));} %>
                                    </div>
                                </td>
								<td>
                                    <div style="color: red" >
                                        <% if (checks.getError(23,1) != null){out.print(checks.getError(23, 1));} %>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    After 4th sample added to beaker:
                                </td>
                                <td>
                                    <input type="text" name="200" pattern="\d+\.\d+" title="only decimals" required <% if (checks.getData(20,0) != null){out.print("value=\"" + checks.getData(20,0) + "\"");}%> /><!-- 2 decimal places -->
								</td>
                                <td>	
									<select name="201" id="unit19" required <% if (checks.getData(20,1) != null){out.print("value=\"" + checks.getData(20,1) + "\"");}%> >
										<option value=""></option>
										<option value="g">g</option>
										<option value="kg">kg</option>
										<option value="mL">mL</option>
										<option value="cm3">cm&#x00B3</option>
										<option value="g/mL">g/mL</option>
										<option value="g/cm3">g/cm&#x00B3</option>
									</select>
                                </td>
                                <td>
                                    <input type="text" name="240" pattern="\d+\.\d+" title="only decimals" required <% if (checks.getData(24,0) != null){out.print("value=\"" + checks.getData(24,0) + "\"");}%> /><!-- 4 decimal places -->
								</td>
                                <td>	
									<select name="241" id="unit23" required <% if (checks.getData(24,1) != null){out.print("value=\"" + checks.getData(24,1) + "\"");}%> >
										<option value=""></option>
										<option value="g">g</option>
										<option value="kg">kg</option>
										<option value="mL">mL</option>
										<option value="cm3">cm&#x00B3</option>
										<option value="g/mL">g/mL</option>
										<option value="g/cm3">g/cm&#x00B3</option>
									</select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <div style="color: red" >
                                        <% if (checks.getError(20,0) != null){out.print(checks.getError(20, 0));} %>
                                    </div>
                                </td>
								<td>
                                    <div style="color: red" >
                                        <% if (checks.getError(20,1) != null){out.print(checks.getError(20, 1));} %>
                                    </div>
                                </td>
                                <td>
                                    <div style="color: red" >
                                        <% if (checks.getError(24,0) != null){out.print(checks.getError(24, 0));} %>
                                    </div>
                                </td>
								<td>
                                    <div style="color: red" >
                                        <% if (checks.getError(24,1) != null){out.print(checks.getError(24, 1));} %>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Density of unknown liquid (slope of the line resulting from the plot of M versus V):
                                </td>
                                <td>
                                    <input type="text" name="250" pattern="\d+\.\d+" title="only decimals" required <% if (checks.getData(25,0) != null){out.print("value=\"" + checks.getData(25,0) + "\"");}%> />
								</td>
                                <td>	
									<select name="251" id="unit24" required <% if (checks.getData(25,1) != null){out.print("value=\"" + checks.getData(25,1) + "\"");}%> >
										<option value=""></option>
										<option value="g">g</option>
										<option value="kg">kg</option>
										<option value="mL">mL</option>
										<option value="cm3">cm&#x00B3</option>
										<option value="g/mL">g/mL</option>
										<option value="g/cm3">g/cm&#x00B3</option>
									</select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <div style="color: red" >
                                        <% if (checks.getError(25,0) != null){out.print(checks.getError(25, 0));} %>
                                    </div>
                                </td>
								<td>
                                    <div style="color: red" >
                                        <% if (checks.getError(25,1) != null){out.print(checks.getError(25, 1));} %>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
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
        <br>
    </body>
</html>
</bbNG:learningSystemPage>