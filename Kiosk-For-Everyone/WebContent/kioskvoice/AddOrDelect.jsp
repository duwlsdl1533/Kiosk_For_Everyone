<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>되묻는 페이지</title>
<link rel="stylesheet" type="text/css" href="../css/addordel.css"/>
<script>
function OrSTT(){
	  window.SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;

	 	 var recognition = new SpeechRecognition();
	 	 recognition.interimResults = true; // true면 음절을 연속적으로 인식하나 false면 한 음절만 기록함
	 	 recognition.lang = 'ko-KR';
		 recognition.maxAlternatives = 10000; // 숫자가 작을수록 발음대로 적고, 크면 문장의 적합도에 따라 알맞은 단어로 대체합니다.
			// maxAlternatives가 크면 이상한 단어도 문장에 적합하게 알아서 수정합니다.
	  
	 	 var words = document.querySelector('.words');
	 	 var text = document.querySelector('.text');

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
	 		
	 		var delect = "취소";
	 		
	 		//말한 내용중에 취소라는 단어가 있으면  MenuDelect 페이지로 이동
	 		 if(transcript.includes(delect)!=false){
	 			 setTimeout(function(){
	 				location.href="MenuDelect.jsp";
				}, 3000);
	 			
	 		}
	 		
	 		//아니면 추가라고 인지하여 Update 페이지로 이동하여 추가주문시작
	 		else{
	 			/* text.textContent="주문이 완료 되었습니다.";  */
	 			 setTimeout(function(){
	 				location.href="MenuUp.jsp";
				}, 3000);
	 			
	 	} 
	}
	 	recognition.onresult=A;
}
</script>
</head>


<body onload="OrSTT()";>
<img id="introimg" src="../image/waiter.gif" border="0" width="1000px" height="1000px">
<img id="menu" src="../image/menu.png" border="0" width="1112px" height="834px">
<audio autoplay src ="mp3/Add_or_Del.mp3"></audio>
<h1>주문한 품목을 취소하시겠습니까? 아니면 더 추가 하시겠습니까?</h1>
 <!-- 음성으로 말하기 -->

<!-- <form action="menuadd.jsp" method="post" name="reorder"></form> -->
<textarea class="words" name="reorder"></textarea>
<textarea class="text" name="text"></textarea>

</body>
</html>