package kh.sns.dto;

public class MemberBusinessDTO {
	
	/*
	 *     member_biz_seq number primary key, 
		    id varchar(20) unique, -- member 테이블의 id
		    biz_website varchar(200), -- 비즈니스용 웹사이트
		    biz_email varchar(200), -- 비즈니스용 이메일
		    biz_phone varchar(20), -- 비즈니스용 전화번호
		    changed_date date default sysdate, -- 비즈니스 계정으로 전환된 최초 일자
		    deposit number default 1000, -- 계좌 잔액
		    is_allow_enter_profile char(1) check(is_allow_enter_profile in ('y', 'n'))
		    -- 광고 윗부분을 누르면 프로필로 갈 수 있는 경우도 있고 없는 경우도 있는데 그거 확인
		    -- 계정 비활성화와 비슷한 개념
	 */
	
	private int memberBizSeq;
	private String id, bizWebsite, bizEmail, bizPhone, changedDate;
	private long deposit;
	private String isAllowEnterProfile;

	public MemberBusinessDTO() {
		super();
	}

	public MemberBusinessDTO(int memberBizSeq, String id, String bizWebsite, String bizEmail, String bizPhone,
			String changedDate, long deposit, String isAllowEnterProfile) {
		super();
		this.memberBizSeq = memberBizSeq;
		this.id = id;
		this.bizWebsite = bizWebsite;
		this.bizEmail = bizEmail;
		this.bizPhone = bizPhone;
		this.changedDate = changedDate;
		this.deposit = deposit;
		this.isAllowEnterProfile = isAllowEnterProfile;
	}

	public int getMemberBizSeq() {
		return memberBizSeq;
	}

	public void setMemberBizSeq(int memberBizSeq) {
		this.memberBizSeq = memberBizSeq;
	}

	public String getBizWebsite() {
		return bizWebsite;
	}

	public void setBizWebsite(String bizWebsite) {
		this.bizWebsite = bizWebsite;
	}

	public String getBizEmail() {
		return bizEmail;
	}

	public void setBizEmail(String bizEmail) {
		this.bizEmail = bizEmail;
	}

	public String getBizPhone() {
		return bizPhone;
	}

	public void setBizPhone(String bizPhone) {
		this.bizPhone = bizPhone;
	}

	public String getChangedDate() {
		return changedDate;
	}

	public void setChangedDate(String changedDate) {
		this.changedDate = changedDate;
	}

	public long getDeposit() {
		return deposit;
	}

	public void setDeposit(long deposit) {
		this.deposit = deposit;
	}

	public String getIsAllowEnterProfile() {
		return isAllowEnterProfile;
	}

	public void setIsAllowEnterProfile(String isAllowEnterProfile) {
		this.isAllowEnterProfile = isAllowEnterProfile;
	}
	

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Override
	public String toString() {
		return "MemberBusinessDTO [memberBizSeq=" + memberBizSeq + ", id=" + id + ", bizWebsite=" + bizWebsite
				+ ", bizEmail=" + bizEmail + ", bizPhone=" + bizPhone + ", changedDate=" + changedDate + ", deposit="
				+ deposit + ", isAllowEnterProfile=" + isAllowEnterProfile + "]";
	}

	

}
