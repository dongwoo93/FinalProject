package kh.sns.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import kh.sns.dto.Member_TagsDTO;
import kh.sns.interfaces.Member_TagsDAO;

@Repository
public class IMember_TagsDAO implements Member_TagsDAO {
	
	@Autowired
	private JdbcTemplate template;
	
	public int insertMembertag(Member_TagsDTO tag) throws Exception {

		String sql = "insert into member_tags values(?, ?, sysdate)";
		return template.update(sql, tag.getBoard_seq(),tag.getMember_tags());
	}
}
