package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_MediaDTO;
import kh.sns.dto.Board_TagsDTO;
import kh.sns.dto.FollowInfo;

import java.util.List;
public interface BoardDAO {
	
	public List<BoardDTO> getFeed(String id) throws Exception ;
	public List<BoardDTO> getBoard(String id);
	/* 태그 넣는 기능 */
	public int[] insertHashTags(BoardDTO article) throws Exception;

	public int insertNewBoardContent(BoardDTO article) throws Exception;	
	public int insertNewMedia(Board_MediaDTO media) throws Exception;	
	public int selectBoardSeqRecentCurrVal() throws Exception;
	
	public BoardDTO getBoardModal(String seq) throws Exception;
	
	public int insertFollowInfo(FollowInfo fi) throws Exception;
	public int deleteFollowInfo(FollowInfo fi) throws Exception;	// 언팔
	public List<BoardDTO> getBoardFromFollowingList(String id) throws Exception;
	
	public int getFollowingCount(String id) throws Exception;
	public int getFollowerCount(String id) throws Exception;

	// search
	public List<BoardDTO> search(String keyword);
	public List<Board_MediaDTO> search2(int seq) throws Exception;
}
