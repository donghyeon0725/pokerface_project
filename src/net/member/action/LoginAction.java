package net.member.action;

import java.io.PrintWriter;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.member.db.MemberBean;
import net.member.db.MemberDAO;

public class LoginAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		ActionForward forward = new ActionForward();
		MemberDAO memberdao = new MemberDAO();
		MemberBean member = new MemberBean();

		HttpSession session = request.getSession();

		String password = request.getParameter("form_password");
		String id = request.getParameter("form_id");
		//회원 정보를 가진 bean 객체 set
		member.setID(id);
		member.setPW(password);
		//for debug
		System.out.println("ID: " + member.getID());
		System.out.println("PASSWORD:  " + member.getPW()) ;
		
		
		boolean result = false;
		//멤버인지 판별 true이면 멤버임
		result = memberdao.isMember(id, password);
		if (result == false) {
			response.setContentType("text/html; charset= UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('비밀번호가 일치하지 않습니다.!');");
			out.println("location.href='./LoginView.bo';");
			out.println("</script>");

			return null;
		}
		//로그인 성공하면 세션에 저장
		session.setAttribute("id", member.getID());
		System.out.println("로그인에 성공하였습니다.");

		forward.setRedirect(true);
		forward.setPath("./BoardListAction.bo");

		return forward;
	}

}
