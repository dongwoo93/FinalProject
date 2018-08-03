package kh.sns.dto;

public class Board_LocationDTO {
	
	private int board_seq;
	private String location_name;
	private String location_latitude;
	private String location_longitude;
	
	public Board_LocationDTO() {
		
		
	}

	public Board_LocationDTO(int board_seq, String location_name, String location_latitude, String location_longitude) {
		super();
		this.board_seq = board_seq;
		this.location_name = location_name;
		this.location_latitude = location_latitude;
		this.location_longitude = location_longitude;
	}

	public int getBoard_seq() {
		return board_seq;
	}

	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}

	public String getLocation_name() {
		return location_name;
	}

	public void setLocation_name(String location_name) {
		this.location_name = location_name;
	}

	public String getLocation_latitude() {
		return location_latitude;
	}

	public void setLocation_latitude(String location_latitude) {
		this.location_latitude = location_latitude;
	}

	public String getLocation_longitude() {
		return location_longitude;
	}

	public void setLocation_longitude(String location_longitude) {
		this.location_longitude = location_longitude;
	}
	
	
	
	

}
