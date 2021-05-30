<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    request.setCharacterEncoding("UTF-8"); //한글처리
%>
<%
	/* String menu[] = {"오늘의 커피","에스프레소","아메리카노","아이스 아메리카노","아이스 카페라떼","카라멜 마키아또","카푸치노","아이스 카푸치노","자몽 에이드","오렌지 에이드","자몽 셔벗 에이드","샹그리아 에이드","망고 스무디","딸기 스무디","녹차 스무디","체리 스무디","요거트 스무디","블루베리 베이글","뺑 오 쇼콜라","하트파이","레드벨벳 케이크","치즈 케이크","단호박 에그 샌드위치","에그에그 샌드위치","크로크무슈","호두당근케이크","사과주스","자몽주스","오렌지주스","생수"};
	 */
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null; 
	String user = "SYSTEM";
	String pwd = "1234";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";

	String sql = "select name, sum(cnt) from alllist group by name ORDER BY sum(cnt) DESC";
%>
<%
	try{
		// 데이터베이스를 접속하기 위한 드라이버 SW 로드
		Class.forName("oracle.jdbc.driver.OracleDriver");
		// 데이터베이스에 연결하는 작업 수행
		conn = DriverManager.getConnection(url, user, pwd);
		// 쿼리를 생성gkf 객체 생성
		stmt = conn.createStatement();
		// 쿼리 생성
		rs = stmt.executeQuery(sql);
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/start.css?after"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@page import="java.sql.*" %>
<%@page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat"%>
<title>nonmember StartDisplay</title>
</head>
<body>
<br>  <br>  <br> 
	<img id="start" src="../image/logo.jpg" border="0" width="1000px" height="1000px">
	<table id="title">
			<tr>
					<td>순위</td>
					<td>메뉴</td>
				</tr>
			</table>

<%
			int rank = 0;
			String name = null;
			for(int i =0; i<5; i++) {
	%>
			<%
				rs.next();
				name = rs.getString("name");
			%>
			 <%
			 rank=rank+1;
			%>
			<table border="1" id="content">
				<tr>
					<td><%=rank %></td>
					<td><%=name%></td>
				</tr>
			</table>
			
			
			
			<%
		}%>
		<%
	} catch (Exception e) {
		e.printStackTrace();
		} finally {
		try {
		if (rs != null) {
			rs.close();
		}
		if (stmt != null) {
			stmt.close();
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
		기존방식으로 주문하기</button> <br>  <br>  <br>
	<button type="button" onclick="location.href=''">
		직원호출하기</button>
</body>
</html>