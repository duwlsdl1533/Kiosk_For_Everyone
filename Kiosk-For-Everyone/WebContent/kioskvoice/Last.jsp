<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> 
<link rel="stylesheet" type="text/css" href="../css/Last.css?after"/>

<img id="start" src="../image/Thankyou.jpg" border="0" width="800px" height="800px">
 <%!// 변수 선언

	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null; 
	String user = "SYSTEM";
	String pwd = "1234";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	
	String sql = "select * from KIOSK ";
%> 	
<%
		try {
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>최중 주문 페이지</title>
</head>
<body>
<table id="title">
			<tr>
					<td>메뉴</td>
					<td>수량</td>
					<td>가격</td>
				</tr>
			</table>

<%
			int sum = 0;
			String name = null;
			String amount = null;
			String price = null;
			while (rs.next()) {
	%>
			<%
			
				name = rs.getString("name");
			    amount = rs.getString("amount");
			    price = rs.getString("price");
					
				int fee = 0;
			%>
			<%
				fee = Integer.parseInt(price);
				sum = fee+sum;
			%>
			
			<table border="1" id="content">
				<tr>
					<td><%=name%></td>
					<td><%=amount%></td>
					<td><%=fee%></td>
				</tr>
			</table>
			
			
			<%
		}%>
		<br><br><br><br>
		<h1>합계 : <%=sum%></h1>
		
		
		<%
		String allsql = "insert into  ALLLIST (name, cnt, id) select name, amount, id from kiosk";
		pstmt = conn.prepareStatement(allsql);
		pstmt.executeUpdate();
		pstmt.close();
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
<!-- <script type="text/javascript">

setTimeout(function(){
	location.href="End.jsp";
}, 5000); 
 
</script> -->
<button type="button" id="pay_voice" name="pay_voice" onclick="location.href='../kioskvoice/End.jsp'">결제하기</button>

</body>
</html>