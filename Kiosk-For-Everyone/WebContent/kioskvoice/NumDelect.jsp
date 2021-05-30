<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>NumOrderPage</title>
<link rel="stylesheet" type="text/css" href="../css/addordel.css"/>
<script>
var nums = [[1,"한개"],[2,"두개"],[3,"세개"],[3,"세계"],[4,"네개"],[5,"다섯개"],[6,"여섯개"],[7,"일곱개"],[8,"여덟개"],[9,"아홉개"],[10,"열개"]];

function NDSTT(){
	  window.SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;

	 	 var recognition = new SpeechRecognition();
	 	 recognition.interimResults = true; // true면 음절을 연속적으로 인식하나 false면 한 음절만 기록함
	 	 recognition.lang = 'ko-KR';
		 recognition.maxAlternatives = 10000; // 숫자가 작을수록 발음대로 적고, 크면 문장의 적합도에 따라 알맞은 단어로 대체합니다.
			// maxAlternatives가 크면 이상한 단어도 문장에 적합하게 알아서 수정합니다.
	  
	 	 var words = document.querySelector('.words');
		 var DelAmount = document.querySelector('.DelAmount');
		 var error = document.querySelector('.error');
		
		 var transcript;
		 
	 	// 음성 인식 시작
	 	recognition.start();
	  
	 	function A(e) {
	 		transcript = Array.from(e.results)
			.map(result => result[0])
	 		.map(result => result.transcript)
	 		.join('');
	 	    
	 		/* words.textContent = transcript;  */
	 		    
	 		console.log(transcript);
	 		
	 		var text = transcript.replace(/ /gi,"");
	 		
	 		var len = text.length; //음성인식한 문장 전체길이 알기
		 	
		 	console.log(text);
		 	
		 	var newtext = text.slice(-6); //마지막 일곱글자 가져오기
		 	
		 	
		 	var newlen = len-6;
		 	var newnum = text.substring(0,newlen); //일곱글자 빼고 가져오기
		 	
		 	console.log(newnum);
		 	
		 	
		 	if (text.includes("취소")){
		 		for(var i=0; i<nums.length; i++){
		 			if(newnum==nums[i][1]){
		 				DelAmount.textContent = nums[i][0]; // 인식된 한글을 숫자로 변환
		 				document.NumDel.submit();
		 			}
		 			else{
				 		error.textContent="다시 말씀해주세요";
				 		setTimeout(function(){
				 			location.href="NumDelect.jsp";
						}, 5000);
				 	}
		 		}
		 	}
		 	 else{
		 		error.textContent="다시 말씀해주세요";
		 		setTimeout(function(){
		 			location.href="NumDelect.jsp";
				}, 5000);
		 	}
	 	}
	 	
	 	recognition.onresult=A;
	}


</script>
</head>
<body onload="NDSTT()";>
<img id="introimg" src="../image/waiter.gif" border="0" width="1000px" height="1000px">
<img id="menu" src="../image/menu.png" border="0" width="1112px" height="834px">
<audio autoplay src ="mp3/how_many_del.mp3"></audio>
<h1>몇개를 취소 하시겠습니까? 최대 열개까지 입니다.</h1> <!-- 음성으로 말하기 -->

<div class="words"></div>
<form class="NumDel" name="NumDel" action = "DelectDB.jsp" method="post">
<textarea class="DelAmount" name="DelAmount"></textarea>

</form>
<textarea class="error" name="error"></textarea>
</body>
</html>