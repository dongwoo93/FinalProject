package kh.sns.interfaces;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_MediaDTO;
	
public interface BoardService {
	
	public int insertNewArticle(BoardDTO boardContent, Board_MediaDTO boardMedia) throws Exception;
	

}
