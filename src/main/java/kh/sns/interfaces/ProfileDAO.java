package kh.sns.interfaces;

import kh.sns.dto.ProfileDTO;

public interface ProfileDAO {
	
	public ProfileDTO getOneProfile(String id) throws Exception;
	
	public int updateOneAdvancedProfile(ProfileDTO profile) throws Exception;
	
	public int updateProfileCheckbox(ProfileDTO profile, String fieldName) throws Exception;
	
	

}
