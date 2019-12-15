<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="net.board.db.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<% 
   List replyList = (List)request.getAttribute("replyList");
   BoardBean board = (BoardBean)request.getAttribute("board");
   //int listcount = ((Integer)request.getAttribute("listcount")).intValue();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board test view</title>
<script language="javascript">
   function replyboard() {
      boardform.submit();
   }
   
   function preview(obj) {
	   document.getElementById("previewImage").src = obj.src;
	   document.getElementsByClass("previewContainer")[0].width = "100px";
	   document.getElementsByClass("previewContainer")[0].height = "100px";
	   document.getElementsByClass("previewContainer")[0].zIndex = 100;
   }
</script>
<style type="text/css">
  body{background: linear-gradient(to right, #283048, #859398);}
   div{padding: 10px;}
    a{text-decoration: none;}
</style>
</head>
<body>
<div class="previewContainer" style="position:absolute; z-index: -1;width:0; height:0; " onclick="this. zIndex: -1;this.style.width='0'; this.style.height='0' document.getElementById('previewImage').src='';"><img src=""  alt=""  id="previewImage"></div>
   
   <div align="center">
      <table style="background: linear-gradient(to top, #E6ECF3, #F8FAFC); width:800px; margin: 10px; border-radius: 10px 10px 10px 10px / 10px 10px 10px 10px;">
         <tr valign="middle" align="center" bgcolor="#494850" style="height:60px;"><td colspan="6" style="border-radius: 10px 10px 10px 10px / 10px 10px 10px 10px;"><font size="5" color="white">게시판 뷰 테스트</font></td></tr>
         <tr>
            <td colspan="2" rowspan="2"><img onclick="preview(this)" src="./boardupload/<%= board.getBOARD_FILE() %>" width="150px" height="150px" style="margin:5px; border-radius: 10px 10px 10px 10px / 10px 10px 10px 10px;"></td>
            <td width="100px"><div align="left">이 름 : </div></td>
            <td><%= board.getID() %></td>
            <td width="100px"><div align="left">작성일 : </div></td>
            <td><%= board.getBOARD_DATE() %></td>
         </tr>
         <tr><td width="100px"><div align="left">제 목 : </div></td><td colspan="3"><%= board.getBOARD_TITLE() %></td></tr>
         <tr>
            <td  valign="top" width="100px"><div align="right">내 용 : &nbsp;&nbsp;</div></td>
            <td colspan="5" bgcolor="#FFFFFF">
               <table border="0" width="500" height="200" style="table-layout:fixed;">
                  <tr>
                     <td valign="top" style="font-family:<%= board.getBOARD_FONT_NAME() %>;font-size:<%= board.getBOARD_FONT_SIZE() %>pt;" >
                        <%= board.getBOARD_CONTENT() %>
                     </td>
                  </tr>
               </table>
            </td>
         </tr>
         <tr><td colspan="6">&nbsp;</td></tr>
         <tr align="center" valign="middle">
            <td colspan="6">
               <font size="3">
                  <a href="./BoardModifyPageAction.bo?num=<%= board.getBOARD_NUM() %>">[수정]</a>&nbsp;&nbsp;
                  <a href="./BoardDeleteAction.bo?num=<%= board.getBOARD_NUM() %>">[삭제]</a>&nbsp;&nbsp;
                  <a href="./BoardListAction.bo">[목록]</a>&nbsp;&nbsp;
               </font>
            </td>
         </tr>
         <tr bgcolor="#000000"><td colspan="6" style="height:2px;"></td></tr>
      </table>
      
      <br>
      <form action="./BoardReplyAction.bo" name="boardform" method="get">
      <table style="background: linear-gradient(to top, #E6ECF3, #F8FAFC); width:800px; margin: 10px; border-radius: 10px 10px 10px 10px / 10px 10px 10px 10px;">
         <tr>
            <td><input type="hidden" name="num" id="num" value="<%=board.getBOARD_NUM() %>" ></td>
         </tr>
         <tr><td colspan="4">댓 글</td></tr>
         <tr bgcolor="#FFFFFF"><td colspan="4" style="height:1px;"></td></tr>
         <tr>
            <td valign="top"><div align="middle"><%= board.getID() %> : </div></td >
            <td colspan="2"><textarea name="board_content" cols="75" rows="3"></textarea></td>
            <td align="middle" width="100px"><input type="button" value="등록"  onclick="javascript:replyboard()"></td>
         </tr>
         <tr bgcolor="#cccccc"><td colspan="4" style="height:1px;"></td></tr>
         <% for(int i = 0; i < replyList.size(); i++){ 
                        BoardBean bl = (BoardBean)replyList.get(i);%>
            <tr bgcolor="#CFD8E6">
               <td width="140px" valign="top"><div align="middle"><%= bl.getID() %> : </div></td>
               <td width="500px"><%= bl.getBOARD_CONTENT() %></td>
               <td width="100px"><%= bl.getBOARD_DATE() %></td>
               <td><font size="3"><a href="./BoardReplyDeleteAction.bo?num=<%= bl.getBOARD_NUM() %>&boardNum=<%= board.getBOARD_NUM()%>">[삭제]</a></font></td>
            </tr>
            
         <% } %>
      </table>
      <%System.out.println(board.getBOARD_NUM()); %>
      </form>
   </div>

</body>
</html>
