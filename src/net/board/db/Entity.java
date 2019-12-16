package net.board.db;

import java.util.ArrayList;

import net.member.db.MemberBean;

public class Entity {
	private BoardBean boardBean;
	private MemberBean memberBean;
	private ArrayList<ReplyBean> replyBeans;
	private LikeBean likeBean;
	private RelationshipBean relationshipBean;
	
	//보드 게시판을 가져올 때 유용하게 사용할 듯
	public Entity (BoardBean boardBean, MemberBean memberBean, ArrayList<ReplyBean> replyBeans, LikeBean likeBean, RelationshipBean relationshipBean) {
		this.boardBean = boardBean;
		this.memberBean =  memberBean;
		this.replyBeans = replyBeans;
		this.likeBean = likeBean;
		this.relationshipBean = relationshipBean;
		//여기서 라이크는 게시물을 보고 있는 사람이 게시물을 눌렀는가 표시하기 위함이다. 주의하자.
	}

	public BoardBean getBoardBean() {
		return boardBean;
	}

	public void setBoardBean(BoardBean boardBean) {
		this.boardBean = boardBean;
	}

	public MemberBean getMemberBean() {
		return memberBean;
	}

	public void setMemberBean(MemberBean memberBean) {
		this.memberBean = memberBean;
	}

	public ArrayList<ReplyBean> getReplyBeans() {
		return replyBeans;
	}

	public void setReplyBeans(ArrayList<ReplyBean> replyBeans) {
		this.replyBeans = replyBeans;
	}

	public LikeBean getLikeBean() {
		return likeBean;
	}
	public void setLikeBean(LikeBean likeBean) {
		this.likeBean = likeBean;
	}

	public RelationshipBean getRelationshipBean() {
		return relationshipBean;
	}

	public void setRelationshipBean(RelationshipBean relationshipBean) {
		this.relationshipBean = relationshipBean;
	}
}
