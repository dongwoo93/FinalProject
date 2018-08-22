package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.BoardBusinessDTO;

public interface BoardBusinessDAO {
	
	public int insertAnBoardBiz(BoardBusinessDTO bbiz) throws Exception;
	public int deleteAnBoardBiz(BoardBusinessDTO bbiz) throws Exception;
	public int updateAnBoardBiz(BoardBusinessDTO bbiz) throws Exception;
	public int selectAnBoardBiz(int boardBizSeq) throws Exception;
	
	public List<BoardBusinessDTO> getAllBoardBiz() throws Exception;
	public List<BoardBusinessDTO> getBoardBizByRange() throws Exception;
}
