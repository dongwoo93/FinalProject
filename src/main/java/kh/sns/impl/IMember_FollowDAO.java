package kh.sns.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.FollowInfo;
import kh.sns.dto.Member_BlockDTO;
import kh.sns.interfaces.Member_FollowDAO;

@Repository
public class IMember_FollowDAO implements Member_FollowDAO {
	
	@Autowired
	private JdbcTemplate template;
	
	@Override
	public int insertFollowInfo(FollowInfo fi) throws Exception {
		String sql = "insert into member_follow values(?, ?, sysdate)";
		return template.update(sql, fi.getId(), fi.getTargetId());
	}
	
	@Override
	public int deleteFollowInfo(FollowInfo fi) throws Exception {
		String sql = "delete from member_follow where id=? and target_id=?";
		return template.update(sql, fi.getId(), fi.getTargetId());
	}
	
	@Override
	public List<BoardDTO> getBoardFromFollowingList(String id) throws Exception {
		
		String sql = "select * from board where id "
				+ "in (select target_id from member_follow where id=?) "
				+ "order by writedate desc";
		
		return template.query(sql, new Object[] {id}, (rs, rowNum) -> {
			BoardDTO article = new BoardDTO();
			article.setBoard_seq(rs.getInt(1));
			article.setContents(rs.getString(2));
			article.setId(rs.getString(3));
			article.setWritedate(rs.getString(4));
			article.setRead_count(rs.getString(5));
			article.setIs_allow_comments(rs.getString(6));
			return article;
		});
	}
	
	@Override	// id媛� �뙏濡쒗븳 �궗�엺�뱾�쓽 �닔
	public int getFollowingCount(String id) throws Exception {
		String sql = "select count(*) from member_follow where id=?";
		List<Integer> temp = template.query(sql, new Object[] {id}, (rs, rowNum)->{			
			return rs.getInt(1);
		});
		return temp.get(0);
		
	}
	
	@Override	// id瑜� �뙏濡쒗븯�뒗 �궗�엺�뱾�쓽 �닔
	public int getFollowerCount(String id) throws Exception {
		String sql = "select count(*) from member_follow where target_id=?";
		List<Integer> temp = template.query(sql, new Object[] {id}, (rs, rowNum)->{			
			return rs.getInt(1);
		});
		return temp.get(0);
	}
   
	@Override
	public boolean isFollow(String sessionid, String id) throws Exception {
		String sql = "select * from member_follow where id=? and target_id=?";
		boolean result = false;
		
		List<FollowInfo> list = template.query(sql, new String[] {sessionid, id} , new RowMapper<FollowInfo>() {

			@Override
			public FollowInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
				return new FollowInfo(rs.getString("id"), rs.getString("target_id"),rs.getString("follow_date"));
			}
			
		});
		
		if(list.size() ==1) {
			result=true;
		}
		return result;
	}

	@Override
	public List<FollowInfo> toFeed(String id) throws Exception{
		String sql = "select target_id from member_follow where id in(select target_id from member_follow where id= ?) and (target_id not in(?)) and (target_id not in (select target_id from member_follow where id= ?)) group by target_id order by count(target_id)";
		return template.query(sql, new Object[] {id,id,id}, new RowMapper<FollowInfo>() {
			
			@Override
			public FollowInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
				FollowInfo followtmp = new FollowInfo();
					followtmp.setId(rs.getString(1));
					return followtmp;
				}	
			});
		}
	

	@Override
	public List<FollowInfo> followerList(String id) throws Exception{
		String sql = "select id from member_follow where target_id in(select target_id from member_follow where target_id=?)and (id not in(?))";
		return template.query(sql, new Object[] {id,id}, new RowMapper<FollowInfo>() {
			
			@Override
			public FollowInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
				FollowInfo followtmp = new FollowInfo();
				return new FollowInfo(rs.getString(1),"",rs.getString(1));
				}	
			});
		}
	

	@Override
	public List<FollowInfo> followList(String id) throws Exception{
		String sql = "select target_id from member_follow where target_id in(select target_id from member_follow where id=?) and (target_id not in(?)) group by target_id order by count(target_id)";
		return template.query(sql, new Object[] {id,id}, new RowMapper<FollowInfo>() {
			
			@Override
			public FollowInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
				return new FollowInfo("", rs.getString(1),"");
				}	
			});
		}
	
	
	

}
