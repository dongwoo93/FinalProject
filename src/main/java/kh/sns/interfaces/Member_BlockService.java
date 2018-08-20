package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.Member_BlockDTO;

public interface Member_BlockService {
	public int insertBlock(Member_BlockDTO dto) throws Exception;
	public int deleteBlock(Member_BlockDTO dto) throws Exception;
	public List<Member_BlockDTO> selectBlock(String id) throws Exception;

}
