package kh.sns.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import kh.sns.dto.BoardBusinessDTO;
import kh.sns.interfaces.BoardBusinessDAO;

@Repository
public class IBoardBusinessDAO implements BoardBusinessDAO {
	
	@Autowired private JdbcTemplate t;

	@Override
	public int insertAnBoardBiz(BoardBusinessDTO bbiz) throws Exception {
		String sql = "insert into board_business values(board_biz_seq.nextval, ?, ?, ?, default, ?, ?, ?, null, null, sysdate, null)";
		// insert into board_business values(board_biz_seq.nextval, 427, 'https://www.youtube.com/watch?v=Poz3ZLetO74', 'n', default, 10000, 80, 100, 'n', '광고가 허접함');
		return t.update(sql, bbiz.getBoardSeq(), bbiz.getMoreInfoWebsite(), 
				bbiz.getIsWebsitePurposeOfPurchase(), bbiz.getCostPerMille(), bbiz.getCostPerClick(),
				bbiz.getRemainedPublicExposureCount());
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
		String sql = "select * from board_business order by board_biz_seq asc";
		return t.query(sql, (rs, rowNum) -> {
			BoardBusinessDTO bbiz = new BoardBusinessDTO();
			bbiz.setBoardBizSeq(rs.getInt("board_biz_seq"));
			bbiz.setBoardSeq(rs.getInt("board_seq"));
			bbiz.setClickCount(rs.getInt("click_count"));
			bbiz.setCostPerClick(rs.getInt("cost_per_click"));
			bbiz.setCostPerMille(rs.getInt("cost_per_mille"));
			bbiz.setIsWebsitePurposeOfPurchase(rs.getString("is_website_purpose_of_purchase"));
			bbiz.setMoreInfoWebsite(rs.getString("more_info_website"));
			bbiz.setRemainedPublicExposureCount(rs.getInt("remained_public_exposure_count"));
			bbiz.setIsAllowed(rs.getString("is_allowed"));
			bbiz.setRejectedMessage(rs.getString("rejected_message"));
			bbiz.setRequestDate(rs.getString("requestdate"));	// 변수명 실수
			bbiz.setDisposedDate(rs.getString("disposeddate"));	// 변수명 실수
			return bbiz;
		});
	}

	@Override
	public List<BoardBusinessDTO> getBoardBizByRange() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public int updateAnEvaluationResult(BoardBusinessDTO bbiz) throws Exception {
		String sql = "update board_business set is_allowed = ?, rejected_message = ?, disposeddate = sysdate where board_biz_seq = ?";		
		return t.update(sql, bbiz.getIsAllowed(), bbiz.getRejectedMessage(), bbiz.getBoardBizSeq());
	}
	
}
