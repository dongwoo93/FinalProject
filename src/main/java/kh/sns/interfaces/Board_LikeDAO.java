package kh.sns.interfaces;

import java.util.List;
import java.util.Map;

import kh.sns.dto.Board_LikeDTO;

public interface Board_LikeDAO {

	// like
	public int selectLike(Board_LikeDTO dto) throws Exception;
	public int insertLike(Board_LikeDTO dto) throws Exception;
	public int deleteLike(Board_LikeDTO dto) throws Exception;
	public List<Integer> searchLike(String id) throws Exception;
	public List<int[]> selectLikeCount() throws Exception;

	//likeBest
	public List<int[]> bestLike() throws Exception; 

	// 연뜹
	public int insertLiko(Board_LikeDTO dto) throws Exception;
	public Board_LikeDTO isLiked(String id, int board_seq) throws Exception;

	public List<int[]> bestLike(int start, int end) throws Exception;
	public List<Board_LikeDTO> simpleGetLikeStatus(String id) throws Exception;
}
