package VO;

public class loginVO {
	//로그인 
	//멤버변수 선언
	private String id;
	
	public boolean checkUser() {
			if(id.equals(id)){
				return true;
			}
			else
				return false;
		}
	public void setUserid(String id) {
		this.id = id;
	}

	public String getUserid() {
		return id;
	}
	
	
}
