package kh.sns.dto;

public class Member_NoteDTO {
	private String seq, id, title, content, write_date;

	public Member_NoteDTO() {
		super();
	}

	public Member_NoteDTO(String seq, String id, String title, String content, String write_date) {
		super();
		this.seq = seq;
		this.id = id;
		this.title = title;
		this.content = content;
		this.write_date = write_date;
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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWrite_date() {
		return write_date;
	}

	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}
	
	
}
