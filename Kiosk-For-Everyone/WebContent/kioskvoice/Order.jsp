<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="../css/Order.css?after"/>
<title>CoffeeOrderPage</title>
<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>

var menu_price=[['오늘의커피',3500],['에스프레소',3000],['아메리카노',4000],['아이스아메리카노',4000],['아이스카페라떼',4500],['카라멜마끼아또',5500],['카푸치노',5000],['아이스카푸치노',5000],['자몽에이드',5500],['오렌지에이드',6000],['자몽셔벗에이드',6000],['샹그리아에이드',6500],['망고스무디',5000],['요거트스무디',6000],['딸기스무디',5500],['녹차스무디',5500],['체리스무디',6000],['블루베리베이글',5800],['뺑오쇼콜라',6000],['하트파이',6500],['레드벨벳케이크',6500],['치즈케이크',7000],['단호박에그샌드위치',7000],['에그에그샌드위치',7000],['크로크무슈',7000],['호두당근케이크',7000],['사과주스',4500],['자몽주스',5000],['오렌지주스',3500],['생수',3000]];

function OrderSTT(){
	  window.SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;

	var recognition = new SpeechRecognition();
	recognition.interimResults = true; // true면 음절을 연속적으로 인식하나 false면 한 음절만 기록함
	recognition.lang = 'ko-KR';
	recognition.maxAlternatives = 10000; // 숫자가 작을수록 발음대로 적고, 크면 문장의 적합도에 따라 알맞은 단어로 대체합니다.
			// maxAlternatives가 크면 이상한 단어도 문장에 적합하게 알아서 수정합니다.
	  

	  
	 	 var words = document.querySelector('.words');
		 var menu = document.querySelector('.menu');
		 var sell_price = document.querySelector('.sell_price');
		 var error = document.querySelector('.error');
		 var transcript;
		 
		// 음성 인식 시작
	 	recognition.start();
	 	
	 	function A(e) {
	 		
	 		transcript = Array.from(e.results)
			.map(result => result[0])
	 		.map(result => result.transcript)
	 		.join('');
	 	    
	 		words.textContent = transcript; 
	 		    
	 		console.log(transcript);
	 	
	 		var len = transcript.length; //음성인식한 문장 전체길이 알기
		 	var name = transcript.slice(-4); //마지막 네글자 가져오기
		 	
		 	var newlen = len-4;
		 	var newname = transcript.substring(0,newlen); //메뉴 가져오기
		 	var nname = newname.replace(/(\s*)/g,"");
		 	
		 	console.log(nname);
		 	
		 	if (name==" 주세요"){
		 		for(var i = 0; i<menu_price.length; i++){
		 			if(nname==menu_price[i][0]){//해당 메뉴가 있으면
		 				menu.textContent = nname;
		 				sell_price.textContent = menu_price[i][1];
		 				document.Order.submit();
		 			}
		 			else{
				 		error.textContent="해당하는 메뉴가 없습니다.";
				 		setTimeout(function(){
							location.href="Order.jsp";
				 			//recognition.onresult=A;
						}, 3000);
				 	} 
		 		}
		 		
		 	
		 	 }
		 	else{
		 		error.textContent="다시 말씀해주세요";
		 		setTimeout(function(){
					location.href="Order.jsp";
				}, 5000);
		 	}
		 	console.log(name);
	 	}
	 	recognition.onresult=A;
}
</script>


</head>
<body onload="OrderSTT()";>


<style>

</style>
</head>

<body bgcolor="#f6e6ac">
<center>
<audio autoplay src ="mp3/what_menu.mp3"></audio>
<img id="introimg" src="../image/waiter.gif" border="0" width="1000px" height="1000px">
<img id="menu" src="../image/menu.png" border="0" width="1112px" height="834px">

<div class="words" contenteditable></div>
</center>
<h1>무엇을 주문 하시겠습니까?</h1>
 
<audio autoplay src ="what_menu.mp3"></audio>
<div class="words"></div>

<form name="Order" action = "Storage.jsp" method="post">
<textarea class="menu" name="menu"></textarea>
<textarea class="sell_price" name="sell_price"></textarea>
</form>
<textarea class="error" name="error"></textarea>
</body>
</html>