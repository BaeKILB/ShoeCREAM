package com.pj2.shoecream.service;

import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriBuilder;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.google.gson.Gson;
import com.pj2.shoecream.handler.BankValueGenerator;
import com.pj2.shoecream.vo.BankAccountDetailVO;
import com.pj2.shoecream.vo.ResponseAuthCodeInfo;
import com.pj2.shoecream.vo.ResponseDepositVO;
import com.pj2.shoecream.vo.ResponseTokenVO;
import com.pj2.shoecream.vo.ResponseUserInfoVO;
import com.pj2.shoecream.vo.ResponseWithdrawVO;

@Service
public class BankApiClient {
	// classpath:/config/appdata.properties 파일 내의 속성값 자동 주입
	// 주의! @Value 어노테이션 선언 시 패키지명 : org.springframework.beans.factory.annotation
	@Value("${base_url}")
	private String baseUrl;
	
	@Value("${client_id}")
	private String clientId;
	
	@Value("${client_secret}")
	private String clientSecret;
	
//	@Autowired
	private RestTemplate restTemplate; // @Autowired 어노테이션 사용 불가(스프링에서 관리하는 Bean 객체가 아님)
	
	@Autowired
	private BankValueGenerator valueGenerator; // @Component 어노테이션이 적용된 클래스
	
	private static final Logger logger = LoggerFactory.getLogger(BankApiClient.class);

	static final String REDIRCT_URI = "http://c5d2302t3.itwillbs.com/ShoeCREAM/callback";
	
	
	// 인증코드 요청
	public String requestAuth(String access_token, String user_seq_no) {
		String url = baseUrl + "/oauth/2.0/authorize";
		String redirectUri = REDIRCT_URI;
		String scope = "login inquiry transfer";
		String state = "12345678901234567890123456789012";
		
		ResponseUserInfoVO userInfo = requestUserInfo(access_token, user_seq_no);
		
		HttpHeaders httpHeaders = new HttpHeaders();
		HttpEntity<String> httpEntity = new HttpEntity<String>(httpHeaders);
		
		UriComponents uriComponents = null;
		
		if(access_token == null) {
			uriComponents = UriComponentsBuilder.fromHttpUrl(url)
							.queryParam("response_type", "code")
							.queryParam("client_id", clientId)
							.queryParam("redirect_uri", redirectUri)
							.queryParam("scope", scope)
							.queryParam("state", "12345678901234567890123456789012")
							.queryParam("auth_type", "0")
							.build();
		} else {
			httpHeaders.add("Kftc-Bfop-UserSeqNo", user_seq_no);
			httpHeaders.add("Kftc-Bfop-UserCI", userInfo.getUser_ci());
			httpHeaders.add("Kftc-Bfop-AccessToken", access_token);
			
			uriComponents = UriComponentsBuilder.fromHttpUrl(url)
					.queryParam("response_type", "code")
					.queryParam("client_id", clientId)
					.queryParam("redirect_uri", redirectUri)
					.queryParam("scope", scope)
					.queryParam("state", "12345678901234567890123456789012")
					.queryParam("auth_type", "2")
					.build();
			
		}
		
		restTemplate = new RestTemplate();
		
		ResponseEntity<ResponseAuthCodeInfo> responseEntity = 
				restTemplate.exchange(uriComponents.toString(), HttpMethod.GET, httpEntity, ResponseAuthCodeInfo.class);
		logger.info("□□□□□□ 잔액조회 ResponseEntity.getBody() : " + responseEntity.getBody());
		
		return null;
	}
	
	// 2.1.2. 토큰발급 API - 사용자 토큰발급 API (3-legged)
	// https://testapi.openbanking.or.kr/oauth/2.0/token
	public ResponseTokenVO requestToken(Map<String, String> authResponse) {
		// 엑세스토큰 발급 요청에 사용될 API 의 URI 설정
		// => 기본 URL + 엑세스토큰 발급 URL
		String url = baseUrl + "/oauth/2.0/token";
		
		// HTTP 프로토콜로 전송할 요청 정보(헤더, 바디(파라미터)) 생성
		// 1. 헤더 설정(org.springframework.http.HttpHeaders 클래스 활용)을 위한 HttpHeaders 객체 생성
		//    - 객체 생성 후 add() 메서드를 호출하여 헤더 정보 설정
		//      => add("헤더속성명", "헤더값") 
		//    - 별도의 추가 헤더 정보가 없을 경우 객체 생성만 수행
		HttpHeaders httpHeaders = new HttpHeaders();
		
		// 2. 헤더에 정보 추가
		httpHeaders.add("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
		
		// 3. 요청에 필요한 파라미터(Body) 설정
		//    - 요청 방식(HTTP Method)에 따라 다른 방식 사용
		//    - POST 방식일 경우 org.springframework.util.MultiValueMap 및 LinkedMultiValueMap 활용
		//      => HTTP 요청 파라미터는 모두 String 이므로 제네릭타입 <String, String> 고정
		MultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();
		// 사용자 인증 과정에서 응답받은 데이터(인증코드)가 Map 타입 객체 authResponse 에 저장되어 있으므로
		// 요청 파라미터에 사용할 데이터를 authResponse 객체에서 꺼내서 add() 메서드로 전달하기
		parameters.add("code", authResponse.get("code")); // 응답데이터 활용
		parameters.add("client_id", clientId); // @Value 어노테이션으로 포함한 속성값
		parameters.add("client_secret", clientSecret); // @Value 어노테이션으로 포함한 속성값
		parameters.add("redirect_uri", REDIRCT_URI); // 기존 콜백 URL 그대로 활용
		parameters.add("grant_type", "authorization_code"); // 고정값
		logger.info("□□□□□□ parameters : " + parameters.toString());
		
		// 4. 요청에 사용될 헤더와 파라미터 정보를 갖는 HttpEntity 객체 생성
		// => 제네릭타입으로 요청 파라미터 타입 지정
		HttpEntity<MultiValueMap<String, String>> httpEntity = 
				new HttpEntity<MultiValueMap<String,String>>(parameters, httpHeaders);
		
		// 5. REST 방식 요청을 수행하기 위해 RestTemplate 객체 생성
		restTemplate = new RestTemplate();
		
		// 6. RestTemplate 객체의 exchange() 메서드 호출하여 HTTP 요청 수행
		// => 파라미터 : 요청 URL, 요청메서드(HttpMethod.XXX), HttpEntity 객체, 응답데이터 저장 클래스타입(.class 필수)
		// => 리턴타입 : ResponseEntity<T> => 제네릭타입은 exchange() 메서드의 마지막 파라미터인 클래스타입 사용
		ResponseEntity<ResponseTokenVO> responseEntity = 
				restTemplate.exchange(url, HttpMethod.POST, httpEntity, ResponseTokenVO.class);
		// => HTTP 요청을 수행한 후 응답 데이터를 ResponseEntity 객체가 관리하며
		//    해당 응답 데이터를 관리할 ResponseTokenVO 객체를 통해 응답 정보를 저장
		// => 단, 응답 데이터를 저장할 VO 객체의 멤버변수명은 응답 데이터의 파라미터명과 동일해야하며
		//    JSON 타입 응답 데이터가 자동으로 변환되기 위해서는 Converter 클래스가 필요한데
		//    이 때, org.json 라이브러리가 아닌 Gson 또는 Jackson 라이브러리 필요
		
		// 7. 응답받은 ResponseEntity 객체의 getBody() 메서드를 호출하면
		//    제네릭타입으로 지정한 객체에 저장된 응답 데이터를 가져올 수 있다!
//		logger.info("□□□□□□ ResponseEntity.toString() : " + responseEntity.toString());
		logger.info("□□□□□□ ResponseEntity.getBody() : " + responseEntity.getBody());
		logger.info("□□□□□□ ResponseEntity.getStatusCode() : " + responseEntity.getStatusCode());
		
		// 8. 응답 데이터 리턴
		// => ResponseEntity 객체의 제네릭타입인 ResponseTokenVO 타입 객체는
		//    ResponseEntity 객체의 getBody() 메서드로 리턴받을 수 있다!
		return responseEntity.getBody();
	}

	// 2.2. 사용자/계좌 관리 
	// - 2.2.1. 사용자정보조회 API - GET
	public ResponseUserInfoVO requestUserInfo(String access_token, String user_seq_no) {
		// 사용자정보조회 요청 API 의 URL 생성 - GET 방식
		String url = baseUrl + "/v2.0/user/me";
		
		// 1. 헤더 설정(org.springframework.http.HttpHeaders 클래스 활용)을 위한 HttpHeaders 객체 생성
		HttpHeaders httpHeaders = new HttpHeaders();
		// 2. 헤더에 정보 추가(Authorization 항목으로 엑세스 토큰 전달("Bearer 엑세스토큰" 형식)
		httpHeaders.add("Authorization", "Bearer " + access_token);
		
		// 3. 요청에 사용될 헤더와 파라미터 정보를 갖는 HttpEntity 객체 생성
		// => 단, GET 방식 요청에 바디 없이 헤더만 전달하므로 바디 생략
		// => 제네릭타입 String 타입 지정
		HttpEntity<String> httpEntity = new HttpEntity<String>(httpHeaders);
		
		// 4. 요청에 필요한 파라미터 설정
		//    - 요청 방식(HTTP Method)에 따라 다른 방식 사용
		//    - GET 방식 요청은 바디(Body) 영역 없이 URL 을 통해 파라미터 전송이 가능하므로
		//      UriComponent 객체를 통해 HTTP URL 형식으로 파라미터를 포함시켜 전달 가능
		// => UriComponentsBuilder 클래스의 fromHttpUrl() 메서드를 호출하여 UriComponents 객체 얻어오기
		//    Builder Pattern 을 활용하여 복수개의 메서드를 연결한 후
		//    최종적으로 build() 메서드를 호출하면 UriComponents 객체 생성 후 리턴됨
		//    이 때, URL 뒤에 파라미터를 연결하는 경우 build() 메서드 호출 전에
		//    queryParam() 메서드를 통해 파라미터 설정 가능(복수개 호출하여 복수개의 파라미터 전달 가능)
		UriComponents uriComponents = UriComponentsBuilder.fromHttpUrl(url)
															.queryParam("user_seq_no", user_seq_no)
															.build();
		
		// 5. REST 방식 요청을 수행하기 위해 RestTemplate 객체 생성
		restTemplate = new RestTemplate();
		
		// 6. RestTemplate 객체의 exchange() 메서드 호출하여 HTTP 요청 수행
		// => 파라미터 : 요청 URL 과 파라미터가 저장된 UriComponents 객체(단, 문자열로 변환 필요), 
		//               요청메서드(HttpMethod.XXX), HttpEntity 객체, 응답데이터 저장 클래스타입(.class 필수)
		// => 리턴타입 : ResponseEntity<T> => 제네릭타입은 exchange() 메서드의 마지막 파라미터인 클래스타입 사용
		ResponseEntity<ResponseUserInfoVO> responseEntity = 
				restTemplate.exchange(uriComponents.toString(), HttpMethod.GET, httpEntity, ResponseUserInfoVO.class);
		logger.info("□□□□□□ 사용자정보조회 ResponseEntity.getBody() : " + responseEntity.getBody());
		
		return responseEntity.getBody();
	}

	// 2.3. 조회서비스(사용자) - 2.3.1. 잔액조회 API - GET
	public BankAccountDetailVO requestAccountDetail(Map<String, String> map) {
		String bank_tran_id = valueGenerator.getBankTranId();
		String tran_dtime = valueGenerator.getTranDTime();
		logger.info("□□□□□□ 은행거래고유번호 bank_tran_id : " + bank_tran_id);
		logger.info("□□□□□□ 요청일시 tran_dtime : " + tran_dtime);
		
		// 잔액조회 요청 API 의 URL 생성 - GET 방식
		String url = baseUrl + "/v2.0/account/balance/fin_num";
		
		// 1. 헤더 설정(org.springframework.http.HttpHeaders 클래스 활용)을 위한 HttpHeaders 객체 생성
		HttpHeaders httpHeaders = new HttpHeaders();
		// 2. 헤더에 정보 추가(Authorization 항목으로 엑세스 토큰 전달("Bearer 엑세스토큰" 형식)
		httpHeaders.add("Authorization", "Bearer " + map.get("access_token"));
		
		// 3. 요청에 사용될 헤더와 파라미터 정보를 갖는 HttpEntity 객체 생성
		// => 단, GET 방식 요청에 바디 없이 헤더만 전달하므로 바디 생략
		// => 제네릭타입 String 타입 지정
		HttpEntity<String> httpEntity = new HttpEntity<String>(httpHeaders);
		
		// 4. 요청에 필요한 파라미터 설정
		UriComponents uriComponents = UriComponentsBuilder.fromHttpUrl(url)
															.queryParam("bank_tran_id", bank_tran_id)
															.queryParam("fintech_use_num", map.get("fintech_use_num"))
															.queryParam("tran_dtime", tran_dtime)
															.build();
		
		// 5. REST 방식 요청을 수행하기 위해 RestTemplate 객체 생성
		restTemplate = new RestTemplate();
		
		// 6. RestTemplate 객체의 exchange() 메서드 호출하여 HTTP 요청 수행
		// => 파라미터 : 요청 URL 과 파라미터가 저장된 UriComponents 객체(단, 문자열로 변환 필요), 
		//               요청메서드(HttpMethod.XXX), HttpEntity 객체, 응답데이터 저장 클래스타입(.class 필수)
		// => 리턴타입 : ResponseEntity<T> => 제네릭타입은 exchange() 메서드의 마지막 파라미터인 클래스타입 사용
		ResponseEntity<BankAccountDetailVO> responseEntity = 
				restTemplate.exchange(uriComponents.toString(), HttpMethod.GET, httpEntity, BankAccountDetailVO.class);
		logger.info("□□□□□□ 잔액조회 ResponseEntity.getBody() : " + responseEntity.getBody());
		
		return responseEntity.getBody();
	}

	
	// ** 0811 배경인 계좌 출금 > 포인트로 전환 입금시 사용
	// 파라미터로 사용할 map 에서 access_token , point_amount 가져옴
	// 2.5. 이체서비스 - 2.5.1. 출금이체 API 요청을 위한 폼 생성(PDF p74)
	public ResponseWithdrawVO requestWithdraw(Map<String, String> map) {
		// 서비스 요청시 보낼 값

		// 유의사항) 현재 테스트를 위한 은행 계좌 임으로 
		// 여러 요청값을 수동으로 사이트에 넣어야함
		// 따라서 지금은 테스트로 지정된 고정된 출금자 이름과 계좌로 출금 수행
		String req_client_name = "배경인";
		String fintech_use_num = "120211385488932375480309";
		String cntr_account_num = "50000009";
		
		// 출금이체 요청 API 의 URL 생성 - POST 방식
		String url = baseUrl + "/v2.0/transfer/withdraw/fin_num";
		
		// 헤더 생성
		// => Content-Type 속성 JSON 형식으로 변경
		HttpHeaders httpHeaders = new HttpHeaders();
//		httpHeaders.add("Authorization", "Bearer " + map.get("access_token"));
//		httpHeaders.add("Content-Type", "application/json; charset=UTF-8"); // JSON 타입 요청 헤더 설정
		
		// 위의 코드와 동일한 작업을 수행하는 또 다른 방법
		httpHeaders.setBearerAuth(map.get("access_token")); // Bearer 토큰 설정
		httpHeaders.setContentType(MediaType.APPLICATION_JSON); // JSON 타입 요청 헤더 설정
		
		// 요청 파라미터를 JSON 형식으로 생성하기 - org.json 패키지 클래스 활용
		JSONObject jo = new JSONObject();
		jo.put("bank_tran_id", valueGenerator.getBankTranId());
		jo.put("cntr_account_type", "N"); // 약정 계좌/계정 구분(N:계좌, C:계정 => N 고정)
		jo.put("cntr_account_num", cntr_account_num); // 약정계좌 계좌번호(테스트데이터 출금계좌 항목에 등록할 계좌번호)
		jo.put("dps_print_content", "슈크림포인트입금"); // 입금계좌 인자내역
//		jo.put("fintech_use_num", map.get("fintech_use_num")); // 출금계좌 핀테크이용번호(전달받은 값)
		jo.put("fintech_use_num", fintech_use_num); // 출금계좌 핀테크이용번호(전달받은 값)
		jo.put("tran_amt", map.get("point_amount")); // 거래금액
		jo.put("tran_dtime", valueGenerator.getTranDTime()); // 거래요청일시
		jo.put("req_client_name", req_client_name); // 거래를 요청한 사용자 이름
//		jo.put("req_client_fintech_use_num", map.get("fintech_use_num")); // 거래를 요청한 사용자 핀테크번호
		jo.put("req_client_fintech_use_num",fintech_use_num); // 거래를 요청한 사용자 핀테크번호
		jo.put("req_client_num", "1"); //  // 거래를 요청한 사용자 번호(아이디처럼 사용되는 번호, 임의부여)
		jo.put("transfer_purpose", "TR"); // 출금(송금)
		// 아래 3개 정보는 피싱 등의 사고 발생 시 지급 정지를 위한 정보(검증 수행하지 않음)
		jo.put("recv_client_name", "슈크림"); // 출금이체 테스트 데이터 등록 시 수취인 성명에 기록할 이름
		jo.put("recv_client_bank_code", "002");
		jo.put("recv_client_account_num", "123123123");
		logger.info("□□□□□□ 출금이체 요청 JSON 데이터 : " + jo.toString());
		
		
		// 3. 요청에 사용될 헤더와 파라미터 정보를 갖는 HttpEntity 객체 생성
		// => 파라미터 데이터로 JSONObject 객체를 문자열로 변환하여 전달 
		HttpEntity<String> httpEntity = new HttpEntity<String>(jo.toString(), httpHeaders);
		
		// 4. POST 요청 시 JSON 데이터를 전송하기 위해 RestTemplate 객체의 postForEntity() 메서드 호출
		// => 리턴타입 : ResponseEntity<T> => 제네릭타입은 리턴되는 데이터를 관리하는 클래스 타입으로 지정
		//               (ResponseWithdrawVO 타입)
		// => 파라미터 : URL, HttpEntity 객체(요청 데이터 포함), 응답데이터 관리 클래스타입
		restTemplate = new RestTemplate();
		ResponseEntity<ResponseWithdrawVO> responseEntity = 
				restTemplate.postForEntity(url, httpEntity, ResponseWithdrawVO.class);
		logger.info("□□□□□□ 출금이체결과 ResponseEntity.getBody() : " + responseEntity.getBody());
		
		return responseEntity.getBody();
	}

	
	// ** 0812 배경인 포인트 출금 > 계좌로 입금 시 사용
	// 포인트 계좌 이체
	// 파라미터로 사용할 map 에서 access_token , point_amount 가져옴
	// 2.5. 이체서비스 - 2.5.2. 입금이체 API 요청을 위한 폼 생성(PDF p83)
	public ResponseDepositVO requestDeposit(Map<String, String> map) {
		// 입금이체 요청 API 의 URL 생성 - POST 방식
		String url = baseUrl + "/v2.0/transfer/deposit/fin_num";
		
		// 유의사항) 현재 테스트를 위한 은행 계좌 임으로 
		// 여러 요청값을 수동으로 사이트에 넣어야함
		// 따라서 지금은 테스트로 지정된 고정된 출금자 이름과 계좌로 출금 수행
		String req_client_name = "배경인";
		String fintech_use_num = "120211385488932375480309";
		String cntr_account_num = "50000009";
				
		
		// 헤더 생성
		// => Content-Type 속성 JSON 형식으로 변경
		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.setBearerAuth(map.get("access_token")); // Bearer 토큰 설정
		httpHeaders.setContentType(MediaType.APPLICATION_JSON); // JSON 타입 요청 헤더 설정
		
		// 1개 입금정보(송금인)를 저장할 JSONObject 객체 생성
		JSONObject joReq = new JSONObject();
		joReq.put("tran_no", "1"); // 거래순번
		joReq.put("bank_tran_id", valueGenerator.getBankTranId());
		joReq.put("fintech_use_num", fintech_use_num); // 입금계좌 핀테크이용번호(전달받은 값)
		joReq.put("print_content", "슈크림포인트계좌이체"); // 입금계좌 인자내역(테스트 데이터 등록)
		joReq.put("tran_amt", map.get("point_amount")); // 거래금액(테스트 데이터 등록)
		joReq.put("req_client_name", "슈크림"); // 거래를 요청한 사용자 이름(송금인)
		joReq.put("req_client_fintech_use_num", fintech_use_num); // 거래를 요청한 사용자 핀테크번호
		joReq.put("req_client_num", "15"); //  // 거래를 요청한 사용자 번호(아이디처럼 사용되는 번호, 임의부여)
		joReq.put("transfer_purpose", "TR"); // 출금(송금)
		
		// 입금 정보를 배열로 관리할 JSONArray 객체 생성
		JSONArray jaReqList = new JSONArray();
		jaReqList.put(joReq);
		
		// 요청 파라미터를 JSON 형식으로 생성하기 - org.json 패키지 클래스 활용
		JSONObject jo = new JSONObject();
		jo.put("cntr_account_type", "N"); // 약정 계좌/계정 구분(N:계좌, C:계정 => N 고정)
		jo.put("cntr_account_num", cntr_account_num); // 약정계좌 계좌번호(테스트데이터 입금계좌 항목에 등록할 계좌번호)
		jo.put("wd_pass_phrase", "NONE"); // 테스트용은 "NONE" 값 고정
		jo.put("wd_print_content", "슈크림포인트계좌이체"); // 출금계좌인자내역
		jo.put("name_check_option", "on"); // 수취인성명 검증 여부(on:검증함) - 생략 시 기본값 on
		jo.put("tran_dtime", valueGenerator.getTranDTime()); // 거래요청일시
		jo.put("req_cnt", "1"); // 입금요청건수("1" 고정)
		jo.put("req_list", jaReqList); // 입금정보목록 - JSONArray 객체
		
		logger.info("□□□□□□ 입금이체 요청 JSON 데이터 : " + jo.toString());
		
		// 3. 요청에 사용될 헤더와 파라미터 정보를 갖는 HttpEntity 객체 생성
		// => 파라미터 데이터로 JSONObject 객체를 문자열로 변환하여 전달 
		HttpEntity<String> httpEntity = new HttpEntity<String>(jo.toString(), httpHeaders);
		// 4. POST 요청 시 JSON 데이터를 전송하기 위해 RestTemplate 객체의 postForEntity() 메서드 호출
		// => 리턴타입 : ResponseEntity<T> => 제네릭타입은 리턴되는 데이터를 관리하는 클래스 타입으로 지정
		//               (ResponseWithdrawVO 타입)
		// => 파라미터 : URL, HttpEntity 객체(요청 데이터 포함), 응답데이터 관리 클래스타입
		restTemplate = new RestTemplate();
		ResponseEntity<ResponseDepositVO> responseEntity = 
				restTemplate.postForEntity(url, httpEntity, ResponseDepositVO.class);
		logger.info("□□□□□□ 입금이체결과 ResponseEntity.getBody() : " + responseEntity.getBody());
		
		return responseEntity.getBody();
	}


}












