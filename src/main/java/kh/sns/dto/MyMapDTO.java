package kh.sns.dto;

public class MyMapDTO {
	private String id;
	private String pinimg;
	private String clusterimg;
	
	public MyMapDTO() {
		
	}
	
	public MyMapDTO(String id, String pinimg, String clusterimg) {
		super();
		this.id = id;
		this.pinimg = pinimg;
		this.clusterimg = clusterimg;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPinimg() {
		return pinimg;
	}

	public void setPinimg(String pinimg) {
		this.pinimg = pinimg;
	}

	public String getClusterimg() {
		return clusterimg;
	}

	public void setClusterimg(String clusterimg) {
		this.clusterimg = clusterimg;
	}
	
	
    
}
