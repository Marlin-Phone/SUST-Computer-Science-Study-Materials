package com.beans;

import java.io.Serializable;

public class UserBean implements Serializable {
    private String username;
    private String password;
    private String email;
    
    // 无参构造函数
    public UserBean() {
    }
    
    // getter和setter方法
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
}