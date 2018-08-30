package kh.sns.interfaces;

import java.util.List;
import java.util.Map;

import kh.sns.dto.Board_LikeDTO;

public interface Board_LikeService {
	
	// like
			public int selectLike(Board_LikeDTO dto) throws Exception;
			public int insertLike(Board_LikeDTO dto) throws Exception;
			public int deleteLike(Board_LikeDTO dto) throws Exception;
			
			//Search
			public List<Integer> searchLike(String id) throws Exception;
			public List<int[]> selectLikeCount() throws Exception;
			
			// BestLike
			List<int[]> bestLike() throws Exception;
			
			//dus
			public int insertLiko(Board_LikeDTO dto) throws Exception;
			public Board_LikeDTO isLiked(String id, int board_seq) throws Exception;
		
			
}
