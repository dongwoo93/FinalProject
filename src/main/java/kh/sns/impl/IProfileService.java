package kh.sns.impl;

import java.lang.reflect.Method;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.sns.dto.ProfileDTO;
import kh.sns.dto.Profile_ImageDTO;
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
	public int toggleProfileCheckbox(ProfileDTO profile, String fieldName) throws Exception {
		Class<? extends ProfileDTO> c = profile.getClass();
		Method[] methods = c.getDeclaredMethods();
		boolean targetValue = false;
		for(Method m : methods) {
			if(m.getName().equalsIgnoreCase("get" + fieldName))
				targetValue = m.invoke(profile).equals("y") ? true : false;
		}
		System.out.println(targetValue + " : " + !targetValue);
		return pdao.updateProfileCheckbox(profile, fieldName, !targetValue);
	}
	
	public boolean isNotPublic(String id) throws Exception{
		return pdao.isNotPublic(id);
	}
	
	@Override
	public List<Profile_ImageDTO> selectProfileImage(String id) throws Exception {
		return pdao.selectProfileImage(id);
	}
	
	@Override
	public String selectOneProfileImage(String id) throws Exception {
		return pdao.selectOneProfileImage(id);
	}

	@Override
	public int insertProfileImage(Profile_ImageDTO dto) throws Exception {
		return pdao.insertProfileImage(dto);
	}

	@Override
	public int updateProfileImages(String id) throws Exception {
		return pdao.updateProfileImages(id);
	}

	@Override
	public int updateProfileImages2(String systemFileName) throws Exception {
		return pdao.updateProfileImages2(systemFileName);
	}
	
	@Override
	public int deleteProfileImage(String systemFileName) throws Exception {
		return pdao.deleteProfileImage(systemFileName);
	}

	@Override
	public List<Profile_ImageDTO> getAllProfileImage() throws Exception {
		// TODO Auto-generated method stub
		return pdao.getAllProfileImage();
	}

	@Override
	public String getPic(String id) throws Exception {
		// TODO Auto-generated method stub
		return pdao.getPic(id);
	}

	@Override
	public List<ProfileDTO> selectIntro(String id) throws Exception {
		// TODO Auto-generated method stub
		return pdao.selectIntro(id);
	}

	

	

}
