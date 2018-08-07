package kh.sns.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import kh.sns.dto.BoardDTO;
import kh.sns.interfaces.BoardDAO;
import kh.sns.interfaces.BoardService;

@Component
public class IBoardService implements BoardService{
	
	@Autowired
	private BoardDAO dao;
	
	
	public List<BoardDTO> getBoard(String id) {
		return this.dao.getBoard(id);
	}
	
}
