package kh.sns.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.sns.dto.Board_BookmarkDTO;
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
	
	

}
