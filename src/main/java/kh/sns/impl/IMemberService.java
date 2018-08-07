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



//	@Override
//	public boolean isIdExist(String id) {
//		
//		return this.isIdExist(id);
//	}
	
}

