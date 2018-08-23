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
	
	@Autowired	JdbcTemplate t;
	@Autowired	TextHandler th;
	
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
		String sql = "insert into admin_reports values (report_seq.nextval,?,?,?,sysdate,?,null,null,null,null)";
		if(ard.getCommentSeq() == 0) {
			return t.update(sql, ard.getReportCode(), ard.getBoardSeq(), null, ard.getReportersComment());
		}else {
			return t.update(sql, ard.getReportCode(), ard.getBoardSeq(), ard.getCommentSeq(), ard.getReportersComment());
		}
		
	}
	
	@Override
	public int updateAnReport(AdminReportDTO report) throws Exception {
		String sql = "update admin_reports set admin_first_read_date = sysdate, admin_accepted_date = sysdate, result_code = ?, admin_comment = ? where report_seq = ?";
		return t.update(sql, report.getResultCode(), report.getAdminComment(), report.getReportSeq());
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
	public List<JQueryPieChartVO> getAdminReportProcessedForPieChartVO(int category) throws Exception {
		String sql = "select report_code as code, REPORT_CODE_DESCRIPTION as label, "
				+ "(select count(*) from admin_reports where c.report_code = report_code) as y "
				+ "from admin_report_code c";
		switch(category) {
		case 1:
			// 기본 sql
			break;
		case 2:
			sql = "select result_code as code, result_description as label, (select count(*) from admin_reports where c.result_code = result_code) as y from admin_report_result_code c order by code";
			break;
		case 21:
			sql = "select '상품 판매 목적' as code, decode(is_allowed,'y','허용됨','n','거부됨') as label, count(*) as y from board_business where IS_WEBSITE_PURPOSE_OF_PURCHASE = 'y' group by is_allowed";
			break;
		case 22:
			sql = "select '기타 목적' as code, decode(is_allowed,'y','허용됨','n','거부됨') as label, count(*) as y from board_business where IS_WEBSITE_PURPOSE_OF_PURCHASE = 'n' group by is_allowed";
			break;
		}
		
		return t.query(sql, (rs, rowNum) -> {
			JQueryPieChartVO pcvo = new JQueryPieChartVO();
			pcvo.setLabel(rs.getString("label"));
			pcvo.setY(rs.getDouble("y"));
			pcvo.setLegendText(rs.getString("code") + ". " + rs.getString("label"));			
			return pcvo;
		});
	}
	
	@Override
	public List<AdminReportResultCode> getResultCodeList() throws Exception {
		String sql = "select * from admin_report_result_code order by result_code";
		return t.query(sql, (rs, rowNum) -> {
			AdminReportResultCode arrc = new AdminReportResultCode();
			arrc.setBlockedDay(rs.getInt("blocked_day"));
			arrc.setIsDelete(rs.getString("is_delete"));
			arrc.setIsExternalNotify(rs.getString("is_external_notify"));
			arrc.setIsMemberBlocked(rs.getString("is_member_blocked"));
			arrc.setResultCode(rs.getInt("result_code"));
			arrc.setResultDescription(rs.getString("result_description"));
			return arrc;
		});
	}
	
	@Override
	public List<Integer> getAllAcceptedCounts() throws Exception {
		String sql = "select (select count(result_code) from admin_reports where board_seq = r.board_seq) as count from admin_reports r order by report_seq desc";
		return t.query(sql, (rs, rowNum) -> {			
			return rs.getInt(1);
		});
	}
	
	@Override
	public List<Integer> getAcceptedCountsByRange() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	
	@Override
	public int blockAnMemberByAdmin(String id, int day) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public AdminReportDTO getOneReport(int reportSeq) throws Exception {
		String sql = "select * from admin_reports where report_seq = ?";
		return t.query(sql, new Object[] {reportSeq}, (rs, rowNum) -> {
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
		}).get(0);
	}
	
	@Override
	public AdminReportResultCode getOneResultCode(int resultCode) throws Exception {
		String sql = "select * from admin_report_result_code where result_code = ?";
		
		return t.query(sql, new Object[] {resultCode}, (rs, rowNum) -> {
			AdminReportResultCode arrc = new AdminReportResultCode();
			arrc.setBlockedDay(rs.getInt("blocked_day"));
			arrc.setIsDelete(rs.getString("is_delete"));
			arrc.setIsExternalNotify(rs.getString("is_external_notify"));
			arrc.setIsMemberBlocked(rs.getString("is_member_blocked"));
			arrc.setResultCode(rs.getInt("result_code"));
			arrc.setResultDescription(rs.getString("result_description"));
			return arrc;			
		}).get(0);
	}
	
}
