package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_MediaDTO;
import kh.sns.dto.Board_TagsDTO;

import kh.sns.dto.FollowInfo;
	
public interface BoardService {
	
	public List<BoardDTO> getFeed(String id) throws Exception ;
	public List<BoardDTO> getBoard(String id);
	public int insertNewArticle(BoardDTO boardContent, List<Board_MediaDTO> boardMediaList) throws Exception;
	public BoardDTO getBoardModal(String seq) throws Exception;
	
	public int insertFollowInfo(FollowInfo fi) throws Exception;
	public int deleteFollowInfo(FollowInfo fi) throws Exception;	// 언팔
	public List<BoardDTO> getBoardFromFollowingList(String id) throws Exception;
	
	public int getFollowingCount(String id) throws Exception;
	public int getFollowerCount(String id) throws Exception;

	

	   public List<Board_TagsDTO> search(String keyword) throws Exception;
	   public List<Board_MediaDTO> search2(String media)throws Exception;
}
