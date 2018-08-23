package kh.sns.impl;

import java.lang.reflect.Array;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.aspectj.weaver.TemporaryTypeMunger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_MediaDTO;
import kh.sns.dto.FollowInfo;
import kh.sns.dto.Board_TagsDTO;
import kh.sns.interfaces.BoardDAO;
import kh.sns.util.HashTagUtil;

@Repository
public class IBoardDAO implements BoardDAO  {

	private static final String SAVE_PATH = "/upload";
	private static final String PREFIX_URL = "/upload/";

	@Autowired
	private JdbcTemplate template;
	
	
	@Override
	public List<FollowInfo> toFeed(String id) throws Exception{
		String sql = "select target_id from member_follow where id in(select target_id from member_follow where id= ?) and (target_id not in(?)) and (target_id not in (select target_id from member_follow where id= ?)) group by target_id order by count(target_id)";
		return template.query(sql, new Object[] {id,id,id}, new RowMapper<FollowInfo>() {
			
			@Override
			public FollowInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
				FollowInfo followtmp = new FollowInfo();
					followtmp.setId(rs.getString(1));
					return followtmp;
				}	
			});
		}
	
	
	@Override
	public List<FollowInfo> followerList(String id) throws Exception{
		String sql = "select target_id from member_follow where target_id in(select target_id from member_follow where id=?) and (target_id not in(?)) group by target_id order by count(target_id)";
		return template.query(sql, new Object[] {id,id}, new RowMapper<FollowInfo>() {
			
			@Override
			public FollowInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
				return new FollowInfo("", rs.getString(1),"");
				}	
			});
		}
	

	@Override
	public List<FollowInfo> followList(String id) throws Exception{
		String sql = "select id from member_follow where target_id in(select target_id from member_follow where target_id=?)and (id not in(?))";
		return template.query(sql, new Object[] {id,id}, new RowMapper<FollowInfo>() {
			
			@Override
			public FollowInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
				FollowInfo followtmp = new FollowInfo();
				return new FollowInfo(rs.getString(1),"",rs.getString(1));
				}	
			});
		}
	

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
		String sql = "select * from board where (board_seq in (select board_seq from board_tags where tags like '%'||?||'%')) or "
				+ "(board_seq in (select board_seq from board_location where location_name like '%'||?||'%')) order by board_seq desc";
		return template.query(sql, new Object[] {keyword, keyword}, new RowMapper<BoardDTO>() {

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
				return media;
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

		List<String> hashTagList = new HashTagUtil().extractHashTag(article.getContents());

		String sql = "insert into board_tags values(?, ?)";
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

}
