package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.BoardDTO;

public interface BoardService {
	
	public List<BoardDTO> getFeed(String id) throws Exception ;
	public List<BoardDTO> getBoard(String id);
	public List<BoardDTO> search(String keyword);
	 
	

}
