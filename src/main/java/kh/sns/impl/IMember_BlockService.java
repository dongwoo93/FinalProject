package kh.sns.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.sns.dto.Member_BlockDTO;
import kh.sns.interfaces.Member_BlockDAO;
import kh.sns.interfaces.Member_BlockService;

@Service
public class IMember_BlockService implements Member_BlockService {
	
	@Autowired
	private Member_BlockDAO dao;

	@Override
	public int insertBlock(Member_BlockDTO dto) throws Exception {
		return dao.insertBlock(dto);
	}

	@Override
	public int deleteBlock(Member_BlockDTO dto) throws Exception {
		return dao.deleteBlock(dto);
	}

	@Override
	public List<Member_BlockDTO> selectBlock(String id) throws Exception {
		return dao.selectBlock(id);
	}
	
	public boolean isBlock(String sessionid, String id) throws Exception {
		return dao.isBlock(sessionid,id);
	}

}
