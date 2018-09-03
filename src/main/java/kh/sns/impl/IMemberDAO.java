package kh.sns.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import kh.sns.dto.MemberDTO;
import kh.sns.interfaces.MemberDAO;

@Component
public class IMemberDAO implements MemberDAO {
	
	@Autowired
	private JdbcTemplate template;


	@Override
	public int loginMem(MemberDTO dto) {		
		String sql = "select * from member where id=? and pw=?";
		return template.update(sql, dto.getId(), dto.getPw());
	}
	@Override
	public List<MemberDTO> selectfriendlist(String id,String searchtext) throws Exception{
		String sql = "select nickname from member where id in(select id from member_follow where target_id=? and id in(select target_id from member_follow where id=?)) and nickname like '%'||?||'%'";
		
		return template.query(sql, new String[] {id,id,searchtext}, new RowMapper<MemberDTO>() {

			@Override
			public MemberDTO mapRow(ResultSet rs, int arg1) throws SQLException {
				System.out.println("홀로로로로ㅗ롤" + rs.getString(1));
				MemberDTO dto = new MemberDTO("","",rs.getString(1),"","","","");   
				return dto;
			}

			
		});
	}
	
	@Override
	public List<MemberDTO> findMember(String searchtext) throws Exception {
		String sql = "select * from member where id like '%'||?||'%'";
		return template.query(sql, new Object[] {searchtext}, new RowMapper<MemberDTO>() {
			
			@Override
			public MemberDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				MemberDTO tmp = new MemberDTO();
				tmp.setId(rs.getString("id"));
				tmp.setEmail(rs.getString("email"));
				tmp.setGender(rs.getString("gender"));
				tmp.setName(rs.getString("name"));
				tmp.setNickname(rs.getString("nickname"));
				tmp.setPhone(rs.getString("phone"));
				tmp.setPw(rs.getString("pw"));
				return tmp;
			}
		});
	}
	
	@Override
	public List<MemberDTO> selectfollowlist(String id,String searchtext) throws Exception{
		String sql = "select id,nickname from member where id in(select target_id from member_follow where id=?) and nickname like '%'||?||'%'";
		
		return template.query(sql, new String[] {id,searchtext}, new RowMapper<MemberDTO>() {

			@Override
			public MemberDTO mapRow(ResultSet rs, int arg1) throws SQLException {
				MemberDTO dto = new MemberDTO(rs.getString(1),"",rs.getString(2),"","","","");   
				return dto;
			}

			
		});
	}


	@Override
	public int signUp(MemberDTO dto)  throws Exception {
		// TODO Auto-generated method stub
		String sql = "insert into member values(?,?,?,?,?,?,?,default,default,?,?) ";
		return template.update(sql,dto.getId(),dto.getPw(),dto.getNickname(),dto.getEmail(),dto.getPhone(),dto.getGender(),dto.getName(),dto.getLastDisabledDate(),dto.getDisabledReason());
				
	}
	
	@Override
	public int insertProfile(String id) throws Exception {
		String sql = "insert into profile values(?,'','',default,default,default,default,default,default,sysdate)";
		return template.update(sql,id);
	}


	@Override
	public int isIdExist(String id) {
		// TODO Auto-generated method stub

		String sql = "SELECT * FROM MEMBER WHERE ID =?";
		return template.update(sql,id);

	}


	@Override
	public int isNickExist(String nick) {
		// TODO Auto-generated method stub

		String sql = "SELECT * FROM MEMBER WHERE nickname =?";
		return template.update(sql, nick);		
	}


	@Override
	public int isEmailExist(String email) {
		// TODO Auto-generated method stub
		String sql = "SELECT * FROM MEMBER WHERE email =?";
		return template.update(sql, email);		
	}
	
	@Override
	public MemberDTO getOneMember(String id) throws Exception {
		String sql = "select * from member where id=?";
		
		List<MemberDTO> temp = template.query(sql, new Object[] {id}, (rs, rowNum) -> {
			MemberDTO member = new MemberDTO();
			member.setId(rs.getString("id"));
			member.setEmail(rs.getString("email"));
			member.setGender(rs.getString("gender"));
			member.setName(rs.getString("name"));
			member.setNickname(rs.getString("nickname"));
			member.setPhone(rs.getString("phone"));
			member.setPw(rs.getString("pw"));
			member.setIsDisabledAccount(rs.getString("is_disabled_account"));
			member.setIsBlockedAccount(rs.getString("is_blocked_account"));
			member.setDisabledReason(rs.getInt("disabled_reason"));
			member.setLastDisabledDate(rs.getString("last_disabled_date"));
			return member;			
		});		
		
		return temp.get(0);
		

/*		try {
			return template.queryForObject(sql, new Object[] {id}, (rs, rowNum) -> {
				MemberDTO member = new MemberDTO();
				member.setId(rs.getString("id"));
				member.setEmail(rs.getString("email"));
				member.setGender(rs.getString("gender"));
				member.setName(rs.getString("name"));
				member.setNickname(rs.getString("nickname"));
				member.setPhone(rs.getString("phone"));
				member.setPw(rs.getString("pw"));
				return member;
			});
		} catch( NoSuchMethodError | EmptyResultDataAccessException e ) {
			e.printStackTrace();
			return null;
		} // 이건 왜 안되는거야? */
		
	}
	
	@Override
	public int updateOneMemberProfile(MemberDTO member) throws Exception {
		String sql = "update member set NAME=?, NICKNAME=?, PHONE=?, EMAIL=?, GENDER=? "
				+ "where id=?";
		return template.update(sql, member.getName(), member.getNickname(), 
				member.getPhone(), member.getEmail(), member.getGender(), member.getId());
		
	}
	
	@Override
	public int updateOneMemberPassword(MemberDTO member) throws Exception {
		String sql = "update member set pw=? where id=?";
		return template.update(sql, member.getPw(), member.getId());
	}
	
	@Override
	public int checkEmailDuplicated(String email, String currentUserId) throws Exception {
		String sql = "select * from member where email = ? and id != ?";
		return template.update(sql, email, currentUserId);
	}


	@Override
	public int findPw(MemberDTO dto) {
		// TODO Auto-generated method stub
		
	     String sql = "update member set pw=? where id=? and email=?";

		
		return template.update(sql, dto.getPw(), dto.getId(), dto.getEmail());
	}


	@Override
	public String changePass(String id) throws Exception{
		// TODO Auto-generated method stub
		String sql = "select pw from member where id=?";
		
		List<MemberDTO> temp = template.query(sql, new Object[] {id}, (rs, rowNum) -> {
			MemberDTO member = new MemberDTO("",rs.getString("pw"),"","","","","");
			
			return member;			
		});		
		
		return temp.get(0).getPw();
		
	}


	@Override
	public List<MemberDTO> findId(String name, String email) throws Exception{
		System.out.println(name);
		String sql = "select id from member where name=? and email=?";
	
		return template.query(sql, new String[] {name,email}, new RowMapper<MemberDTO>() {
			@Override
			public MemberDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				MemberDTO tmp = new MemberDTO(rs.getString("id"),"","","","","","");
		
				return tmp;
			}
		});		
	}
	@Override
	public List<MemberDTO> myNick_Id(String id) throws Exception {
		String sql = "select nickname from member where id=?";
		MemberDTO dto = new MemberDTO();
		return template.query(sql, new Object[] {id}, new RowMapper<MemberDTO>() {

			@Override
			public MemberDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				dto.setNickname(rs.getString(1));
				return dto;
			}
			
		});
	}
	
	@Override
	public MemberDTO selectUserId(String nickname) throws Exception {
		String sql = "select * from member where nickname=?";
		
		return template.query(sql, new String[] {nickname}, new RowMapper<MemberDTO>() {

			@Override
			public MemberDTO mapRow(ResultSet rs, int arg1) throws SQLException {
				MemberDTO dto = new MemberDTO(rs.getString(1),"","","","","","");   
				return dto;
			}

			
		}).get(0);
		
	}
	
	@Override
	public int updateDisabledInfo(MemberDTO member) throws Exception {
		String sql = "update member set is_disabled_account = ?, LAST_DISABLED_DATE = sysdate, DISABLED_REASON = ? where id = ?";
		return template.update(sql, member.getIsDisabledAccount(), member.getDisabledReason(), member.getId());
	}
	
	@Override
	public int checkIdPwd(MemberDTO dto) {
		String sql = "select * from member where id=? and pw=?";
		return template.update(sql, dto.getId(), dto.getPw());
	}
}