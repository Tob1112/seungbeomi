package com.leinbow.domain;

public class LoginInfo {

    private String j_username;
    private String j_password;
    private boolean authFail;
    private String usernameErrorMsgKey;
    private String passwordErrorMsgKey;
    private String authenticationFailMsgKey;

    public String getJ_username() {
        return j_username;
    }
    public void setJ_username(String j_username) {
        this.j_username = j_username;
    }
    public String getJ_password() {
        return j_password;
    }
    public void setJ_password(String j_password) {
        this.j_password = j_password;
    }
    public String getUsernameErrorMsgKey() {
        return usernameErrorMsgKey;
    }
    public void setUsernameErrorMsgKey(String usernameErrorMsgKey) {
        this.usernameErrorMsgKey = usernameErrorMsgKey;
        this.authFail = true;
    }
    public String getPasswordErrorMsgKey() {
        return passwordErrorMsgKey;
    }
    public void setPasswordErrorMsgKey(String passwordErrorMsgKey) {
        this.passwordErrorMsgKey = passwordErrorMsgKey;
        this.authFail = true;
    }
    public String getAuthenticationFailMsgKey() {
        return authenticationFailMsgKey;
    }
    public void setAuthenticationFailMsgKey(String authenticationFailMsgKey) {
        this.authenticationFailMsgKey = authenticationFailMsgKey;
        this.authFail = true;
    }
    public boolean isAuthFail() {
        return authFail;
    }


}
