package net.member.action;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.member.db.MemberBean;
import net.member.db.MemberDAO;

public class FoundIDAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		
		ActionForward forward = new ActionForward();
		MemberDAO memberdao = new MemberDAO();
		MemberBean member = new MemberBean();
		
		String tel = request.getParameter("form_tel");
		String email = request.getParameter("form_email");
		String ssnum = request.getParameter("form_ssnum");
		
		System.out.println("tel:"+ tel);
		System.out.println("email:"+email);
		
		ArrayList<String> foundAllId = null;
		foundAllId = memberdao.foundID(tel, email);

		//실패하면
		if (foundAllId == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('tel or email not found.');");
			out.println("location.href='./login/loginForm.jsp';");
			out.println("</script>");
			out.close();

			return null;
		}
		
		request.setAttribute("IdList", foundAllId);
		forward.setRedirect(false);
		forward.setPath("/login/FoundIDView.lo");

		return forward;
	}

}
