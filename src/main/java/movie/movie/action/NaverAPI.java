package movie.movie.action;

	// 네이버 검색 API 예제 - 블로그 검색
	import java.io.*;
	import java.net.HttpURLConnection;
	import java.net.MalformedURLException;
	import java.net.URL;
	import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
	import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import movie.movie.db.NaverAPIDTO;






	public class NaverAPI{
		


	    public NaverAPIDTO getNaverAPI(String movieNm) {
	    	NaverAPIDTO dto = new NaverAPIDTO();
	    	
	        String clientId = "wf1OgFI5wpDsumQh_6Sp"; //애플리케이션 클라이언트 아이디
	        String clientSecret = "kX2ZWirTjW"; //애플리케이션 클라이언트 시크릿
	        String text = null;
	       
	        try {
	            text = URLEncoder.encode(movieNm, "UTF-8");
	        } catch (UnsupportedEncodingException e) {
	            throw new RuntimeException("검색어 인코딩 실패",e);
	        }
	        String apiURL = "https://openapi.naver.com/v1/search/movie.json?query=" + text;    // JSON 결과
	        //String apiURL = "https://openapi.naver.com/v1/search/movie.xml?query="+ text; // XML 결과

	        Map<String, String> requestHeaders = new HashMap<>();
	        requestHeaders.put("X-Naver-Client-Id", clientId);
	        requestHeaders.put("X-Naver-Client-Secret", clientSecret);
	        String responseBody = get(apiURL,requestHeaders);
	        
	        JSONParser parser = new JSONParser();
	        
	        JSONObject obj;
			try {
				obj = (JSONObject)parser.parse(responseBody);
				JSONArray items = (JSONArray)obj.get("items");
				JSONObject jsonObj = (JSONObject)items.get(0);
				
				String userRating = jsonObj.get("userRating").toString();
				String img = jsonObj.get("image").toString();
				
				dto.setImg(img);
				dto.setUserRating(userRating);
				

			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			return dto;
	    }


	    private static String get(String apiUrl, Map<String, String> requestHeaders){
	        HttpURLConnection con = connect(apiUrl);
	        try {
	            con.setRequestMethod("GET");
	            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
	                con.setRequestProperty(header.getKey(), header.getValue());
	            }


	            int responseCode = con.getResponseCode();
	            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
	                return readBody(con.getInputStream());
	            } else { // 오류 발생
	                return readBody(con.getErrorStream());
	            }
	        } catch (IOException e) {
	            throw new RuntimeException("API 요청과 응답 실패", e);
	        } finally {
	            con.disconnect();
	        }
	    }


	    private static HttpURLConnection connect(String apiUrl){
	        try {
	            URL url = new URL(apiUrl);
	            return (HttpURLConnection)url.openConnection();
	        } catch (MalformedURLException e) {
	            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
	        } catch (IOException e) {
	            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
	        }
	    }


	    private static String readBody(InputStream body){
	        InputStreamReader streamReader = new InputStreamReader(body);


	        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
	            StringBuilder responseBody = new StringBuilder();


	            String line;
	            while ((line = lineReader.readLine()) != null) {
	                responseBody.append(line);
	            }


	            return responseBody.toString();
	        } catch (IOException e) {
	            throw new RuntimeException("API 응답을 읽는 데 실패했습니다.", e);
	        }
	    }
	}

