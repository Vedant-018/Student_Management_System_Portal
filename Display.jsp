<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.util.*" %>
<%@ page import ="com.tca.entites.Student" %>
<%@ include file="Header.jsp" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
  </head>
  <body>
  <%
  String trno =request.getParameter("rno");
  String sbtn = request.getParameter("sbtn");
  
  if(trno==null){
	  trno="";
  }
  if(sbtn!= null && sbtn.equals("Refresh")){
	  trno="";
  }
  
  
  %>
  <div class="container" style="margin-top:100px; ">
  <h2 class="text-center mb-4 text-primary">Student Information </h2>
  
  <!-- Search Logic -->
  <div class="container-fluid d-flex justify-content-start" >
    <form class="d-flex" role="search" method="POST"  action="./DisplayStudent">
      <input class="form-control me-2" type="search"name="rno" value="<%=trno %>" placeholder="Enter Roll No." aria-label="Search"/>
      <button class="btn btn-outline-primary" type="submit" name="sbtn"value="Search">Search</button>
      <button class="btn btn-outline-success ms-2" type="submit" name="sbtn" value="Refresh">Refresh</button>
    </form>
  </div>
  
  <!-- Table Logic -->
  <table class="table table-hover border table-bordered text-center mt-3">
  <thead>
    <tr class="table-primary">
      <th scope="col">RNO</th>
      <th scope="col">NAME</th>
      <th scope="col">PER</th>
    </tr>
  </thead>
  <tbody class="table-group-divider">
 <%
 
 List<Student> L=(List<Student>)request.getAttribute("listofstudents");
 
 if(L==null || L.isEmpty()){	 
 %>
 	<tr>
 		<td colspan="3" class="text-danger">
 		NO DATA FOUND !
 		</td>
 	</tr>
 	
 <% 
 }
 else{
 
 	for(Student S:L){
	 
	 	int rno=S.getRno();
	 	String name=S.getName();
	 	Double per=S.getPer();
	 	String cls ="";
	 	if(per<70){
		 	cls = "table-danger";
	 	}
%>	 
	 <tr class="<%= cls %>">
	    <td><%=rno%></td>
	    <td><%= name%></td>
	    <td><%=per%></td>
	 
	 </tr>
<%
 	} 
 } 	
 %>
 </tbody>
</table> 
    
   </div> 
  </body>
</html>