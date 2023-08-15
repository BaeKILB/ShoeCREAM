package com.pj2.shoecream.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj2.shoecream.mapper.MemberMapper;
import com.pj2.shoecream.mapper.PayMapper;
import com.pj2.shoecream.vo.MemberVO;
import com.pj2.shoecream.vo.PayInfoVO;
import com.pj2.shoecream.vo.PointInoutVO;

@Service
public class PayService {
	
	@Autowired
	private PayMapper mapper;
	
	@Autowired
	private MemberMapper memMapper;
	
	
	// 포인트 충전
	// 포인트 충전 담당 메서드
	
	// PointInoutVO 필요 파라미터
	// mem_idx charge_point point_usage
	
	// PointInoutVO 의 point_usage 값 
	// CHECK('계좌충전','결제대금입금','카드결제충전','취소결제충전',
	//		'결제사용','카드결제사용','계좌이체출금','결제취소출금','관리자입출금')
	
	// 1. 성공
	// 2. 멤버 update 실패
	// 3. 포인트 충전/출금 내역 기록 실패
	// 4. 멤버 가져오기 실패
	public int depositPoints(PointInoutVO pointInout) {
		pointInout.setPoint_status("충전");
		
		// 충전할 멤버 가져오기
		MemberVO depositUser = null;
		try {
			depositUser = memMapper.findMemberByMemIdx(pointInout.getMem_idx()); 
		}
		catch(Exception e) {
			return 4;
		}
		
		// 충전시작
		int depositPoint = pointInout.getCharge_point() + depositUser.getCharge_point();
		if(mapper.updateMemberPoint(pointInout.getMem_idx(), depositPoint) <= 0) {
			return 2;
		}
		
		if(mapper.insertPointInout(pointInout) <= 0) {
			return 3;
		}
		return 1;
	}
	
	// 포인트 출금
	// 포인트 출금 담당 메서드
	
	// PointInoutVO 필요 파라미터
	// mem_idx charge_point point_usage

	// PointInoutVO 의 point_usage 값 
	// CHECK('계좌충전','결제대금입금','카드결제충전','취소결제충전',
	//		'결제사용','카드결제사용','계좌이체출금','결제취소출금','관리자입출금')
	
	// 1. 성공
	// 2. 멤버 update 실패
	// 3. 포인트 충전/출금 내역 기록 실패
	// 4. 없는 멤버idx 또는 멤버 불러오기 실패
	// 5. 잔고 부족
	public int withdrawPoints(PointInoutVO pointInout) {
		pointInout.setPoint_status("출금");
		
		// 출금할 멤버 가져오기
		MemberVO withdrawUser = null;
		try {
			withdrawUser = memMapper.findMemberByMemIdx(pointInout.getMem_idx()); 
		}
		catch(Exception e) {
			return 4;
		}
		
		// 출금될 금액보다 현재 잔고가 작은지 체크
		if(withdrawUser.getCharge_point() < pointInout.getCharge_point()) {
			return 5;
		}
		
		// 출금시작
		int withdrawPoint =  withdrawUser.getCharge_point() - pointInout.getCharge_point();
		if(mapper.updateMemberPoint(pointInout.getMem_idx(), withdrawPoint) <= 0) {
			return 2;
		}
		
		if(mapper.insertPointInout(pointInout) <= 0) {
			return 3;
		}
		return 1;
	}
	
	
	// 포인트로 결제
	// PayInfoVO 와 PointInoutVO를 받기
	
	// PayInfoVO 에는 mem_idx, product_idx, pay_method, pay_total
	// PointInoutVO 에는 mem_idx와 point_usage 값을 미리 넣고 와야함
	
	// PointInoutVO 의 point_usage 값 
	// CHECK('계좌충전','결제대금입금','카드결제충전','취소결제충전',
	//		'결제사용','카드결제사용','계좌이체출금','결제취소출금','관리자입출금')
	
	// 반환값은 int
	// 1: 완료 
	// 2: 잔고부족
	// 3: 결제완료 또는 거래완료된 상품
	// 4: 결제 정보 저장 실패
	// 5: 기타오류
	public int productPayment(PayInfoVO payInfo, PointInoutVO pointInout) {
		MemberVO payUser = memMapper.findMemberByMemIdx(pointInout.getMem_idx()); 
		
		int payPrice = payInfo.getPay_total();
		
		// 입금이든 출금이든 양수로 들어가야함
		if(payPrice < 0) {
			payPrice = payPrice * -1;
			payInfo.setPay_total(payPrice);
		}
		// 잔고 충분한지 확인
		if(payInfo.getPay_total() > payUser.getCharge_point()) {
			return 2;
		}
		
		// 최근 거래정보에 해당 상품이 결제완료 상태인지 확인
		if(mapper.selectGetPayInfoTop(payInfo.getProduct_idx()) != null) {
			String payStatus = mapper.selectGetPayInfoTop(payInfo.getProduct_idx()).getPay_status();
			if(payStatus.equals("결제완료")
					|| payStatus.equals("거래완료")) {
				return 3;
			}
		}
		
		// 결제 시작
		// pointInout에 결제 금액 넣기
		pointInout.setCharge_point(payPrice);
		
		// 포인트 출금 밑 기록 추가
		int withdrawResult = withdrawPoints(pointInout);
		
		// 출금 성공시 결제정보 추가
		if(withdrawResult == 1) {
			payInfo.setPay_status("결제완료");
			if(mapper.insertPayInfo(payInfo) > 0) {
				return 1;
			}
			else {
				return 4;
			}
		}
		// 기타 실패시 5 반환
		return 5;
	}

	// 결제 환불
	
	//파라미터
	// int mem_buyer_idx  : 구매자 idx
	// String product_idx  : 상품 idx
	// int product_selector : 어느영역에서 구매했는지( 중고, 경매, 크림)
	// product_selector 에 들어가는 값
	// 0: 중고, 1: 경매, 2: 크림
	
	
	// 반환값은 int
	// 1. 성공
	// 2. 결제 정보 불러오기 실패
	// 3. 상품 결제 정보가 결제 완료가 아님
	// 4. 판매자 정보 불러오기 실패
	// 5. 
	// 6. 기타 실패
	public int productCancelPayment(int mem_buyer_idx ,String product_idx , int product_selector) {
		// 최근 거래정보 가져오기
		PayInfoVO payInfo = null;
		
		// product_selector 따라서 다르게 들고오기(크림의경우 한 product idx로 여러개 구매 가능임으로)
		if(product_selector == 2) {			
			try {
				payInfo = mapper.selectGetPayInfoIdx(product_idx, mem_buyer_idx);
			}
			catch(Exception e) {
				return 2;
			}
		}
		else {
			try {
				payInfo = mapper.selectGetPayInfoTop(product_idx);
			}
			catch(Exception e) {
				return 2;
			}
		}
		
		// 최근 거래정보에 해당 상품이 결제완료 상태인지 확인
		if(payInfo != null) {			
			if(!payInfo.getPay_status().equals("결제완료")) {
				return 3;
			}
		}
		else {
			return 2;
		}
		
		// 포인트 환불 위한 PointInoutVO 만들기
		PointInoutVO pointInout = new PointInoutVO();
		
		// 구매자 정보 불러오기
		MemberVO member = null;
		
		try {
			member = memMapper.findMemberByMemIdx(mem_buyer_idx);
		}
		catch(Exception e) {
			return 4;
		}
		
		pointInout.setPoint_status("충전");
		pointInout.setCharge_point_amount(member.getCharge_point());
		pointInout.setMem_idx(mem_buyer_idx);
		pointInout.setCharge_point(payInfo.getPay_total());
		pointInout.setPoint_usage("취소결제충전");
		
		// 판매자 송금 성공시 기록 남기기
		if(depositPoints(pointInout) == 1) {
			// 거래 성공시 거래정보 추가
			payInfo.setPay_status("결제취소");
			payInfo.setPay_method(2);
			payInfo.setCancel_pay(payInfo.getPay_total());
			if(mapper.insertPayInfo(payInfo) > 0) {
				return 1;
			}
			else {
				return 6;
			}
		}
		return 6;
	}
	
	// 구매자가 거래완료를 누를시 판매자에게 해당 상품 금액 입금 되도록 하기
	// fee = 수수료(% 라고 치고 입력 0 ~ 100 사이)
	// 1. 성공
	// 2. 결제 정보 불러오기 실패
	// 3. 상품 결제 정보가 결제 완료가 아님
	// 4. 판매자 정보 불러오기 실패
	// 5. 수수료율 값 이상
	// 6. 기타 실패
	public int transCompleteDeposit(int mem_seller_idx ,String product_idx, int fee) {
		// 최근 거래정보 가져오기
		PayInfoVO payInfo = null;
		try {
			payInfo = mapper.selectGetPayInfoTop(product_idx);
		}
		catch(Exception e) {
			return 2;
		}
		
		// 최근 거래정보에 해당 상품이 결제완료 상태인지 확인
		if(payInfo != null) {			
			if(!payInfo.getPay_status().equals("결제완료")) {
				return 3;
			}
		}
		else {
			return 2;
		}
		
		// 포인트 충전을 위한 PointInoutVO 만들기
		PointInoutVO pointInout = new PointInoutVO();
		
		// 판매자 정보 불러오기
		MemberVO member = null;
		
		try {
			member = memMapper.findMemberByMemIdx(mem_seller_idx);
		}
		catch(Exception e) {
			return 4;
		}
		
		pointInout.setPoint_status("충전");
		pointInout.setCharge_point_amount(member.getCharge_point());
		pointInout.setMem_idx(mem_seller_idx);
		
		pointInout.setCharge_point(payInfo.getPay_total());
		
		// 수수료율 존재시 수수료율 적용 및 관리자에게 수수료 전송
		// 수수료율 값 체크
		if(fee >= 100 || fee < 0) {
			return 5;
		}
		if(fee > 0) {			
			pointInout.setCharge_point(
					payInfo.getPay_total() - (payInfo.getPay_total() * (fee / 100))
					);
		}
		pointInout.setPoint_usage("결제대금입금");
		
		// 판매자 송금 성공시 기록 남기기
		if(depositPoints(pointInout) == 1) {
			// 거래 성공시 거래정보 추가
			payInfo.setPay_status("거래완료");
			payInfo.setPay_method(2);
			if(mapper.insertPayInfo(payInfo) > 0) {
				return 1;
			}
			else {
				return 6;
			}
		}
		return 6;
	}

	
	// 구매자가 거래완료를 누를시 직거래일때 사용
	// 1. 성공
	// 2. 결제 정보 불러오기 실패
	// 3. 상품 결제 정보가 결제 완료가 아님
	// 4. 판매자 정보 불러오기 실패
	// 6. 기타 실패
	public int transCompleteJik(int mem_buyer_idx, int mem_seller_idx ,String product_idx) {
		// 최근 거래정보 가져오기
		PayInfoVO payInfoTop = null;
		try {
			payInfoTop = mapper.selectGetPayInfoTop(product_idx);
		}
		catch(Exception e) {
			return 2;
		}
		
		// 최근 거래정보에 해당 상품이 결제완료 상태인지 확인
		if(payInfoTop != null) {			
			if(!payInfoTop.getPay_status().equals("결제완료")) {
				return 3;
			}
		}
		
		PayInfoVO payInfo = new PayInfoVO();
		// 페이 결제 시작 
		// 페이 결제시 사용할 객체에 정보 담기
		payInfo.setMem_idx(mem_buyer_idx);
		payInfo.setProduct_idx(product_idx);
		payInfo.setProduct_selector(0);;
		payInfo.setPay_method(2);
		payInfo.setPay_total(0);
		
		
		// 직거래시에는 추가적인 포인트 입 출금, 기록 필요 X
		
		// 거래 성공시 거래정보 추가
		payInfo.setPay_status("거래완료");
		payInfo.setPay_method(4); // 4 : 직거래시 사용
		if(mapper.insertPayInfo(payInfo) > 0) {
			return 1;
		}
		else {
			return 6;
		}

	}
}
