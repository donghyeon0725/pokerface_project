package net.board.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.board.db.BoardDAO;
import net.board.db.BoardEntry;
import net.member.action.Action;
import net.member.action.ActionForward;

public class BoardListPageAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
	/*
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		if(id == null) {
			response.setContentType("text/html; charset=utf-8"); 
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			out.println("alert('아이디가 없습니다.')");
			out.println("location.href='../login/loginForm.jsp'");
			out.println("</script>");
			return null;
		}
	*/	
		
		String openOption = request.getParameter("openOption");
		String orderOption = request.getParameter("orderOption");
		String searchKeyword = request.getParameter("searchKeyword");
		String searchOption = request.getParameter("searchOption");
		
		checkOptions(searchKeyword);
		if(openOption == null) {
			openOption = "totalBoards";
		}
		if(orderOption == null) {
			orderOption = "newest";
		}
		if(searchOption == null) {
			searchOption = "idSearch";
		}
		
		
		BoardDAO boarddao = new BoardDAO();
		ArrayList <BoardEntry> boardEntryList = boarddao.getBoards("zs1", openOption, orderOption, searchOption, searchKeyword);
		request.setAttribute("boardEntryList", boardEntryList);
		
		ActionForward forward = new ActionForward("/main/boardListBoard.jsp", false);
		
		return forward;
	}
	
	
	public void checkOptions (String value) {
		if(value == null) {
			value = "";
		}
	}

}
