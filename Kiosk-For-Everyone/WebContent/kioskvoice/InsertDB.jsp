<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DB에 데이터 넣기</title>
</head>
<body>
<%
// POST 방식의 한글처리
request.setCharacterEncoding("UTF-8");

// 파라미터 정보 가져오기

String amount = request.getParameter("amount");

//session 정보 가져오기
String menuname = (String)session.getAttribute("n");
String price = (String)session.getAttribute("p");
String id = (String)session.getAttribute("id");
String Storagename = (String)session.getAttribute("S");

//amount가 널이면 갯수 주문화면으로
if(amount==null){
	response.sendRedirect("NumOrder.jsp");
}
//그렇지 않으면 DB에 insert
else{
	System.out.println(amount);
	System.out.println(menuname);
	System.out.println(Storagename);
	System.out.println(price);
	
	
	int amount1 = Integer.parseInt(amount);
	int menuprice = amount1 * Integer.parseInt(price);
	
	
	
	// JDBC 참조 변수 준비
	Connection con = null; 
	PreparedStatement pstmt = null; 
	PreparedStatement pstmt1 = null;
	String user = "SYSTEM";
	String pwd = "1234";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	// 1) JDBC 드라이버 로딩
	Class.forName("oracle.jdbc.OracleDriver");

	// 2) DB연결(DB url, DB id, DB pw)
	con = DriverManager.getConnection(url, user, pwd);

	// 3) SQL문 준비
	
	String sql = "merge into kiosk  USING dual on(name = ?) when not matched then INSERT (id, name, amount, price) VALUES (?, ?, ?, ?)";
	/* String sql1 = "merge into pos  USING dual on(name = ?) when not matched then INSERT (name, amount, price) VALUES (?, ?, ?)";  */// 중복되지 않으면 insert

	pstmt = con.prepareStatement(sql);
	/* pstmt1 = con.prepareStatement(sql1);
	 */
	if(menuname == null){
		pstmt.setString(1, Storagename);
		pstmt.setString(2, id);
		pstmt.setString(3, Storagename);
		pstmt.setDouble(4, amount1);
		pstmt.setDouble(5, menuprice);
		
		/* pstmt1.setString(1, Storagename);
		pstmt1.setDouble(2, amount1); */
	}
	else{
		pstmt.setString(1, menuname);
		pstmt.setString(2, id);
		pstmt.setString(3, menuname);
		pstmt.setDouble(4, amount1);
		pstmt.setDouble(5, menuprice);
		
		/* pstmt1.setString(1, menuname);
		pstmt1.setDouble(2, amount1); */
	}
	
	
 	/* pstmt1.setString(1, menuname);
	pstmt1.setDouble(2, amount1); */

	// 4) 실행
	pstmt.executeUpdate();
	/*  pstmt1.executeUpdate(); */
	
	// JDBC 자원 닫기
	pstmt.close();
/* 	pstmt1.close();
	 */
	con.close();
	 
	// session 초기화 
	/* session.invalidate(); */
}
%>

<div name = "n"><%=menuname %></div>
<div name = "p"><%=price %></div>
<div name = "a"><%=amount %></div>
<script>
location.href="ReOrder.jsp";
</script>
</body>
</html>