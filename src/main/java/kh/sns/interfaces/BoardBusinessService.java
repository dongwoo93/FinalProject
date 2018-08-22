package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.BoardBusinessDTO;

public interface BoardBusinessService {
	
	public int insertAnBoardBiz(BoardBusinessDTO bbiz) throws Exception;
	public int deleteAnBoardBiz(BoardBusinessDTO bbiz) throws Exception;
	public int updateAnBoardBiz(BoardBusinessDTO bbiz) throws Exception;
	public int selectAnBoardBiz(int boardBizSeq) throws Exception;
	
	public List<BoardBusinessDTO> getAllBoardBiz() throws Exception;
	public List<BoardBusinessDTO> getBoardBizByRange() throws Exception;
	
	public int updateAnEvaluationResult(BoardBusinessDTO bbiz) throws Exception;
}
