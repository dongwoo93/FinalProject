package kh.sns.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.FollowInfo;
import kh.sns.interfaces.Member_FollowDAO;
import kh.sns.interfaces.Member_FollowService;

@Service
public class IMember_FollowService implements Member_FollowService {
	@Autowired
	private Member_FollowDAO dao;
	
	@Override
	public int insertFollowInfo(FollowInfo fi) throws Exception {
		return dao.insertFollowInfo(fi);
	}
	
	@Override
	public int deleteFollowInfo(FollowInfo fi) throws Exception {
		return dao.deleteFollowInfo(fi);
	}
	
	@Override
	public int getFollowingCount(String id) throws Exception {
		return dao.getFollowingCount(id);
	}
	
	@Override
	public int getFollowerCount(String id) throws Exception {
		return dao.getFollowerCount(id);
	}
	
	@Override
	public List<BoardDTO> getBoardFromFollowingList(String id) throws Exception {
		return dao.getBoardFromFollowingList(id);
	}
	
	public boolean isFollow(String sessionid, String id) throws Exception {
		return dao.isFollow(sessionid, id);
	}


}
