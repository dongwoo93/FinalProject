package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.MemberDTO;
import kh.sns.dto.ProfileDTO;

public interface MemberService {
	public int loginMem(MemberDTO dto);
	public int signUp(MemberDTO dto) throws Exception;
	public int insertProfile(String id) throws Exception;
	
	public int isIdExist(String id);
	public int isNickExist(String nick);
	public int isEmailExist(String email);
	public int findPw(MemberDTO dto);
	public List<MemberDTO> findId(String name, String email) throws Exception;
	public String changePass(String id) throws Exception;
	public List<MemberDTO> selectfriendlist(String id,String searchtext) throws Exception;
	public List<MemberDTO> findMember(String searchtext) throws Exception;
	public List<MemberDTO> selectfollowlist(String id,String searchtext) throws Exception;
	
	public MemberDTO getOneMember(String id) throws Exception;
	
	public int updateOneMemberProfile(MemberDTO member, ProfileDTO profile) throws Exception;
	
	public int updateOneMemberPassword(MemberDTO member) throws Exception;
	
	public int checkEmailDuplicated(String email, String currentUserId) throws Exception;
	public MemberDTO selectUserId(String nickname) throws Exception;
	
	// My_aticle
	public List<MemberDTO> myNick_Id(String id) throws Exception;
	
	// update disabled information(20180903)
	public int updateDisabledInfo(MemberDTO member, boolean isToggleToNo) throws Exception; 
	
}
