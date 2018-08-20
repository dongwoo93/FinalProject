package kh.sns.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import kh.sns.dto.ProfileDTO;
import kh.sns.interfaces.ProfileDAO;

@Repository
public class IProfileDAO implements ProfileDAO {
	
	@Autowired
	private JdbcTemplate template;
	
	@Override
	public ProfileDTO getOneProfile(String id) throws Exception {
		String sql = "select * from profile where id=?";
		
		List<ProfileDTO> temp = template.query(sql, new Object[] {id}, (rs, rowNum) -> {
			
			ProfileDTO profile = new ProfileDTO();
			profile.setId(rs.getString("id"));
			profile.setIntroduce(rs.getString("introduce"));
			profile.setWebsite(rs.getString("website"));
			profile.setIs_allow_email(rs.getString("is_allow_email"));
			profile.setIs_allow_login2(rs.getString("is_allow_login2"));
			profile.setIs_allow_public(rs.getString("is_allow_public"));
			profile.setIs_allow_share(rs.getString("is_allow_share"));
			profile.setIs_allow_sms(rs.getString("is_allow_sms"));
			profile.setIs_allow_status(rs.getString("is_allow_status"));
			
			return profile;			
		});	
		
		return temp.get(0);	// queryForObject 에러나서 이렇게함
	}
	
	@Override
	public int updateOneAdvancedProfile(ProfileDTO profile) throws Exception {
		String sql = "update profile set website = ?, introduce = ? where id = ?";
		return template.update(sql, profile.getWebsite(), profile.getIntroduce(), profile.getId());
	}
	
	@Override
	public int updateProfileCheckbox(ProfileDTO profile, String fieldName, boolean isYes) throws Exception {
		String sql = "update profile set " + fieldName + " = ?";
		return template.update(sql, isYes ? "y" : "n");
	}
	
	public boolean isNotPublic(String id) throws Exception {
		String sql = "select is_allow_public from profile where id=?";
		boolean result =false;
		String is_allow_public = template.query(sql, new String[] {id}, new RowMapper<String>() {

			@Override
			public String mapRow(ResultSet rs, int rowNum) throws SQLException {
				return rs.getString("is_allow_public");
			}
		}).get(0);
		
		if(is_allow_public.equals("n")) {    
			result = true;
		}
		return result;
	}
}
