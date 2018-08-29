package kh.sns.dto;

public class Board_LikeDTO {
	
	private int board_seq;
	private String id;
	private String is_liked;
	private String apply_date;
	
	public Board_LikeDTO() {
		
	}

	public Board_LikeDTO(int board_seq, String id, String is_liked, String apply_date) {
		super();
		this.board_seq = board_seq;
		this.id = id;
		this.is_liked = is_liked;
		this.apply_date = apply_date;
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

	public String getIs_liked() {
		return is_liked;
	}

	public void setIs_liked(String is_liked) {
		this.is_liked = is_liked;
	}

	public String getApply_date() {  
		return apply_date;
	}

	public void setApply_date(String apply_date) {
		this.apply_date = apply_date;
	}
	
	
	
	

}
