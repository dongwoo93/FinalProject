package kh.sns.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import kh.sns.dto.MemberBusinessDTO;
import kh.sns.interfaces.MemberBusinessDAO;

@Repository
public class IMemberBusinessDAO implements MemberBusinessDAO {
	
	@Autowired	private JdbcTemplate template;

	@Override
	public int insertAnMemberBiz(MemberBusinessDTO mbiz) throws Exception {
		String sql = "insert into member_business values(member_biz_seq.nextval, ?, ?, ?, ?, default, default, ?)";
		return template.update(sql, mbiz.getId(), mbiz.getBizWebsite(), mbiz.getBizEmail(), mbiz.getBizPhone(), mbiz.getIsAllowEnterProfile());
	}

	@Override
	public int delteAnMemberBiz(MemberBusinessDTO mbiz) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateAnMemberBiz(MemberBusinessDTO mbiz) throws Exception {
		String sql = "update member_business set biz_website = ?, biz_email = ?, biz_phone = ?, IS_ALLOW_ENTER_PROFILE = ? where id=?";
		return template.update(sql, mbiz.getBizWebsite(), mbiz.getBizEmail(), mbiz.getBizPhone(), mbiz.getIsAllowEnterProfile(), mbiz.getId());
	}

	@Override
	public MemberBusinessDTO selectAnMemberBiz(int memberBizSeq) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public MemberBusinessDTO selectAnMemberBiz(String memberId) throws Exception {
		String sql = "select * from member_business where id = ?";
		return template.query(sql, new Object[] {memberId}, (rs, rowNum) -> {
			MemberBusinessDTO mbiz = new MemberBusinessDTO();
			mbiz.setBizEmail(rs.getString("biz_email"));
			mbiz.setBizPhone(rs.getString("biz_phone"));
			mbiz.setBizWebsite(rs.getString("biz_website"));
			mbiz.setChangedDate(rs.getString("changed_date"));
			mbiz.setDeposit(rs.getLong("deposit"));
			mbiz.setId(rs.getString("id"));
			mbiz.setIsAllowEnterProfile(rs.getString("is_allow_enter_profile"));
			mbiz.setMemberBizSeq(rs.getInt("member_biz_seq"));
			return mbiz;
		}).get(0);
	}

	@Override
	public List<MemberBusinessDTO> getAllMemberBiz() throws Exception {
		String sql = "select * from member_business";
		return template.query(sql, (rs, rowNum) -> {
			MemberBusinessDTO mbiz = new MemberBusinessDTO();
			mbiz.setBizEmail(rs.getString("biz_email"));
			mbiz.setBizPhone(rs.getString("biz_phone"));
			mbiz.setBizWebsite(rs.getString("biz_website"));
			mbiz.setChangedDate(rs.getString("changed_date"));
			mbiz.setDeposit(rs.getLong("deposit"));
			mbiz.setId(rs.getString("id"));
			mbiz.setIsAllowEnterProfile(rs.getString("is_allow_enter_profile"));
			mbiz.setMemberBizSeq(rs.getInt("member_biz_seq"));
			return mbiz;
		});
	}

	@Override
	public List<MemberBusinessDTO> getMemberBizByRange(int start, int end) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public int updateAnBizMembersDeposit(MemberBusinessDTO mbiz) throws Exception {
		String sql = "update member_business set deposit = ? where id=?";
		return template.update(sql, mbiz.getDeposit(), mbiz.getId());
	}
	
	
}
