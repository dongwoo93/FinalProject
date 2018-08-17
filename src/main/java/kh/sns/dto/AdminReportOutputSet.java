package kh.sns.dto;

import java.util.List;

public class AdminReportOutputSet {
	
	private List<AdminReportDTO> reportList;
	private List<AdminReportCode> codeList;
	private List<AdminReportResultCode> resultList;
	
	public AdminReportOutputSet() {
		super();
		// TODO Auto-generated constructor stub
	}
	public AdminReportOutputSet(List<AdminReportDTO> reportList, List<AdminReportCode> codeList,
			List<AdminReportResultCode> resultList) {
		super();
		this.reportList = reportList;
		this.codeList = codeList;
		this.resultList = resultList;
	}
	/**
	 * @return the reportList
	 */
	public List<AdminReportDTO> getReportList() {
		return reportList;
	}
	/**
	 * @param reportList the reportList to set
	 */
	public void setReportList(List<AdminReportDTO> reportList) {
		this.reportList = reportList;
	}
	/**
	 * @return the codeList
	 */
	public List<AdminReportCode> getCodeList() {
		return codeList;
	}
	/**
	 * @param codeList the codeList to set
	 */
	public void setCodeList(List<AdminReportCode> codeList) {
		this.codeList = codeList;
	}
	/**
	 * @return the resultList
	 */
	public List<AdminReportResultCode> getResultList() {
		return resultList;
	}
	/**
	 * @param resultList the resultList to set
	 */
	public void setResultList(List<AdminReportResultCode> resultList) {
		this.resultList = resultList;
	}

}
