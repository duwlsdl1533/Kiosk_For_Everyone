<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" type="text/css" href="../css/NumOrder.css?after"/>
<title>NumOrderPage</title>
<script>
var nums = [[1,"한 개"],[2,"두 개"],[3,"세 개"],[4,"네 개"],[5,"다섯 개"],[6,"여섯 개"],[7,"일곱 개"],[8,"여덟 개"],[9,"아홉 개"],[10,"열 개"]];

function NOSTT(){
	  window.SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;

	 	 var recognition = new SpeechRecognition();
	 	 recognition.interimResults = true; // true면 음절을 연속적으로 인식하나 false면 한 음절만 기록함
	 	 recognition.lang = 'ko-KR';
		 recognition.maxAlternatives = 10000; // 숫자가 작을수록 발음대로 적고, 크면 문장의 적합도에 따라 알맞은 단어로 대체합니다.
			// maxAlternatives가 크면 이상한 단어도 문장에 적합하게 알아서 수정합니다.
	  
	 	 var words = document.querySelector('.words');
		 var num = document.querySelector('.amount');
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
		 	var text = transcript.slice(-4); //마지막 네글자 가져오기
		 	
		 	var newlen = len-4;
		 	var newnum = transcript.substring(0,newlen); //네글자 빼고 가져오기
		 	
		 	console.log(newnum);
		 	
		 	
		 	if (text==" 주세요"){
		 		for(var i=0; i<nums.length; i++){
		 			if(newnum==nums[i][1]){
		 				num.textContent = nums[i][0]; // 인식된 한글을 숫자로 변환
		 			}
		 		}
		 		setTimeout(function(){
		 			document.num.submit();
				}, 2000);
		 		
		 	}
		 	else{
		 		error.textContent="다시 말씀해주세요";
		 		setTimeout(function(){
		 			location.href="NumOrder.jsp";
				}, 5000);
		 	}
	 	}
	 	
	 	recognition.onresult=A;
	}


</script>
</head>
<body onload="NOSTT()";>

<style>

</style>
</head>

<body bgcolor="#f6e6ac" >
<center>
<audio autoplay src ="mp3/How_many.mp3"></audio>
<img id="introimg" src="../image/waiter.gif" border="0" width="1000px" height="1000px">
<img id="menu" src="../image/menu.png" border="0" width="1112px" height="834px">

<div class="words" contenteditable></div>
</center>
<h1>몇개를 주문하시겠습니까? 최대 열개까지 입니다.</h1>
<div class="words"></div>
<form name="num" action = "InsertDB.jsp" method="post">
<textarea class="amount" name="amount"></textarea>
<textarea class="error" name="error"></textarea>
</form>

</body>
</html>