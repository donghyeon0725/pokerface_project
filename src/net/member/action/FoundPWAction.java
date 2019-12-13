package net.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.member.db.MemberBean;
import net.member.db.MemberDAO;
import tool.MailSender;

public class FoundPWAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		//이메일 전송 작업과alert로 띄워준다. 
		//다음페이지로 넘김
		//맞는지 판별을 한다.
		//이메일 전송작업
		
		String id = request.getParameter("id");
		if(id == null) {
			id = (String)request.getAttribute("id");
		}
		String ssnum = request.getParameter("ssnum");
		
		MemberDAO memberdao = new MemberDAO();
		//주민번호와 아이디로 멤버가 맞는지 판별하는 작업 => privacy와 account가 ssnum으로 조인 되었을때 id로 검색하면 검색된 계정이 있어야함
		boolean isMember = memberdao.isMemberWithSSNUM(id, ssnum);
		
		String respondantEmail = memberdao.getEmail(id);
		String key = memberdao.getSecurityKey();
		System.out.println("얻은 키 값은 : " + key);
		//이메일 전송 작업
		MailSender sender = new MailSender();
		try {
			sender.mailSender(request, "보안 메일입니다.", "이동한 창에 받은 암호를 입력해주세요 \r\n" + key, respondantEmail);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		response.setContentType("text/html; charset=utf-8"); 
		PrintWriter out = response.getWriter();
		
		if	(!isMember) {
			out.println("<script>");
			out.println("alert('계정이 없거나 주민번호가 틀렸습니다.')");
			out.println("location.href='./foundPW.jsp'");
			out.println("</script>");
			return null;
		} else {
			
			int  maxInactiveInterval = 60*5;
			session.setMaxInactiveInterval(maxInactiveInterval);
			//지속 시간을 가져다가 쓰고 싶으면 쓰면됨
			session.setAttribute("maxInactiveInterval", maxInactiveInterval + "");
			session.setAttribute("securityKey", key);
			
			MemberBean bean = new MemberBean();
			bean.setEMAIL(respondantEmail);
			bean.setID(id);
			System.out.println("FoundPWAction 에서 member에 설정된 아이디 값 " + id + "    "  + bean.getID());
			bean.setSSNUM(ssnum);
			//무효한 코드 같다.
			
			//페이지에 필요한 기본 값은 request에 저장중
			request.setAttribute("member", bean);
			
			out.println("<script>");
			out.println("alert('기존에 연결된 " + respondantEmail + "로 암호 키를 발송하였습니다. 확인해주세요')");
			out.println("location.href='./FoundPWView.lo?id=" + id +"'");
			out.println("</script>");
			return null;
		}
		//세션에 보안키를 저장해두고 입력창에 입력한 값이랑 같으면 다음으로 넘겨줌 5분임
	}

}
