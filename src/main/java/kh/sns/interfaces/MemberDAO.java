package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.MemberDTO;

public interface MemberDAO {
	public int loginMem(MemberDTO dto);
	public int signUp(MemberDTO dto);
	public int isIdExist(String id);
	public int isNickExist(String nick);
	public int isEmailExist(String email);
}
