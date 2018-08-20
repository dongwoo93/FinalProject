package kh.sns.impl;

import java.lang.reflect.Method;

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
}
