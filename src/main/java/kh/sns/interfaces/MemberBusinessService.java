package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.MemberBusinessDTO;

public interface MemberBusinessService {
	public int insertAnMemberBiz(MemberBusinessDTO mbiz) throws Exception;
	public int delteAnMemberBiz(MemberBusinessDTO mbiz) throws Exception;
	public int updateAnMemberBiz(MemberBusinessDTO mbiz) throws Exception;
	public MemberBusinessDTO selectAnMemberBiz(int memberBizSeq) throws Exception;
	public MemberBusinessDTO selectAnMemberBiz(String memberId) throws Exception;
	
	public List<MemberBusinessDTO> getAllMemberBiz() throws Exception;
	public List<MemberBusinessDTO> getMemberBizByRange(int start, int end) throws Exception;
}
