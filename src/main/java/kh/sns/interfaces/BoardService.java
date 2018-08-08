package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.BoardDTO;


import kh.sns.dto.Board_MediaDTO;
import kh.sns.dto.MemberDTO;
	
public interface BoardService {
	
	public List<BoardDTO> getFeed(String id) throws Exception ;
	public List<BoardDTO> getBoard(String id);
	public List<BoardDTO> search(String keyword);
	
	
	
	public int insertNewArticle(BoardDTO boardContent, List<Board_MediaDTO> boardMediaList) throws Exception;
	

}
