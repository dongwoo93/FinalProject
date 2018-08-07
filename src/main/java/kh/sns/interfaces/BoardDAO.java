package kh.sns.interfaces;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_MediaDTO;

public interface BoardDAO {
	
	public int insertNewBoardContent(BoardDTO article) throws Exception;
	
	public int insertNewMedia(Board_MediaDTO media) throws Exception;

}
