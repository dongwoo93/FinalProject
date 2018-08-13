package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.MemberDTO;

public interface MemberDAO {
	public int loginMem(MemberDTO dto);
	public int signUp(MemberDTO dto) throws Exception;
	public int insertProfile(String id) throws Exception;
	
	public int isIdExist(String id);
	public int isNickExist(String nick);
	public int isEmailExist(String email);
	public int findPw(String id,String email);
	public List<MemberDTO> findId(String name, String email) throws Exception;
	
	public String changePass(String id) throws Exception;
	public MemberDTO getOneMember(String id) throws Exception;
	
	public int updateOneMemberProfile(MemberDTO member) throws Exception;
	
	public int updateOneMemberPassword(MemberDTO member) throws Exception;
	public List<MemberDTO> selectfriendlist(String id,String searchtext) throws Exception;

	public int checkEmailDuplicated(String email, String currentUserId) throws Exception;

//	boolean isIdExist(String id);
}
