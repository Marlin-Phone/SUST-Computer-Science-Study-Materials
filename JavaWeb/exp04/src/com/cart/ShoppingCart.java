package com.cart;

import java.util.*;

public class ShoppingCart {
    private List<GoodsItem> items = new ArrayList<>();
    
    // 添加商品
    public void add(GoodsItem item) {
        // 检查购物车中是否已存在该商品
        for (GoodsItem existingItem : items) {
            if (existingItem.getId() == item.getId()) {
                // 如果存在，增加数量
                existingItem.setQuantity(existingItem.getQuantity() + item.getQuantity());
                return;
            }
        }
        // 如果不存在，添加新商品
        items.add(item);
    }
    
    // 更新商品数量
    public void update(GoodsItem item) {
        for (GoodsItem existingItem : items) {
            if (existingItem.getId() == item.getId()) {
                // 更新商品数量
                existingItem.setQuantity(item.getQuantity());
                return;
            }
        }
    }
    
    // 删除商品
    public void remove(int id) {
        items.removeIf(cartItem -> cartItem.getId() == id);
    }
    
    // 获取所有商品
    public List<GoodsItem> getItems() {
        return items;
    }
    
    // 计算总金额
    public double getTotal() {
        return items.stream().mapToDouble(cartItem -> cartItem.getPrice() * cartItem.getQuantity()).sum();
    }
}