package com.pj2.shoecream.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class PointInoutVO {
	private int point_idx;
	private String point_status;
	private int charge_point_amount;
	private int mem_idx;
	private int charge_point;
	private String point_usage;
	private Timestamp point_date;
}
