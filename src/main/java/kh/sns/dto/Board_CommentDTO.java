package kh.sns.dto;

public class Board_CommentDTO {
	
	private int comment_seq;
	private int board_seq;
	private String id;
	private String comment_contents;
	
	public Board_CommentDTO() {
		
		
	}

	public Board_CommentDTO(int comment_seq, int board_seq, String id, String comment_contents) {
		super();
		this.comment_seq = comment_seq;
		this.board_seq = board_seq;
		this.id = id;
		this.comment_contents = comment_contents;
	}

	public int getComment_seq() {
		return comment_seq;
	}

	public void setComment_seq(int comment_seq) {
		this.comment_seq = comment_seq;
	}

	public int getBoard_seq() {
		return board_seq;
	}

	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getComment_contents() {
		return comment_contents;
	}

	public void setComment_contents(String comment_contents) {
		this.comment_contents = comment_contents;
	}
	
	

}
