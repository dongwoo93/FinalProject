package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_LocationDTO;

public interface Board_LocationDAO {
	public int insertLocation(Board_LocationDTO dto) throws Exception;
	public List<Board_LocationDTO> selectLocation(String id) throws Exception;
	public List<BoardDTO> getBoard(String id,String lat,String lng) throws Exception;
}
