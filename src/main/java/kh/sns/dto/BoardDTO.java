package kh.sns.dto;

public class BoardDTO {
	
	private int board_seq;
	private String contents;
	private String id;
	private String writedate;
	private String read_count;
	private String is_allow_comments;
	
	// 특수 목적
	private int thisArticleForAd;
	
	public BoardDTO() {
	
	}

	public BoardDTO(int board_seq, String contents, String id, String writedate, String read_count,
			String is_allow_comments) {
		super();
		this.board_seq = board_seq;
		this.contents = contents;
		this.id = id;
		this.writedate = writedate;
		this.read_count = read_count;
		this.is_allow_comments = is_allow_comments;
	}

	public int getBoard_seq() {
		return board_seq;
	}

	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getWritedate() {
		return writedate;
	}

	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}

	public String getRead_count() {
		return read_count;
	}

	public void setRead_count(String read_count) {
		this.read_count = read_count;
	}

	public String getIs_allow_comments() {
		return is_allow_comments;
	}

	public void setIs_allow_comments(String is_allow_comments) {
		this.is_allow_comments = is_allow_comments;
	}

	public int getThisArticleForAd() {
		return thisArticleForAd;
	}

	public void setThisArticleForAd(int thisArticleForAd) {
		this.thisArticleForAd = thisArticleForAd;
	}

	@Override
	public String toString() {
		return "BoardDTO [board_seq=" + board_seq + ", contents=" + contents + ", id=" + id + ", writedate=" + writedate
				+ ", read_count=" + read_count + ", is_allow_comments=" + is_allow_comments + ", ThisArticleForAd="
				+ thisArticleForAd + "]";
	}
	

}
