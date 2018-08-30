package kh.sns.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
}
