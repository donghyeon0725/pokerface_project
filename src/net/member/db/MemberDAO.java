package net.member.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import tool.Security;


public class MemberDAO {
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs; 
	private DataSource ds;
	private String accountTable = " account ";
	private String privacyTable = " privacy ";
	private Security security;
	
	public static void main(String[] args) {
		//테스트 할때 사용하세요
		
		int randomSeed1 = (int)(Math.random() * 100)  + 1;
		int randomSeed2 = (int)(Math.random() * 100)  + 1;
		int randomSeed3 = (int)(Math.random() * 100)  + 1;
		String total = "" + randomSeed1 + randomSeed2 + randomSeed3;
		Security sc = new Security();
		
		System.out.println(sc.encodeBase64(total));
		
	}
	
	
	public MemberDAO () {
		try {
			Context init = new InitialContext();
			ds  = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
			security = new Security();
		} catch(Exception e) {
			System.out.println("DB 연결 실패 : " + e );
			return;
		}
	}
	
	public void connect() {
		try {
			con = ds.getConnection();
		} catch(Exception e) {
			System.out.println("연결 중 에러 발생  : " +e);
		}
	}
	
	public void disConnect() {
		try {
			if(rs != null) { 
				rs.close();
			}
			if(pstmt != null) { 
				pstmt.close();
			}
			if(con != null) {
				con.close();
			}
		} catch(Exception e) {
			System.out.println("연결 해제 중 에러 발생  : " +e);
		}
	}
	
	//아이디와 새로운 비밀번호를 받아서 비밀번호 변경
	public boolean updatePassword (String id, String newPW) {
		String salt = getSalt(id);
		System.out.println("변경 위해 받은 아이디 : " + id );
		System.out.println("변경 될 비밀 번호 : " + newPW );
		connect();
		
		String sql = "UPDATE " +accountTable + " SET PW = ? WHERE ID = ?";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, security.encodeBase64(security.SHAValue(newPW, salt)));
			pstmt.setString(2, security.encodeBase64(id));
			
			int next = pstmt.executeUpdate();
			if(next == 1) {
				return true;
			}
			
		} catch(SQLException e) {
			System.out.println("updatePassword 에러 : " + e);
		}
		
		
		return false;
	}
	
	//아이디로 멤버 솔트값 찾아오기
	public String getSalt (String id) {
		connect();
		String salt = null;
		
		String sql = "SELECT SALT FROM " + accountTable + " WHERE ID = ?";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, security.encodeBase64(id));
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				salt = rs.getString(1);
				System.out.println("getSalt로 얻어낸 솔트 값 " + security.decodeBase64(salt));
				return security.decodeBase64(salt);
				//디코딩 해서 보냄
			}
			
		} catch(SQLException e) {
			System.out.println("getSalt 에러 : " + e);
		}
		
		
		return null;
	}
	
	//아이디로 이메일 알아내기
	public String getEmail(String id) {
		connect();
		
		String sql = "SELECT pr.EMAIL FROM " + privacyTable + "pr, " + accountTable + " ac " + " WHERE ac.ssnum = pr.ssnum AND ac.id LIKE ?";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, security.encodeBase64(id));
			
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				return security.decodeBase64(rs.getString(1));
			}
		} catch(SQLException e) {
			System.out.println("getEmail에러 : " + e);
		}
		return null;
	}
	
	
	//foundPW.jsp 에서 쓸 메소드 => 멤버인지 확인함 
	public boolean isMemberWithSSNUM(String id, String ssnum) {
		connect();
		
		String sql = "SELECT ID FROM " + accountTable + " ac, " +privacyTable +" pr WHERE ac.ssnum = pr.ssnum AND ac.id = ? AND pr.ssnum = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, security.encodeBase64(id));
			pstmt.setString(2, security.encodeBase64(ssnum));
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				System.out.println("선택 된 값이 있으므로 이 사람은 회원입니다." + rs.getString(1));
				return true;
			}
		} catch (SQLException e) {
			System.out.println("isMemberWithSSNUM 에러 : " + e);
		} finally {
			disConnect();
		}
		
		return false;
	}
	
	//이메일로 비밀번호를 찾을때 등등, 사용할 랜덤한 생성키
	public String getSecurityKey () {
		String key = null;
		
		int randomSeed1 = (int)(Math.random() * 100)  + 1;
		int randomSeed2 = (int)(Math.random() * 100)  + 1;
		int randomSeed3 = (int)(Math.random() * 100)  + 1;
		String total = "" + randomSeed1 + randomSeed2 + randomSeed3;
		System.out.println("생성된 랜덤 키 값 : " + security.encodeBase64(total));
		
		return security.encodeBase64(total);
	}
	
	//중복 검사
	public boolean isDuplication(String id) {
		connect();
		
		String sql = "SELECT ID FROM " + accountTable + " WHERE ID LIKE ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, security.encodeBase64(id));
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				System.out.println("중복 검사에서 선택된 값 : " + rs.getString(1));
				return true;
			}
		} catch (SQLException e) {
			System.out.println("isDuplication 에러 : " + e);
		} finally {
			disConnect();
		}
		
		return false;
	}
	
	//아이디 찾기
	public ArrayList<String> foundID(String tel, String email) {
		connect();
		String id = null;
		ArrayList<String>  list = new ArrayList<>();
		
	    String sql = "select ssnum  from " + privacyTable + " where email like ? and tel like ? ";
	    String sql2 = "select id from " + accountTable + "  where ssnum like ? ";
	    try {
	    	pstmt = con.prepareStatement(sql);
	    	System.out.println("입력받은 이메일 : " + email);
	    	System.out.println("입력받은 전화번호 : " + tel);
	    	pstmt.setString(1, security.encodeBase64(email));
	    	pstmt.setString(2, security.encodeBase64(tel));
	         
	    	rs = pstmt.executeQuery();
	    	String ssnum = null;
	    	if (rs.next()) {
	    		ssnum = rs.getString(1);
	    	} else {
	    		return null;
	    	}
	    	//검색된 주민번호를 가져왔다.
	    	
	    	
	    	pstmt = con.prepareStatement(sql2);
	    	pstmt.setString(1, ssnum);
	    	rs = pstmt.executeQuery();
	    	while (rs.next()) {
	    		System.out.println("검색결과 받아온 아이디" + security.decodeBase64(rs.getString(1)));
	    		list.add(security.decodeBase64(rs.getString(1)));
	    	}
	    	return  list;
	         
	    } catch (Exception e) {
	    	System.out.println("foundID 에러 " + e);
	         System.out.println("sql : " + sql);
	         System.out.println("sql2 : " + sql2 );
	    } finally {
	         disConnect();
	    }
	    return null;
	}
	
	
	//멤버 전부를 가져오기 => !!!!!!!!!!!수정 안했음
	public ArrayList<MemberBean> getAllMembers () {
		connect();
		
		ArrayList<MemberBean> list = new ArrayList <> ();
		String sql  ="SELECT * from " + accountTable;
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemberBean bean = new MemberBean();
				
				bean.setID(rs.getString("id"));
				bean.setPW(rs.getString("pw"));
				bean.setGENDER(rs.getString("gender"));
				bean.setEMAIL(rs.getString("email"));
				bean.setSALT("");
				
				bean = decodedMemberDAO(bean, security, "");
				
				list.add(bean);
			}
			return list;
		} catch (SQLException e) {
			System.out.println("getMembers 에러 : " + e);
		} finally {
			disConnect();
		}
		return null;
	}
	
	
	
	//멤버 한명을 가져오기 => !!!!!!!!!!!수정 안했음
	public MemberBean getMember(String id) {
		connect();
		
		String sql  ="SELECT * from " + accountTable + " WHERE id like ?";
		MemberBean bean = new MemberBean();
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bean.setID(rs.getString("id"));
				bean.setPW(rs.getString("pw"));
				bean.setGENDER(rs.getString("gender"));
				bean.setEMAIL(rs.getString("email"));
				bean.setSALT(rs.getString("salt"));
			}
			
			bean = decodedMemberDAO(bean, security, "");
			return bean;
		} catch (SQLException e) {
			System.out.println("getMembers 에러 : " + e);
		} finally {
			disConnect();
		}
		return null;
	}
	
	//아이디 길이나 사용문자가 적합한지 
	public boolean rightId(String formId) {
		if(formId.length() >8 && formId.length() < 20) {
			return true;
		}
		return false;
	}
	
	
	//중복되었는지
	public boolean duplicationId(String formId) {
		connect();
		
		String sql  = "SELECT ID FROM " + accountTable + " WHERE ID = ?";
			
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, security.encodeBase64(formId));
			
			int result = pstmt.executeUpdate();
			
			if(result == 1) {
				return false;
			}
		} catch (SQLException e) {
			System.out.println("duplicationId 에러 : " + e);
		} finally {
			disConnect();
		}
		return true;
	}
	
	//비밀번호가 적합한지
	//길이는 8~20
	//특수문자 1개 이상
	//영문 + 숫자
	public boolean rightPass(String formPass) {
		if(formPass.length() > 8 && formPass.length() < 20) {
			return true;
		}
		return false;
	}
	

	//가입시키기 
	public int joinMember(MemberBean bean) {
		if(!rightId(bean.getID())) {
			return -1;
		} else if(!duplicationId(bean.getID())) {
			return -2;
		} else if(!rightPass(bean.getPW())) {
			return 0;
		}
		//-3은 에러 -2는 아이디 중복 -1은 아이디 부적합 0은 비밀번호 부적합 1은 통과
		connect();
		MemberBean member = bean;
		//먼저 인코딩을 한다.
		member = encodedMemberDAO(member, security, security.salt());
			
		String sql  ="INSERT into " +privacyTable +" values(?,?,?,?)";
			
		try {
			pstmt = con.prepareStatement(sql);
			System.out.println("처음 가져온 값 : " + member.getSSNUM());
			pstmt.setString(1, member.getSSNUM());
			pstmt.setString(2, member.getGENDER());
			pstmt.setString(3, member.getTEL());
			pstmt.setString(4, member.getEMAIL());
			
			int result = pstmt.executeUpdate();
			System.out.println("privacyTable 테이블 삽입 성공");
			if(result != 1) {
				return -3;
			}
			
			
			sql = "INSERT into " +accountTable +" values(?,?,?,?,?,?)";
			
			System.out.println(member.getID());
			System.out.println(member.getPW());
			System.out.println(member.getSALT());
			System.out.println(member.getSSNUM());
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getID());
			pstmt.setString(2, member.getPW());
			pstmt.setString(3, " ");
			pstmt.setString(4, " ");
			//null을 허용하도록 했지만 직접 null은 넣을 수 없음
			pstmt.setString(5, member.getSALT());
			pstmt.setString(6, member.getSSNUM());
			
			int total  = pstmt.executeUpdate();
			
			if(total == 1) {
				return 1;
			}
				
		} catch (SQLException e) {
			System.out.println("joinMember 에러 : " + e);
		} finally {
			disConnect();
		}
		return -3;
	}

	
	//멤버가 맞는지 판정하기. 로그인 할 때 사용
	public boolean isMember(String id, String password) {
		connect();
		
		String sql  ="SELECT password, salt from " + accountTable + " WHERE id like ?";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, security.encodeBase64(id));
			rs = pstmt.executeQuery();
			
			String getPass = "";
			String getSalt = "";
			if(rs.next()) {
				getPass = security.decodeBase64(rs.getString("password"));
				System.out.println(getPass);
				getSalt = security.decodeBase64(rs.getString("salt"));
			}
			
			//for debug
			System.out.println("받은 비밀번호 : " + getPass);
			System.out.println("DB의 비밀번호 : " + password);
			System.out.println(security.SHA256( getSalt +  password));
			
			if(getPass.equals(security.SHA256( getSalt +  password))) {
				//대신 SHAValue 사용 가능
				return true;
			}
			
		} catch (SQLException e) {
			System.out.println("isMember 에러 : " + e);
		} finally {
			disConnect();
		}
		return false;
	}
	
	//삭제 전에 모든 보드 먼저 지우기 => MemberDAO에서만 사용이 가능 
	//모든 리플라이도 지워야함!
	public boolean deleteAllBoards(String id, String password) {
		connect();
		boolean result = false;
		String sql  = "DELETE FROM " +  privacyTable + " WHERE ID LIKE ?";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			int next = pstmt.executeUpdate();
			
			if(next == 1) {
				return true;
			}
			
		} catch (SQLException e) {
			System.out.println("deleteAllBoards 에러 : " + e);
		} finally {
			disConnect();
		}
		return result;
	}
	
	//멤버를 삭제하는 메소드 => !!!!!!아직 수정안함
	public boolean deleteMember(String id, String password) {
		boolean isMember = isMember(id, password);

		//비밀번호가 맞는지 검사
		if(!isMember) {
			return false;
		}
		
		//boolean canProcess = deleteAllReply(id, password);
		boolean canProcess = deleteAllBoards(id, password);
			
		if(!canProcess) {
			return false;
			//진행할 수 없음
		}
		connect();
		
		String sql = "DELETE FROM " + accountTable + " WHERE ID = ?" ;
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			int next = pstmt.executeUpdate();
			
			if(next == 1) {
				return true;
			}
			
		} catch(Exception e) {
			System.out.println("deleteMember 에러 : " + e);
		} finally {
			disConnect();
		}
		return false;
	}
	
	
	
	//멤버 빈 단위로 인코딩해줌
	private MemberBean encodedMemberDAO(MemberBean member, Security sc, String salt) {
		MemberBean bean = new MemberBean(); 
		
		bean.setID(sc.encodeBase64(member.getID()));
		bean.setPW(sc.encodeBase64(security.SHAValue(member.getPW(), salt)));
		bean.setGENDER(sc.encodeBase64(member.getGENDER()));
		bean.setEMAIL(sc.encodeBase64(member.getEMAIL()));
		bean.setSSNUM(sc.encodeBase64(member.getSSNUM()));
		bean.setTEL(sc.encodeBase64(member.getTEL()));
		bean.setSALT(sc.encodeBase64(salt));
		
		return bean;
	}
	
	//멤버 빈 단위로 디코딩 해줌
	private MemberBean decodedMemberDAO(MemberBean member, Security sc, String salt) {
		MemberBean bean = new MemberBean(); 
		
		bean.setID(sc.decodeBase64(member.getID()));
		bean.setPW(sc.decodeBase64(member.getPW()));
		//비밀번호는 decoded 하면 암호화 된 (비번 + 솔트)값
		bean.setGENDER(sc.decodeBase64(member.getGENDER()));
		bean.setEMAIL(sc.decodeBase64(member.getEMAIL()));
		if(salt != null && !salt.equals("")) {
			bean.setSALT(sc.decodeBase64(member.getSALT()));
		} else {
			bean.setSALT("value what you can read");
		}
		bean.setTEL(sc.decodeBase64(member.getTEL()));
		bean.setSSNUM(sc.decodeBase64(member.getSSNUM()));
		
		return bean;
	}
	
}
