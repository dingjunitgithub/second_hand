package com.second_hand.sell.service;

import java.util.List;

import com.second_hand.model.OrderInfo;

public interface GoodsOrderService {


	//新增
	public boolean add(OrderInfo order);
	//根据id查找
	public OrderInfo findById(int id);
	//用户订单删除，相当于重置属性
	public void delete(int id,int statu);
	//分页查询用户售出的订单
	public List<OrderInfo> findByPageSale(final int page, final int pageSize,final int userId,int condition);
	//查询用户售出的订单最大页数
	public int countMaxPageSale(int pageSize,int userId,int condition) throws Exception;
	//修改订单状态
	public void updateStatu(int id,String statu);
	//评价
	public boolean evaluate(int orderId,String evaluate);
	//删除评价
	public void deleteEvaluate(int orderId);
	//评价管理
	public List<OrderInfo> findEvaluateNotNullByPage(final int page, final int pageSize);
	//查询评价管理的最大页数
	public int countMaxPageByEvaluate(int pageSize);
	//不分页查询用户已卖出商品反馈（div）
	public List<OrderInfo> findEvaluateNotNullByUser(int userId);
	//分页查询用户已卖出商品反馈（重载）
	public List<OrderInfo> findEvaluateNotNullByUser(int userId,final int page, final int pageSize);
	//查询用户已卖出商品反馈的最大页数
	public int countMaxPageByEvaluateByUser(int userId,int pageSize);
	//查询用户购买的订单的最大页数
	public int countMaxPageBuy(int pageSize,int userId,int condition);
	//分页查询用户购买的订单
	public List<OrderInfo> findByPageBuy(final int page, final int pageSize,final int userId,int condition);
	//计算卖家待处理订单
	public int countWaitSend(int userId);
	//查询买家待收货数量
	public int countWaitReceive(int userId);
	//查询买家待评价数量
	public int countWaitEvaluate(int userId);
	//查询买家待发货数量
	public int countWaitSendToBuy(int userId);
}
