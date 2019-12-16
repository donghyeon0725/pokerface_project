<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PROFILE BOARD</title>
<script type="text/javascript">
 
</script>
</head>
<body align="center">
   <div style="height: 100px"></div>
   <div align="center">
      <div style="float:left">
         <table border="1" width="250px" height="50px" style="text-align:center;">
            <tr>
               <td style="cursor:pointer" onClick = " location.href='#'">모아보기</td>
               <td style="cursor:pointer; background-color:red;" onClick = " location.href='#'">내프로필</td>
               <td style="cursor:pointer" onClick = " location.href='#'">친구검색</td>
            </tr>
         </table>
      </div>
      <div style="display: inline-block; width: 900px">
         <div style="height: 300px;">
            <table border="1" style="height:250px; width:850px">
               <tr>
                  <td style="width:200px; height:200px" rowspan="3"><img style="border-radius:100px; width:200px; height:200px;" src="../image/write2.png"></td>
                  <td align="center" style="width:100px;">ID : </td>
                  <td>---</td>
               </tr>
               <tr>
                  <td align="center">TEL : </td>               
                  <td>---</td>               
               </tr>
               <tr>
                  <td align="center">GENDER : </td>
                  <td>---</td>
               </tr>
               <tr>
                  <td align="center"><button style="cursor:pointer" onClick="location.href='profileModify.jsp'">Profile Modify</button></td>
                  <td align="center">E-MAIL : </td>
                  <td>---</td>
               </tr>
            </table>
         </div>
         <div align="right">
            <button style="cursor:pointer" onClick="location.href='writeBoard.jsp'">WRITE</button>&nbsp;&nbsp;&nbsp;&nbsp;
            <p>            
         </div>
         <div>
         <% int num = 12; int a = 1; int num2 = num%5;%> 
         <!-- num: list갯수 / a: 모양내기용 / num2: 5의배수 확인용 -->
            <table border="1">
               <% if(num2 == 0) { %>
                  <% for (int i = 0; i < num/5; i++){ %>
                  <tr>
                     <% for(int j = 0; j < 5; j++) { %>
                        <td valign="bottom" style="width:170px; height:170px; background: url(../image/write2.png); background-size:100% 100%;" onClick = " location.href='#'"><%= a %></td>
                        <% a++; %>
                        <% if(a > num){ break; } %>
                     <% } %>
                  </tr>
                  <% }%>
               <% } else { %>
                  <% for (int i = 0; i < num/5+1; i++){ %>
                  <tr>
                     <% for(int j = 0; j < 5; j++) { %>
                        <td valign="bottom" style="width:170px; height:170px; background: url(../image/write2.png); background-size:100% 100%;" onClick = " location.href='#?num=<%=a%>'"><%= a %></td>
                        <% a++; %>
                        <% if(a > num){ break; } %>
                     <% } %>
                  </tr>
                  <% }%>
               <% } %>
            </table>
         </div>
      </div>
      <div style="float:right;">
      <button style="cursor:pointer" onClick = " location.href='#'">친구리스트</button>
      </div>
   </div>
</body>
</html>
