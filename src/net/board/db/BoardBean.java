package net.board.db;

import java.sql.Date;

public class BoardBean {
	private int BOARDNUM;
	private Date UDATE;
	private String CONTENT;
	private String IMAGE;
	private int LIKECOUNT;
	private String ID;
	
	public int getBOARDNUM() {
		return BOARDNUM;
	}
	public void setBOARDNUM(int bOARDNUM) {
		BOARDNUM = bOARDNUM;
	}
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
	public String getIMAGE() {
		return IMAGE;
	}
	public void setIMAGE(String iMAGE) {
		IMAGE = iMAGE;
	}
	public int getLIKECOUNT() {
		return LIKECOUNT;
	}
	public void setLIKECOUNT(int lIKECOUNT) {
		LIKECOUNT = lIKECOUNT;
	}
	public String getID() {
		return ID;
	}
	public void setID(String iD) {
		ID = iD;
	}
}
