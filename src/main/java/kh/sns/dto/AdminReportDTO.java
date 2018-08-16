package kh.sns.dto;

public class AdminReportDTO {
	
	/*
	 * REPORT_SEQ            NOT NULL NUMBER        
	REPORT_CODE           NOT NULL NUMBER        
	BOARD_SEQ                      NUMBER        
	COMMENT_SEQ                    NUMBER        
	REPORTED_DATE         NOT NULL DATE          
	REPORTERS_COMMENT              VARCHAR2(500) 
	ADMIN_FIRST_READ_DATE          DATE          
	ADMIN_ACCEPTED_DATE            DATE          
	RESULT_CODE           NOT NULL NUMBER        
	ADMIN_COMMENT                  VARCHAR2(500) 
	 * 
	 */
	
	private int reportSeq, reportCode, boardSeq, commentSeq;
	private String reportedDate, reportersComment, adminFirstReadDate, adminAcceptedDate;
	private int resultCode;
	private String adminComment;
	
	public AdminReportDTO() {
		super();
	}

	public AdminReportDTO(int reportSeq, int reportCode, int boardSeq, int commentSeq, String reportedDate,
			String reportersComment, String adminFirstReadDate, String adminAcceptedDate, int resultCode,
			String adminComment) {
		super();
		this.reportSeq = reportSeq;
		this.reportCode = reportCode;
		this.boardSeq = boardSeq;
		this.commentSeq = commentSeq;
		this.reportedDate = reportedDate;
		this.reportersComment = reportersComment;
		this.adminFirstReadDate = adminFirstReadDate;
		this.adminAcceptedDate = adminAcceptedDate;
		this.resultCode = resultCode;
		this.adminComment = adminComment;
	}

	/**
	 * @return the reportSeq
	 */
	public int getReportSeq() {
		return reportSeq;
	}

	/**
	 * @param reportSeq the reportSeq to set
	 */
	public void setReportSeq(int reportSeq) {
		this.reportSeq = reportSeq;
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
	 * @return the boardSeq
	 */
	public int getBoardSeq() {
		return boardSeq;
	}

	/**
	 * @param boardSeq the boardSeq to set
	 */
	public void setBoardSeq(int boardSeq) {
		this.boardSeq = boardSeq;
	}

	/**
	 * @return the commentSeq
	 */
	public int getCommentSeq() {
		return commentSeq;
	}

	/**
	 * @param commentSeq the commentSeq to set
	 */
	public void setCommentSeq(int commentSeq) {
		this.commentSeq = commentSeq;
	}

	/**
	 * @return the reportedDate
	 */
	public String getReportedDate() {
		return reportedDate;
	}

	/**
	 * @param reportedDate the reportedDate to set
	 */
	public void setReportedDate(String reportedDate) {
		this.reportedDate = reportedDate;
	}

	/**
	 * @return the reportersComment
	 */
	public String getReportersComment() {
		return reportersComment;
	}

	/**
	 * @param reportersComment the reportersComment to set
	 */
	public void setReportersComment(String reportersComment) {
		this.reportersComment = reportersComment;
	}

	/**
	 * @return the adminFirstReadDate
	 */
	public String getAdminFirstReadDate() {
		return adminFirstReadDate;
	}

	/**
	 * @param adminFirstReadDate the adminFirstReadDate to set
	 */
	public void setAdminFirstReadDate(String adminFirstReadDate) {
		this.adminFirstReadDate = adminFirstReadDate;
	}

	/**
	 * @return the adminAcceptedDate
	 */
	public String getAdminAcceptedDate() {
		return adminAcceptedDate;
	}

	/**
	 * @param adminAcceptedDate the adminAcceptedDate to set
	 */
	public void setAdminAcceptedDate(String adminAcceptedDate) {
		this.adminAcceptedDate = adminAcceptedDate;
	}

	/**
	 * @return the resultCode
	 */
	public int getResultCode() {
		return resultCode;
	}

	/**
	 * @param resultCode the resultCode to set
	 */
	public void setResultCode(int resultCode) {
		this.resultCode = resultCode;
	}

	/**
	 * @return the adminComment
	 */
	public String getAdminComment() {
		return adminComment;
	}

	/**
	 * @param adminComment the adminComment to set
	 */
	public void setAdminComment(String adminComment) {
		this.adminComment = adminComment;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "AdminReportDTO [reportSeq=" + reportSeq + ", reportCode=" + reportCode + ", boardSeq=" + boardSeq
				+ ", commentSeq=" + commentSeq + ", reportedDate=" + reportedDate + ", reportersComment="
				+ reportersComment + ", adminFirstReadDate=" + adminFirstReadDate + ", adminAcceptedDate="
				+ adminAcceptedDate + ", resultCode=" + resultCode + ", adminComment=" + adminComment + "]";
	}
	

}
