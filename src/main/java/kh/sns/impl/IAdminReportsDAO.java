package kh.sns.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import kh.sns.dto.AdminReportCode;
import kh.sns.dto.AdminReportDTO;
import kh.sns.dto.AdminReportResultCode;
import kh.sns.dto.JQueryPieChartVO;
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
		String sql = "insert into admin_reports values (report_seq.nextval,?,?,?,sysdate,?,null,null,101,null)";
		if(ard.getCommentSeq() == 0) {
			return t.update(sql, ard.getReportCode(), ard.getBoardSeq(), null, ard.getReportersComment());
		}else {
			return t.update(sql, ard.getReportCode(), ard.getBoardSeq(), ard.getCommentSeq(), ard.getReportersComment());
		}
		
	}
	
	@Override
	public int updateAnReport(AdminReportDTO ard) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	

	
	@Override
	public List<AdminReportCode> getAllAdminReportCode() throws Exception {
		String sql = "select "
				+ "(select c.report_code_description from admin_report_code c "
					+ "where r.report_code = c.report_code) "
				+ "from admin_reports r order by reported_date desc";
		
		return t.query(sql, (rs, rowNum) -> {
			AdminReportCode arc = new AdminReportCode();
			arc.setReportCodeDescription(rs.getString(1));
			return arc;
			
		});
	}
	

	
	@Override
	public List<AdminReportResultCode> getAllAdminResultCode() throws Exception {
		String sql = "select "
				+ "(select u.result_description from admin_report_result_code u "
					+ "where r.result_code = u.result_code) "
				+ "from admin_reports r order by reported_date desc";
		
		return t.query(sql, (rs, rowNum) -> {
			AdminReportResultCode arr = new AdminReportResultCode();
			arr.setResultDescription(rs.getString(1));
			return arr;
			
		});
	}
	
	@Override
	public List<AdminReportCode> getReportCodeList() throws Exception {
		String sql = "select * from admin_report_code order by report_code";
		return t.query(sql, (rs, rowNum) -> {
			AdminReportCode arc = new AdminReportCode();
			arc.setAcceptDepartment(rs.getString("report_accept_department"));
			arc.setReportCode(rs.getInt("report_code"));
			arc.setReportCodeDescription(rs.getString("report_code_description"));
			return arc;
		});
	}
	
	@Override
	public List<JQueryPieChartVO> getAdminReportProcessedForPieChartVO() throws Exception {
		String sql = "select report_code, REPORT_CODE_DESCRIPTION as label, "
				+ "(select count(*) from admin_reports where c.report_code = report_code) as y "
				+ "from admin_report_code c";
		return t.query(sql, (rs, rowNum) -> {
			JQueryPieChartVO pcvo = new JQueryPieChartVO();
			pcvo.setLabel(rs.getString("label"));
			pcvo.setY(rs.getDouble("y"));
			pcvo.setLegendText(rs.getString("report_code") + ". " + rs.getString("label"));			
			return pcvo;
		});
	}
	
}
