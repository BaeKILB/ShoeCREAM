package com.pj2.shoecream.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class MemberProfileDto {
	private boolean pageOwnerState;
//	private int imageCount;
	private MemberVO member;
}
