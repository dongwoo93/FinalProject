package kh.sns.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.sns.dto.Member_NoteDTO;
import kh.sns.interfaces.Member_NoteDAO;
import kh.sns.interfaces.Member_NoteService;

@Service
public class IMember_Service implements Member_NoteService {
	
	@Autowired
	private Member_NoteDAO dao;
	
	@Override
	public String getNoteSeq() throws Exception {
		return dao.getNoteSeq();
	}

	@Override
	public List<Member_NoteDTO> selectNote(String id) throws Exception {
		return dao.selectNote(id);
	}

	@Override
	public int insertNote(Member_NoteDTO dto) throws Exception {
		return dao.insertNote(dto);
	}

	@Override
	public int updateNote(Member_NoteDTO dto) throws Exception {
		return dao.updateNote(dto);
	}

	@Override
	public int deleteNote(String seq) throws Exception {
		return dao.deleteNote(seq);
	}

}
