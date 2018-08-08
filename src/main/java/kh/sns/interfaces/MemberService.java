package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.MemberDTO;

public interface MemberService {
	public int loginMem(MemberDTO dto);
	public int signUp(MemberDTO dto);
	public int isIdExist(String id);
}
