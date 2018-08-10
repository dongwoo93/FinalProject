package kh.sns.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.sns.dto.ProfileDTO;
import kh.sns.interfaces.ProfileDAO;
import kh.sns.interfaces.ProfileService;

@Service
public class IProfileService implements ProfileService {
	
	@Autowired
	ProfileDAO pdao;

	@Override
	public ProfileDTO getOneProfile(String id) throws Exception {
		return pdao.getOneProfile(id);
	}
	
	@Override
	public int updateOneAdvancedProfile(ProfileDTO profile) throws Exception {
		return pdao.updateOneAdvancedProfile(profile);
	}
	
	@Override
	public int updateProfileCheckbox(ProfileDTO profile, String fieldName) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
}
