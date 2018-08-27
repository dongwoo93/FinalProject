package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.FollowInfo;

public interface Member_FollowService {
	
	public int insertFollowInfo(FollowInfo fi) throws Exception;
	public int deleteFollowInfo(FollowInfo fi) throws Exception;	// 언팔
	public List<BoardDTO> getBoardFromFollowingList(String id) throws Exception;
	
	public int getFollowingCount(String id) throws Exception;
	public int getFollowerCount(String id) throws Exception;
	
	public boolean isFollow(String sessionid, String id) throws Exception;
	public List<FollowInfo> toFeed(String id) throws Exception ;
	public List<FollowInfo> followerList(String id) throws Exception;
	
	public List<FollowInfo> followList(String id) throws Exception;
	

}
