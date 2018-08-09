package kh.sns.interfaces;

import kh.sns.dto.MemberDTO;

public interface MemberDAO {
	public int loginMem(MemberDTO dto);
	public int signUp(MemberDTO dto);
	public int isIdExist(String id);
	public int isNickExist(String nick);
	public int isEmailExist(String email);
	
	public MemberDTO getOneMember(String id) throws Exception;
	
	public int updateOneMemberProfile(MemberDTO member) throws Exception;
	
	public int updateOneMemberPassword(MemberDTO member) throws Exception;

	public int checkEmailDuplicated(String email, String currentUserId) throws Exception;

//	boolean isIdExist(String id);
}
