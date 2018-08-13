package kh.sns.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import kh.sns.dto.Board_LikeDTO;
import kh.sns.interfaces.Board_LikeDAO;

@Repository
public class IBoard_LikeDAO implements Board_LikeDAO {
	
	@Autowired
	private JdbcTemplate template;
	
	@Override
	public int selectLike(Board_LikeDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertLike(Board_LikeDTO dto) throws Exception {
		String sql = "insert into board_like values(?,?,?)";
		return template.update(sql,dto.getBoard_seq(), dto.getId(),dto.getIs_liked());
	}

	@Override  
	public int deleteLike(Board_LikeDTO dto) throws Exception {
		String sql = "delete from board_like where board_seq=? and id=?";
		return template.update(sql,dto.getBoard_seq(), dto.getId());
	}

}
