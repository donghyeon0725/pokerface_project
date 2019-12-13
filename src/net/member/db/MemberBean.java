package net.member.db;

public class MemberBean {
	private String ID;
	private String PW;
	private String GENDER;
	private String EMAIL;
	private String SALT;
	private String TEL;
	private String PFILE;
	private String FRIEND;
	private String SSNUM;
	
	
	public String getSALT() {
		return SALT;
	}
	public void setSALT(String sALT) {
		SALT = sALT;
	}
	public String getID() {
		return ID;
	}
	public void setID(String iD) {
		ID = iD;
	}
	public String getGENDER() {
		return GENDER;
	}
	public void setGENDER(String gENDER) {
		GENDER = gENDER;
	}
	public String getEMAIL() {
		return EMAIL;
	}
	public void setEMAIL(String eMAIL) {
		EMAIL = eMAIL;
	}
	public String getPW() {
		return PW;
	}
	public void setPW(String pW) {
		PW = pW;
	}
	public String getTEL() {
		return TEL;
	}
	public void setTEL(String tEL) {
		TEL = tEL;
	}
	public String getPFILE() {
		return PFILE;
	}
	public void setPFILE(String pFILE) {
		PFILE = pFILE;
	}
	public String getFRIEND() {
		return FRIEND;
	}
	public void setFRIEND(String fRIEND) {
		FRIEND = fRIEND;
	}
	public String getSSNUM() {
		return SSNUM;
	}
	public void setSSNUM(String sSNUM) {
		SSNUM = sSNUM;
	}
}
