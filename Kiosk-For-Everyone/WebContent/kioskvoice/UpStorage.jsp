<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>session 저장</title>
</head>
<body>
<%
// POST 방식의 한글처리
request.setCharacterEncoding("UTF-8");

// 파라미터 정보 가져오기

String MenuUp = request.getParameter("MenuUp");

//session 저장하기
session.setAttribute("M", MenuUp);


%>


<textarea name = "menuname"><%=MenuUp %> </textarea>


<script>
/* document.InsertDB.submit(); */
/* alert("주문이 들어갔음."); */
 location.href="UpdateDB.jsp"; 

</script>
</body>
</html>