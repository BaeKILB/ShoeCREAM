package com.pj2.shoecream.vo;

import java.util.Date;
import lombok.Data;

@Data
public class InquiryBoardVO {
	private int qst_idx;
	private int mem_idx;
	private String mem_name;
	private String qst_pass;
	private String qst_subject;
	private String qst_content;
	private int qst_board_re_ref;
	private int qst_board_re_lev;
	private int qst_board_re_seq;
	private Date qst_date;
	private String qst_type;
}
