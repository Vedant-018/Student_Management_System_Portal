<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.tca.entites.Student" %>
<%@ include file="Header.jsp" %>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
   
   <script>
   	function modify(trno) //trno=101
   	{
   		var tr= document.getElementById(trno);//tr is hook on <tr> tag
   		
   		var td=tr.getElementsByTagName("td");  //<tr> <td-0> <td-1></tr>
   		
   		trno =td[0].textContent;
   		var tname = td[1].querySelector("input").value;//name="AAA"
   		var tper = td[2].querySelector("input").value;
   		
   		// take that trno
   		// preparer Requst : http://localhost:8080/00-APP/DeleteStudent
   		//          method : POST
   		//          trno   : 101
   		// send
   	
   		// fetch(URL,{method, bodcy})
   		// data =" sucecss "
   	
   		fetch('http://localhost:8080/00-APP/UpdateStudent',
   				{ 
   	 			   method: 'POST',
   			   	   body  : new URLSearchParams({'trno': trno,'tname':tname,'tper':tper})
   				}
   		 )
   		.then(response => response.text()) 
   		.then(data => 
   					{
   						if(data.trim()=="success")
   						{
   							alert("Record is Update for Roll Number : " + trno);
   							
   							
   						}
   						
   						if(data.trim()=="failed")
   						{
   							alert("Failed to Update  for Roll Number : " + trno);
   						}
   			     	})
   		.catch(error => console.error("MyError while Updating :", error))
   	
   	}
   
   </script>
   
   
  </head>
<body>
<%
	String trno = request.getParameter("rno");
	String sbtn = request.getParameter("sbtn");

	if(trno==null)
		trno="";
	
	if(sbtn!=null && sbtn.equals("Refresh"))
		trno="";

%>




<div class="container" style="margin-top:100px;" > 
<h2 class="text-center mb-4 text-primary"> Student Information </h2> 

<!-- Search Logic -->

<div class="container-fluid mb-3 d-flex justify-content-end">

<form class="d-flex" role="search" method ="GET" action="./UpdateStudent">

      <input class="form-control me-2" type="search" name="rno" value="<%= trno %>" placeholder="Enter roll num" aria-label="Search">
      
      <button class="btn btn-outline-success"     type="submit"  name="sbtn" value="Search">Search</button>
      <button class="btn btn-outline-success ms-2" type="submit" name="sbtn" value="Refresh">Refresh</button>
  
</form>
</div>

<!--  Table Logic -->

<table class="table table-hover table-bordered text-center ">
<thead > 
	<tr class ="table-primary">
      <th scope="col">RNO</th>
      <th scope="col">NAME</th>
      <th scope="col">PER</th>
      <th scope="col"> ACTION </th>
    </tr>
</thead>

<tbody> 
<%
	List<Student> L =  (List<Student>) request.getAttribute("listofstudents");

	if(L==null || L.isEmpty())
	{
%>

			<tr>
				<td colspan="4" class="text-danger">
					No Data Found !!
				</td>
			</tr>
	
<% 
	}
	else
	{
	
		for(Student S : L)  // S-->[101,AAA, 60]
		{
			int rno = S.getRno();
			String name = S.getName();
			double per  = S.getPer();
		
			String cls = "";
			if(per < 40)
			{
				cls ="table-danger";
			}
%>
	
			<tr id="<%= rno %>" class ="<%= cls %>">
				<td> <%= rno %> </td>
				<td> <input type="text" value="<%= name %>" class="form-control me-2 border-danger"/></td>
				<td> <input type="text" value="<%= per %>" class="form-control me-2 border-danger" /></td>
				<td> <input type="button" value="Update" class="btn btn-primary" onclick="modify(<%= rno %>)" ></td>
			</tr>
		
<%	
		}//for
	}//else

%>

</tbody>
</table>
</div>
    
  </body>
</html>