package kh.sns.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import kh.sns.dto.AdminReportCode;
import kh.sns.dto.AdminReportDTO;
import kh.sns.interfaces.AdminReportsDAO;
import kh.sns.util.TextHandler;

@Repository
public class IAdminReportsDAO implements AdminReportsDAO {
	
	@Autowired
	JdbcTemplate t;
	@Autowired
	TextHandler th;
	
	@Override
	public List<AdminReportDTO> getAllReports() throws Exception {
		String sql = "select * from admin_reports order by reported_date desc";
		return t.query(sql, (rs, rowNum) -> {
			AdminReportDTO ard = new AdminReportDTO();
			ard.setAdminAcceptedDate(rs.getString("admin_accepted_date"));
			ard.setAdminComment(rs.getString("admin_comment"));
			ard.setAdminFirstReadDate(rs.getString("admin_first_read_date"));
			ard.setBoardSeq(rs.getInt("board_seq"));
			ard.setCommentSeq(rs.getInt("comment_seq"));
			ard.setReportCode(rs.getInt("report_code"));
			ard.setReportedDate(rs.getString("reported_date"));
			ard.setReportersComment(rs.getString("reporters_comment"));
			ard.setReportSeq(rs.getInt("report_seq"));
			ard.setResultCode(rs.getInt("result_code"));
			return ard;
		});
	}
	
	@Override
	public List<AdminReportDTO> getReportsByRange(int start, int end) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public int insertAnReport(AdminReportDTO ard) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public int updateAnReport(AdminReportDTO ard) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public List<AdminReportCode> getAdminReportCodeByRange(int start, int end) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public List<AdminReportCode> getAllAdminReportCode() throws Exception {
		String sql = "select report_code_description "
				+ "from admin_reports r, admin_report_code c "
				+ "where r.report_code = c.report_code "
				+ "order by r.reported_date desc";
		
		return t.query(sql, (rs, rowNum) -> {
			AdminReportCode arc = new AdminReportCode();
			arc.setReportCodeDescription(rs.getString(1));
			return arc;
			
		});
	}
	
}
