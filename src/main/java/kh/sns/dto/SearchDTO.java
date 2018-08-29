package kh.sns.dto;

public class SearchDTO {
	
	private String keyword;
	private String searchdate;
	
	public SearchDTO(String keyword, String searchdate) {
		super();
		this.keyword = keyword;
		this.searchdate = searchdate;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getSearchdate() {
		return searchdate;
	}

	public void setSearchdate(String searchdate) {
		this.searchdate = searchdate;
	}
	
	
	
	

}
