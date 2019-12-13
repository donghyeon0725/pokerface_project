package net.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ChangePageAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		
		String getSecurityKey = request.getParameter("securityKey");
		
		HttpSession session  = request.getSession();
		
		String id = request.getParameter("id");
		System.out.println("ChangePageAction에서 받은 id 값 :  "  + id);
		request.setAttribute("id", id);
		if(getSecurityKey != null) {
			if(getSecurityKey.equals((String)session.getAttribute("securityKey"))) {
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("location.href='./ChangePageView.lo?id="+id+"'");
				out.println("</script>");
				out.close();

				return null;
			} else {
				
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('인증코드가 맞지 않습니다.');");
				out.println("location.href='./FoundPWAction.lo';");
				out.println("</script>");
				
				out.close();
				return null;
			}
		} else {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('인증코드가 맞지 않습니다.');");
			out.println("location.href='./FoundPWAction.lo';");
			out.println("</script>");
			
			out.close();
			return null;
		}
		
	}

}
