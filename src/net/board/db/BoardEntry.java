package net.board.db;

import java.util.ArrayList;

import net.member.db.MemberBean;

public class BoardEntry {
	private BoardBean boardBean;
	private MemberBean memberBean;
	private boolean isLike;
	private ArrayList<ReplyBean> replys;
	
	//보드 게시판을 가져올 때 유용하게 사용할 듯
	public BoardEntry (BoardBean boardBean, MemberBean memberBean, ArrayList<ReplyBean> replys, boolean isLike) {
		this.boardBean = boardBean;
		this.memberBean =  memberBean;
		this.replys = replys;
		this.isLike = isLike;
		//여기서 라이크는 게시물을 보고 있는 사람이 게시물을 눌렀는가 표시하기 위함이다. 주의하자.
	}
	
	
	public BoardBean getBoardBean() {
		return boardBean;
	}
	
	public MemberBean getMemberBean() {
		return memberBean;
	}
	
	public boolean getIsLike() {
		return isLike;
	}
	
	public ArrayList<ReplyBean> getReplyBeans() {
		return replys;
	}
	
}
