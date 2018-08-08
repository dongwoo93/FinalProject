package kh.sns.interfaces;

import kh.sns.dto.MemberDTO;

public interface MemberDAO {
	public int loginMem(MemberDTO dto);
	
	public MemberDTO getOneMember(String id) throws Exception;
	
	public int updateOneMemberProfile(MemberDTO member) throws Exception;
	
	public int updateOneMemberPassword(MemberDTO member) throws Exception;

//	boolean isIdExist(String id);
}
