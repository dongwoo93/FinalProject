package kh.sns.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
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
	
	
//	@Override
//	public boolean isIdExist(String id) throws Exception{
//		
//		String sql = "SELECT * FROM MEMBER WHERE ID =?";
//		return template.update(new Object[] {id});		
//
//	}
}