package kh.sns.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import kh.sns.dto.Member_CalendarDTO;
import kh.sns.interfaces.Member_CalendarDAO;

@Repository
public class IMember_CalendarDAO implements Member_CalendarDAO {
	
	@Autowired
	private JdbcTemplate template;

	@Override
	public int insertCalendar(Member_CalendarDTO dto) throws Exception {
		String sql = "insert into member_calendar values(?,?,?,?,sysdate,?)";
		return template.update(sql, dto.getId(), dto.getDate_start(), dto.getDate_end(), dto.getContent(), dto.getSeq());
	}

	@Override
	public List<Member_CalendarDTO> selectCalendar(String id) throws Exception {
		String sql = "select * from member_calendar where id=?";
		return template.query(sql, new Object[] {id}, new RowMapper<Member_CalendarDTO>() {

			@Override
			public Member_CalendarDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				Member_CalendarDTO tmp = new Member_CalendarDTO();
				tmp.setId(rs.getString(1));
				tmp.setDate_start(rs.getString(2));
				tmp.setDate_end(rs.getString(3));
				tmp.setContent(rs.getString(4));
				tmp.setApply_date(rs.getString(5));
				tmp.setSeq(rs.getString(6));
				return tmp;
			}
		});
	}

	@Override
	public int updateCalendar(Member_CalendarDTO dto) throws Exception {
		String sql = "update member_calendar set date_start=?, date_end=?, content=? where seq=?";
		return template.update(sql, dto.getDate_start(), dto.getDate_end(), dto.getContent(), dto.getSeq());
	}

	@Override
	public String getCalendarSeq() throws Exception {
		String sql = "select member_calendar_seq.nextval from dual";
		return template.query(sql, new RowMapper<String>() {

			@Override
			public String mapRow(ResultSet rs, int rowNum) throws SQLException {
				String seq = rs.getString(1);
				return seq;
			}
		}).get(0);
	}

	@Override
	public int deleteCalendar(String seq) throws Exception {
		String sql ="delete from member_calendar where seq=?";
		return template.update(sql, seq);
	}

}
