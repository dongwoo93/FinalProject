package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.MemberDTO;

public interface MemberDAO {
	public int loginMem(MemberDTO dto);
	public List<MemberDTO> selectfriendlist(String id,String searchtext) throws Exception;

//	boolean isIdExist(String id);
}
