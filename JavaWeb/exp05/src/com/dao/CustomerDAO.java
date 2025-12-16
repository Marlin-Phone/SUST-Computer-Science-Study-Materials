package com.dao;

import com.beans.CustomerBean;
import java.util.List;

public interface CustomerDAO {
    List<CustomerBean> getAllCustomers();
    CustomerBean getCustomerByEmail(String email);
    boolean insertCustomer(CustomerBean customer);
    boolean updateCustomer(CustomerBean customer);
    boolean deleteCustomer(String email);
}