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

String Del_menu = request.getParameter("DelMenu");

//session 저장하기
session.setAttribute("D", Del_menu);


%>

<form action="DelectDB.jsp" name="DelectDB" method="post">
<textarea name = "menuname"><%=Del_menu %></textarea>

</form>
<script>
/* document.InsertDB.submit(); */
/* alert("주문이 들어갔음."); */
 location.href="DelectDB.jsp"; 

</script>
</body>
</html>