package kh.sns.dto;

public class Member_TagsDTO {
	private int board_seq;
	private String member_tags;
	private String apply_date;
	
	public Member_TagsDTO() {
		
	}
	
	public Member_TagsDTO(int board_seq, String member_tags, String apply_date) {
		super();
		this.board_seq = board_seq;
		this.member_tags = member_tags;
		this.apply_date = apply_date;
	}

	public int getBoard_seq() {
		return board_seq;
	}

	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}

	public String getMember_tags() {
		return member_tags;
	}

	public void setMember_tags(String member_tags) {
		this.member_tags = member_tags;
	}

	public String getApply_date() {
		return apply_date;
	}

	public void setApply_date(String apply_date) {
		this.apply_date = apply_date;
	}
	
	
}
