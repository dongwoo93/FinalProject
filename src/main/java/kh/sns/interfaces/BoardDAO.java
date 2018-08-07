package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.BoardDTO;

public interface BoardDAO {
	
	public List<BoardDTO> getFeed(String id) throws Exception ;

}
