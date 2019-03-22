package kr.or.ddit.login.google;

public class AuthInfoVo {
	 private String clientId;
	    private String clientSecret;
	    
	    public AuthInfoVo(){
	    	
	    }
	    
	    public AuthInfoVo(String clientId, String clientSecret) {
	        this.clientId = clientId;
	        this.clientSecret = clientSecret;
	    }
	 
	 
	    public String getClientId() {
	        return clientId;
	    }
	 
	 
	    public String getClientSecret() {
	        return clientSecret;
	    }
}
