package kh.sns.impl;

import java.util.List;

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
	
	//Search 좋아요 
	@Override
	public List<Integer> searchLike(String id) throws Exception {
		// TODO Auto-generated method stub
		return board_likedao.searchLike(id);
	}
	
	//Search 좋아요 카운트
	@Override
	public List<int[]> selectLikeCount() throws Exception {
		// TODO Auto-generated method stub
		return board_likedao.selectLikeCount();
	}

	@Override
	public int insertLiko(Board_LikeDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return board_likedao.insertLiko(dto);
	}

	@Override
	public Board_LikeDTO isLiked(String id, int board_seq) throws Exception {
		// TODO Auto-generated method stub
		return board_likedao.isLiked(id, board_seq);
	}
	
	// 좋아요 많은 순서
	@Override
	public List<int[]> bestLike() throws Exception{
		return board_likedao.bestLike();
	}
	
	@Override
	public List<int[]> bestLike(int start, int end) throws Exception {
		return board_likedao.bestLike(start, end);
	}
	
	@Override
	public List<Board_LikeDTO> simpleGetLikeStatus(String id) throws Exception {
		return board_likedao.simpleGetLikeStatus(id);
	}
}
