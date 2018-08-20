package kh.sns.dto;

public class Profile_ImageDTO {
	private String id, original_file_name, system_file_name, is_selected;

	public Profile_ImageDTO() {
		super();
	}

	public Profile_ImageDTO(String id, String original_file_name, String system_file_name, String is_selected) {
		super();
		this.id = id;
		this.original_file_name = original_file_name;
		this.system_file_name = system_file_name;
		this.is_selected = is_selected;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

	public String getIs_selected() {
		return is_selected;
	}

	public void setIs_selected(String is_selected) {
		this.is_selected = is_selected;
	}

	
	
	
}
