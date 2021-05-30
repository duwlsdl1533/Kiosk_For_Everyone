<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    request.setCharacterEncoding("UTF-8"); //한글처리
   
    String id = request.getParameter("id");
    session.setAttribute("id", id);
    
    System.out.println(id);
%>
<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	Statement stmt1 = null;
	ResultSet rs1 = null;
	PreparedStatement pstmt = null; 
	PreparedStatement pstmt1 = null; 
	PreparedStatement pstmt2 = null; 
	String user = "SYSTEM";
	String pwd = "1234";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	
	
%>
<%
	try{
		// 데이터베이스를 접속하기 위한 드라이버 SW 로드
		Class.forName("oracle.jdbc.driver.OracleDriver");
		// 데이터베이스에 연결하는 작업 수행
		conn = DriverManager.getConnection(url, user, pwd);
		// 쿼리를 생성gkf 객체 생성
	/* 	stmt = conn.createStatement();
		stmt1 = conn.createStatement(); */
		
		pstmt = conn.prepareStatement("select DISTINCT name from alllist WHERE id ='" + id +"'");
		pstmt1 = conn.prepareStatement("select name, sum(cnt) from alllist group by name ORDER BY sum(cnt) DESC");
		
		// 쿼리 생성
		/* rs = stmt.executeQuery("select DISTINCT name from alllist WHERE id ='" + id +"'");
		rs1 = stmt1.executeQuery("select name, sum(cnt) from alllist group by name ORDER BY sum(cnt) DESC"); */
		
		rs = pstmt.executeQuery();
		rs1 = pstmt1.executeQuery();
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/start.css?after"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@page import="java.sql.*" %>
<%@page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat"%>
<title>member StartDisplay</title>
</head>
<body>
	<img id="start" src="../image/logo.jpg" border="0" width="1000px" height="1000px">

	<table id="title" width=50%>
			
			<tr>
				<td>ID</td>
				<td><%=id%></td>
				
			</tr>
			
			<tr>
					<td>번호</td>
					<td>메뉴</td>
					<td>순위</td>
					<td>메뉴</td>
			</tr>
			</table>
	
<%
			int rank = 0;
			int num = 0;
			String name = null;
			String menu = null;
			for(int i=0; i<5; i++) {
			/*while(rs.next()){*/
	%>
			<%	
				rs.next();
				name = rs.getString("name");
				rank = rank + 1;
				
				rs1.next();
				menu = rs1.getString("name");
				num = num + 1;
				
			%>
			
			<table border="1" id="content1">
				<tr>
					<td><%=rank %></td>
					<td><%=name%></td>
					<td><%=num %></td>
					<td><%=menu%></td>
				</tr>
			</table>
			<br>  <br>  <br>
			<%
		
			
		}%>
	<!-- 	<table id="persnal" width=50% align="right">
			<tr>
					<td>순위</td>
					<td>메뉴</td>
				</tr>
		</table> -->
		<%
			/*for(int i =0; i<5; i++){
				
				rs1.next();
				menu = rs1.getString("name");
				num = num + 1;*/
			%>
			<!--  <table border="1" id="content2" width=50% align="right">
				<tr>
					<td> < %=num %></td>
					<td>< %=menu%></td>
				</tr>
			</table> -->
		<%
		//	}
		%>  
			
		<%
	} catch (Exception e) {
		e.printStackTrace();
		} finally {
		try {
		if (rs != null) {
			rs.close();
		}
		if (rs1 != null) {
			rs1.close();
		}
		if (stmt != null) {
			pstmt.close();
		}
		if (stmt1 != null) {
			pstmt1.close();
		}
		if (conn != null) {
			conn.close();
		}
		} catch (Exception e) {
		e.printStackTrace();
		}
		}
		%>
	<br>  <br>  <br>  
	<button type="button" onclick="location.href='../kioskvoice/Order.jsp'">
		직원에게 주문하기</button> <br>  <br>  <br>  
	<button type="button" onclick="location.href='../kiosk2/startProc.jsp'">
		기존방식으로 주문하기</button>
		<br>  <br>  <br>  
	<button type="button" onclick="location.href=''">
		직원호출하기</button>
</body>
</html>