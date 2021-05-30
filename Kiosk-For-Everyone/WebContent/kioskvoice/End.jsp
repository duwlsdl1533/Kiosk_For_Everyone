<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마지막페이지</title>
</head>
<body>
<link rel="stylesheet" type="text/css" href="../css/voice_End.css"/>
<%
// POST 방식의 한글처리
request.setCharacterEncoding("UTF-8");

//JDBC 참조 변수 준비
	Connection con = null; 
	PreparedStatement pstmt = null; 
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "SYSTEM", pw = "1234";

	// 1) JDBC 드라이버 로딩
	Class.forName("oracle.jdbc.OracleDriver");

	// 2) DB연결(DB url, DB id, DB pw)
	con = DriverManager.getConnection(url, user, pw);

	// 3) SQL문 준비 (초기화 해주기)
	String sql = "DELETE FROM KIOSK";
	
	pstmt = con.prepareStatement(sql);
	
	// 4) 실행
	pstmt.executeUpdate();

	// JDBC 자원 닫기
	pstmt.close();
	con.close();
%>
<img id="start" src="../image/Thankyou.jpg" border="0" width="800px" height="800px">
<h1>주문이 완료 되었습니다.</h1>
<h1>감사합니다.</h1>

</body>
</html>