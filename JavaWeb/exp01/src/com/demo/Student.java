package com.demo;

public class Student {
    // 学号
    private String sno;
    // 姓名
    private String name;
    
    // 无参构造方法
    public Student() {
    }
    
    // 有参构造方法
    public Student(String sno, String name) {
        this.sno = sno;
        this.name = name;
    }
    
    // sno的getter和setter方法
    public String getSno() {
        return sno;
    }
    
    public void setSno(String sno) {
        this.sno = sno;
    }
    
    // name的getter和setter方法
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
}