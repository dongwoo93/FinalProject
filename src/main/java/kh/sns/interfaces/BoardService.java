package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_MediaDTO;
import kh.sns.dto.Board_TagsDTO;

public interface BoardService {
	
	   public List<BoardDTO> getFeed(String id) throws Exception ;
	   public List<BoardDTO> getBoard(String id);
	   public List<Board_TagsDTO> search(String keyword) throws Exception;
	   public List<Board_MediaDTO> search2(String media)throws Exception;
	   public int insertNewArticle(BoardDTO boardContent, List<Board_MediaDTO> boardMediaList) throws Exception;
	   
}
