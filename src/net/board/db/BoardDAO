package net.board.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import net.member.db.MemberBean;
import tool.Security;

public class BoardDAO {
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs; 
	private ResultSet newRs;
	private DataSource ds;
	private String boardTable = " BOARD ";
	private String like_itTable = " LIKE_IT ";
	private String replyTable = " REPLY ";
	private Security security;
	
	public static void main(String[] args) {
		
	}
	
	public BoardDAO () {
		try {
			Context init = new InitialContext();
			ds  = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
			security = new Security();
		} catch(Exception e) {
			System.out.println("DB 연결 실패 : " + e );
			return;
		}
	}
	
	

	private void connect() {
		try {
			con = ds.getConnection();
		} catch(Exception e) {
			System.out.println("연결 중 에러 발생  : " +e);
		}
	}
	
	private void disConnect() {
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
			if(newRs != null) {
				newRs.close();
			}
			
		} catch(Exception e) {
			System.out.println("연결 해제 중 에러 발생  : " +e);
		}
	}
	
	//조건에 해당하는 모든 보드를 가져옴 
	public ArrayList<BoardEntry> getBoards (String watcherID, String openOption, String orderOption, String searchOption, String searchKeyword) {
		connect();
		//friendBoards totalBoards/ oldest newest/ idSearch contentSearch
		
		String sql = "select * from board where id in (select regexp_substr(friend, '[^,]+', 1, level) friends from (select friend from account where id=?) connect by instr(friend, ',', 1, level - 1) > 0)";
		/* sql 설명
		 select regexp_substr(friend, '[^,]+', 1, level) friends from (select friend from account where id='zs1') connect by instr(friend, ',', 1, level - 1) > 0)
		 account의 board를 ','을 기준으로 나눈 값을 row 형태로 가지고 있음
		 id board의 id값중 앞서 사전 검색한 row에 해당하는 값이 있으면 모두 검색
		 즉, 친구 인 사람의 모든 게시물만 검색한 것이다.
		 */
		
		//친구가 아닌 전체 보기일 때 sql = "select * from board"; 이것을 사용해야할 것 같다. watcher는 그대로 써야함
		//게시물을 어떻게 가져올 것인가... 가장 위에 있는 sql을 어떤 순서로 가져올지 어떤 내용만 가져올지 결정해야함
		//orderOption은 뒤에 order by udate desc 등을 붙여줌
		//키워드는 where 조건 붙여줌
		
		
		//게시물 값, 주인의 프로필, 보는 사람(id)이 좋아요를 눌렀는지 여부를 함께 가져와야함
		
		ArrayList <BoardEntry> list = new ArrayList();
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, watcherID);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardBean board = new BoardBean();
				MemberBean member = new MemberBean();
				ArrayList<ReplyBean> replys = new ArrayList<>();
				
				boolean isLike;
				int boardnum;
				String boardOwner = null;
				
				board.setBOARDNUM(boardnum = rs.getInt("boardnum"));
				//이것을 이용해서 사용자의 좋아요 누름 여부를 검색해야한다.
				board.setCONTENT(rs.getString("content"));
				board.setID(boardOwner = rs.getString("id"));
				//이것은 보드 주인의 아이디이다. 절대 위에서 받은 아이디가 아니다.
				board.setIMAGE(rs.getString("image"));
				board.setLIKECOUNT(rs.getInt("likecount"));
				board.setUDATE(rs.getDate("udate"));
				//보드 정보 완료
				
				System.out.println("보드 주인 : " + boardOwner);
				
				
				//이 와중에 보드 번호에 해당하는 MemberBean 정보 가져옴
				sql = "SELECT ID, PFILE FROM ACCOUNT WHERE ID LIKE ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, boardOwner);
				newRs = pstmt.executeQuery();
				if(newRs.next()) {
					member.setID(newRs.getString("id"));
					member.setPFILE(newRs.getString("PFILE"));
				}
				//멤버정보 완료
				System.out.println("보드 주인 : " + boardOwner);
				
				sql = "SELECT ISLIKE FROM LIKE_IT WHERE BOARDNUM = ? AND ID = ?";
				//보는 사람이 보고있는(좋아요를 누른사람) 보드 번호에 좋아요를 눌렀는가
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, boardnum);
				pstmt.setString(2, watcherID);
				newRs = pstmt.executeQuery();
				if(newRs.next()) {
					isLike = Boolean.parseBoolean(newRs.getString("isLike"));
					//좋아요를 누른사람
				} else {
					isLike = false;
					//좋아요를 누른 여부가 없다면
				}
				//좋아요 여부완료
				System.out.println("보드 주인 : " + boardOwner);
				
				
				sql = "select * from reply where ref = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, boardnum);
				newRs = pstmt.executeQuery();
				while(newRs.next()) {
					ReplyBean reply = new ReplyBean();
					
					reply.setID(newRs.getString("id"));
					reply.setCONTENT(newRs.getString("content"));
					reply.setUDATE(newRs.getDate("udate"));
					
					replys.add(reply);
				}
				System.out.println("보드 주인 : " + boardOwner);
				
				BoardEntry boardEntry = new BoardEntry(board, member, replys, isLike);
				
				list.add(boardEntry);
			}
			return list;
		} catch(SQLException e) {
			System.out.println("getBoards 에러 : " + e);
		} finally {
			disConnect();
		}
		return null;
	}
	
	//계정 정보에 해당하는 개인정보를 가져옴
	
	
	
}
