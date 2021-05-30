<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="../js/jquery-1.7.1.js"></script>
<% 
	request.setCharacterEncoding("UTF-8"); //한글처리
	String idx = (String)session.getAttribute("idx");
%>
<script type="text/javascript">
</script>

</head>
<body>
<%@page import="java.sql.*" %>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%
	String jdbcDriver = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbUser = "system";
	String dbPass = "1234";
	Connection conn = null; // DBMS와 Java연결객체
	Statement stmt = null; // SQL구문을 실행
	ResultSet rs = null; // SQL구문의 실행결과를 저장
	
	//insert용
	PreparedStatement pstmt = null; // SQL구문을 실행
	try {
		//오늘 주문 번호 확인
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		
		ArrayList<HashMap> brdList = new ArrayList<HashMap>();
		HashMap map;
		
		String idx_query = "SELECT BRD_NAME, BRD_CNT, BRD_FEE FROM BRD_ORDER WHERE IDX='"+idx+"'";
		System.out.println(idx_query+" >> 쿼리2");
		rs = stmt.executeQuery(idx_query);
		while(rs.next()){
			map = new HashMap();
	         map.put("BRD_NAME",rs.getString(1)); 
	         map.put("BRD_CNT",rs.getInt(2));
	         map.put("BRD_FEE",rs.getInt(3));
	         brdList.add(map);
		}	
		stmt.close();
		rs.close();
		conn.close();
	}catch(Exception e){
	e.getStackTrace();
	}finally{
	try{ // 연결된 DB를 종료
		if (conn != null) {
	//			System.out.println("데이터베이스와 연결 성공");
			conn.close();
		} else {
			throw new Exception("데이터베이스를 연결할 수 없습니다.");
		}
		if (stmt != null) {
	//			System.out.println("psmt 접속성공");
			stmt.close();
		} else {
			throw new Exception("stmt 에러");
		}
		if (pstmt != null) {
			//			System.out.println("psmt 접속성공");
					stmt.close();
			 	} else {
					throw new Exception("pstmt 에러");
				}
	} catch (SQLException e) {
		e.getStackTrace();
	}
}
System.out.println("The end");
%>
</body>