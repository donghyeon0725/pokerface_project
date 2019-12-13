<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script>
	<%-- 키값이 맞으면 원래 창은 없애고 아이작스로 요청해서 새로운 form을 받고 그 폼에서 비밀번호를 입력받으면 명령어를 전송하는 작업을 해준다. --%>
</script>
<style>

*{ 
   margin: 0;
   padding: 0;
   text-decoration: none;
   font-family: motserrat;
   
   }
 
 body {
   min-height: 100vh;
   background-image: linear-gradient(to right, #283048, #859398);
   }
 
 .login-form{
   width: 360px;
   background: #f1f1f1;
   height: 300px;
   padding: 80px 40px;
   border-radius: 10px;
   position: absolute;
   left: 50%;
   top: 50%;
   transform: translate(-50%, -50%);
}

 .login-form h1{
   text-align: center;
   margin-bottom: 60px;
}

 .txtb{
   border-bottom: 2px solid #adadad;
   position: relative;
   margin: 30px 0;
}

 .txtb input{
   font-size: 15px;
   color: #333;
   border: none;
   width: 100%;
   outline: none;
   background: none;
   padding: 0 5px;
   height: 50px;
  }

 .txtb span::before {
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
   background:linear-gradient(120deg,#3498db,#8e44ad);
   transition: .5s; 
  }
  
 .focus + span::before{
   top: -5px; 
  }
 .focus + span::after{
   width: 100%;
 }
   
 .bottom-text{
   margin-top: 60px;
   text-align: center;
   font-size: 13px;
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
</style>
<link rel="stylesheet" href="style.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js" charset="utf-8"></script>
<script>

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
	
	function posting() {
		inputForm.submit();
	}
	
	

</script>
</head>
<body>
	<form name="inputForm" action="./PasswdChangeAction.lo" method="get" class="login-form">
		<input type="hidden" name="id" id="id" value="<%=request.getParameter("id")%>" >
		
		<div class="txtb">
		   <input type="password" name="password" id="password" onKeyPress="PassCheck(this)">
	  	 <span data-placeholder="password"></span>
	   </div>
	   <div class="txtb">
		   <input type="password" name="password_check" id="password_check" onchange="samePassCheck()">
	  	 <span data-placeholder="password_check"></span>
	   </div>
	   <button class="joinbtn"  onclick="posting()">제출하기</button>
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