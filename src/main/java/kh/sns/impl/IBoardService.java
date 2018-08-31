package kh.sns.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.sns.dto.BoardBusinessDTO;
import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_LocationDTO;
import kh.sns.dto.Board_MediaDTO;
import kh.sns.dto.MemberBusinessDTO;
import kh.sns.dto.Profile_ImageDTO;
import kh.sns.dto.Member_TagsDTO;
import kh.sns.interfaces.BoardBusinessDAO;
import kh.sns.interfaces.BoardDAO;
import kh.sns.interfaces.BoardService;
import kh.sns.interfaces.Board_LocationDAO;
import kh.sns.interfaces.MemberBusinessDAO;
import kh.sns.interfaces.ProfileDAO;
import kh.sns.interfaces.Member_TagsDAO;

@Service
public class IBoardService implements BoardService {

	@Autowired	private BoardDAO dao;
	@Autowired	private BoardBusinessDAO bbdao;
	@Autowired	private MemberBusinessDAO mbdao;
	@Autowired  private Board_LocationDAO ldao;
	@Autowired  private Member_TagsDAO mtdao;	
	
	@Override
	public List<BoardDTO> getFeed(String id) throws Exception {
		return dao.getFeed(id);
	}
	
	@Override
	public List<BoardDTO> getFeed(String id, int start, int end) throws Exception{
		return dao.getFeed(id, start, end);
	}
	
	@Override
	public List<BoardDTO> getFeedForAd(int... picks) throws Exception {
		return dao.getFeedForAd(picks);
	}
	
	@Override
	public List<BoardDTO> getBoard(String id) throws Exception {
		return this.dao.getBoard(id);
	}
	
	@Override
	public String boardCount(String id) throws Exception {
		return this.dao.boardCount(id);
	}
	
	@Override
	public int deleteBoard(int seq) throws Exception{
	
		return this.dao.deleteBoard(seq);
	}
	
	@Override
	public int modifyBoard(BoardDTO dto) throws Exception {
		
		return this.dao.modifyBoard(dto);
	}


	
	@Override	
	// @Transactional("txManager")
	public int insertNewArticle(BoardDTO boardContent, List<Board_MediaDTO> boardMediaList, BoardBusinessDTO bbiz,Board_LocationDTO locationdto,List<Member_TagsDTO> membertag) throws Exception {
		
		// 글 삽입
		int contentResult = dao.insertNewBoardContent(boardContent);
		int mediaResult = 1;
		int bizResult = 1;
		int mtagResult = 1;
		int locationResult = 1;
		
		// 그림 등 삽입
		if(contentResult == 1) {
			int boardCurrVal = dao.selectBoardSeqRecentCurrVal();
			System.out.println("boardCurrVal" + boardCurrVal);
			
			if(membertag != null) {
				for(Member_TagsDTO tag : membertag) {
					tag.setBoard_seq(boardCurrVal);
					mtagResult *= mtdao.insertMembertag(tag);
				}
			}
			
			if(locationdto !=null) {
				locationdto.setBoard_seq(boardCurrVal);
				locationResult = ldao.insertLocation(locationdto);
			}
			
			for(Board_MediaDTO media : boardMediaList) {
				media.setBoard_seq(boardCurrVal);
				mediaResult *= dao.insertNewMedia(media);
			}	
			
			// 태그 삽입
			boardContent.setBoard_seq(boardCurrVal);
			int[] hashTagResult = dao.insertHashTags(boardContent);
			
			for(int i : hashTagResult) {
				System.out.print(i);
			}
			
			// 비즈니스 계정이 null이 아닌 경우 비즈니스 보드에도 삽입
			if(bbiz != null) {
				bbiz.setBoardSeq(boardCurrVal);
				bizResult = bbdao.insertAnBoardBiz(bbiz);
				
				// deposit 차감(복잡하다..)
				// CPO * 노출 횟수 * 1.2(보증비 가산)
				long totalCost = Math.round(bbiz.getCostPerMille() * bbiz.getRemainedPublicExposureCount() * 1.2);
				MemberBusinessDTO mbiz = new MemberBusinessDTO();
				mbiz.setId(boardContent.getId());
				mbiz.setDeposit(mbdao.selectAnMemberBiz(boardContent.getId()).getDeposit() - totalCost);	
				mbdao.updateAnBizMembersDeposit(mbiz);
				
			}
			
		} 			
		
		return contentResult * mediaResult * bizResult * locationResult * mtagResult;
	}

	@Override
	public List<Board_MediaDTO> search2(int seq) throws Exception {
		return dao.search2(seq);
	}

	@Override
	public BoardDTO getBoardModal(String seq) throws Exception {
		return dao.getBoardModal(seq);
	}
	

	//Search(검색)
	@Override
	public List<BoardDTO> search(String keyword) throws Exception {
		// TODO Auto-generated method stub
		return dao.search(keyword);
	}
	
	@Override
	public List<String[]> getTag(String keyword) throws Exception {
		return dao.getTag(keyword);
	}

	@Override
	public BoardDTO  oneBoard(String board_seq) throws Exception {
		// TODO Auto-generated method stub
		return dao.oneBoard(board_seq);
	}
	
	//tour(둘러보기)
	@Override
	public List<BoardDTO> getAllBoard() throws Exception {
		return dao.getAllBoard();
	}

	@Override
	public List<Board_MediaDTO> getAllBoard2() throws Exception {
		return dao.getAllBoard2();
	}

	@Override
	public List<String[]> selectTagCount() throws Exception {
		return dao.selectTagCount();
	}
	
	//my_articlef_bookmark
	@Override
	public List<int[]> myBookmark(String id) throws Exception {
		return dao.myBookmark(id);
	}

	@Override
	public List<Object[]> alerting(String id) throws Exception {
		// TODO Auto-generated method stub
		return dao.alerting(id);
	}
	
	// my_article_tags
	   @Override
	   public List<int[]> myTags(String id) throws Exception {
	      return dao.myTag(id);
	   }

}
