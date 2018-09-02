package kh.sns.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import kh.sns.dto.Member_NoteDTO;
import kh.sns.interfaces.Member_NoteDAO;

@Repository
public class IMember_NoteDAO implements Member_NoteDAO {
	
	@Autowired
	private JdbcTemplate template;
	
	@Override
	public String getNoteSeq() throws Exception {
		String sql = "select member_note_sequence.nextval from dual";
		return template.query(sql, new RowMapper<String>() {

			@Override
			public String mapRow(ResultSet rs, int rowNum) throws SQLException {
				String seq = rs.getString(1);
				return seq;
			}
		}).get(0);
	}

	@Override
	public List<Member_NoteDTO> selectNote(String id) throws Exception {
		String sql = "select * from member_note where id=? order by seq desc";
		return template.query(sql, new Object[] {id}, new RowMapper<Member_NoteDTO>() {

			@Override
			public Member_NoteDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				Member_NoteDTO tmp = new Member_NoteDTO();
				tmp.setSeq(rs.getString(1));
				tmp.setId(rs.getString(2));
				tmp.setTitle(rs.getString(3));
				tmp.setContent(rs.getString(4));
				tmp.setWrite_date(rs.getString(5));
				return tmp;
			}
		});
	}

	@Override
	public int insertNote(Member_NoteDTO dto) throws Exception {
		String sql = "insert into member_note values(?, ?, ?, ?, sysdate)";
		return template.update(sql,dto.getSeq(), dto.getId(), dto.getTitle(), dto.getContent());
	}

	@Override
	public int updateNote(Member_NoteDTO dto) throws Exception {
		String sql = "update member_note set title=?, content=? where seq=?";
		return template.update(sql, dto.getTitle(),dto.getContent(),dto.getSeq());
	}

	@Override
	public int deleteNote(String seq) throws Exception {
		String sql = "delete from member_note where seq=?";
		return template.update(sql, seq);
	}

}
