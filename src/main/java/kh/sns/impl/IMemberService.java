package kh.sns.impl;

import java.util.List;

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



//	@Override
//	public boolean isIdExist(String id) {
//		
//		return this.isIdExist(id);
//	}
	
}

