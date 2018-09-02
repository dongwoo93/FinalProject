package kh.sns.dto;

public class Board_TagsDTO {
	private int board_seq;
	private String tags;
	private int comment_seq; 
	
	public Board_TagsDTO(int board_seq, String tags, int comment_seq) {
		super();
		this.board_seq = board_seq;
		this.tags = tags;
		this.comment_seq = comment_seq;
	} 
	
	public Board_TagsDTO() {}
	
	public int getBoard_seq() {
		return board_seq;
	}
	
	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}
	
	public String getTags() {
		return tags;
	}
	
	public void setTags(String tags) {
		this.tags = tags;
	}
	
	public int getComment_seq() {
		return comment_seq;
	}
	   
	public void setComment_seq(int comment_seq) {
		this.comment_seq = comment_seq;
	}
	
}
