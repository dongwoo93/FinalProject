package kh.sns.dto;

public class ProfileDTO {
	private String id;
	private String website;
	private String introduce;
	private String is_allow_email;
	private String is_allow_sms;
	private String is_allow_public;
	private String is_allow_status;
	private String is_allow_share;
	private String is_allow_login2;
	
	
	
	public ProfileDTO() {
		super();
	}

	public ProfileDTO(String id, String website, String introduce, String is_allow_email, String is_allow_sms,
			String is_allow_public, String is_allow_status, String is_allow_share, String is_allow_login2) {
		super();
		this.id = id;
		this.website = website;
		this.introduce = introduce;
		this.is_allow_email = is_allow_email;
		this.is_allow_sms = is_allow_sms;
		this.is_allow_public = is_allow_public;
		this.is_allow_status = is_allow_status;
		this.is_allow_share = is_allow_share;
		this.is_allow_login2 = is_allow_login2;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getWebsite() {
		return website;
	}

	public void setWebsite(String website) {
		this.website = website;
	}

	public String getIntroduce() {
		return introduce;
	}

	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}

	public String getIs_allow_email() {
		return is_allow_email;
	}

	public void setIs_allow_email(String is_allow_email) {
		this.is_allow_email = is_allow_email;
	}

	public String getIs_allow_sms() {
		return is_allow_sms;
	}

	public void setIs_allow_sms(String is_allow_sms) {
		this.is_allow_sms = is_allow_sms;
	}

	public String getIs_allow_public() {
		return is_allow_public;
	}

	public void setIs_allow_public(String is_allow_public) {
		this.is_allow_public = is_allow_public;
	}

	public String getIs_allow_status() {
		return is_allow_status;
	}

	public void setIs_allow_status(String is_allow_status) {
		this.is_allow_status = is_allow_status;
	}

	public String getIs_allow_share() {
		return is_allow_share;
	}

	public void setIs_allow_share(String is_allow_share) {
		this.is_allow_share = is_allow_share;
	}

	public String getIs_allow_login2() {
		return is_allow_login2;
	}

	public void setIs_allow_login2(String is_allow_login2) {
		this.is_allow_login2 = is_allow_login2;
	}
	
	
	
	
}
