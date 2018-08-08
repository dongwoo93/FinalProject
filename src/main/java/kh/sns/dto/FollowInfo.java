package kh.sns.dto;

public class FollowInfo {
	
	String id, targetId, followDate;

	public FollowInfo() {
		super();
		// TODO Auto-generated constructor stub
	}

	public FollowInfo(String id, String targetId, String followDate) {
		super();
		this.id = id;
		this.targetId = targetId;
		this.followDate = followDate;
	}

	/**
	 * @return the id
	 */
	public String getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(String id) {
		this.id = id;
	}

	/**
	 * @return the targetId
	 */
	public String getTargetId() {
		return targetId;
	}

	/**
	 * @param targetId the targetId to set
	 */
	public void setTargetId(String targetId) {
		this.targetId = targetId;
	}

	/**
	 * @return the followDate
	 */
	public String getFollowDate() {
		return followDate;
	}

	/**
	 * @param followDate the followDate to set
	 */
	public void setFollowDate(String followDate) {
		this.followDate = followDate;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "FollowInfo [id=" + id + ", targetId=" + targetId + ", followDate=" + followDate + "]";
	}
	
	

}
