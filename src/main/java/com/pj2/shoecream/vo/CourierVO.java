package com.pj2.shoecream.vo;

import java.util.List;

import lombok.Data;

@Data
public class CourierVO {
	private String adUrl;
	private String complete;
	private String invoiceNo;
	private String itemImage;
	private String itemName;
	private String level;
	private String receiverAddr;
	private String receiverName;
	private String recipient;
	private String result;
	private String senderName;
	private List<CourierDetailVO> trackingDetails;
	private String orderNumber;
	private String estimate;
	private String productInfo;
	private String zipCode;
	private CourierDetailVO lastDetail;
	private CourierDetailVO lastStateDetail;
	private CourierDetailVO firstDetail;
	private String completeYN;
}
