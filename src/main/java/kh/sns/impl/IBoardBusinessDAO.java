package kh.sns.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import kh.sns.dto.BoardBusinessDTO;
import kh.sns.interfaces.BoardBusinessDAO;

@Repository
public class IBoardBusinessDAO implements BoardBusinessDAO {

	@Override
	public int insertAnBoardBiz(BoardBusinessDTO bbiz) throws Exception {
		String sql = "insert into board_business values(board_biz_seq.nextval, 427, 'https://www.youtube.com/watch?v=Poz3ZLetO74', 'n', default, 10000, 80, 100, 'n', '광고가 허접함')";
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
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<BoardBusinessDTO> getBoardBizByRange() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
}
