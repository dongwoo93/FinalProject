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



	@Override
	public int signUp(MemberDTO dto) {
		// TODO Auto-generated method stub
		return this.dao.signUp(dto);
	}



	@Override
	public int isIdExist(String id) {
		// TODO Auto-generated method stub
		return dao.isIdExist(id);
	}



	@Override
	public int isNickExist(String nick) {
		// TODO Auto-generated method stub
		return dao.isNickExist(nick);
	}



	@Override
	public int isEmailExist(String email) {
		// TODO Auto-generated method stub
		return dao.isEmailExist(email);
	}


	@Override
	public List<MemberDTO> selectfriendlist(String id,String searchtext) throws Exception{
		return this.dao.selectfriendlist(id,searchtext);
	}

//	@Override
//	public boolean isIdExist(String id) {
//		
//		return this.isIdExist(id);
//	}
	
}

