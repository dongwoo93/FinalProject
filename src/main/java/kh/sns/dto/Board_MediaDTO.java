package kh.sns.dto;

public class Board_MediaDTO {
	
	private int media_seq;
	private int board_seq;
	private String media_type;
	private String original_file_name;
	private String system_file_name;
	
	/* 20180816 추가 */
	private String filterName;
	private String soundOriginalFileName, soundSystemFileName;
	
	public Board_MediaDTO() {
		
		
	}

	public Board_MediaDTO(int media_seq, int board_seq, String media_type, String original_file_name,
			String system_file_name) {
		super();
		this.media_seq = media_seq;
		this.board_seq = board_seq;
		this.media_type = media_type;
		this.original_file_name = original_file_name;
		this.system_file_name = system_file_name;
	}
	
	

	public Board_MediaDTO(int media_seq, int board_seq, String media_type, String original_file_name,
			String system_file_name, String filterName, String soundOriginalFileName, String soundSystemFileName) {
		super();
		this.media_seq = media_seq;
		this.board_seq = board_seq;
		this.media_type = media_type;
		this.original_file_name = original_file_name;
		this.system_file_name = system_file_name;
		this.filterName = filterName;
		this.soundOriginalFileName = soundOriginalFileName;
		this.soundSystemFileName = soundSystemFileName;
	}

	public int getMedia_seq() {
		return media_seq;
	}

	public void setMedia_seq(int media_seq) {
		this.media_seq = media_seq;
	}

	public int getBoard_seq() {
		return board_seq;
	}

	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}

	public String getMedia_type() {
		return media_type;
	}

	public void setMedia_type(String media_type) {
		this.media_type = media_type;
	}

	public String getOriginal_file_name() {
		return original_file_name;
	}

	public void setOriginal_file_name(String original_file_name) {
		this.original_file_name = original_file_name;
	}

	public String getSystem_file_name() {
		return system_file_name;
	}

	public void setSystem_file_name(String system_file_name) {
		this.system_file_name = system_file_name;
	}

	/**
	 * @return the filterName
	 */
	public String getFilterName() {
		return filterName;
	}

	/**
	 * @param filterName the filterName to set
	 */
	public void setFilterName(String filterName) {
		this.filterName = filterName;
	}

	/**
	 * @return the soundOriginalFileName
	 */
	public String getSoundOriginalFileName() {
		return soundOriginalFileName;
	}

	/**
	 * @param soundOriginalFileName the soundOriginalFileName to set
	 */
	public void setSoundOriginalFileName(String soundOriginalFileName) {
		this.soundOriginalFileName = soundOriginalFileName;
	}

	/**
	 * @return the soundSystemFileName
	 */
	public String getSoundSystemFileName() {
		return soundSystemFileName;
	}

	/**
	 * @param soundSystemFileName the soundSystemFileName to set
	 */
	public void setSoundSystemFileName(String soundSystemFileName) {
		this.soundSystemFileName = soundSystemFileName;
	}
	
	
	
	
	
	

}
