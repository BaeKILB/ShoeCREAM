package com.pj2.shoecream.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class FollowingDto {
	private int mem_idx; // 로그인한 사람이 아닌 다른 사람의 id (난 mem_idx 로 놓겠다)
	private String mem_id;
	private String profileImageUrl; // 프로필 이미지
	private Integer followState; // 구독 상태
	private Integer equalMemberState; // 로그인한 사용자가 동일인인지 false 면 보여주고 ture 면 구독하기 같은거 안보이게
}
