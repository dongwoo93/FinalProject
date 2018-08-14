package kh.sns.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.sns.dto.Board_LikeDTO;
import kh.sns.interfaces.Board_LikeDAO;
import kh.sns.interfaces.Board_LikeService;

@Service
public class IBoard_LikeService implements Board_LikeService {

	
	@Autowired
	private Board_LikeDAO board_likedao;
	
	@Override
	public int selectLike(Board_LikeDTO dto) throws Exception {
		return board_likedao.selectLike(dto);
	}

	@Override
	public int insertLike(Board_LikeDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return board_likedao.insertLike(dto);
	}

	@Override
	public int deleteLike(Board_LikeDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return board_likedao.deleteLike(dto);
	}
}
