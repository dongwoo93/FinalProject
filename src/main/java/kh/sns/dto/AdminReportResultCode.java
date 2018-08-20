package kh.sns.dto;

public class AdminReportResultCode {

	/*
	 * RESULT_CODE        NOT NULL NUMBER         
		IS_DELETE          NOT NULL CHAR(1)        
		IS_MEMBER_BLOCKED  NOT NULL CHAR(1)        
		BLOCKED_DAY        NOT NULL NUMBER         
		IS_EXTERNAL_NOTIFY NOT NULL CHAR(1)        
		RESULT_DESCRIPTION          VARCHAR2(1500) 
	 */
	
	private int resultCode;
	private String isDelete, isMemberBlocked;
	private int blockedDay;
	private String isExternalNotify, resultDescription;
	public AdminReportResultCode() {
		super();
		// TODO Auto-generated constructor stub
	}
	public AdminReportResultCode(int resultCode, String isDelete, String isMemberBlocked, int blockedDay,
			String isExternalNotify, String resultDescription) {
		super();
		this.resultCode = resultCode;
		this.isDelete = isDelete;
		this.isMemberBlocked = isMemberBlocked;
		this.blockedDay = blockedDay;
		this.isExternalNotify = isExternalNotify;
		this.resultDescription = resultDescription;
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
	 * @return the isDelete
	 */
	public String getIsDelete() {
		return isDelete;
	}
	/**
	 * @param isDelete the isDelete to set
	 */
	public void setIsDelete(String isDelete) {
		this.isDelete = isDelete;
	}
	/**
	 * @return the isMemberBlocked
	 */
	public String getIsMemberBlocked() {
		return isMemberBlocked;
	}
	/**
	 * @param isMemberBlocked the isMemberBlocked to set
	 */
	public void setIsMemberBlocked(String isMemberBlocked) {
		this.isMemberBlocked = isMemberBlocked;
	}
	/**
	 * @return the blockedDay
	 */
	public int getBlockedDay() {
		return blockedDay;
	}
	/**
	 * @param blockedDay the blockedDay to set
	 */
	public void setBlockedDay(int blockedDay) {
		this.blockedDay = blockedDay;
	}
	/**
	 * @return the isExternalNotify
	 */
	public String getIsExternalNotify() {
		return isExternalNotify;
	}
	/**
	 * @param isExternalNotify the isExternalNotify to set
	 */
	public void setIsExternalNotify(String isExternalNotify) {
		this.isExternalNotify = isExternalNotify;
	}
	/**
	 * @return the resultDescription
	 */
	public String getResultDescription() {
		return resultDescription;
	}
	/**
	 * @param resultDescription the resultDescription to set
	 */
	public void setResultDescription(String resultDescription) {
		this.resultDescription = resultDescription;
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "AdminReportResultCode [resultCode=" + resultCode + ", isDelete=" + isDelete + ", isMemberBlocked="
				+ isMemberBlocked + ", blockedDay=" + blockedDay + ", isExternalNotify=" + isExternalNotify
				+ ", resultDescription=" + resultDescription + "]";
	}
	
	
}
