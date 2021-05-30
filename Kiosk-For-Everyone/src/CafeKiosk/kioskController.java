package CafeKiosk;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

public class kioskController {
	/*전역변수를 써서 다른 함수에서도 close할수 있도록*/
	Connection conn = null; // DBMS와 Java연결객체
	Statement stmt = null; // SQL구문을 실행
	ResultSet rs = null; // SQL구문의 실행결과를 저장
	public kioskController() throws SQLException{
		
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
	
	//리스트출력
//	@SuppressWarnings("rawtypes")
	public ArrayList CoffeeList(HttpServletRequest request) throws Exception{
		//insert용
		ArrayList<HashMap> cfList = new ArrayList<HashMap>();
		try {
			
			stmt = conn.createStatement();
			
			HashMap map;
			int idx = (int)request.getAttribute("idx");
			String td = (String)request.getAttribute("today");
			System.out.println(idx + "  키오스크 컨트롤러에서!!");
			
			String idx_query = "SELECT CF_NAME, CF_CNT, CF_FEE FROM COFFEE_ORDER WHERE IDX='"+idx+"' AND TODAY='"+td+"'";
			//String idx_query = "SELECT CF_NAME, CF_CNT, CF_FEE FROM COFFEE_ORDER WHERE IDX ='"+idx+"' AND TODAY='"+td+"'" ;
			//String first_query="SELECT CF_NAME, CF_CNT, CF_FEE FROM COFFEE_ORDER WHERE IDX="+idx;
			//String second_query="SELECT CF_NAME, CF_CNT, CF_FEE FROM COFFEE_ORDER WHERE TODAY="+td;
			//String idx_query=first_query+ "AND"+ second_query;
//			String idx_query="SELECT CF_NAME,CF_CNT,CF_FEE FROM COFFEE_ORDER WHERE IDX='3' AND TODAY='20210319'";
			System.out.println(idx_query+" >> 커피리스트 불러와지는지");
			System.out.println("============================================커피끝＃＃");
			rs = stmt.executeQuery(idx_query);
			while(rs.next()){
				map = new HashMap();
				map.put("CF_NAME",rs.getString(1)); 
				map.put("CF_CNT",rs.getInt(2));
				map.put("CF_FEE",rs.getInt(3));
				cfList.add(map);
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
			} catch (SQLException e) {
				e.getStackTrace();
			}
		}
		return cfList;
	}
	//리스트출력
//	@SuppressWarnings("rawtypes")
	public ArrayList AdeList(HttpServletRequest request) throws Exception{
		//insert용
		PreparedStatement pstmt = null; // SQL구문을 실행
		ArrayList<HashMap> adeList = new ArrayList<HashMap>();
		try {
			
			stmt = conn.createStatement();
			
			HashMap map;
			int idx = (int)request.getAttribute("idx");
			String td = (String)request.getAttribute("today");
			System.out.println(idx + "    키오스크 컨트롤러에서!!");
			
			String idx_query1 = "SELECT ADE_NAME, ADE_CNT, ADE_FEE FROM ADE_ORDER WHERE IDX ='"+idx+"' AND TODAY='"+td+"'";
		    System.out.println(idx_query1+" >> 에이드리스트 불러와지는지");
		    System.out.println("============================================에이드끝＃＃");
		    rs = stmt.executeQuery(idx_query1);
		    while(rs.next()){
		         map = new HashMap();
		         map.put("ADE_NAME",rs.getString(1)); 
		         map.put("ADE_CNT",rs.getInt(2));
		         map.put("ADE_FEE",rs.getInt(3));
		         adeList.add(map);
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
			} catch (SQLException e) {
				e.getStackTrace();
			}
		}
		return adeList;
	}
	//리스트출력
//	@SuppressWarnings("rawtypes")
	public ArrayList SmoothieList(HttpServletRequest request) throws Exception{
		//insert용
		PreparedStatement pstmt = null; // SQL구문을 실행
		ArrayList<HashMap> smtList = new ArrayList<HashMap>();
		try {
			
			stmt = conn.createStatement();
			
			HashMap map;
			int idx = (int)request.getAttribute("idx");
			String td = (String)request.getAttribute("today");
			System.out.println(idx + "    키오스크 컨트롤러에서!!");
			
			String idx_query1 = "SELECT SMT_NAME, SMT_CNT, SMT_FEE FROM SMT_ORDER WHERE IDX='"+idx+"' AND TODAY='"+td+"'";
		    System.out.println(idx_query1+" >>스무디스트 불러와지는지");
		    rs = stmt.executeQuery(idx_query1);
		    while(rs.next()){
		         map = new HashMap();
		         map.put("SMT_NAME",rs.getString(1)); 
		         map.put("SMT_CNT",rs.getInt(2));
		         map.put("SMT_FEE",rs.getInt(3));
		         smtList.add(map);
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
			} catch (SQLException e) {
				e.getStackTrace();
			}
		}
		return smtList;
	}
	//리스트출력
//	@SuppressWarnings("rawtypes")
	public ArrayList BottleList(HttpServletRequest request) throws Exception{
		//insert용
		PreparedStatement pstmt = null; // SQL구문을 실행
		ArrayList<HashMap> btList = new ArrayList<HashMap>();
		try {
			
			stmt = conn.createStatement();
			
			HashMap map;
			int idx = (int)request.getAttribute("idx");
			String td = (String)request.getAttribute("today");
			System.out.println(idx + "    키오스크 컨트롤러에서!!");
			
			String idx_query1 = "SELECT BT_NAME, BT_CNT, BT_FEE FROM BT_ORDER WHERE IDX='"+idx+"' AND TODAY='"+td+"'";
		    System.out.println(idx_query1+" >> 병리스트 불러와지는지");
		    rs = stmt.executeQuery(idx_query1);
		    while(rs.next()){
		         map = new HashMap();
		         map.put("BT_NAME",rs.getString(1)); 
		         map.put("BT_CNT",rs.getInt(2));
		         map.put("BT_FEE",rs.getInt(3));
		         btList.add(map);
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
			} catch (SQLException e) {
				e.getStackTrace();
			}
		}
		return btList;
	}
	//리스트출력
//	@SuppressWarnings("rawtypes")
	public ArrayList BreadList(HttpServletRequest request) throws Exception{
		//insert용
		PreparedStatement pstmt = null; // SQL구문을 실행
		ArrayList<HashMap> brdList = new ArrayList<HashMap>();
		try {
			
			stmt = conn.createStatement();
			
			HashMap map;
			int idx = (int)request.getAttribute("idx");
			String td = (String)request.getAttribute("today");
			System.out.println(idx + "    키오스크 컨트롤러에서!!");
			
			String idx_query1 = "SELECT BRD_NAME, BRD_CNT, BRD_FEE FROM BRD_ORDER WHERE IDX='"+idx+"' AND TODAY='"+td+"'";
		    System.out.println(idx_query1+" >> 빵리스트 불러와지는지");
		    rs = stmt.executeQuery(idx_query1);
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
			} catch (SQLException e) {
				e.getStackTrace();
			}
		}
		return brdList;
	}
	//메뉴 count 쿼리
	/*
	 * public String countMenuList(HttpServletRequest request) throws Exception{ int
	 * cnt = 0; int idx = (int)request.getAttribute("idx"); String td =
	 * (String)request.getAttribute("today"); String mn =
	 * request.getParameter("mn"); String cnt_query = null; try { stmt =
	 * conn.createStatement(); if(mn.equals("coffee")) { cnt_query =
	 * "SELECT COUNT(*) FROM COFFEE_ORDER WHERE IDX='"+idx+"' AND TODAY='"+td+"'"; }
	 * if(mn.equals("smoothie")) { cnt_query =
	 * "SELECT COUNT(*) FROM SMT_ORDER WHERE IDX='"+idx+"' AND TODAY='"+td+"'"; }
	 * if(mn.equals("bread")) { cnt_query =
	 * "SELECT COUNT(*) FROM BRD_ORDER WHERE IDX='"+idx+"' AND TODAY='"+td+"'"; }
	 * if(mn.equals("ade")) { cnt_query =
	 * "SELECT COUNT(*) FROM ADE_ORDER WHERE IDX='"+idx+"' AND TODAY='"+td+"'"; }
	 * if(mn.equals("bottle")) { cnt_query =
	 * "SELECT COUNT(*) FROM BT_ORDER WHERE IDX='"+idx+"' AND TODAY='"+td+"'"; }
	 * 
	 * System.out.println(cnt_query+" >> 오늘 해당 메뉴의 주문 건수는?"); rs =
	 * stmt.executeQuery(cnt_query); if(rs.next()) { cnt = rs.getInt(1); }
	 * 
	 * if(cnt == 0) { return "new"; }
	 * 
	 * if(cnt >=1 ) { return "update"; } stmt.close(); rs.close(); conn.close();
	 * }catch(Exception e){ e.getStackTrace(); }finally{ try{ // 연결된 DB를 종료 if (conn
	 * != null) { // System.out.println("데이터베이스와 연결 성공"); conn.close(); } else {
	 * throw new Exception("데이터베이스를 연결할 수 없습니다."); } if (stmt != null) { //
	 * System.out.println("psmt 접속성공"); stmt.close(); } else { throw new
	 * Exception("stmt 에러"); } } catch (SQLException e) { e.getStackTrace(); } }
	 * return false; }
	 */
}
	
	