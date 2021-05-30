<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" type="text/css" href="../css/NumOrder.css?after"/>
<title>NumOrderPage</title>
<script>
var nums = [[1,"�� ��"],[2,"�� ��"],[3,"�� ��"],[4,"�� ��"],[5,"�ټ� ��"],[6,"���� ��"],[7,"�ϰ� ��"],[8,"���� ��"],[9,"��ȩ ��"],[10,"�� ��"]];

function NOSTT(){
	  window.SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;

	 	 var recognition = new SpeechRecognition();
	 	 recognition.interimResults = true; // true�� ������ ���������� �ν��ϳ� false�� �� ������ �����
	 	 recognition.lang = 'ko-KR';
		 recognition.maxAlternatives = 10000; // ���ڰ� �������� ������� ����, ũ�� ������ ���յ��� ���� �˸��� �ܾ�� ��ü�մϴ�.
			// maxAlternatives�� ũ�� �̻��� �ܾ ���忡 �����ϰ� �˾Ƽ� �����մϴ�.
	  
	 	 var words = document.querySelector('.words');
		 var num = document.querySelector('.amount');
		 var error = document.querySelector('.error');
		
		 var transcript;
		 
	 	// ���� �ν� ����
	 	recognition.start();
	  
	 	function A(e) {
	 		transcript = Array.from(e.results)
			.map(result => result[0])
	 		.map(result => result.transcript)
	 		.join('');
	 	    
	 		words.textContent = transcript; 
	 		    
	 		console.log(transcript);
	 	
	 		var len = transcript.length; //�����ν��� ���� ��ü���� �˱�
		 	var text = transcript.slice(-4); //������ �ױ��� ��������
		 	
		 	var newlen = len-4;
		 	var newnum = transcript.substring(0,newlen); //�ױ��� ���� ��������
		 	
		 	console.log(newnum);
		 	
		 	
		 	if (text==" �ּ���"){
		 		for(var i=0; i<nums.length; i++){
		 			if(newnum==nums[i][1]){
		 				num.textContent = nums[i][0]; // �νĵ� �ѱ��� ���ڷ� ��ȯ
		 			}
		 		}
		 		setTimeout(function(){
		 			document.num.submit();
				}, 2000);
		 		
		 	}
		 	else{
		 		error.textContent="�ٽ� �������ּ���";
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
<h1>��� �ֹ��Ͻðڽ��ϱ�? �ִ� �������� �Դϴ�.</h1>
<div class="words"></div>
<form name="num" action = "InsertDB.jsp" method="post">
<textarea class="amount" name="amount"></textarea>
<textarea class="error" name="error"></textarea>
</form>

</body>
</html>