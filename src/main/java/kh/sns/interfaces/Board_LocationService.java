package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_LocationDTO;
import kh.sns.dto.MyMapDTO;

public interface Board_LocationService {
	
	public int insertLocation(Board_LocationDTO dto) throws Exception;
	public List<Board_LocationDTO> selectLocation(String id) throws Exception;
	public List<BoardDTO> getBoard(String id,String lat,String lng) throws Exception;
	public int setMyMap(String id,String cluster,String pin) throws Exception;
	public int insertMyMap(String id) throws Exception;
	public MyMapDTO selectMyMap(String id) throws Exception;
	
}
