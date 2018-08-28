package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.ProfileDTO;
import kh.sns.dto.Profile_ImageDTO;

public interface ProfileService {
	
	public ProfileDTO getOneProfile(String id) throws Exception;
	
	public int updateOneAdvancedProfile(ProfileDTO profile) throws Exception;
	
	public int toggleProfileCheckbox(ProfileDTO profile, String fieldName) throws Exception;
	public boolean isNotPublic(String id) throws Exception;
	
	public List<Profile_ImageDTO> selectProfileImage(String id) throws Exception;
	public String selectOneProfileImage(String id) throws Exception;
	public int insertProfileImage(Profile_ImageDTO dto) throws Exception;
	public int updateProfileImages(String id) throws Exception;
	public int updateProfileImages2(String systemFileName) throws Exception;
	public int deleteProfileImage(String systemFileName) throws Exception;
	public List<Profile_ImageDTO> getAllProfileImage() throws Exception;
	public String getPic(String id) throws Exception;
	
	// INTRODUCE(소개)
	public List<ProfileDTO> selectIntro(String id) throws Exception; 

}
