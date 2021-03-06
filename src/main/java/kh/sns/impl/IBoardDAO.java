package kh.sns.impl;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_LocationDTO;
import kh.sns.dto.Board_MediaDTO;
import kh.sns.interfaces.BoardDAO;
import kh.sns.util.HashTagUtil;

@Repository
public class IBoardDAO implements BoardDAO  {	

	@Autowired
	private JdbcTemplate template;	

	@Override
	public List<BoardDTO> getBoard(String id) throws Exception {	   	 
		String sql = "select * from board where id = ? order by board_seq desc";
		return template.query(sql, new Object[] {id}, new RowMapper<BoardDTO>() {

			@Override
			public BoardDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				BoardDTO tmp = new BoardDTO();
				tmp.setBoard_seq(rs.getInt(1));
				tmp.setContents(rs.getString(2));
				tmp.setId(rs.getString(3));
				tmp.setWritedate(rs.getString(4));
				tmp.setRead_count(rs.getString(5));
				tmp.setIs_allow_comments(rs.getString(6));
				return tmp;
			}
		});
	}

	public String boardCount(String id) throws Exception {
		String sql = "select count(*) from board where id = ?";
		return template.query(sql, new Object[] {id}, new RowMapper<String>() {

			@Override
			public String mapRow(ResultSet rs, int rowNum) throws SQLException {
				String tmp = rs.getString(1);
				return tmp;
			}
		}).get(0);

	}

	@Override
	public BoardDTO getBoardModal(String seq) throws Exception {
		System.out.println(seq + " d에에에엑");  
		String sql = "select * from board where board_seq=?";

		return template.query(sql, new Object[] {seq}, new RowMapper<BoardDTO>() {

			@Override
			public BoardDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				BoardDTO tmp = new BoardDTO();
				tmp.setBoard_seq(rs.getInt(1));
				tmp.setContents(rs.getString(2));
				tmp.setId(rs.getString(3));
				tmp.setWritedate(rs.getString(4));
				tmp.setRead_count(rs.getString(5));
				tmp.setIs_allow_comments(rs.getString(6));
				return tmp;
			}
		}).get(0);
	}




	@Override
	public int deleteBoard(int seq) {
		String sql = "delete from board where board_seq = ? ";
		return template.update(sql, seq);
	}



	@Override
	public int modifyBoard(BoardDTO dto) throws Exception {
		String sql = "update board set contents = ? where board_seq = ?";  
		return template.update(sql, dto.getContents(), dto.getBoard_seq());
	}


	// Search 
	@Override
	public List<BoardDTO> search(String keyword) {
		String sql = "select * from board where board_seq in (select board_seq from board_tags where tags=?) order by board_seq desc";
		/*String sql = "select * from board where (board_seq in (select board_seq from board_tags where tags=?)) or "
				+ "(board_seq in (select board_seq from board_location where location_name=?)) order by board_seq desc";*/
		return template.query(sql, new Object[] {keyword}, new RowMapper<BoardDTO>() {

			@Override
			public BoardDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				BoardDTO tmp = new BoardDTO();
				tmp.setBoard_seq(rs.getInt(1));
				
				tmp.setContents(rs.getString(2));
				tmp.setId(rs.getString(3));
				tmp.setWritedate(rs.getString(4));
				tmp.setRead_count(rs.getString(5));
				tmp.setIs_allow_comments(rs.getString(6));
				return tmp;
			}

		});
	}
	
	@Override
	public List<BoardDTO> search(String keyword, int start, int end) {
		String sql = "select mid.* from (select inn.*, rownum rn "
				+ "from (select * from board where board_seq in (select board_seq from board_tags where tags = ?) "
				+ "order by board_seq desc) inn) mid where rn between ? and ?";
		
		return template.query(sql, new Object[] {keyword, start, end}, new RowMapper<BoardDTO>() {

			@Override
			public BoardDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				BoardDTO tmp = new BoardDTO();
				tmp.setBoard_seq(rs.getInt(1));
				tmp.setContents(rs.getString(2));
				tmp.setId(rs.getString(3));
				tmp.setWritedate(rs.getString(4));
				tmp.setRead_count(rs.getString(5));
				tmp.setIs_allow_comments(rs.getString(6));
				return tmp;
			}

		});
	}

	@Override
	public List<Board_MediaDTO> search2(int seq) throws Exception {
		String sql = "select * from board_media where board_seq=? order by media_seq";
		return template.query(sql, new Object[] {seq}, new RowMapper<Board_MediaDTO>() {

			@Override
			public Board_MediaDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				Board_MediaDTO media = new Board_MediaDTO();
				media.setMedia_seq(rs.getInt(1));
				media.setBoard_seq(rs.getInt(2));
				media.setMedia_type(rs.getString(3));
				media.setOriginal_file_name(rs.getString(4));
				media.setSystem_file_name(rs.getString(5));
				media.setFilterName(rs.getString(6));
				return media;
			}
		});
	}

	@Override
	public List<String[]> getTag(String keyword) throws Exception {
		String sql = "select bt.tags, COUNT(DISTINCT(b.board_seq)) from board b, board_tags bt where bt.tags like '%'||?||'%' and bt.board_seq = b.board_seq group by bt.tags";
		return template.query(sql, new Object[] {keyword}, new RowMapper<String[]>() {

			@Override
			public String[] mapRow(ResultSet rs, int rowNum) throws SQLException {
				String[] tmp = {rs.getString(1), rs.getString(2)};
				return tmp;
			}

		});
	}

	@Override
	public List<BoardDTO> getFeed(String id) throws Exception {
		String sql = "select * from board where (id in (select target_id from member_follow where id=?)) or (id=?) order by board_seq desc";
		return template.query(sql, new String[] {id,id}, new RowMapper<BoardDTO>() {

			@Override
			public BoardDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				BoardDTO dto = new  BoardDTO();
				dto.setBoard_seq(rs.getInt("board_seq"));
				dto.setContents(rs.getString("contents"));
				dto.setId(rs.getString("id"));
				dto.setWritedate(rs.getString("writedate"));
				dto.setRead_count(rs.getString("read_count"));
				dto.setIs_allow_comments(rs.getString("is_allow_comments"));
				return dto;
			}
		});
	}

	@Override
	public List<BoardDTO> getFeed(String id, int start, int end) { 
		String sql = "select * from (select board.*, row_number() over(order by board_seq desc) as rn  from board where (id in ((select target_id from member_follow where id=?)) or (id=?))) where (rn between ? and ?)";    

		return template.query(sql, new Object[] {id, id, start, end}, (rs, rowNum) -> {
			BoardDTO dto = new  BoardDTO();
			dto.setBoard_seq(rs.getInt("board_seq"));
			dto.setContents(rs.getString("contents"));
			dto.setId(rs.getString("id"));
			dto.setWritedate(rs.getString("writedate"));
			dto.setRead_count(rs.getString("read_count"));
			dto.setIs_allow_comments(rs.getString("is_allow_comments"));
			return dto;
		});
	}


	@Override
	public int insertNewBoardContent(BoardDTO board) {

		String sql = "insert into board values(board_seq.nextval, ?, ?, sysdate, default, default)";
		return template.update(sql, board.getContents(), board.getId());
	}

	/*
	 * (non-Javadoc)
	 * @see kh.sns.interfaces.BoardDAO#insertNewMedia(kh.sns.dto.Board_MediaDTO)
	 * 
	 * �렪�쓽�긽 �뿬湲곕떎 �씪�떒 留뚮뱾怨� �굹以묒뿉 �븘�슂�븯硫� 蹂꾨룄 �겢�옒�뒪濡� 遺꾨━�빀�땲�떎. // ㅠㅠ ㅂㄷㅂㄷ
	 */
	@Override
	public int insertNewMedia(Board_MediaDTO media) throws Exception {

		String sql = "insert into board_media values(board_media_seq.nextval, ?, ?, ?, ?, ?, ?, ?)";
		return template.update(sql, media.getBoard_seq(), media.getMedia_type(), media.getOriginal_file_name(), media.getSystem_file_name(),
				media.getFilterName(), media.getSoundOriginalFileName(), media.getSoundSystemFileName());
	}

	public int selectBoardSeqRecentCurrVal() throws Exception {

		String sql = "select board_seq.currval from dual";

		List<Integer> temp = template.query(sql, (rs, rowNum) -> {
			return rs.getInt(1);	
		});

		return temp.get(0);
	}



	@Override
	public int[] insertHashTags(BoardDTO article) throws Exception {
		System.out.println(article.getBoard_seq() + " ::::::::::::");  
		List<String> hashTagList = new HashTagUtil().extractHashTag(article.getContents());

		String sql = "insert into board_tags values(?, ?,default)";
		return template.batchUpdate(sql, new BatchPreparedStatementSetter() {			
			@Override
			public void setValues(PreparedStatement ps, int i) throws SQLException {

				ps.setInt(1, article.getBoard_seq());
				ps.setString(2, hashTagList.get(i));

			}

			@Override
			public int getBatchSize() {
				return hashTagList.size();
			}

		});
	}
	
	
	
	@Override
	public int deleteTags(int comment_seq) throws Exception {   
		String sql = "delete from board_tags where comment_seq=?";
		return template.update(sql,comment_seq);
				
		
	}
	
	@Override
	public int deleteBoardTags(int board_seq) throws Exception {   
		String sql = "delete from board_tags where board_seq=? and comment_seq=0";
		return template.update(sql,board_seq);
				
		
	}
	
	

	@Override
	public int[] insertHashTags(BoardDTO article,int comment_seq) throws Exception {
		System.out.println(article.getBoard_seq() + " ::::::::::::");  
		List<String> hashTagList = new HashTagUtil().extractHashTag(article.getContents());

		String sql = "insert into board_tags values(?, ?,?)";
		return template.batchUpdate(sql, new BatchPreparedStatementSetter() {			
			@Override
			public void setValues(PreparedStatement ps, int i) throws SQLException {

				ps.setInt(1, article.getBoard_seq());
				ps.setString(2, hashTagList.get(i));
				ps.setInt(3, comment_seq); 

			}

			@Override
			public int getBatchSize() {
				return hashTagList.size();
			}

		});
	}




	@Override
	public BoardDTO oneBoard(String board_seq) throws Exception {

		String sql = "select * from board where board_seq = ?";
		List<BoardDTO> result =  template.query(sql, new String[] {board_seq}, new RowMapper<BoardDTO>() {

			@Override   
			public BoardDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				// TODO Auto-generated method stub
				BoardDTO article = new BoardDTO();
				article.setBoard_seq(rs.getInt(1));
				article.setContents(rs.getString(2));
				article.setId(rs.getString(3));
				article.setWritedate(rs.getString(4));
				article.setRead_count(rs.getString(5));
				article.setIs_allow_comments(rs.getString(6));
				return article;
			}
		});

		return result.get(0);
	}


	//tour
	@Override
	public List<BoardDTO> getAllBoard() throws Exception {
		String sql = "select * from board order by board_seq desc";
		return template.query(sql, new RowMapper<BoardDTO>() {

			@Override
			public BoardDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				BoardDTO tmp = new BoardDTO();
				tmp.setBoard_seq(rs.getInt(1));
				tmp.setContents(rs.getString(2));
				tmp.setId(rs.getString(3));
				tmp.setWritedate(rs.getString(4));
				tmp.setRead_count(rs.getString(5));
				tmp.setIs_allow_comments(rs.getString(6));
				return tmp;
			}
		});

	}
	
	// tour For JSON
	@Override
	public List<BoardDTO> getBoardByRange(int start, int end) throws Exception {
		
		//String sql = "select * from (select board.*, rownum rn from board order by board_seq desc) where (rn between ? and ?)";
		String sql = "select bx.* from (select ast.*, rownum rn from ((select board.* from board order by board_seq desc) ast)) bx where rn between ? and ?";
			return template.query(sql, new Object[] {start, end} , new RowMapper<BoardDTO>() {

				@Override
				public BoardDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
					BoardDTO tmp = new BoardDTO();
					tmp.setBoard_seq(rs.getInt(1));
					tmp.setContents(rs.getString(2));
					tmp.setId(rs.getString(3));
					tmp.setWritedate(rs.getString(4));
					tmp.setRead_count(rs.getString(5));
					tmp.setIs_allow_comments(rs.getString(6));
					return tmp;
				}
			});
	}
	
	@Override
	public List<int[]> getLikeSortByRange(int start, int end) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public List<String[]> getTagSortByRange(int start, int end) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	// tour 사진
	@Override
	public List<Board_MediaDTO> getAllBoard2() throws Exception {
		String sql = "select * from board_media where board_seq";
		return template.query(sql, new RowMapper<Board_MediaDTO>() {

			@Override
			public Board_MediaDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				Board_MediaDTO media = new Board_MediaDTO();
				media.setMedia_seq(rs.getInt(1));
				media.setBoard_seq(rs.getInt(2));
				media.setMedia_type(rs.getString(3));
				media.setOriginal_file_name(rs.getString(4));
				media.setSystem_file_name(rs.getString(5));
				return media;
			}
		});
	}

	// TOUR TAG 인기순 
	@Override
	public List<String[]> selectTagCount() throws Exception {
		String sql = "SELECT T10.TAGS"  			// STEP03 : 여러개의 ROW를 1개의 셀로 합치기
				+ "     , T10.CNT"  
				+ "     , LISTAGG(T10.BOARD_SEQ,',') WITHIN GROUP (ORDER BY T10.BOARD_SEQ)" 
				+ " FROM ("  					// STEP02 : TAGS별 건수가 많은 순으로 임의 번호 지정
				+ "       SELECT T20.BOARD_SEQ" 
				+ "			  , T20.TAGS" 
				+ "			  , T20.CNT" 
				+ "			  , ROW_NUMBER() OVER(PARTITION BY T20.BOARD_SEQ ORDER BY CNT DESC) AS SEQ"
				+ "		   FROM (" 				// STEP01 - TAGS 별 건수 조회
				+ "				 SELECT T30.BOARD_SEQ"
				+ "					  , T30.TAGS" 
				+ "					  , COUNT(1) OVER(PARTITION BY T30.TAGS) AS CNT"  // TAG별건수
				+ "				   FROM BOARD_TAGS T30" 
				+ "				) T20"
				+ "					  ) T10"
				+ "				WHERE T10.SEQ = 1"		// TAG별 건수가 가장 많은 TAG만 뽑기위한 조건(중복제거용)
				+ "				GROUP BY " 
				+ "					  T10.TAGS" 
				+ "					, T10.CNT" 
				+ "				ORDER BY " 
				+ "					  2 DESC";
		return template.query(sql, new RowMapper<String[]>() {

			@Override
			public String[] mapRow(ResultSet rs, int rowNum) throws SQLException {
				String[] list = {rs.getString(1), rs.getString(2), rs.getString(3)};
				System.out.println(list[2]);
				return list;
			}

		});
	}

	// my_aticle_bookmark
	@Override 
	public List<int[]> myBookmark(String id) throws Exception {
		String sql = "select board_seq from board_bookmark where id=?";
		return template.query(sql, new Object[] {id}, new RowMapper<int[]>() {

			@Override
			public int[] mapRow(ResultSet rs, int rowNum) throws SQLException {
				int[] list = {rs.getInt(1)};
				System.out.println(list);
				return list;
			}
		});
	}

	// my_aticle_Tag
	@Override
	public List<int[]> myTag(String id) throws Exception {
		String sql = "select board_seq from member_tags where member_tags=?";
		return template.query(sql, new Object[] {id}, new RowMapper<int[]>() {

			@Override
			public int[] mapRow(ResultSet rs, int arg1) throws SQLException {
				int[] listTag = {rs.getInt("board_seq")};
				System.out.println(listTag);
				return listTag;
			}

		});
	}

	@Override
	public List<BoardDTO> getFeedForAd(int... picks) throws Exception {
		String innerSql = "";
		Object[] objs = new Object[picks.length];
		for(int i = 0; i < picks.length; i++) {
			innerSql += "?";
			objs[i] = picks[i];
			if(i + 1 != picks.length) {
				innerSql += ", ";
			} else {
				break;
			}
		}
		
		String sql = "select * from board where board_seq in(" + innerSql + ")";
		return template.query(sql, objs, new RowMapper<BoardDTO>() {
			
			@Override
			public BoardDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				BoardDTO dto = new  BoardDTO();
				dto.setBoard_seq(rs.getInt("board_seq"));
				dto.setContents(rs.getString("contents"));
				dto.setId(rs.getString("id"));
				dto.setWritedate(rs.getString("writedate"));
				dto.setRead_count(rs.getString("read_count"));
				dto.setIs_allow_comments(rs.getString("is_allow_comments"));
				return dto;
			}
		});
	}

	@Override  
	public List<Object[]> alerting(String id) throws Exception {   
		// TODO Auto-generated method stub    
		String sql = "(select board_seq, id, floor((TRUNC(SYSDATE, 'MI')-TO_DATE(to_char(apply_date,'YYYYMMDD HH24:MI:SS'),'YYYYMMDD HH24:MI:SS')) * 1440) as applydate, id||' 님이 회원님의 사진을 좋아합니다.' as alert from board_like where (board_seq in(select board_seq from board where id=?)) and (id != ?)) union (select 0 as board_seq , id ,floor((TRUNC(SYSDATE, 'MI')-TO_DATE(to_char(follow_date,'YYYYMMDD HH24:MI:SS'),'YYYYMMDD HH24:MI:SS')) * 1440) as applydate, id||' 님이 회원님을 팔로우하기 시작했습니다.' as alert from member_follow where target_id=?) union (select board_seq , id, floor((TRUNC(SYSDATE, 'MI')-TO_DATE(to_char(writedate,'YYYYMMDD HH24:MI:SS'),'YYYYMMDD HH24:MI:SS')) * 1440) as applydate, id||' 님이 댓글을 남겼습니다 : '||comment_contents as alert from board_comment where (board_seq in(select board_seq from board where id=?)) and (id!=?)) order by applydate";
		return template.query(sql, new String[] {id,id,id,id,id}, new RowMapper<Object[]>() {

			@Override
			public Object[] mapRow(ResultSet rs, int rowNum) throws SQLException {
				// TODO Auto-generated method stub
				Object[] result = new Object[] {rs.getInt("board_seq"),rs.getString("id"),rs.getInt("applydate"), rs.getString("alert"),"","n"};
				
				
				
				return result;
			}
			
		});
		
	}
	
	@Override
	public Board_LocationDTO location(int seq) throws Exception {
		String sql = "select * from board_location where board_seq=?";
		Board_LocationDTO dto;
		List<Board_LocationDTO> list = template.query(sql, new Object[] {seq}, new RowMapper<Board_LocationDTO>() {

			@Override
			public Board_LocationDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				Board_LocationDTO tmp = new Board_LocationDTO();
				tmp.setBoard_seq(rs.getInt(1));
				tmp.setLocation_name(rs.getString(2));
				tmp.setLocation_latitude(rs.getString(3));
				tmp.setLocation_longitude(rs.getString(4));
				return tmp;
			}

		});
		if(list.size() > 0) {
			return list.get(0);
		}
		return dto = new Board_LocationDTO(0, " ", " ", " ");
	}

	@Override
	public String getBoardId(int commentSeq) throws Exception {
		String sql = "select id from board where board_seq=(select board_seq from board_comment where comment_seq=?)";
		return template.query(sql, new Object[] {commentSeq}, new RowMapper<String>() {

			@Override
			public String mapRow(ResultSet rs, int rowNum) throws SQLException {
				
				return rs.getString("id");
			}
		}).get(0);
	}

}
