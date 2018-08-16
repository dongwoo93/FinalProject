package kh.sns.dto;

public class AdminReportCode {
	
	/*
	 * REPORT_CODE              NOT NULL NUMBER         
	REPORT_ACCEPT_DEPARTMENT          VARCHAR2(200)  
	REPORT_CODE_DESCRIPTION           VARCHAR2(1500) 
	 */
	
	private int reportCode;
	private String acceptDepartment, reportCodeDescription;
	
	public AdminReportCode() {
		super();
	}

	public AdminReportCode(int reportCode, String acceptDepartment, String reportCodeDescription) {
		super();
		this.reportCode = reportCode;
		this.acceptDepartment = acceptDepartment;
		this.reportCodeDescription = reportCodeDescription;
	}

	/**
	 * @return the reportCode
	 */
	public int getReportCode() {
		return reportCode;
	}

	/**
	 * @param reportCode the reportCode to set
	 */
	public void setReportCode(int reportCode) {
		this.reportCode = reportCode;
	}

	/**
	 * @return the acceptDepartment
	 */
	public String getAcceptDepartment() {
		return acceptDepartment;
	}

	/**
	 * @param acceptDepartment the acceptDepartment to set
	 */
	public void setAcceptDepartment(String acceptDepartment) {
		this.acceptDepartment = acceptDepartment;
	}

	/**
	 * @return the reportCodeDescription
	 */
	public String getReportCodeDescription() {
		return reportCodeDescription;
	}

	/**
	 * @param reportCodeDescription the reportCodeDescription to set
	 */
	public void setReportCodeDescription(String reportCodeDescription) {
		this.reportCodeDescription = reportCodeDescription;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "AdminReportCode [reportCode=" + reportCode + ", acceptDepartment=" + acceptDepartment
				+ ", reportCodeDescription=" + reportCodeDescription + "]";
	}
	
	
	 

}
