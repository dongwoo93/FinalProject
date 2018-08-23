package kh.sns.dto;

public class BoardBusinessDTO {
	
	/*
	 *     board_biz_seq number primary key,
		    board_seq number unique, -- board 테이블의 seq
		    more_info_website varchar(200), -- 더 알아보기 버튼
		    is_website_purpose_of_purchase char(1) check(is_website_purpose_of_purchase in ('y', 'n')),
		    -- 더 알아보기 버튼이 '구매하러 가기' 버튼인 경우도 있는데 그것이 맞는지 확인, default n..
		    click_count number default 0,    -- 더 알아보기(구매하러 가기) 클릭한 횟수
		    cost_per_mille number,    -- 1회 노출당 단가 = CPM / 1000, 
		    cost_per_click number,    -- 1회 클릭당 단가
		    remained_public_exposure_count number    -- 총 몇회 노출시킬것인지 
	 */
	
	private int boardBizSeq, boardSeq;
	private String moreInfoWebsite, isWebsitePurposeOfPurchase;
	private int clickCount, costPerMille, costPerClick, remainedPublicExposureCount;
	private String isAllowed, rejectedMessage, requestDate, disposedDate;

	public BoardBusinessDTO() {
		super();
	}

	public int getBoardBizSeq() {
		return boardBizSeq;
	}

	public void setBoardBizSeq(int boardBizSeq) {
		this.boardBizSeq = boardBizSeq;
	}

	public int getBoardSeq() {
		return boardSeq;
	}

	public void setBoardSeq(int boardSeq) {
		this.boardSeq = boardSeq;
	}

	public String getMoreInfoWebsite() {
		return moreInfoWebsite;
	}

	public void setMoreInfoWebsite(String moreInfoWebsite) {
		this.moreInfoWebsite = moreInfoWebsite;
	}

	public String getIsWebsitePurposeOfPurchase() {
		return isWebsitePurposeOfPurchase;
	}

	public void setIsWebsitePurposeOfPurchase(String isWebsitePurposeOfPurchase) {
		this.isWebsitePurposeOfPurchase = isWebsitePurposeOfPurchase;
	}

	public int getClickCount() {
		return clickCount;
	}

	public void setClickCount(int clickCount) {
		this.clickCount = clickCount;
	}

	public int getCostPerMille() {
		return costPerMille;
	}

	public void setCostPerMille(int costPerMille) {
		this.costPerMille = costPerMille;
	}

	public int getCostPerClick() {
		return costPerClick;
	}

	public void setCostPerClick(int costPerClick) {
		this.costPerClick = costPerClick;
	}

	public int getRemainedPublicExposureCount() {
		return remainedPublicExposureCount;
	}

	public void setRemainedPublicExposureCount(int remainedPublicExposureCount) {
		this.remainedPublicExposureCount = remainedPublicExposureCount;
	}

	public String getIsAllowed() {
		return isAllowed;
	}

	public void setIsAllowed(String isAllowed) {
		this.isAllowed = isAllowed;
	}

	public String getRejectedMessage() {
		return rejectedMessage;
	}

	public void setRejectedMessage(String rejectedMessage) {
		this.rejectedMessage = rejectedMessage;
	}

	public String getRequestDate() {
		return requestDate;
	}

	public void setRequestDate(String requestDate) {
		this.requestDate = requestDate;
	}

	public String getDisposedDate() {
		return disposedDate;
	}

	public void setDisposedDate(String disposedDate) {
		this.disposedDate = disposedDate;
	}

	@Override
	public String toString() {
		return "BoardBusinessDTO [boardBizSeq=" + boardBizSeq + ", boardSeq=" + boardSeq + ", moreInfoWebsite="
				+ moreInfoWebsite + ", isWebsitePurposeOfPurchase=" + isWebsitePurposeOfPurchase + ", clickCount="
				+ clickCount + ", costPerMille=" + costPerMille + ", costPerClick=" + costPerClick
				+ ", remainedPublicExposureCount=" + remainedPublicExposureCount + ", isAllowed=" + isAllowed
				+ ", rejectedMessage=" + rejectedMessage + ", requestDate=" + requestDate + ", disposedDate="
				+ disposedDate + "]";
	}
	
}
