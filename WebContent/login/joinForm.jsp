<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
 
 *{
   margin: 0;
   padding: 0;
   text-decoration: none;
   font-family: montserrat;
   
  }
 
 body{
   min-height: 100vh;
   background-image: linear-gradient(to right, #283048, #859398);
 } 
 
 .join-form{
   width: 360px;
   background: #f1f1f1;
   height: 730px;
   padding: 80px 40px;
   border-radius: 10px;
   position: absolute;
   left: 50%;
   top: 50%;
   transform: translate(-50%, -50%); 
 }
 
 .join-form h1{
   text-align: center;
   margin-bottom: 60px;
 }
 
 .txtb{
   border-bottom: 2px solid #adadad;
   position: relative;
   margin: 30px 0 0 0;
 }
 
 .txtb input{
   font-size: 15px;
   color: #333;
   border: none;
   width: 100%;
   outline: none;
   background: none;
   padding:0 5px;
   height: 50px;
 }
 
 .txtb span::before{
  content: attr(data-placeholder);
  position: absolute;
  top: 50%;
  left: 5px;
  color: #adadad;
  transform: translateY(-50%);
  z-index: -1;
  transition: .5s;
  }
  
 .txtb span::after{
  content: '';
  position: absolute;
  width: 0%;
  height: 2px;
  background: linear-gradient(120deg,#3498db,#8e44ad);
  transition: .5s;
 }
 .txta{
   
   position: relative;
   margin: 30px 0;
 }
 
  .txta input{
   color: #333;
   border: none;
   width: 10%;
   outline: none;
   background: none;
   padding:0 5px;
   height: 20px;
 }
 .focus + span::before{
   top: -5px;
 }
 .focus + span::after{
   width: 100%;
 }
 
 .joinbtn{
   display: block;
   width: 100%;
   height: 50px;
   border: none;
   background: linear-gradient(120deg,#3498db,#8e44ad,#3498db);
   background-size: 200%;
   color: #fff;
   outline: none;
   cursor: pointer;
   transition: .5s;
   }
   
 .joinbtn:hover{
   background-position: right;
  }
  
  p{
  	margin-top:  0;
  	padding: 0;
  	
  }
</style>
<title>프로젝트 조인폼</title>
<link rel="stylesheet" href="style.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js" charset="utf-8"></script>
<script>
	$( function( ){
		$("#form_id").change(function(){
			createHttpRequest();
			mySend();
		})
	})
	//그냥 넘기게 되면 값을 submit 한 것이 아니기 때문에 request에 값이 담기지 않을 것으로 예측

	var xhttp;
	function createHttpRequest() {
		xhttp =  new XMLHttpRequest();
	}
	
	function mySend() {
		createHttpRequest();
		xhttp.onreadystatechange = function callFunction () {
			if(xhttp.readyState == 4) {
				if(xhttp.status == 200 ){
					var responseData = xhttp.responseText;
					document.getElementById("i").innerHTML = responseData;
				}
			}
			
		};
		xhttp.open("POST", "./duplication.lo", true);
		var sendString = "id=" + document.getElementById("form_id").value ;
		xhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xhttp.send(sendString);
	}
	
	

	function IdCheck(obj) {
		var checkTab = RegExp(/^[A-Z]$/);
		if(checkTab.test(obj.value)) {
			document.getElementById("i").innerHTML ="<font color='red'>Tab Turned On<font>";
			return false;
		}
		
		var check = RegExp(/^[a-zA-Z0-9\{\}\[\]\/?.,;:|\)*~`!^\-+<>@\#$%&\\\=\(]{8,20}$/); //아이디와 패스워드가 적합한지 검사할 정규식
		if(!check.test(obj.value)) {
			document.getElementById("i").innerHTML="<font color='red' size='2pt'>8~20 Letter Alphabet With Number<font>";
			return true;
		} else {
			document.getElementById("i").innerHTML="<font color='#8e44ad' size='2pt'>Right ID Form</font>";
			return false;
		}
	}
	
	function PassCheck(obj) {
		var check = RegExp(/^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{8,20}$/i); // 이메일 형식 검사
		
		if(!check.test(obj.value)) {
			document.getElementById("pw").innerHTML="<font color='red' size='2pt'>Unsuitable Password Form<font>";
			return true;
		} else {
			document.getElementById("pw").innerHTML="<font color='#8e44ad' size='2pt'>Right Password Form</font>";
			return false;
		}
	}
	
	function EmailCheck(obj) {
		var check = RegExp(/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i); // 이메일 형식 검사
		
		if(!check.test(obj.value)) {
			document.getElementById("em").innerHTML="<font color='red' size='2pt'>Unsuitable Email Form<font>";
			return true;
		} else {
			document.getElementById("em").innerHTML="<font color='#8e44ad' size='2pt'>Right Email Form</font>";
			return false;
		}
	}
	
	
	function check() {
		if(IdCheck(document.getElementByName("form_id")) && PassCheck(document.getElementByName("form_password")) && EmailCheck(document.getElementByName("form_email"))) {
			joinForm.submit();
		} else {
			return false;
		}
	}
	
	
	function samePassCheck() {
		var pw = document.getElementById("form_password").value;
		var pwc = document.getElementById("form_password_check").value;
		console.log(document.getElementById("form_password").value);
		console.log(document.getElementById("form_password_check").value);
		if(pw == pwc) {
			document.getElementById("pwc").innerHTML="<font color='#8e44ad' size='2pt'>The password match.</font>";
			return;
		} else {
			document.getElementById("pwc").innerHTML="<font color='red' size='2pt'>The password does not match.<font>";
			return;
		}
	}
</script>
</head>
<body>
	<div class="titleBox" style="position:absolute; left: 10px; top: 10px;"></div>
   
   <form action="./JoinAction.lo" class="join-form" method="post" name="joinForm">
   <h1>Join</h1> 
   
   <div class="txtb">
   <input type="text" name="form_id" id="form_id" onkeyPress="IdCheck(this)">
   <span data-placeholder="Id" ></span>
   </div>
   <p class="isRight" id="i"></p>
   
  <div class="txtb">
   <input type="password" name="form_password" id="form_password" onkeyPress="PassCheck(this)">
   <span data-placeholder="Password" class="underText"></span>
   </div>
   <p class="isRight" id="pw"></p>
   
   <div class="txtb">
   <input type="password" name="form_password_check" id="form_password_check" onchange="samePassCheck()">
   <span data-placeholder="PasswordCheck" class="underText"></span>
   </div>
   <p class="isRight" id="pwc"></p>
   
   
   <div class="txtb">
   <input type="text" name="form_ssnum">
   <span data-placeholder="주민번호"></span>
   </div>

   <div class="txtb">
   <input type="email" name="form_email" id="form_email" onkeyPress="EmailCheck(this)">
   <span data-placeholder="Email"></span>
   </div>
   <p class="isRight" id="em"></p>
   
   <div class="txtb">
   <input type="tel" name="form_tel">
   <span data-placeholder="전화번호"></span>
   </div>
   
   
   <div class="txta">Gender : 
   <input type="radio" name="form_gender" value="femail" checked>남자
   <input type="radio" name="form_gender" value="mail">여자
   <span data-placeholder="없음"></span>
   </div>
   
   
   
   <button class="joinbtn"  onclick="check()">회원가입</button>
   </form>
   <script type="text/javascript">
   $(".txtb input").on("focus", function(){
   $(this).addClass("focus"); 
   });
   
   $(".txtb input").on("blur", function(){
   if($(this).val() == "")  
   $(this).removeClass("focus"); 
      });
   </script>
   </body>
</html>