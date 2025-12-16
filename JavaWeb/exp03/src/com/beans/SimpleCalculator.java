package com.beans;

import java.io.Serializable;

public class SimpleCalculator implements Serializable {
    private double first;
    private double second;
    private String operator;
    private double result;
    
    // 无参构造函数
    public SimpleCalculator() {
    }
    
    // 计算方法
    public void calculate() {
        switch (operator) {
            case "+":
                result = first + second;
                break;
            case "-":
                result = first - second;
                break;
            case "*":
                result = first * second;
                break;
            case "/":
                if (second != 0) {
                    result = first / second;
                } else {
                    result = Double.NaN; // 表示除零错误
                }
                break;
            default:
                result = 0;
        }
    }
    
    // getter和setter方法
    public double getFirst() {
        return first;
    }
    
    public void setFirst(double first) {
        this.first = first;
    }
    
    public double getSecond() {
        return second;
    }
    
    public void setSecond(double second) {
        this.second = second;
    }
    
    public String getOperator() {
        return operator;
    }
    
    public void setOperator(String operator) {
        this.operator = operator;
    }
    
    public double getResult() {
        return result;
    }
    
    public void setResult(double result) {
        this.result = result;
    }
}