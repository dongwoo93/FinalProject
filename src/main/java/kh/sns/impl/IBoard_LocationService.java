package kh.sns.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_LocationDTO;
import kh.sns.interfaces.Board_LocationDAO;
import kh.sns.interfaces.Board_LocationService;

@Service
public class IBoard_LocationService implements Board_LocationService{
	
	@Autowired
	private Board_LocationDAO board_locationdao;
	
	@Override
	public int insertLocation(Board_LocationDTO dto) throws Exception {
		return board_locationdao.insertLocation(dto);
	}
	
	@Override
	public List<Board_LocationDTO> selectLocation(String id) throws Exception {
		return board_locationdao.selectLocation(id);
	}
	
	@Override
	public List<BoardDTO> getBoard(String id,String lat,String lng) throws Exception {
		return board_locationdao.getBoard(id,lat,lng);
	}
}
