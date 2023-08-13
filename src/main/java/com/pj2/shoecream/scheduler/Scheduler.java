package com.pj2.shoecream.scheduler;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.pj2.shoecream.service.CourierService;
import com.pj2.shoecream.vo.CourierVO;

@Component
public class Scheduler {

	@Autowired
	private CourierService service;
	
	@Scheduled(cron = "0 0/30 10-20 * * *")
//	@Scheduled(fixedRate = 10000000)
	public void courierUpdate() {
		List<Map<String,Object>> courierList = service.getCourierList();
		
		for(Map<String, Object> courier : courierList) {
			String trackingNumber = String.valueOf(courier.get("tracking_num"));
			CourierVO item = service.requestCourierInfo(courier);
			if (item.getLastDetail() != null) {
				String kind = item.getLastDetail().getKind();
				service.modifyCourier(trackingNumber,kind);
				System.out.println("상태 변경 완료 : " + courier.get("tracking_num"));
			}
			System.out.println(courier.toString());
			System.out.println(item.toString());
		}
	}
}
