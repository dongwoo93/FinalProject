package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.MemberDTO;
import kh.sns.dto.ProfileDTO;

public interface MemberService {
	public int loginMem(MemberDTO dto);
	public int signUp(MemberDTO dto);
	public int isIdExist(String id);
	public int isNickExist(String nick);
	public int isEmailExist(String email);
	public int findPw(String id,String email);
	public String findId(String name, String phone) throws Exception;
	public String changePass(String id) throws Exception;
	public List<MemberDTO> selectfriendlist(String id,String searchtext) throws Exception;
	
	public MemberDTO getOneMember(String id) throws Exception;
	
	public int updateOneMemberProfile(MemberDTO member, ProfileDTO profile) throws Exception;
	
	public int updateOneMemberPassword(MemberDTO member) throws Exception;
	
	public int checkEmailDuplicated(String email, String currentUserId) throws Exception;
	
	
	
	
	
}
