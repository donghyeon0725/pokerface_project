package net.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.member.db.MemberDAO;

public class PasswdChangeAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		
		MemberDAO memberdao = new MemberDAO();
		HttpSession session = request.getSession();
		
		String id = request.getParameter("id");
		String newPassword = request.getParameter("password");
		
		
		boolean isChangePW = memberdao.updatePassword(id, newPassword);
		
		if(!isChangePW) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('비밀번호 변경에 실패했습니다.');");
			out.println("location.href='./ChangePageAction.lo'");
			out.println("</script>");
			out.close();
			return null;
		}
		System.out.println("비밀번호 변경에 성공하셨습니다.");
		
		
		ActionForward forward = new ActionForward("/PasswdChangeView.lo", false);
		
		return forward;
	}

}
