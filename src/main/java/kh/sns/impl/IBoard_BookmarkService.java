package kh.sns.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.sns.dto.Board_BookmarkDTO;
import kh.sns.dto.Board_LikeDTO;
import kh.sns.interfaces.Board_BookmarkDAO;
import kh.sns.interfaces.Board_BookmarkService;

@Service
public class IBoard_BookmarkService implements Board_BookmarkService {
	
	@Autowired
	private Board_BookmarkDAO bookmarkdao;

	@Override
	public int selectBookmark(Board_BookmarkDTO dto) throws Exception {
		return bookmarkdao.selectBookmark(dto);
	}

	@Override
	public int insertBookmark(Board_BookmarkDTO dto) throws Exception {
		return bookmarkdao.insertBookmark(dto);
	}

	@Override
	public int deleteBookmark(Board_BookmarkDTO dto) throws Exception {
		return bookmarkdao.deleteBookmark(dto);
	}
	@Override
	public List<Integer> searchMark(String id) throws Exception {
		return bookmarkdao.searchMark(id);
	}

	@Override
	public Board_BookmarkDTO isBookmarked(String id, int board_seq) throws Exception {
		// TODO Auto-generated method stub
		return bookmarkdao.isBookmarked(id, board_seq);
	}
	
	@Override
	public List<Board_BookmarkDTO> simpleGetMark(String id) throws Exception {
		return bookmarkdao.simpleGetMark(id);
	}
	

}
