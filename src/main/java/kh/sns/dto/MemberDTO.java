package kh.sns.dto;

/**
 * @author user1
 *
 */
public class MemberDTO {
	
	private String id;
	private String pw;
	private String nickname;
	private String email;
	private String phone;
	private String gender;
	private String name;
	
	/*
	 * 2018-9-3 추가
	 */
	private String isDisabledAccount, isBlockedAccount, lastDisabledDate;
	private int disabledReason;
	
	
	
	public MemberDTO() {
		
	}
	
	public MemberDTO(String id, String pw, String nickname, String email, String phone, String gender, String name) {
		super();
		this.id = id;
		this.pw = pw;
		this.nickname = nickname;
		this.email = email;
		this.phone = phone;
		this.gender = gender;
		this.name = name;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getGender() {
		return gender;
	}
	
	public void setGender(String gender) {
		this.gender = gender;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}	

	public String getIsDisabledAccount() {
		return isDisabledAccount;
	}

	public void setIsDisabledAccount(String isDisabledAccount) {
		this.isDisabledAccount = isDisabledAccount;
	}

	public String getIsBlockedAccount() {
		return isBlockedAccount;
	}

	public void setIsBlockedAccount(String isBlockedAccount) {
		this.isBlockedAccount = isBlockedAccount;
	}

	public String getLastDisabledDate() {
		return lastDisabledDate;
	}

	public void setLastDisabledDate(String lastDisabledDate) {
		this.lastDisabledDate = lastDisabledDate;
	}

	public int getDisabledReason() {
		return disabledReason;
	}

	public void setDisabledReason(int disabledReason) {
		this.disabledReason = disabledReason;
	}

	@Override
	public String toString() {
		return "MemberDTO [id=" + id + ", pw=" + pw + ", nickname=" + nickname + ", email=" + email + ", phone=" + phone
				+ ", gender=" + gender + ", name=" + name + ", isDisabledAccount=" + isDisabledAccount
				+ ", isBlockedAccount=" + isBlockedAccount + ", lastDisabledDate=" + lastDisabledDate
				+ ", disabledReason=" + disabledReason + "]";
	}


}
