package kh.sns.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.sns.dto.BoardBusinessDTO;
import kh.sns.interfaces.BoardBusinessDAO;
import kh.sns.interfaces.BoardBusinessService;

@Service
public class IBoardBusinessService implements BoardBusinessService {
	
	@Autowired	private BoardBusinessDAO bbdao;

	@Override
	public int insertAnBoardBiz(BoardBusinessDTO bbiz) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteAnBoardBiz(BoardBusinessDTO bbiz) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateAnBoardBiz(BoardBusinessDTO bbiz) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int selectAnBoardBiz(int boardBizSeq) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<BoardBusinessDTO> getAllBoardBiz() throws Exception {	
		return bbdao.getAllBoardBiz();
	}

	@Override
	public List<BoardBusinessDTO> getBoardBizByRange() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public int updateAnEvaluationResult(BoardBusinessDTO bbiz) throws Exception {
		return bbdao.updateAnEvaluationResult(bbiz);
	}
	
}
