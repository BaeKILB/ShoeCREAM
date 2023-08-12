package com.pj2.shoecream.vo;

import java.util.List;

import lombok.Data;

@Data
public class TrackingVO {
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
	private List<TrackingDetailVO> trackingDetails;
	private String orderNumber;
	private String estimate;
	private String productInfo;
	private String zipCode;
	private TrackingDetailVO lastDetail;
	private TrackingDetailVO lastStateDetail;
	private TrackingDetailVO firstDetail;
	private String completeYN;
}
