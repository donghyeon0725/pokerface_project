<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VIEW BOARD</title>
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
      <div style="display: inline-block; width: 900px" align="center">
         <table width="850">
            <tr>
               <td rowspan="4"><img src="../images/bang.png" width="500px" height="500px"></td>
               <td rowspan="2"><img src="../images/c.jpg" width="150px" height="150px" style="border-radius: 75px / 75px;"></td>
               <td width="200px" align="center">--id--</td>
            </tr>
            <tr><td align="center">--date--</td></tr>
            <tr><td colspan="2" height="300px" align="left" valign="top">내용내용</td></tr>
            <tr>
               <td colspan="2" align="center">
                  <button style="cursor:pointer" onclick="location.href='#?name=modify'">수정</button>&nbsp;&nbsp;&nbsp;
                  <button style="cursor:pointer" onclick="location.href='#?name=delete'">삭제</button>
               </td>
            </tr>
         </table>
      </div>
      <div style="float: right;">
         <button style="cursor:pointer" onClick=" location.href='#'">친구리스트</button>
      </div>
   </div>
</body>
</html>
