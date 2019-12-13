package net.member.action;

public class ActionForward {
	private String path;
	private boolean isRedirect;
	public ActionForward(String path, boolean isRedirect) {
		//생성자를 통해서도 간단하게 경로와 Redirect 여부를 설정 가능하게 해둠
		this.path = path;
		this.isRedirect = isRedirect;
	}
	
	public ActionForward() {
	}
	
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public boolean isRedirect() {
		return isRedirect;
	}
	public void setRedirect(boolean isRedirect) {
		this.isRedirect = isRedirect;
	}
}
