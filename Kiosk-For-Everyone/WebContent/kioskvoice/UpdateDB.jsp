<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> 
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숫자 감소</title>

<%
request.setCharacterEncoding("UTF-8");

String Up_amount = request.getParameter("UpAmount");

String Up_name = (String)session.getAttribute("M");
String price = (String)session.getAttribute("p");

if(Up_amount == null){
	response.sendRedirect("NumUp.jsp");
}
else{ 
	 int Up_num = Integer.parseInt(Up_amount); 

	System.out.println(Up_name);
	System.out.println(Up_amount);
	System.out.println(price);
%>

<% // 변수 선언

	Connection conn = null; 
 	PreparedStatement pstmt = null; 
	Statement stmt = null;
	ResultSet rs = null;
	
	String user = "SYSTEM";
	String pwd = "1234";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	
		// 데이터베이스를 접속하기 위한 드라이버 SW 로드
		Class.forName("oracle.jdbc.driver.OracleDriver");
		// 데이터베이스에 연결하는 작업 수행
		conn = DriverManager.getConnection(url, user, pwd);
		
		stmt = conn.createStatement();
		/* String name_sql="select amount from KIOSK where NAME = "+Del_name+"";
	
		 ResultSet rs = stmt.executeQuery(name_sql); */
		String name_sql = "select amount from KIOSK where name = ?";
		pstmt = conn.prepareStatement(name_sql);
		pstmt.setString(1, Up_name);
		rs = pstmt.executeQuery();
		
		int amount = 0;
	
		/* if(!rs.next()){
			out.println("해당하는 정보가 없습니다.");
		}
		else{
			rs.previous();
		} */
		String num = null;
		int nnum=0;
		while(rs.next()){
			num = rs.getString("amount");
			nnum=Integer.parseInt(num);
			System.out.println(num);
		}
		
		
		amount = nnum + Up_num;
		int menuprice = amount * Integer.parseInt(price);
		String sql = "update KIOSK set amount = ?, price = ? where name = ?";
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1, amount);
		pstmt.setInt(2, menuprice);
		pstmt.setString(3, Up_name);
		
		pstmt.executeUpdate();
		pstmt.close(); 
 		
		System.out.println(amount);
}
%>

</head>
<body>
<script type="text/javascript">
location.href="ReOrder.jsp";
</script>

</body>
</html>