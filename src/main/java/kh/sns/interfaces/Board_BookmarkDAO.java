package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.Board_BookmarkDTO;

public interface Board_BookmarkDAO {
	
	public int selectBookmark(Board_BookmarkDTO dto) throws Exception;
	public int insertBookmark(Board_BookmarkDTO dto) throws Exception;
	public int deleteBookmark(Board_BookmarkDTO dto) throws Exception;
	public List<Integer> searchMark(String id) throws Exception;

}
