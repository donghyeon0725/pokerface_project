package net.member.action;

import java.io.PrintWriter;
import java.net.URLDecoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.member.db.MemberDAO;

public class Duplication implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		//아이작스로 요청 받았을 때 
		
		String id = request.getParameter("id");

		MemberDAO memberdao = new MemberDAO();
		boolean isDuplication = false;
		if(id != null) {
			isDuplication = memberdao.isDuplication(id);	
			//중복 검사를 함
			System.out.println("중복 여부  :  "  + isDuplication );
		}
		
		PrintWriter out = response.getWriter();
		response.setContentType("text/html; charset='utf-8';"); 
		if(isDuplication) {
			out.println("<font color='red'>Duplicated ID</font>");
			out.close();
			return null;
		} else {
			out.println("<font color='8e44ad'>ID Success</font>");
			out.close();
			return null;
		}
	}

}
