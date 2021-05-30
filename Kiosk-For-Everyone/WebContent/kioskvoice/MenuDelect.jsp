<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import = "java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/addordel.css"/>
<meta charset="UTF-8">
<title>되묻는 페이지</title>
<script type="text/javascript" src="../js/jquery-3.5.1.min.js"></script>
<script>
/* var menu = ["오늘의 커피","에스프레소","아메리카노","아이스 아메리카노","아이스 카페라떼","카라멜 마끼아또","카푸치노","아이스 카푸치노","자몽에이드","오렌지에이드","자몽 셔벗 에이드","샹그리아 에이드","망고 스무디","딸기스무디","녹차스무디","체리스무디","블루베리베이글","뺑오쇼콜라","하트파이","레드벨벳케이크","치즈케이크","단호박에그샌드위치","에그에그샌드위치","크로크무슈","호두당근케이크","사과 주스","자몽 주스","오렌지 주스","생수"]; */
var menu_name;
<%!// 변수 선언
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String user = "SYSTEM";
	String pwd = "1234";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String sql = "select name from KIOSK";
%> 	
<%
	/* 	try { */
		// 데이터베이스를 접속하기 위한 드라이버 SW 로드
		Class.forName("oracle.jdbc.driver.OracleDriver");
		// 데이터베이스에 연결하는 작업 수행
		conn = DriverManager.getConnection(url, user, pwd);
		// 쿼리를 생성gkf 객체 생성
		stmt = conn.createStatement();
		// 쿼리 생성
		rs = stmt.executeQuery(sql);
%>
<%
int i =0;
ArrayList<String> name = new ArrayList<String>();

while(rs.next()){
	name.add(i,rs.getString("name"));
	i++;
}


for(int j =0 ; j<name.size(); j++){
%>
menu_name += '<%=name.get(j)%>';

<%
}
%>

<%
rs.close();
stmt.close();
conn.close();
%>

function MDSTT(){
	  window.SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;

	 	 var recognition = new SpeechRecognition();
	 	 recognition.interimResults = true; // true면 음절을 연속적으로 인식하나 false면 한 음절만 기록함
	 	 recognition.lang = 'ko-KR';
		 recognition.maxAlternatives = 10000; // 숫자가 작을수록 발음대로 적고, 크면 문장의 적합도에 따라 알맞은 단어로 대체합니다.
			// maxAlternatives가 크면 이상한 단어도 문장에 적합하게 알아서 수정합니다.
	  
	 	 var words = document.querySelector('.words');
	 	/*  var text = document.querySelector('.text'); */
	 	 var DelMenu = document.querySelector('.DelMenu');
		 var transcript;
		
	 	// 음성 인식 시작
	 	recognition.start();
	 	console.log(menu_name);
	 	function A(e) {
	 		transcript = Array.from(e.results)
			.map(result => result[0])
	 		.map(result => result.transcript)
	 		.join('');
	 	    
	 		words.textContent = transcript; 
	 		    
	 		console.log(transcript);
	 		
	 		menu = transcript.replace(/ /gi,"");
	 		
	 	
	 		/* console.log(name); */
	 		
	 		//주문한 내용중에 있으면 페이지 이동
	 		if(menu_name.includes(menu)){
	 			DelMenu.textContent = menu;
	 			setTimeout(function(){
	 				document.MenuDel.submit();
				}, 2000);
	 			
	 		}
	 		//아니면 다시 말하기
	 		else{
	 			setTimeout(function(){
	 				 location.href="MenuDelect.jsp";
	 				/* console.log("1"); */
				}, 5000);
	 			
	 	}  
	}
	 	recognition.onresult=A;
}
</script>
</head>


<body onload="MDSTT()";>
<img id="introimg" src="../image/waiter.gif" border="0" width="1000px" height="1000px">
<img id="menu" src="../image/menu.png" border="0" width="1112px" height="834px">
<audio autoplay src ="mp3/what_del.mp3"></audio>
<h1>무슨 메뉴를 취소하시겠습니까? 취소하는 메뉴 이름을 말씀해주세요</h1>
 <!-- 음성으로 말하기 -->

<form name="MenuDel" action = "Del_Storage.jsp" method="post" >
<textarea class="words" name="words"></textarea> 
<textarea class="DelMenu" name="DelMenu"></textarea>
</form>

</body>
</html>