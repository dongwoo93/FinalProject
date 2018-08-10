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
	public int findPw(String id, String email) {
		// TODO Auto-generated method stub
		
		return dao.findPw(id, email);
	}

	@Override
	public String changePass(String id) throws Exception {
		// TODO Auto-generated method stub
		return dao.changePass(id);
	}

	@Override
	public String findId(String name,String phone) throws Exception{
		// TODO Auto-generated method stub
		return dao.findId(name, phone);
	}



//	@Override
//	public boolean isIdExist(String id) {
//		
//		return this.isIdExist(id);
//	}
	
}

