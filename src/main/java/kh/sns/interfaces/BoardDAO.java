package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_MediaDTO;

import kh.sns.dto.Board_TagsDTO;
import kh.sns.dto.FollowInfo;
public interface BoardDAO {
	
	public List<BoardDTO> getFeed(String id) throws Exception ;
	public List<FollowInfo> toFeed(String id) throws Exception;
	public List<FollowInfo> followerList(String id) throws Exception;
	public List<FollowInfo> followList(String id) throws Exception;
	public List<BoardDTO> getBoard(String id) throws Exception;
	public String boardCount(String id) throws Exception;
	public int deleteBoard(int seq) throws Exception;
	public int modifyBoard(BoardDTO dto) throws Exception;
	/* 태그 넣는 기능 */
	public int[] insertHashTags(BoardDTO article) throws Exception;

	public int insertNewBoardContent(BoardDTO article) throws Exception;	
	public int insertNewMedia(Board_MediaDTO media) throws Exception;	
	public int selectBoardSeqRecentCurrVal() throws Exception;
	
	public BoardDTO getBoardModal(String seq) throws Exception;

	// search
	public List<BoardDTO> search(String keyword);
	public List<Board_MediaDTO> search2(int seq) throws Exception;
	
	//oneBoard
	public BoardDTO oneBoard(String board_seq) throws Exception;
	
	//tour
	public List<BoardDTO> getAllBoard() throws Exception;
	public List<Board_MediaDTO> getAllBoard2() throws Exception;
	public List<String[]> selectTagCount() throws Exception;
	
	// my_aticle_bookmark
	public List<int[]> myBookmark(String id) throws Exception;
}
