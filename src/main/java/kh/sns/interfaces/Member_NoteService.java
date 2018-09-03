package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.Member_NoteDTO;

public interface Member_NoteService {
	public String getNoteSeq() throws Exception;
	public List<Member_NoteDTO> selectNote(String id) throws Exception;
	public int insertNote(Member_NoteDTO dto) throws Exception;
	public int updateNote(Member_NoteDTO dto) throws Exception;
	public int deleteNote(String seq) throws Exception;
}
