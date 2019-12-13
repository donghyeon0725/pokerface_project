<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	String id = request.getParameter("id");
    	if(id == null) {
    		id = "";
    	}
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
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
   height: 400px;
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
 
 
 .focus + span::before{
   top: -5px;
 }
 .focus + span::after{
   width: 100%;
 }
 
 .foundbtn{
   display: block;
   margin-top: 50px;
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
<link rel="stylesheet" href="style.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js" charset="utf-8"></script>
<script>
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
</script>
</head>
<body>

<div class="titleBox" style="position:absolute; left: 10px; top: 10px;"></div>

<form method="post" action="./FoundPWAction.lo" name="foundForm" class="join-form" >
	<div class="txtb">
   <input type="text" name="id" id="id" onkeyPress="IdCheck(this)" value="<%=id%>">
   <span data-placeholder="Id" ></span>
   </div>
   <p class="isRight" id="i"></p>
   
   <div class="txtb">
   <input type="text" name="ssnum" id="ssnum" >
   <span data-placeholder="Social Security Number" ></span>
   </div>
   <p class="isRight" id="ss"></p>
   
   <input type="submit" value="암호 전송" class="foundbtn">
	
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