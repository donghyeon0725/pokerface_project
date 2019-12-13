package net.board.db;

public class LikeBean {
	private String OWNER;
	private String ISLIKE;
	private String ID;
	private int BOARDNUM;
	
	public String getOWNER() {
		return OWNER;
	}
	public void setOWNER(String oWNER) {
		OWNER = oWNER;
	}
	public String getISLIKE() {
		return ISLIKE;
	}
	public void setISLIKE(String iSLIKE) {
		ISLIKE = iSLIKE;
	}
	public String getID() {
		return ID;
	}
	public void setID(String iD) {
		ID = iD;
	}
	public int getBOARDNUM() {
		return BOARDNUM;
	}
	public void setBOARDNUM(int bOARDNUM) {
		BOARDNUM = bOARDNUM;
	}
}
