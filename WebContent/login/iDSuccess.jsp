<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import ="net.member.db.MemberBean" %>
	<%@ page import ="java.util.ArrayList" %>
	<%
		ArrayList <String> idList = (ArrayList<String>)request.getAttribute("IdList");
	
		
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
* {
	margin: 0;
	padding: 0;
	text-decoration: none;
	font-family: motserrat;
}

body {
	min-height: 100vh;
	background-image: linear-gradient(to right, #283048, #859398);
}
div{
background-color : white;
align : center;}

</style>

<title>프로젝트 로그인폼</title>
<link rel="stylesheet" href="style.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"
	charset="utf-8"></script>
</head>
<body>
<div align="center" >

	<h1>ID찾기</h1>
	
	<%
		for(String id :  idList) {
	%>
	<div class="txtb">ID의 값은 <a href="./login/foundPW.jsp?id=<%=id%>"><%= id %></a></div>
	<%} %>

</div>
</body>
</html>



