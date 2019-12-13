package net.board.db;

import java.sql.Date;

public class ReplyBean {
	private Date UDATE;
	private String CONTENT;
	private int REPLYNUM;
	private String ID;
	
	public Date getUDATE() {
		return UDATE;
	}
	public void setUDATE(Date uDATE) {
		UDATE = uDATE;
	}
	public String getCONTENT() {
		return CONTENT;
	}
	public void setCONTENT(String cONTENT) {
		CONTENT = cONTENT;
	}
	public int getREPLYNUM() {
		return REPLYNUM;
	}
	public void setREPLYNUM(int rEPLYNUM) {
		REPLYNUM = rEPLYNUM;
	}
	public String getID() {
		return ID;
	}
	public void setID(String iD) {
		ID = iD;
	}
}
