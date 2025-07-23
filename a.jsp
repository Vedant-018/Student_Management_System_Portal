<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
function display(){
	var h1= document.getElementById("msg");
	h1.innerText ="INDIA ";

}
function show(){
	var sn =document.getElementById("sn");
	var data = sn.value;// data="sachin"
	sn.value = data.toUpperCase();
}
</script>



<body>
<h1 id="msg">Welcome !</h1>
<input type="text" name="sn" id="sn" class="" onkeyup="show()"/><br>
<input type ="button" value="Click Here" onclick="display()">



</body>
</html>