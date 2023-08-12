package com.pj2.shoecream.vo;

import java.util.Date;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.pj2.shoecream.handler.DateDeserializer;

import lombok.Data;

@Data
public class TrackingDetailVO {
	private String kind;
	private String level;
	private String manName;
	private String manPic;
	private String telno;
	private String telno2;
	private String time;
	@JsonDeserialize(using = DateDeserializer.class)
	private Date timeString;
	private String where;
	private String code;
	private String remark;
}
