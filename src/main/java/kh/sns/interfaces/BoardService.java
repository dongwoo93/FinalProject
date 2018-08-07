package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_MediaDTO;
	
public interface BoardService {
	
	public int insertNewArticle(BoardDTO boardContent, List<Board_MediaDTO> boardMediaList) throws Exception;
	
	
	

}
