package net.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginPageAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		//단순히 페이지를 요청
		
		ActionForward forward = new ActionForward("./LoginPageView.lo", true);
		return forward;
	}

}
