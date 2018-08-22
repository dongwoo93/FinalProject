package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.ProfileDTO;
import kh.sns.dto.Profile_ImageDTO;

public interface ProfileDAO {
	
	public ProfileDTO getOneProfile(String id) throws Exception;
	
	public int updateOneAdvancedProfile(ProfileDTO profile) throws Exception;
	
	public int updateProfileCheckbox(ProfileDTO profile, String fieldName, boolean isYes) throws Exception;
	
	public boolean isNotPublic(String id) throws Exception;
	
	public List<Profile_ImageDTO> selectProfileImage(String id) throws Exception;
	public int insertProfileImage(Profile_ImageDTO dto) throws Exception;
	public int updateProfileImages(String id) throws Exception;
	public int updateProfileImages2(String systemFileName) throws Exception;
	public List<Profile_ImageDTO> getAllProfileImage() throws Exception;
	public List<Profile_ImageDTO> getPic(String id) throws Exception;
     
}
