<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>NumOrderPage</title>
<link rel="stylesheet" type="text/css" href="../css/addordel.css"/>
<script>
var nums = [[1,"�Ѱ�"],[2,"�ΰ�"],[3,"����"],[3,"����"],[4,"�װ�"],[5,"�ټ���"],[6,"������"],[7,"�ϰ���"],[8,"������"],[9,"��ȩ��"],[10,"����"]];

function NDSTT(){
	  window.SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;

	 	 var recognition = new SpeechRecognition();
	 	 recognition.interimResults = true; // true�� ������ ���������� �ν��ϳ� false�� �� ������ �����
	 	 recognition.lang = 'ko-KR';
		 recognition.maxAlternatives = 10000; // ���ڰ� �������� ������� ����, ũ�� ������ ���յ��� ���� �˸��� �ܾ�� ��ü�մϴ�.
			// maxAlternatives�� ũ�� �̻��� �ܾ ���忡 �����ϰ� �˾Ƽ� �����մϴ�.
	  
	 	 var words = document.querySelector('.words');
		 var DelAmount = document.querySelector('.DelAmount');
		 var error = document.querySelector('.error');
		
		 var transcript;
		 
	 	// ���� �ν� ����
	 	recognition.start();
	  
	 	function A(e) {
	 		transcript = Array.from(e.results)
			.map(result => result[0])
	 		.map(result => result.transcript)
	 		.join('');
	 	    
	 		/* words.textContent = transcript;  */
	 		    
	 		console.log(transcript);
	 		
	 		var text = transcript.replace(/ /gi,"");
	 		
	 		var len = text.length; //�����ν��� ���� ��ü���� �˱�
		 	
		 	console.log(text);
		 	
		 	var newtext = text.slice(-6); //������ �ϰ����� ��������
		 	
		 	
		 	var newlen = len-6;
		 	var newnum = text.substring(0,newlen); //�ϰ����� ���� ��������
		 	
		 	console.log(newnum);
		 	
		 	
		 	if (text.includes("���")){
		 		for(var i=0; i<nums.length; i++){
		 			if(newnum==nums[i][1]){
		 				DelAmount.textContent = nums[i][0]; // �νĵ� �ѱ��� ���ڷ� ��ȯ
		 				document.NumDel.submit();
		 			}
		 			else{
				 		error.textContent="�ٽ� �������ּ���";
				 		setTimeout(function(){
				 			location.href="NumDelect.jsp";
						}, 5000);
				 	}
		 		}
		 	}
		 	 else{
		 		error.textContent="�ٽ� �������ּ���";
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
<h1>��� ��� �Ͻðڽ��ϱ�? �ִ� �������� �Դϴ�.</h1> <!-- �������� ���ϱ� -->

<div class="words"></div>
<form class="NumDel" name="NumDel" action = "DelectDB.jsp" method="post">
<textarea class="DelAmount" name="DelAmount"></textarea>

</form>
<textarea class="error" name="error"></textarea>
</body>
</html>