<html>
	<head>
    	<script>
        function ActivateLab1() {
        document.getElementById("Lab1").disabled = false;
        out.println("<p> test try")
		}
   		
   		function ActivateLab2() {
   		document.getElementById("Lab2").disabled = false;
		}
		
    	function callLab1 () {
		window.open("lab0_5.jsp"); 		
		}		
	
        function callLab2 () {
		window.open("lab2.jsp")
		}	    			
    	</script>
	</head>
	<body>
	<p>User Information</p>  
  	<p style="margin-left:10px">
  		Name: <%= u.getGivenName()%>  <%= u.getFamilyName() %><br />   
  		Student Id: <%= u.getId().toExternalString()%> <br />   
  		Batch UID: <%= u.getBatchUid()%> <br /> 			  
 		Course Role: <%= crsMembershipRoleStr%> <br />
 	</p>  
		
	<div style="text-align: left">
		
    <form method="post" action="welcome_i.jsp?course_id=${ctx.courseId.externalString}"> 
    	<input type="submit" name="button" id="ActivateLab1" value="ActivateLab1" >
    	</form>
    <form method="post" action="lab0_1i.jsp?course_id=${ctx.courseId.externalString}&user_id=${ctx.userId.externalString}"> 
        <input type="submit" id="lab1" value="Lab1"/>
    </form>
     <form method="post" action="welcome_i.jsp?course_id=${ctx.courseId.externalString}"> 
    	<input type="submit" name="button" id="deletelab1" value="deletelab1"   />
    	</form>
     <form method="post" action="welcome_i.jsp?course_id=${ctx.courseId.externalString}"> 
    	<input type="submit" name="button" id="deletelines" value="deletelines"   />
    	</form>
    	 </div>
<br>
<br>
<br>
    <div style="text-align: left">

    <form method="post" action="welcome_i.jsp?course_id=${ctx.courseId.externalString}"> 
		<input type="submit" name="button" id="ActivateLab2" value="ActivateLab2" />
	</form>
    <form method="post" action="lab0_2.jsp?course_id=${ctx.courseId.externalString}&user_id=${ctx.userId.externalString}"> 
        <input type="submit" id="lab2" value="lab 2"/>
    </form>
    
	</div>	
	<br>	
	</body>
</html>