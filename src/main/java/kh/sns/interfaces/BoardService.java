package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.BoardBusinessDTO;
import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_LocationDTO;
import kh.sns.dto.Board_MediaDTO;

import kh.sns.dto.Board_TagsDTO;

import kh.sns.dto.FollowInfo;
import kh.sns.dto.Profile_ImageDTO;
import kh.sns.dto.Member_TagsDTO;
	
public interface BoardService {
	
	public List<BoardDTO> getFeed(String id) throws Exception;
	public List<BoardDTO> getFeed(String id, int start, int end) throws Exception;
	
	public List<BoardDTO> getFeedForAd(int... picks) throws Exception;
	
	public List<BoardDTO> getBoard(String id) throws Exception;
	public String boardCount(String id) throws Exception;
	public int deleteBoard(int seq) throws Exception;
	public int modifyBoard(BoardDTO dto) throws Exception;


	public int insertNewArticle(BoardDTO boardContent, List<Board_MediaDTO> boardMediaList, BoardBusinessDTO bbiz,Board_LocationDTO locationdto,List<Member_TagsDTO> membertag) throws Exception;
	public BoardDTO getBoardModal(String seq) throws Exception;
	
	
	//search
	public List<BoardDTO> search(String keyword) throws Exception;
	public List<Board_MediaDTO> search2(int seq) throws Exception;
	public List<String[]> getTag(String keyword) throws Exception;
	
	//board_comment
	
	
	//oneBoard
	public BoardDTO oneBoard(String board_seq) throws Exception;
	
	//tour
	public List<BoardDTO> getAllBoard() throws Exception;
	public List<Board_MediaDTO> getAllBoard2() throws Exception;
	public List<String[]> selectTagCount() throws Exception;
	public List<int[]> myBookmark(String id) throws Exception;
	
	//my_article_Tags
	public List<int[]> myTags(String id) throws Exception;
	
	//alert
	public List<Object[]> alerting(String id) throws Exception;
}
