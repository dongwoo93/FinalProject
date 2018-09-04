package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.Board_BookmarkDTO;
import kh.sns.dto.Board_CommentDTO;
import kh.sns.dto.Board_LikeDTO;

public interface Board_BookmarkService {
	
	public int selectBookmark(Board_BookmarkDTO dto) throws Exception;
	public int insertBookmark(Board_BookmarkDTO dto) throws Exception;
	public int deleteBookmark(Board_BookmarkDTO dto) throws Exception;
	public Board_BookmarkDTO isBookmarked(String id, int board_seq) throws Exception;
	public List<Integer> searchMark(String id) throws Exception;
	public List<Board_BookmarkDTO> simpleGetMark(String id) throws Exception;
	

}
