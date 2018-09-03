package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_LocationDTO;
import kh.sns.dto.Board_MediaDTO;
public interface BoardDAO {
	
	public List<BoardDTO> getFeed(String id) throws Exception ;
	public List<BoardDTO> getFeed(String id, int start, int end) throws Exception;	// 범위로 읽어들이기
	
	public List<BoardDTO> getFeedForAd(int... picks) throws Exception;
	
	public List<BoardDTO> getBoard(String id) throws Exception;
	public String boardCount(String id) throws Exception;
	public int deleteBoard(int seq) throws Exception;
	public int modifyBoard(BoardDTO dto) throws Exception;
	/* 태그 넣는 기능 */
	public int[] insertHashTags(BoardDTO article) throws Exception;
	public int[] insertHashTags(BoardDTO article,int comment_seq) throws Exception;

	public int insertNewBoardContent(BoardDTO article) throws Exception;	
	public int insertNewMedia(Board_MediaDTO media) throws Exception;	
	public int selectBoardSeqRecentCurrVal() throws Exception;
	
	public BoardDTO getBoardModal(String seq) throws Exception;

	// search
	public List<BoardDTO> search(String keyword);
	public List<Board_MediaDTO> search2(int seq) throws Exception;
	public List<String[]> getTag(String keyword) throws Exception;
	
	//oneBoard
	public BoardDTO oneBoard(String board_seq) throws Exception;
	
	//tour
	public List<BoardDTO> getAllBoard() throws Exception;
	public List<Board_MediaDTO> getAllBoard2() throws Exception;
	public List<String[]> selectTagCount() throws Exception;
	
	// my_aticle_bookmark
	public List<int[]> myBookmark(String id) throws Exception;
	
	//my_article_Tags
	List<int[]> myTag(String id) throws Exception;
	
	
	public List<Object[]> alerting(String id) throws Exception;
	
	public List<BoardDTO> getBoardByRange(int start, int end) throws Exception;
	public List<int[]> getLikeSortByRange(int start, int end) throws Exception;
	public List<String[]> getTagSortByRange(int start, int end) throws Exception;
	
	public List<BoardDTO> search(String keyword, int start, int end);
	public int deleteTags(int comment_seq) throws Exception ;
	
	public int deleteBoardTags(int board_seq) throws Exception;
	
	// 지도
	public Board_LocationDTO location(int seq)throws Exception;
}
