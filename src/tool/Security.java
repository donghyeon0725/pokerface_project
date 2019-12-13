package tool;

import java.io.UnsupportedEncodingException;

import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.Base64.Decoder;
import java.util.Base64.Encoder;

public class Security {
	private SecureRandom RANDOM = null;
	
	
	public static void main(String[] args) {
		//메인은 기능을 테스트 할 때 사용하세요 
		Security sc = new Security();
	}
	
	//객체 생성 할 때 솔트 생성에 필요한 작업을 해둠
	public Security () {
		try {
			RANDOM = SecureRandom.getInstance("SHA1PRNG");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
	}
	
	//해시 SHA256의 방법이다. 해시함수 => 같은 값이 들어가면 같은 값을 반환함 원래 비밀번호가 뭔지는 알 수 없고 다만 같은 비밀번호였는지는 알 수 있음
	public String SHA256(String str){
		String SHA = ""; 
		try{
			MessageDigest sh = MessageDigest.getInstance("SHA-256"); 
			sh.update(str.getBytes()); 
			byte byteData[] = sh.digest();
			StringBuffer sb = new StringBuffer(); 
			for(int i = 0 ; i < byteData.length ; i++){
				sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
			}
			SHA = sb.toString();
		}catch(NoSuchAlgorithmException e){
			e.printStackTrace(); 
			SHA = null; 
		}
		return SHA;
	}
	
	//솔트값 생성
	public String salt() {
		int num = (int)(Math.random() * 100) + 1;
		byte[] salt = new byte[32];
		for(int i = 0; i<num; i++ ) {
			RANDOM.setSeed(salt);
			RANDOM.nextBytes(salt);
		}
		int salyNum = ByteBuffer.wrap(salt).getInt();
		
		return salyNum + "";
	}
	
	
	//자바 기본 클래스 통한 인코딩의 방법
	public String encodeBase64(String originalString) {
		if(originalString == null) {
			return null;
		}
		int temp = originalString.getBytes().length;
		if(temp < 2) {
			return originalString;
		} else  {
			try {
				return Base64.getEncoder().encodeToString(originalString.getBytes("UTF-8"));
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}
	}
	
	//자바 기본 클래스 통한 디코딩의 방법
	public String decodeBase64(String encodedString) {
		if(encodedString == null) {
			return null;
		}
		int temp = encodedString.getBytes().length;
		if(temp < 2) {
			return encodedString;
		} else {
			try {
				return new String(Base64.getDecoder().decode(encodedString), "UTF-8");
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		} 
	}
	
	//솔트와 비번을 이용해서 보안하기 => 약속 된 방법으로 비밀번호와 소금값을 붙여서 해시함수화 함
	//비밀번호를 암호화 할땐 이 함수를 사용한 뒤에 encodeBase64를 사용하면 된다.
	public String SHAValue (String password, String salt) {
		String  result = null;
		if(salt == null || salt.equals("")) {
			result = SHA256(salt() + password );
		} else {
			result = SHA256(salt + password );
		}
		return result;
	}
}
