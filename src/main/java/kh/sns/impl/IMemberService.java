package kh.sns.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.sns.dto.MemberDTO;
import kh.sns.interfaces.MemberDAO;
import kh.sns.interfaces.MemberService;

@Service
public class IMemberService implements MemberService{
	
	@Autowired
	private MemberDAO dao;
	
	
	
	@Override
	public int loginMem(MemberDTO dto) {
		return this.dao.loginMem(dto);
		
	}
	
	@Override
	public MemberDTO getOneMember(String id) throws Exception {
		
		return dao.getOneMember(id);
	}
	
	@Override
	public int updateOneMemberProfile(MemberDTO member) throws Exception {
		return dao.updateOneMemberProfile(member);
	}
	
	@Override
	public int updateOneMemberPassword(MemberDTO member) throws Exception {
		return dao.updateOneMemberPassword(member);
	}
	
	@Override
	public int checkEmailDuplicated(String email, String currentUserId) throws Exception {
		return dao.checkEmailDuplicated(email, currentUserId);
	}



//	@Override
//	public boolean isIdExist(String id) {
//		
//		return this.isIdExist(id);
//	}
	
}

