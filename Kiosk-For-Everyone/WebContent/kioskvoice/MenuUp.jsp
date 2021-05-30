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
<!-- <script type="text/javascript" src="../js/jquery-3.5.1.min.js"></script>
 --><script>

var menu_name;
var menu_price=[['오늘의커피',3500],['에스프레소',3000],['아메리카노',4000],['아이스아메리카노',4000],['아이스카페라떼',4500],['카라멜마끼아또',5500],['카푸치노',5000],['아이스카푸치노',5000],['자몽에이드',5500],['오렌지에이드',6000],['자몽셔벗에이드',6000],['샹그리아에이드',6500],['망고스무디',5000],['요거트스무디',6000],['딸기스무디',5500],['녹차스무디',5500],['체리스무디',6000],['블루베리베이글',5800],['뺑오쇼콜라',6000],['하트파이',6500],['레드벨벳케이크',6500],['치즈케이크',7000],['단호박에그샌드위치',7000],['에그에그샌드위치',7000],['크로크무슈',7000],['호두당근케이크',7000],['사과주스',4500],['자몽주스',5000],['오렌지주스',3500],['생수',3000]];
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

function MUSTT(){
	  window.SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;

	 	 var recognition = new SpeechRecognition();
	 	 recognition.interimResults = true; // true면 음절을 연속적으로 인식하나 false면 한 음절만 기록함
	 	 recognition.lang = 'ko-KR';
		 recognition.maxAlternatives = 10000; // 숫자가 작을수록 발음대로 적고, 크면 문장의 적합도에 따라 알맞은 단어로 대체합니다.
			// maxAlternatives가 크면 이상한 단어도 문장에 적합하게 알아서 수정합니다.
	  
	 	/*  var words = document.querySelector('.words'); */
	 	/*  var text = document.querySelector('.text'); */
	 	 var MenuUp = document.querySelector('.MenuUp');
	 	 var Storagename = document.querySelector('.Storagename');
	 	var sell_price = document.querySelector('.sell_price');
		 var transcript;
		
	 	// 음성 인식 시작
	 	recognition.start();
	 	console.log(menu_name);
	 	function A(e) {
	 		transcript = Array.from(e.results)
			.map(result => result[0])
	 		.map(result => result.transcript)
	 		.join('');
	 	    
	 	/* 	words.textContent = transcript;  */
	 		    
	 		console.log(transcript);
	 		
	 		menu = transcript.replace(/ /gi,"");
	 		
	 		console.log(menu);
	 	
	 		/* console.log(name); */
	 		
	 		//주문한 내용중에 있으면 update페이지로 이동
	 		if(menu_name.includes(menu)){
	 			MenuUp.textContent = menu;
	 			setTimeout(function(){
	 				document.MenuUp.submit();
				}, 2000);
	 			
	 		}
	 		//새로운메뉴 추가이면 메뉴 저장
	 		else{
	 			for(var i = 0; i<menu_price.length; i++){
		 			if(menu==menu_price[i][0]){//해당 메뉴가 있으면
		 				Storagename.textContent = menu;
		 				sell_price.textContent = menu_price[i][1];
		 				 document.Storage.submit(); 
		 				 System.out.println(menu); 
		 			}
		 			else{
		 				 setTimeout(function() {
							location.href="MenuUp.jsp";
						}, 3000);
		 			}
	 			}
	 		}
	 	}
	
	 	recognition.onresult=A;
}
</script>
</head>


<body onload="MUSTT()";>
<img id="introimg" src="../image/waiter.gif" border="0" width="1000px" height="1000px">
<img id="menu" src="../image/menu.png" border="0" width="1112px" height="834px">
<audio autoplay src ="mp3/what_add.mp3"></audio>
<h1>무슨 메뉴를 추가하시겠습니까? 메뉴 이름을 말씀해주세요</h1>
 <!-- 음성으로 말하기 -->

<form name="MenuUp" action = "UpStorage.jsp" method="post" >
<textarea class="MenuUp" name="MenuUp"></textarea>
</form>

<form name = "Storage" action="Storage.jsp" method="post">
<textarea class = "Storagename" name = "Storagename"></textarea>
<textarea class="sell_price" name="sell_price"></textarea>
</form>
</body>
</html>