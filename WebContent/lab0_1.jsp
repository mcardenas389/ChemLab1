<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Labs.lab0_1Checks" %>
<%@ page import="Labs.GradeLogistics" %>
<%@ page import="Labs.Helper" %>
<!DOCTYPE html>

 <%
	int dataX = 12;
 	int dataY = 3;
 	
 	//User u = ctx.getUser();
 	String userid = "";
	lab0_1Checks checks;
  	String courseid = request.getParameter("course_id");
  	String button = null;
  	String tableName = "ycdb_lab_data";
	
  	//CourseMembership crsMembership = null;
	//CourseMembershipDbLoader crsMembershipLoader = null;
	//PersistenceService bbPm = PersistenceServiceFactory.getInstance() ;
    //BbPersistenceManager bpManager = bbPm.getDbPersistenceManager();
 
	String errMsg = null;
	//crsMembershipLoader = (CourseMembershipDbLoader)bpManager.getLoader(CourseMembershipDbLoader.TYPE);
	/*
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
 		userid = h.getUserIdFromCourseMembershipId(ctx, cid);	 	
	}
	else
	{
		userid = u.getId().toExternalString();
    }
 	*/
	checks = new lab0_1Checks(tableName, dataX, dataY, "userid", "courseid", 1);
	 
 	button = request.getParameter("button");
	
 	if (button == null)
    {
        button = "";
	    
        //set types
        /*
        checks.setType(0, 0, "String");
        checks.setType(1, 0, "String");
        
        for (int i = 2; i < dataX; i++)
        {
            for (int j = 0; j < dataY; j++)
            {
                if (j == 0)
                {
                    checks.setType(i, j, "Double");
                }
                else if (j == 1)
                {
                    checks.setType(i, j, "Unit");
                }
                else 
                {
                    checks.setType(i, j, "Integer");
                }
            }
        }
        */
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
    	
        if (button.equals("Clear"))
        {  
            checks.clear();
        }
        else if (button.equals("Save"))
        {              
            //perform save
            checks.save(1, userid, courseid);
        }
        else if (button.equals("Check"))
        {              
            //perform checks
            checks.gradeLab(1, "userid", "courseid");
        }
        else if (button.equals("Submit"))
        {
        	GradeLogistics gl = new GradeLogistics();
        	//LineItem lineitem = gl.makeLineItem("CHEM 109 - Lab 1", "lab0_1.jsp", 100, ctx);//not sure if we should call make or getlineitem
        	//gl.addStudentAttempts(ctx, 1, "lab0_1.jsp", lineitem);
            //perform submit
            checks.gradeLab(1, userid, courseid);
        }
        /*
        else if (button.equals("ClearAttempt"))
        {
         	if (crsMembershipRole == CourseMembership.Role.INSTRUCTOR)
         	{
    			GradeLogistics gl = new GradeLogistics();

        		checks.clearAttempt(ctx, userid, tableName);
         	}
        }
        */
        else
        {
            button = "";
        }
        button="";
    }
 
 %>
 
<html>
    <head>
    	<title>
            Lab 1: Weighing Measurements: The Balance
    	</title>
    	<link rel="stylesheet" href="labs_css.css">
        <script>
        	if (crsMembershipRole == CourseMembership.Role.INSTRUCTOR) 
	     		{
	     			var d = document.getElementById("btns");
	     			var b = document.createElement("BUTTON")
	      		    var t = document.createTextNode("ClearAttempt");
	     		    b.appendChild(t);
					d.appendChild(b);
	     		}
	     	
        	function loadMassData()
        	{
        		loadMass1();
        		loadMass2();
        		loadMass3();
        		loadMass4();
        		loadMass5();
        		loadMass6();
        		loadMass7();
        		loadMass8();
        		loadMass9();
        		loadMass10();
        	}
        	
	     	function loadMass1() 
	     	{
	     		var element = document.getElementById('mass1');
	     		element.value = '<%=checks.getData(2,1)%>';
	     		
	     	}
	     	
	     	function loadMass2() 
	     	{
	     		var element = document.getElementById('mass2');
	     		element.value = '<%=checks.getData(3,1)%>';
	     		
	     	}
	     	
	     	function loadMass3() 
	     	{
	     		var element = document.getElementById('mass3');
	     		element.value = '<%=checks.getData(4,1)%>';
	     		
	     	}
	     	
	     	function loadMass4() 
	     	{
	     		var element = document.getElementById('mass4');
	     		element.value = '<%=checks.getData(5,1)%>';
	     		
	     	}
	     	
	     	function loadMass5() 
	     	{
	     		var element = document.getElementById('mass5');
	     		element.value = '<%=checks.getData(6,1)%>';
	     		
	     	}
	     	
	     	function loadMass6() 
	     	{
	     		var element = document.getElementById('mass6');
	     		element.value = '<%=checks.getData(7,1)%>';
	     		
	     	}
	     	
	     	function loadMass7() 
	     	{
	     		var element = document.getElementById('mass7');
	     		element.value = '<%=checks.getData(8,1)%>';
	     		
	     	}
	     	
	     	function loadMass8() 
	     	{
	     		var element = document.getElementById('mass8');
	     		element.value = '<%=checks.getData(9,1)%>';
	     		
	     	}
	     	
	     	function loadMass9() 
	     	{
	     		var element = document.getElementById('mass9');
	     		element.value = '<%=checks.getData(10,1)%>';
	     		
	     	}
	     	
	     	function loadMass10() 
	     	{
	     		var element = document.getElementById('mass10');
	     		element.value = '<%=checks.getData(11,1)%>';
	     		
	     	}
        </script>
    </head>
    <body onload="loadMassData()">
    	<p>User Information</p>  
  	<p style="margin-left:10px">
  		Name: <br />   
  		Student Id: <br />   
 	</p>    
    	<fieldset class="fieldset-auto-width">
            <legend>Lab 1: Weighing Measurements: The Balance</legend>
            <form method="POST">        
            <fieldset>
                <legend>Basic info</legend>
                <table>
                    <tr>
                        <th>
                            Unknown number of metal rod:
                        </th>
                        <th>
                            <input type="text" name="00" pattern="[0-9]+" title="only whole numbers" <% if (checks.getData(0,0) != null){out.print("value=\"" + checks.getData(0,0) + "\"");} %> required />
                        </th>
                    </tr>
                    <tr>
                        <th>
                        </th>
                    </tr>
                    <tr>
                        <th>
                            Unknown number of metal wire:
                        </th>
                        <th>
                            <input type="text" name="10" pattern="[0-9]+" title="only whole numbers" <% if (checks.getData(1,0) != null){out.print("value=\"" + checks.getData(1,0) + "\"");}%> required />
                        </th>
                    </tr>
                    <tr>
                        <th>
                        </th>
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
                            <input type="text" name="20" pattern="\d+\.\d+" title="only decimals" <% if (checks.getData(2,0) != null){out.print("value=\"" + checks.getData(2,0) + "\"");}%> />
                        </td>
                        <td>
                            <select name="21" id="mass1" required>
                            	<option value=""></option>
		   						<option value="g">g</option>
		   						<option value="kg">kg</option>
							</select> 
                        </td>
                        <td>
                            <input type="text" name="22" pattern="[0-9]+" title="only whole numbers" <% if (checks.getData(2,2) != null){out.print("value=\"" + checks.getData(2,2) + "\"");}%> />
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <div style="color: red">
                                <% if (checks.getError(2,0) != null){out.print(checks.getError(2,0));} %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red">
                                <% if (checks.getError(2,1) != null){out.print(checks.getError(2,1));} %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red">
                                <% if (checks.getError(2,2) != null){out.print(checks.getError(2,2));} %>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Vial + Sodium chloride
                        </td>
                        <td>
                            <input type="text" name="30" pattern="\d+\.\d+" title="only decimals" <% if (checks.getData(3,0) != null){out.print("value=\"" + checks.getData(3,0) + "\"");}%> />
                        </td>
                        <td>
                            <select name="31" id="mass2" required>
                            	<option value=""></option>
		   						<option value="g">g</option>
		   						<option value="kg">kg</option>
							</select> 
                        </td>
                        <td>
                            <input type="text" name="32" pattern="[0-9]+" title="only whole numbers" <% if (checks.getData(3,2) != null){out.print("value=\"" + checks.getData(3,2) + "\"");}%> />
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <div style="color: red">
                                <% if (checks.getError(3,0) != null){out.print(checks.getError(3,0));} %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red">
                                <% if (checks.getError(3,1) != null){out.print(checks.getError(3,1));} %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red">
                                <% if (checks.getError(3,2) != null){out.print(checks.getError(3,2));} %>
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
                            <input type="text" name="40" pattern="\d+\.\d+" title="only decimals" <% if (checks.getData(4,0) != null){out.print("value=\"" + checks.getData(4,0) + "\"");}%> />
                        </td>
                        <td>
                            <select name="41" id="mass3" required>
                            	<option value=""></option>
		   						<option value="g">g</option>
		   						<option value="kg">kg</option>
							</select>
                        </td>
                        <td>
                            <input type="text" name="42" pattern="[0-9]+" title="only whole numbers" <% if (checks.getData(4,2) != null){out.print("value=\"" + checks.getData(4,2) + "\"");}%> />
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <div style="color: red">
                                <% if (checks.getError(4,0) != null){out.print(checks.getError(4,0));} %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red">
                                <% if (checks.getError(4,1) != null){out.print(checks.getError(4,1));} %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red">
                                <% if (checks.getError(4,2) != null){out.print(checks.getError(4,2));} %>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Metal wire - Trial 1
                        </td>
                        <td>
                            <input type="text" name="50" pattern="\d+\.\d+" title="only decimals" <% if (checks.getData(5,0) != null){out.print("value=\"" + checks.getData(5,0) + "\"");}%> required />
                        </td>
                        <td>
                            <select name="51" id="mass4" required>
                            	<option value=""></option>
		   						<option value="g">g</option>
		   						<option value="kg">kg</option>
							</select>
                        </td>
                        <td>
                            <input type="text" name="52" pattern="[0-9]+" title="only whole numbers" <% if (checks.getData(5,2) != null){out.print("value=\"" + checks.getData(5,2) + "\"");}%> />
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <div style="color: red">
                                <% if (checks.getError(5,0) != null){out.print(checks.getError(5,0));} %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red">
                                <% if (checks.getError(5,1) != null){out.print(checks.getError(5,1));} %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red">
                                <% if (checks.getError(5,2) != null){out.print(checks.getError(5,2));} %>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Trial 2
                        </td>
                        <td>
                            <input type="text" name="60" pattern="\d+\.\d+" title="only decimals" <% if (checks.getData(6,0) != null){out.print("value=\"" + checks.getData(6,0) + "\"");}%> required />
                        </td>
                        <td>
                            <select name="61" id="mass5" required>
                            	<option value=""></option>
		   						<option value="g">g</option>
		   						<option value="kg">kg</option>
							</select>
                        </td>
                        <td>
                            <input type="text" name="62" pattern="[0-9]+" title="only whole numbers" <% if (checks.getData(6,2) != null){out.print("value=\"" + checks.getData(6,2) + "\"");}%> />
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <div style="color: red">
                                <% if (checks.getError(6,0) != null){out.print(checks.getError(6,0));} %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red">
                                <% if (checks.getError(6,1) != null){out.print(checks.getError(6,1));} %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red">
                                <% if (checks.getError(6,2) != null){out.print(checks.getError(6,2));} %>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Trial 3
			</td>
			<td>
                            <input type="text" name="70" pattern="\d+\.\d+" title="only decimals" <% if (checks.getData(7,0) != null){out.print("value=\"" + checks.getData(7,0) + "\"");}%> required />
                        </td>
                        <td>
                            <select name="71" id="mass6" required>
                            	<option value=""></option>
		   						<option value="g">g</option>
		   						<option value="kg">kg</option>
							</select>
                        </td>
                        <td>
                            <input type="text" name="72" pattern="[0-9]+" title="only whole numbers" <% if (checks.getData(7,2) != null){out.print("value=\"" + checks.getData(7,2) + "\"");}%> />
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <div style="color: red">
                                <% if (checks.getError(7,0) != null){out.print(checks.getError(7,0));} %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red">
                                <% if (checks.getError(7,1) != null){out.print(checks.getError(7,1));} %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red">
                                <% if (checks.getError(7,2) != null){out.print(checks.getError(7,2));} %>
                            </div>
                        </td>
                    </tr>
                    <tr>
			<td>
                            Weighing paper and sodium chloride
			</td>
			<td>
                            <input type="text" name="80" pattern="\d+\.\d+" title="only decimals" <% if (checks.getData(8,0) != null){out.print("value=\"" + checks.getData(8,0) + "\"");}%> required />
                        </td>
                        <td>
                            <select name="81" id="mass7" required>
                            	<option value=""></option>
		   						<option value="g">g</option>
		   						<option value="kg">kg</option>
							</select>
                        </td>
                        <td>
                            <input type="text" name="82" pattern="[0-9]+" title="only whole numbers" <% if (checks.getData(8,2) != null){out.print("value=\"" + checks.getData(8,2) + "\"");}%> />
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <div style="color: red">
                                <% if (checks.getError(8,0) != null){out.print(checks.getError(8,0));} %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red">
                                <% if (checks.getError(8,1) != null){out.print(checks.getError(8,1));} %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red">
                                <% if (checks.getError(8,2) != null){out.print(checks.getError(8,2));} %>
                            </div>
                        </td>
                    </tr>
                    <tr>
			<td>
                            Weighing paper
			</td>
			<td>
                            <input type="text" name="90" pattern="\d+\.\d+" title="only decimals" <% if (checks.getData(9,0) != null){out.print("value=\"" + checks.getData(9,0) + "\"");}%> required />
                        </td>
                        <td>
                            <select name="91" id="mass8" required>
                            	<option value=""></option>
		   						<option value="g">g</option>
		   						<option value="kg">kg</option>
							</select>
                        </td>
                        <td>
                            <input type="text" name="92" pattern="[0-9]+" title="only whole numbers" <% if (checks.getData(9,2) != null){out.print("value=\"" + checks.getData(9,2) + "\"");}%> />
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <div style="color: red">
                                <% if (checks.getError(9,0) != null){out.print(checks.getError(9,0));} %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red">
                                <% if (checks.getError(9,1) != null){out.print(checks.getError(9,1));} %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red">
                                <% if (checks.getError(9,2) != null){out.print(checks.getError(9,2));} %>
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
                            <input type="text" name="100" pattern="\d+\.\d+" title="only decimals" <% if (checks.getData(10,0) != null){out.print("value=\"" + checks.getData(10,0) + "\"");}%> />
                        </td>
                        <td>
                            <select name="101" id="mass9" required>
                            	<option value=""></option>
		   						<option value="g">g</option>
		   						<option value="kg">kg</option>
							</select>
                        </td>
                        <td>
                            <input type="text" name="102" pattern="[0-9]+" title="only whole numbers" <% if (checks.getData(10,2) != null){out.print("value=\"" + checks.getData(10,2) + "\"");}%> />
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <div style="color: red">
                                <% if (checks.getError(10,0) != null){out.print(checks.getError(10,0));} %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red">
                                <% if (checks.getError(10,1) != null){out.print(checks.getError(10,1));} %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red">
                                <% if (checks.getError(10,2) != null){out.print(checks.getError(10,2));} %>
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
                            <input type="text" name="110" pattern="\d+\.\d+" title="only decimals" <% if (checks.getData(11,0) != null){out.print("value=\"" + checks.getData(11,0) + "\"");}%> />
                        </td>
                        <td>
                            <select name="111" id="mass10" required>
                            	<option value=""></option>
		   						<option value="g">g</option>
		   						<option value="kg">kg</option>
							</select>
                        </td>
                        <td>
                            <input type="text" name="112" pattern="[0-9]+" title="only whole numbers" <% if (checks.getData(11,2) != null){out.print("value=\"" + checks.getData(11,2) + "\"");}%> />
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <div style="color: red">
                                <% if (checks.getError(11,0) != null){out.print(checks.getError(11,0));} %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red">
                                <% if (checks.getError(11,1) != null){out.print(checks.getError(11,1));} %>
                            </div>
                        </td>
                        <td>
                            <div style="color: red">
                                <% if (checks.getError(11,2) != null){out.print(checks.getError(11,2));} %>
                            </div>
                        </td>
                    </tr>
 		</table>
            </fieldset>
            <br>
            <table>
	            <tr>
	            	<td></td>
		            <td style="width:50%">
		            	<div style="text-align: center" id="btns">
                			<input type="submit" name="button" value="Clear" />
                			<input type="submit" name="button" value="Check" />
                			<input type="submit" name="button" value="Save" />
                			<input type="submit" name="button" value="Submit" />
							<p>Student View [Test Page]</p>
            			</div>
		            </td>
		            <td></td>
	            </tr>     
            </table>
            <br>
            </form>
        </fieldset>
    <br>
    </body>
</html>
<!--</bbNG:learningSystemPage>-->
