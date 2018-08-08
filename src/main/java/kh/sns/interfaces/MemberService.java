package kh.sns.interfaces;

import kh.sns.dto.MemberDTO;

public interface MemberService {
	public int loginMem(MemberDTO dto);
	
	public MemberDTO getOneMember(String id) throws Exception;
	
//	boolean isIdExist(String id);
}
