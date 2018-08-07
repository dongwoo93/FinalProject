package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_TagsDTO;

import kh.sns.dto.Board_MediaDTO;

public interface BoardDAO {
	
	public List<BoardDTO> getFeed(String id) throws Exception ;
	public List<BoardDTO> getBoard(String id);
	public List<Board_TagsDTO> search(String keyword);
	
	
	public int insertNewBoardContent(BoardDTO article) throws Exception;
	
	public int insertNewMedia(Board_MediaDTO media) throws Exception;
	
	public int selectBoardSeqRecentCurrVal() throws Exception;

}
