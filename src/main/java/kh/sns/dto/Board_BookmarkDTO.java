package kh.sns.dto;

public class Board_BookmarkDTO {
	private int board_seq;
	private String id;
	private String is_marked;
	private String apply_date;
	
	public Board_BookmarkDTO() {
		
	}
	
	public Board_BookmarkDTO(int board_seq, String id, String is_marked, String apply_date) {
		super();
		this.board_seq = board_seq;
		this.id = id;
		this.is_marked = is_marked;
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

	public String getIs_marked() {
		return is_marked;
	}

	public void setIs_marked(String is_marked) {
		this.is_marked = is_marked;
	}

	public String getApply_date() {
		return apply_date;
	}

	public void setApply_date(String apply_date) {
		this.apply_date = apply_date;
	}
	
	

	
	
	
	

}
