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
}
