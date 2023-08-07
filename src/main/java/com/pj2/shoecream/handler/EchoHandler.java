package com.pj2.shoecream.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.pj2.shoecream.config.PrincipalDetails;
import com.pj2.shoecream.vo.MemberVO;

@Component
@RequestMapping("/alram")
public class EchoHandler extends TextWebSocketHandler {
	
	private static final Logger logger = LoggerFactory.getLogger(WebSocketHandler.class);
	//로그인 한 인원 전체
	private List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	// 1:1로 할 경우
	private Map<String, WebSocketSession> userSessionsMap = new HashMap<String, WebSocketSession>();
	
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {//클라이언트와 서버가 연결
		logger.info("Socket 연결");
		sessions.add(session);
		String senderId = "";
		try {
			senderId = currentUserIdx();
		} catch (Exception e) {
			senderId = "0";
		}
		userSessionsMap.put(senderId,session);
		logger.info("!@#$");
		logger.info(sessions.toString());
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {// 메시지
		String msg = message.getPayload();//자바스크립트에서 넘어온 Msg
		
		if (StringUtils.isNotEmpty(msg)) {
			String[] strs = msg.split(",");
			if(strs != null && strs.length == 5) {
				
				String cmd = strs[0]; // 분류
				String sender = strs[1]; // 보내는사람
				String receiver = strs[2]; // 받는사람
				String product_idx = strs[3]; // 상품번호
				String product_title = strs[4]; // 상품명
//				String bgno = strs[5]; // 카테고리 분류라는데 cmd로 대체가능
				logger.info("length 성공?"+cmd);
				
				WebSocketSession senderSession = userSessionsMap.get(sender);
				WebSocketSession receiverSession = userSessionsMap.get(receiver);
				logger.info("boardWriterSession="+userSessionsMap.get(receiver));
				logger.info("boardWirterSession="+receiverSession);
				logger.info(receiver);
				logger.info(userSessionsMap.toString());
				
				if (cmd.equals("auction") && receiverSession != null) {
				logger.info("onmessage되나?");
				TextMessage tmpMsg = new TextMessage(
						receiver + "님이 참여하신"
						+ "<a href='AuctionDetail?auction_idx="+product_idx+"' style=\"color: black\">"
						+ product_title+" 상품에 유찰되었습니다.</a>");
				receiverSession.sendMessage(tmpMsg);
				}
				
				
//				//댓글
//				if ("reply".equals(cmd) && receiverSession != null) {
//					logger.info("onmessage되나?");
//					TextMessage tmpMsg = new TextMessage(sender + "님이 "
//							+ "<a href='/board/readView?bno="+ product_idx +"&bgno="+bgno+"'  style=\"color: black\">"
//							+ product_title+" 에 댓글을 달았습니다!</a>");
//					receiverSession.sendMessage(tmpMsg);
//				}
//				
//				//스크랩
//				else if("scrap".equals(cmd) && receiverSession != null) {
//					//replyWriter = 스크랩누른사람 , boardWriter = 게시글작성자
//					TextMessage tmpMsg = new TextMessage(sender + "님이 "
//							+ "<a href='/board/readView?bno=" + product_idx + "&bgno="+bgno+"'  style=\"color: black\"><strong>"
//							+ product_title+"</strong> 에 작성한 글을 스크랩했습니다!</a>");
//
//					receiverSession.sendMessage(tmpMsg);
//					
//				}
//				
//				//좋아요
//				else if("like".equals(cmd) && receiverSession != null) {
//					//replyWriter = 좋아요누른사람 , boardWriter = 게시글작성자
//					TextMessage tmpMsg = new TextMessage(sender + "님이 "
//							+ "<a href='/board/readView?bno=" + product_idx + "&bgno="+bgno+"'  style=\"color: black\"><strong>"
//							+ product_title+"</strong> 에 작성한 글을 좋아요했습니다!</a>");
//
//					receiverSession.sendMessage(tmpMsg);
//					
//				}
//				
//				//DEV
//				else if("Dev".equals(cmd) && receiverSession != null) {
//					//replyWriter = 좋아요누른사람 , boardWriter = 게시글작성자
//					TextMessage tmpMsg = new TextMessage(sender + "님이 "
//							+ "<a href='/board/readView?bno=" + product_idx + "&bgno="+bgno+"'  style=\"color: black\"><strong>"
//							+ product_title+"</strong> 에 작성한 글을 DEV했습니다!</a>");
//
//					receiverSession.sendMessage(tmpMsg);
//					
//				}
//				
//				//댓글채택
//				else if("questionCheck".equals(cmd) && senderSession != null) {
//					//replyWriter = 댓글작성자 , boardWriter = 글작성자
//					TextMessage tmpMsg = new TextMessage(receiver + "님이 "
//							+ "<a href='/board/readView?bno=" + product_idx + "&bgno="+bgno+"'  style=\"color: black\"><strong>"
//							+ product_title+"</strong> 에 작성한 댓글을 채택했습니다!</a>");
//
//					senderSession.sendMessage(tmpMsg);
//					
//				}
//				
//				//댓글좋아요
//				else if("commentLike".equals(cmd) && senderSession != null) {
//					logger.info("좋아요onmessage되나?");
//					logger.info("result=board="+receiver+"//"+sender+"//"+product_idx+"//"+bgno+"//"+product_title);
//					//replyWriter=댓글작성자 , boardWriter=좋아요누른사람 
//					TextMessage tmpMsg = new TextMessage(receiver + "님이 "
//							+ "<a href='/board/readView?bno=" + product_idx + "&bgno="+bgno+"'  style=\"color: black\"><strong>"
//							+ product_title+"</strong> 에 작성한 댓글을 추천했습니다!</a>");
//
//					senderSession.sendMessage(tmpMsg);
//				}
//				
//				
//				//댓글DEV
//				else if("commentDev".equals(cmd) && senderSession != null) {
//					logger.info("좋아요onmessage되나?");
//					logger.info("result=board="+receiver+"//"+sender+"//"+product_idx+"//"+bgno+"//"+product_title);
//					//replyWriter=댓글작성자 , boardWriter=좋아요누른사람 
//					TextMessage tmpMsg = new TextMessage(receiver + "님이 "
//							+ "<a href='/board/readView?bno=" + product_idx + "&bgno="+bgno+"'  style=\"color: black\"><strong>"
//							+ product_title+"</strong> 에 작성한 댓글을 DEV했습니다!</a>");
//
//					senderSession.sendMessage(tmpMsg);
//				}
			}
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {//연결 해제
		// TODO Auto-generated method stub
		logger.info("Socket 끊음");
		sessions.remove(session);
		userSessionsMap.remove(currentUserIdx(),session);
	}
	
	// 세션값 받아오기
	private String currentUserIdx() throws Exception {
    	//spring security
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int sId = -1;
        PrincipalDetails mPrincipalDetails = null;
        try {        	
        	mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
        	sId = mPrincipalDetails.getMember().getMem_idx(); // 세션에 저장된 mem_idx
        }
        catch(Exception e){
        	e.printStackTrace();
        }
		
		return String.valueOf(sId);
	}
	
	
	
}
