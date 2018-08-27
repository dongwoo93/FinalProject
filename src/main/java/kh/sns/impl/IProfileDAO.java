package kh.sns.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import kh.sns.dto.ProfileDTO;
import kh.sns.dto.Profile_ImageDTO;
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
	
	@Override
	public List<Profile_ImageDTO> selectProfileImage(String id) throws Exception {
		String sql = "select * from profile_image where id=? order by apply_date desc";
		return template.query(sql, new Object[] {id}, new RowMapper<Profile_ImageDTO>() {

			@Override
			public Profile_ImageDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				Profile_ImageDTO tmp = new Profile_ImageDTO();
				tmp.setId(rs.getString(1));
				tmp.setOriginal_file_name(rs.getString(2));
				tmp.setSystem_file_name(rs.getString(3));
				tmp.setIs_selected(rs.getString(4));
				return tmp;
			}
		});
	}
	
	@Override
	public String selectOneProfileImage(String id) throws Exception {
		String sql = "select * from profile_image where id=? and is_selected='y'";
		String result = "";
		List<Profile_ImageDTO> image = template.query(sql, new Object[] {id}, new RowMapper<Profile_ImageDTO>() {

			@Override
			public Profile_ImageDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				Profile_ImageDTO tmp = new Profile_ImageDTO();
				tmp.setId(rs.getString(1));
				tmp.setOriginal_file_name(rs.getString(2));
				tmp.setSystem_file_name(rs.getString(3));
				tmp.setIs_selected(rs.getString(4));
				return tmp;
			}
		});
		
		if(image.size() > 0) {
			result =  image.get(0).getSystem_file_name();
		}
		return result;
	}

	@Override
	public int insertProfileImage(Profile_ImageDTO dto) throws Exception {
		String sql = "insert into profile_image values(?,?,?,?,sysdate)";
		return template.update(sql, dto.getId(), dto.getOriginal_file_name(), dto.getSystem_file_name(), dto.getIs_selected());
	}

	@Override
	public int updateProfileImages(String id) throws Exception {
		String sql = "update profile_image set is_selected='n' where id=?";
		return template.update(sql, id);
	}

	@Override
	public int updateProfileImages2(String systemFileName) throws Exception {
		String sql = "update profile_image set is_selected='y', apply_date=sysdate where system_file_name=?";
		return template.update(sql, systemFileName);
	}

	@Override
	public List<Profile_ImageDTO> getAllProfileImage() throws Exception {
		// TODO Auto-generated method stub
		
		String sql = "select * from profile_image where is_selected='y'";
		return template.query(sql, new RowMapper<Profile_ImageDTO>() {

			@Override
			public Profile_ImageDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				// TODO Auto-generated method stub
				Profile_ImageDTO tmp = new Profile_ImageDTO();
				tmp.setId(rs.getString("id"));
				tmp.setOriginal_file_name(rs.getString("original_file_name"));
				tmp.setSystem_file_name(rs.getString("system_file_name"));
				tmp.setIs_selected(rs.getString("is_selected"));
				tmp.setApply_date(rs.getString("apply_date"));
				return tmp;
			}
		
		});
	}

	@Override
	public String getPic(String id) throws Exception {
		// TODO Auto-generated method stub
		String sql = "select system_file_name from profile_image where id=? and is_selected='y'";
		String myImg = null;
		List<Profile_ImageDTO> list = template.query(sql, new Object[] {id}, new RowMapper<Profile_ImageDTO>() {
		
			@Override
			public Profile_ImageDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				// TODO Auto-generated method stub
				Profile_ImageDTO tmp = new Profile_ImageDTO();
				tmp.setId("");
				tmp.setOriginal_file_name("");
				tmp.setIs_selected("");
				tmp.setApply_date("");
				tmp.setSystem_file_name(rs.getString("system_file_name"));
				
				return tmp;
			}
			
		});
		
		if(list.size() > 0 ) {
			myImg = list.get(0).getSystem_file_name(); 
		}
		
		return myImg; 
		
	}
	
	// 소개
	@Override
	public List<ProfileDTO> selectIntro(String introduce) throws Exception {
		String sql = "select introduce from profile where id=?";
		ProfileDTO dto = new ProfileDTO();
		return template.query(sql, new Object[] {introduce}, new RowMapper<ProfileDTO>() {

			@Override
			public ProfileDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				dto.setIntroduce(rs.getString("introduce"));
				return dto;
			}
		});
	}

}
