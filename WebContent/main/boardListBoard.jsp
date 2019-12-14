<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, net.board.db.*, net.member.db.*"%>
<%
	ArrayList<BoardEntry> boardEntryList = (ArrayList<BoardEntry>) request.getAttribute("boardEntryList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script>
	
</script>
<link rel="stylesheet" type="text/css" href="boardListCSS.css">
</head>
<body>
	<input type="hidden" name="openOption" value="totalBoards">
	<!-- 친구 게시물만 볼것인지 전체를 볼 것인지 friendBoards totalBoards -->
	<input type="hidden" name="orderOption" value="newest">
	<!-- oldest newest -->
	<input type="hidden" name="searchKeyword" value="">
	<input type="hidden" name="searchOption" value="idSearch">
	<!-- idSearch contentSearch -->

	<div>
		<div class="page-open">
			<button>모아보기</button>
			<button>내 프로필</button>
			<button>친구 검색</button>
		</div>

		<form>
			<div class="open-option">
				<input type="button" value="전체 게시물 보기"> <input type="button"
					value="친구 게시물만 보기"> <select>
					<option>최신순</option>
					<option>과거순</option>
				</select>
			</div>
			<div>
				<input type="submit">
			</div>
		</form>
	</div>
	<div>
		<div>rss가 들어갈 자리</div>
	</div>
	<div>
		<input type="text"> <select>
			<option>친구 이름으로 검색</option>
			<option>글 내용 검색</option>
		</select>
	</div>

	<div>게시글이 들어갈 자리</div>

	<div>
		profile이 들어갈 자리
		<table border="1">
			<tr>
				<td>프로필</td>
				<td>아이디</td>
				<td>사진</td>
				<td>글</td>
				<td>좋아요 수</td>
				<td>좋아요 여부</td>
				<td>글쓴 날짜</td>
			</tr>
			<%
				for (BoardEntry entry : boardEntryList) {
					BoardBean board = entry.getBoardBean();
					MemberBean owner = entry.getMemberBean();
					ArrayList<ReplyBean> replys = entry.getReplyBeans();
					boolean isLike = entry.getIsLike();
			%>
			<tr>
				<td><%=owner.getPFILE()%></td>
				<td><%=owner.getID()%></td>
				<td><%=board.getIMAGE()%></td>
				<td><%=board.getCONTENT()%></td>
				<td><%=board.getLIKECOUNT()%></td>
				<td><%=isLike %></td>
				<td><%=board.getUDATE() %></td>
			</tr>

			<%
				if (replys != null) {
						for (ReplyBean reply : replys) {
			%>
			<tr>
				<td>댓글!</td>
				<td><%=reply.getID()%></td>
				<td colspan="4"><%=reply.getCONTENT()%></td>
				<td><%=reply.getUDATE()%></td>
			</tr>


			<%
						}
					}
				}
			%>
		</table>

	</div>
	<!-- css는 전혀 넣지 않았습니다. -->
</body>
</html>
