<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    request.setCharacterEncoding("UTF-8"); //한글처리
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@page import="java.sql.*" %>
<%@page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat"%>
<title>StartDisplay</title>
</head>
<body>
<%
	String jdbcDriver = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbUser = "system";
	String dbPass = "1234";
	Connection conn = null; // DBMS와 Java연결객체
	Statement stmt = null; // SQL구문을 실행
	ResultSet rs = null; // SQL구문의 실행결과를 저장
	
	//insert용
	PreparedStatement pstmt = null; // SQL구문을 실행
		int today_idx = 0;
		String td = null;
	try {
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		td = sdf.format(d);
		//오늘날짜 , 형식yyyyMMdd
		System.out.println(sdf.format(d));
		//오늘 주문 번호 확인
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		String idx_query = "SELECT IDX FROM TODAY_IDX WHERE TODAY='"+td+"'";
		System.out.println(idx_query+" >> 쿼리1");
		rs = stmt.executeQuery(idx_query);
		while(rs.next()){
			today_idx = rs.getInt(1);
		}
		if(today_idx < 1){
			System.out.println("오늘 첫주문");
			today_idx = 1;
		}else{
			today_idx += 1;
			System.out.println("==================================");
			System.out.println("│오늘 첫주문은 아님, 주문번호 : " + today_idx+"│");
			System.out.println("==================================");
		}
		stmt.close();
		rs.close();
		
		//주문번호 삽입
		String query = "INSERT INTO TODAY_IDX(IDX,TODAY) VALUES(?,?)";
		pstmt = conn.prepareStatement(query);
		pstmt.setInt(1,today_idx);
		pstmt.setString(2, td);
		pstmt.executeUpdate();
		
	    System.out.println("!!!!!!!!!!!!!!START PROC THE END");

	    pstmt.close();
	    conn.close();
	    
		}catch(Exception e){
		e.getStackTrace();
		}finally{
		try{ // 연결된 DB를 종료
			if (conn != null) {
					System.out.println("데이터베이스와 연결 성공");
				conn.close();
			} else {
				throw new Exception("데이터베이스를 연결할 수 없습니다.");
			}
			if (stmt != null) {
					System.out.println("startproc smt 접속성공");
				stmt.close();
			} else {
				throw new Exception("stmt 에러");
			}
			if (pstmt != null) {
					System.out.println("startproc psmt 접속성공");
				pstmt.close();
		 	} else {
				throw new Exception("psmt 에러");
			}
		} catch (SQLException e) {
			e.getStackTrace();
		}
	}
%>
<%
	request.setAttribute("idx", today_idx);
	request.setAttribute("today", td);
	System.out.println("포워딩합니다*********************");
	request.getRequestDispatcher("../kiosk2/Coffee.jsp").forward(request,response);
	System.out.println("현재 주문번호는 "+today_idx);
	System.out.println("현재 주문번호는 "+td);
%>
</body>
</html>