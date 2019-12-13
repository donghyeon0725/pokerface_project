package net.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.member.db.MemberBean;
import net.member.db.MemberDAO;

public class JoinAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		//회원가입
		ActionForward forward = new ActionForward();
		MemberDAO memberdao = new MemberDAO();
		MemberBean member = new MemberBean();

		int result = 1;
		
		member.setID(request.getParameter("form_id"));
		member.setPW(request.getParameter("form_password"));
		member.setSSNUM(request.getParameter("form_ssnum"));
		member.setEMAIL(request.getParameter("form_email"));
		member.setGENDER(request.getParameter("form_gender"));
		member.setTEL(request.getParameter("form_tel"));
		
		//for debug
		System.out.println("joinAction.java 에서 넘어온 form_id 값  : " + request.getParameter("form_id"));
		System.out.println("joinAction.java 에서 넘어온 form_password 값 : "  + request.getParameter("form_password"));
		
		//회원가입
		result = memberdao.joinMember(member);
		System.out.println("회원가입 결과 : "  + result);
		
		if (result != 1) {
			System.out.println("회원가입이 불가능합니다.");
			return null;
		}
		System.out.println("회원가입을 성공하셨습니다.");
		forward.setRedirect(true);
		forward.setPath("./JoinView.lo");

		return forward;

	}

}
