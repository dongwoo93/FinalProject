package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.MemberDTO;

public interface MemberService {
	public int loginMem(MemberDTO dto);
	public List<MemberDTO> selectfriendlist(String id) throws Exception;
	
//	boolean isIdExist(String id);
}
