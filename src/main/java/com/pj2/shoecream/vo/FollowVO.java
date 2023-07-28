package com.pj2.shoecream.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class FollowVO {
//	private int follow_idx; // 팔로우 번호
//	private int follower_idx; // 팔로우 한 사람 번호
//	private int followee_idx; // 팔로우 받은 사람 번호
//	private Date follow_date;
	
	
	
	private int follow_idx; // 팔로우 번호
	private int follower_idx; // 팔로우 한 사람 번호
	private int followee_idx; // 팔로우 받은 사람 번호
	private Date follow_date;
}
