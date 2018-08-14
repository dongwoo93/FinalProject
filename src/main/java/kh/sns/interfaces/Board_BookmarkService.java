package kh.sns.interfaces;

import kh.sns.dto.Board_BookmarkDTO;
import kh.sns.dto.Board_CommentDTO;

public interface Board_BookmarkService {
	
	public int selectBookmark(Board_BookmarkDTO dto) throws Exception;
	public int insertBookmark(Board_BookmarkDTO dto) throws Exception;
	public int deleteBookmark(Board_BookmarkDTO dto) throws Exception;
	

}
