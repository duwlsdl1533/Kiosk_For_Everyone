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

//파라미터 정보 가져오기

String name = request.getParameter("menu");
String price = request.getParameter("sell_price");
String storagename = request.getParameter("Storagename");

//session 저장하기
session.setAttribute("n", name);
session.setAttribute("p", price);
session.setAttribute("S", storagename);


%>

<form action="InsertDB.jsp" name="InsertDB" method="post">
<textarea name = "menuname"><%=name %></textarea>
<textarea name = "menuprice"><%=price %></textarea>
<textarea name = "storagename"><%=storagename %></textarea>

</form>
<script>
/* document.InsertDB.submit(); */
/* alert("주문이 들어갔음."); */
 location.href="InsertDB.jsp"; 
</script>
</body>
</html>