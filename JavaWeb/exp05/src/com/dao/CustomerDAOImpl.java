package com.dao;

import com.beans.CustomerBean;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAOImpl implements CustomerDAO {
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String URL = "jdbc:mysql://localhost:3306/test?serverTimezone=Asia/Shanghai";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "yourPassword";

    static {
        try {
            Class.forName(DRIVER);
        } catch (ClassNotFoundException e) {
            throw new ExceptionInInitializerError(e);
        }
    }

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }

    @Override
    public List<CustomerBean> getAllCustomers() {
        List<CustomerBean> customers = new ArrayList<>();
        String sql = "SELECT custName, email, phone FROM customer";
        
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                CustomerBean customer = new CustomerBean();
                customer.setCustName(rs.getString("custName"));
                customer.setEmail(rs.getString("email"));
                customer.setPhone(rs.getString("phone"));
                customers.add(customer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return customers;
    }

    @Override
    public CustomerBean getCustomerByEmail(String email) {
        String sql = "SELECT custName, email, phone FROM customer WHERE email = ?";
        CustomerBean customer = null;
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    customer = new CustomerBean();
                    customer.setCustName(rs.getString("custName"));
                    customer.setEmail(rs.getString("email"));
                    customer.setPhone(rs.getString("phone"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return customer;
    }

    @Override
    public boolean insertCustomer(CustomerBean customer) {
        // 检查邮箱是否已存在
        if (getCustomerByEmail(customer.getEmail()) != null) {
            System.err.println("插入失败：邮箱已存在 - " + customer.getEmail());
            return false;
        }
        
        String sql = "INSERT INTO customer (custName, email, phone) VALUES (?, ?, ?)";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, customer.getCustName());
            pstmt.setString(2, customer.getEmail());
            pstmt.setString(3, customer.getPhone());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("插入客户信息失败:");
            System.err.println("SQL: " + sql);
            System.err.println("参数: " + customer.getCustName() + ", " +
                               customer.getEmail() + ", " + customer.getPhone());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateCustomer(CustomerBean customer) {
        String sql = "UPDATE customer SET custName = ?, phone = ? WHERE email = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, customer.getCustName());
            pstmt.setString(2, customer.getPhone());
            pstmt.setString(3, customer.getEmail());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteCustomer(String email) {
        String sql = "DELETE FROM customer WHERE email = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}