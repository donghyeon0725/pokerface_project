<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WRITE BOARD</title>
<script type="text/javascript">
   
</script>
</head>
<body align="center">
   <div style="height: 100px"></div>
   <div align="center">
      <div style="float: left">
         <table border="1" width="250px" height="50px"
            style="text-align: center;">
            <tr>
               <td style="cursor:pointer" onClick=" location.href='#'">모아보기</td>
               <td style="cursor:pointer; background-color: red;" onClick=" location.href='#'">내프로필</td>
               <td style="cursor:pointer" onClick=" location.href='#'">친구검색</td>
            </tr>
         </table>
      </div>
      <div style="display: inline-block; width: 900px">
            <table border="0" style="width: 850px">
               <tr>
                  <td width="150px" height="150px">
                     <img style="border-radius:75px; width1:150px; height:150px" src="../image/write2.png"></td>
                  <td align="center" valign="bottom" width="150px"><h2>
                        <b>LOGIN ID</b>
                     </h2></td>
                  <td></td>
               </tr>
            </table>
            <br>
         <form name="writeform" action="./BoardAddAction.bo" method="post" enctype="multipart/form-data">
            <table border="0" style="width:850px">   
               <tr>
                  <td>
                     <textarea name="BOARD_CONTENT" rows="20" cols="110"></textarea>
                  </td>
               </tr>
               <tr>
                  <td><br><input type="file" style="cursor:pointer" name="BOARD_IMAGE" /></td>
               </tr>
               <tr>
                  <td align="right">
                     <button style="cursor:pointer" onClick="location.href='javascript:writeform.submit()'">ENROLL</button>&nbsp;&nbsp;&nbsp;&nbsp;
               </tr>
            </table>
         </form>
      </div>
      <div style="float: right;">
         <button style="cursor:pointer" onClick=" location.href='#'">친구리스트</button>
      </div>
   </div>
</body>
</html>
