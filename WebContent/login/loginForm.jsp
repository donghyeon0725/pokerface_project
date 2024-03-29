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
   font-family: motserrat;
   
   }
 
 body {
   min-height: 100vh;
   background-image: linear-gradient(to right, #283048, #859398);
   }
 
 .login-form{
   width: 360px;
   background: #f1f1f1;
   height: 580px;
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
 .logbtn{
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
   
 .logbtn:hover{
   background-position: right;
   }
   
 .bottom-text{
   margin-top: 60px;
   text-align: center;
   font-size: 13px;
   }
</style>

<title>프로젝트 로그인폼</title>
<link rel="stylesheet" href="style.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js" charset="utf-8" ></script>
</head>
<body>

   <form action="./LoginAction.bo" class="login-form" method="post">
   
   <h1>Login</h1>
   
   <div class="txtb">
   <input type="text" name="form_id" id="form_id">
   <span data-placeholder="Username"></span>
   </div>
      
   <div class="txtb">
   <input type="password" name="form_password" id="form_password">
   <span data-placeholder="Password"></span>
   </div>
   
   <input type="submit" class="logbtn" value="Login">
   
   <div class="bottom-text">
   Don't have account? <a href="./joinForm.jsp">회원가입</a>
   </div>
   <div class="bottom-text">
  	<a href="./foundID.jsp">아이디찾기</a>&nbsp;&nbsp;&nbsp;<a href="./foundPW.jsp">비밀번호찾기</a>
   </div>
   
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



