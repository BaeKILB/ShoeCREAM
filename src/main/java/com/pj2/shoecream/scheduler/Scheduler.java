package com.pj2.shoecream.scheduler;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.pj2.shoecream.service.SchedulerService;
import com.pj2.shoecream.vo.TrackingVO;

@Component
public class Scheduler {

	@Autowired
	private SchedulerService service;
	
	@Scheduled(cron = "0 0/30 10-20 * * *")
//	@Scheduled(fixedRate = 10000000)
	public void trackingUpdate() {
		List<Map<String,Object>> trackingList = service.getTrackingList();
		
		for(Map<String, Object> tracking : trackingList) {
			String trackingNumber = String.valueOf(tracking.get("tracking_num"));
			TrackingVO item = service.requestTracking(tracking);
			if (item.getLastDetail() != null) {
				String kind = item.getLastDetail().getKind();
				service.modifyTracking(trackingNumber,kind);
				System.out.println("상태 변경 완료 : " + tracking.get("tracking_num"));
			}
			System.out.println(tracking.toString());
			System.out.println(item.toString());
		}
		
	}
}
