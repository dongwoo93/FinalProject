package kh.sns.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_LikeDTO;
import kh.sns.dto.Board_MediaDTO;
import kh.sns.dto.Board_Tags2DTO;
import kh.sns.dto.FollowInfo;
import kh.sns.interfaces.BoardDAO;
import kh.sns.interfaces.BoardService;

@Service
public class IBoardService implements BoardService {

	@Autowired
	private BoardDAO dao;
	
	@Override
	public List<BoardDTO> getFeed(String id) throws Exception {
		return dao.getFeed(id);
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
	public int insertNewArticle(BoardDTO boardContent, List<Board_MediaDTO> boardMediaList) throws Exception {
		
		// 글 삽입
		int contentResult = dao.insertNewBoardContent(boardContent);
		int mediaResult = 1;
		
		// 그림 등 삽입
		if(contentResult == 1) {
			int boardCurrVal = dao.selectBoardSeqRecentCurrVal();
			System.out.println("boardCurrVal" + boardCurrVal);
			
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
		} 			
		
		return contentResult * mediaResult;
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
	public List<Board_Tags2DTO> selectTagCount() throws Exception {
		return dao.selectTagCount();
	}
	
	

	
	
	
}
