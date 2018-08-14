package kh.sns.interfaces;

import kh.sns.dto.Board_LikeDTO;

public interface Board_LikeService {
	
	// like
			public int selectLike(Board_LikeDTO dto) throws Exception;
			public int insertLike(Board_LikeDTO dto) throws Exception;
			public int deleteLike(Board_LikeDTO dto) throws Exception;
			
			
	
}
