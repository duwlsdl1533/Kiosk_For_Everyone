package CafeKiosk;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class payController {
	/*전역변수를 써서 다른 함수에서도 close할수 있도록*/
	Connection conn = null; // DBMS와 Java연결객체
	Statement stmt = null; // SQL구문을 실행
	ResultSet rs = null; // SQL구문의 실행결과를 저장
	public payController() throws SQLException{
		
		String user = "SYSTEM";
		   String pw = "1234";
		   String url = "jdbc:oracle:thin:@localhost:1521:XE";
		try {
			//오늘 주문 번호 확인
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, user, pw);
			stmt = conn.createStatement();
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	//결제
//	@SuppressWarnings("rawtypes")
	public ArrayList paymentControll(HttpServletRequest request) throws Exception{
		ArrayList<HashMap> allList  = new ArrayList<HashMap>();
		PreparedStatement pstmt = null; // SQL구문을 실행
		//HashMap map = null;
		try {
			stmt = conn.createStatement();
			
			HashMap map;
			int idx = (int)request.getAttribute("idx");
			String td = (String)request.getAttribute("today");
			System.out.println("날짜 : "+ td +"주문번호 : "+idx);
			String query = "";
			System.out.println("@@@@@@@@@@자 계산 들어갑니다@@@@@@@@@@@@@");
			query += "SELECT DISTINCT(IDX), TODAY,";
			query += "NVL((SELECT SUM(CF_FEE) FROM COFFEE_ORDER WHERE IDX="+idx+" AND TODAY='"+ td +"'),0) AS CF_SUM, ";
			query += "NVL((SELECT SUM(ADE_FEE) FROM ADE_ORDER WHERE IDX="+idx+" AND TODAY='"+ td +"'),0) AS ADE_SUM, ";
			query += "NVL((SELECT SUM(SMT_FEE) FROM SMT_ORDER WHERE IDX="+idx+" AND TODAY='"+ td +"'),0) AS SMT_SUM, ";
			query += "NVL((SELECT SUM(BT_FEE) FROM BT_ORDER WHERE IDX="+idx+" AND TODAY='"+ td +"'),0) AS BT_SUM, ";
			query += "NVL((SELECT SUM(BRD_FEE) FROM BRD_ORDER WHERE IDX="+idx+" AND TODAY='"+ td +"'),0) AS BRD_SUM ";
			query += "FROM TODAY_IDX WHERE 1=1 ";
			query += "AND IDX = '"+idx+"' AND TODAY = '"+td+"'";
			System.out.println(query);
			rs = stmt.executeQuery(query);
			while(rs.next()){
				map = new HashMap();
				map.put("IDX",rs.getInt(1));
				map.put("TODAY",rs.getString(2));
				map.put("CF_SUM",rs.getInt(3)); 
				map.put("ADE_SUM",rs.getInt(4)); 
				map.put("SMT_SUM",rs.getInt(5)); 
				map.put("BT_SUM",rs.getInt(6));
				map.put("BRD_SUM",rs.getInt(7));
				int result = rs.getInt(3)+rs.getInt(4)+rs.getInt(5)+rs.getInt(6)+rs.getInt(7);
				map.put("TOTAL",result);
				allList.add(map);
			}	
			System.out.println("@@@@@@@@@계산 끝나씁니다@@@@@@@@@@@@@");
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
			} catch (SQLException e) {
				e.getStackTrace();
			}
		}
		return allList;
	}
}
