package kh.sns.dto;

public class Member_CalendarDTO {
	private String seq;
	private String id;
	private String date_start;
	private String date_end;
	private String content;
	private String apply_date;
	
	
	public Member_CalendarDTO() {
		super();
	}


	public Member_CalendarDTO(String seq, String id, String date_start, String date_end, String content,
			String apply_date) {
		super();
		this.seq = seq;
		this.id = id;
		this.date_start = date_start;
		this.date_end = date_end;
		this.content = content;
		this.apply_date = apply_date;
	}


	public String getSeq() {
		return seq;
	}


	public void setSeq(String seq) {
		this.seq = seq;
	}


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getDate_start() {
		return date_start;
	}


	public void setDate_start(String date_start) {
		this.date_start = date_start;
	}


	public String getDate_end() {
		return date_end;
	}


	public void setDate_end(String date_end) {
		this.date_end = date_end;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public String getApply_date() {
		return apply_date;
	}


	public void setApply_date(String apply_date) {
		this.apply_date = apply_date;
	}
	
	

}
