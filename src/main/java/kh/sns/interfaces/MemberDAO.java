package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.MemberDTO;

public interface MemberDAO {
	public int loginMem(MemberDTO dto);

//	boolean isIdExist(String id);
}
