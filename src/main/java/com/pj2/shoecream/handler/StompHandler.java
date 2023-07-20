package com.pj2.shoecream.handler;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

// stomp 설정에 쓰일 클래스는 
// @Configuration 어노테이션와
// @EnableWebSocketMessageBroker 어노테이션 사용해야됨
@Configuration
@EnableWebSocketMessageBroker
public class StompHandler implements WebSocketMessageBrokerConfigurer{

	//메시지 브로커 설정
	@Override
	public void configureMessageBroker(MessageBrokerRegistry registry) {
		// TODO Auto-generated method stub
		//spring 에서 사용하는 내장 브로커를 사용한다고 선언
		// queue 와 topic 으로 설정할수 있음
		registry.enableSimpleBroker("/topic");
		// 메시지가 라우팅 될 핸들러 도착 경로 설정
		// send 요청이 오면 처리함
		registry.setApplicationDestinationPrefixes("/pub");
	}

	// 웹소켓 연결 주소
	@Override
	public void registerStompEndpoints(StompEndpointRegistry registry) {
		// TODO Auto-generated method stub
		
		//웹소켓 핸드세이크(연결) 을 위한 경로명 지정
		// 나중에 페이지 script 부분에서 SockJS 객체 생성시 사용 
		registry.addEndpoint("/stomp_chat")
		.withSockJS();
	}

	
}
