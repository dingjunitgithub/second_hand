package com.second_hand.sell.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.second_hand.model.OrderInfo;
import com.second_hand.sell.dao.GoodsOrderDao;

public class GoodsOrderDaoImpl extends HibernateDaoSupport implements
GoodsOrderDao {

	//新增订单
	public boolean add(OrderInfo order) {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().save(order);

		return true;
	}

	//根据订单编号查询订单信息
	public OrderInfo findById(int id) {
		// TODO Auto-generated method stub
		return (OrderInfo)this.getHibernateTemplate().get(OrderInfo.class,id);
	}

	//根据订单编号删除订单信息
	public boolean delete(int id) {
		// TODO Auto-generated method stub
		OrderInfo order;
		try {
			order = findById(id);
			this.getHibernateTemplate().delete(order);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	//分页查询用户售出订单
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<OrderInfo> findByPageSale(final int page,final  int pageSize,final  int userId,final int condition) {
		// TODO Auto-generated method stub
		List list = (List) this.getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						// 使用session操作
						String hql="";
						if(condition==0){
							//待发货处理statu=0
							hql = "from OrderInfo o where o.saleStatu=0 and o.statu='0' and o.goodsZr.user.userId = "+userId+"order by o.orderId desc";
						}else if(condition==1){
							//已发货处理，待买家收货
							hql = "from OrderInfo o where o.saleStatu=0 and o.statu='1' and o.goodsZr.user.userId = "+userId+"order by o.orderId desc";
						}else if(condition==2){
							//货款已到，待买家评价
							hql = "from OrderInfo o where o.saleStatu=0 and o.statu='2' and o.goodsZr.user.userId = "+userId+"order by o.orderId desc";
						}else if(condition==3){
							//交易完成的订单
							hql = "from OrderInfo o where o.saleStatu=0 and o.statu='3' and o.goodsZr.user.userId = "+userId+"order by o.orderId desc";
						}else{
							//所有
							hql = "from OrderInfo o where o.saleStatu=0 and o.goodsZr.user.userId = "+userId+"order by o.orderId desc";
						}

						Query query = session.createQuery(hql);
						// 设置分页查询参数
						int begin = (page - 1) * pageSize;// 起始点从0开始
						query.setFirstResult(begin);// 设置抓取记录起点索引
						query.setMaxResults(pageSize);// 设置最大抓取数量
						return query.list();
					}
				});
		return list;
	}

	//查询用户售出的订单最大页数
	@SuppressWarnings("rawtypes")
	public int countMaxPageSale(int pageSize, int userId,int condition){
		// TODO Auto-generated method stub
		String hql="";
		if(condition==0){
			//待发货处理statu=0
			hql = "select count(*) from OrderInfo o where o.saleStatu=0 and o.statu='0' and o.goodsZr.user.userId = "+userId;
		}else if(condition==1){
			//已发货处理，待买家收货
			hql = "select count(*) from OrderInfo o where o.saleStatu=0 and o.statu='1' and o.goodsZr.user.userId = "+userId;
		}else if(condition==2){
			//货款已到，待买家评价
			hql = "select count(*) from OrderInfo o where o.saleStatu=0 and o.statu='2' and o.goodsZr.user.userId = "+userId;
		}else if(condition==3){
			//交易完成的订单
			hql = "select count(*) from OrderInfo o where o.saleStatu=0 and o.statu='3' and o.goodsZr.user.userId = "+userId;
		}else{
			//所有
			hql = "select count(*) from OrderInfo o where o.saleStatu=0 and o.goodsZr.user.userId = "+userId;
		}

		List list = this.getHibernateTemplate().find(hql);
		int totalSize = Integer.parseInt(list.get(0).toString());
		// 计算最大页
		if (totalSize % pageSize == 0) {
			return totalSize / pageSize;
		} else {
			return totalSize / pageSize + 1;
		}
	}

	//修改订单状态
	public void updateStatu(OrderInfo order) {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().update(order);
	}

	//评价
	public boolean evaluate(OrderInfo order) {
		// TODO Auto-generated method stub
		try {
			this.getHibernateTemplate().update(order);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	//删除评价
	public void deleteEvaluate(OrderInfo order) {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().update(order);
	}

	//评价管理
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<OrderInfo> findEvaluateNotNullByPage(final int page, final int pageSize) {
		// TODO Auto-generated method stub
		List list = (List) this.getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						// 使用session操作
						String hql = "from OrderInfo o where  o.evaluate is not null order by o.orderId desc";
						Query query = session.createQuery(hql);
						// 设置分页查询参数
						int begin = (page - 1) * pageSize;// 起始点从0开始
						query.setFirstResult(begin);// 设置抓取记录起点索引
						query.setMaxResults(pageSize);// 设置最大抓取数量
						return query.list();
					}
				});
		return list;
	}

	//查询评价的最大页数
	@SuppressWarnings("rawtypes")
	public int countMaxPageByEvaluate(int pageSize) {
		// TODO Auto-generated method stub
		String hql = "select count(*) from OrderInfo o where  o.evaluate is not null order by o.orderId desc";
		List list = this.getHibernateTemplate().find(hql);
		int totalSize = Integer.parseInt(list.get(0).toString());
		// 计算最大页
		if (totalSize % pageSize == 0) {
			return totalSize / pageSize;
		} else {
			return totalSize / pageSize + 1;
		}
	}

	//不分页查询用户已售出商品评价信息
	@SuppressWarnings("unchecked")
	public List<OrderInfo> findEvaluateNotNullByUser(int userId) {
		// TODO Auto-generated method stub
		String hql = "from OrderInfo o where o.goodsZr.user.userId = "+userId+"and  o.evaluate is not null order by o.orderId desc";
		List<OrderInfo> list = this.getHibernateTemplate().find(hql);
		return list;
	}

	//查询用户购买的订单的最大页数
	@SuppressWarnings("rawtypes")
	public int countMaxPageBuy(int pageSize, int userId,int condition) {
		// TODO Auto-generated method stub
		String hql="";
		if(condition==0){
			//待发货处理statu=0
			hql = "select count(*) from OrderInfo o where  o.buyStatu=0 and o.statu='0' and o.user.userId = "+userId+"order by o.orderId desc";;
		}else if(condition==1){
			//已发货处理，待收货
			hql = "select count(*) from OrderInfo o where  o.buyStatu=0 and o.statu='1' and o.user.userId = "+userId+"order by o.orderId desc";;
		}else if(condition==2){
			//待评价
			hql = "select count(*) from OrderInfo o where  o.buyStatu=0 and o.statu='2' and o.user.userId = "+userId+"order by o.orderId desc";;
		}else if(condition==3){
			//交易完成的订单
			hql = "select count(*) from OrderInfo o where o.buyStatu=0 and o.statu='3' and o.user.userId = "+userId+"order by o.orderId desc";;
		}else{
			//所有
			hql = "select count(*) from OrderInfo o where o.buyStatu=0 and o.user.userId= "+userId+"order by o.orderId desc";
		}

		List list = this.getHibernateTemplate().find(hql);
		int totalSize = Integer.parseInt(list.get(0).toString());
		// 计算最大页
		if (totalSize % pageSize == 0) {
			return totalSize / pageSize;
		} else {
			return totalSize / pageSize + 1;
		}
	}


	//分页查询用户购买的订单
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<OrderInfo> findByPageBuy(final int page, final int pageSize, final int userId,final int condition) {
		// TODO Auto-generated method stub
		List list = (List) this.getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						// 使用session操作
						String hql="";
						if(condition==0){
							//待发货处理statu=0
							System.out.println("aaaaac"+condition);
							hql = "from OrderInfo o where o.buyStatu=0 and o.statu = '0' and o.user.userId= "+userId+"order by o.orderId desc";
						}else if(condition==1){
							//已发货处理，待收货
							hql = "from OrderInfo o where o.buyStatu=0 and o.statu = '1' and o.user.userId= "+userId+"order by o.orderId desc";
						}else if(condition==2){
							//待评价
							hql = "from OrderInfo o where o.buyStatu=0 and o.statu = '2' and o.user.userId= "+userId+"order by o.orderId desc";
						}else if(condition==3){
							//交易完成的订单
							hql = "from OrderInfo o where o.buyStatu=0 and o.statu = '3' and o.user.userId = "+userId+"order by o.orderId desc";
						}else{
							//所有
							hql = "from OrderInfo o where o.buyStatu=0  and o.user.userId= "+userId+"order by o.orderId desc";
						}
						System.out.println("hql:"+hql);
						Query query = session.createQuery(hql);
						// 设置分页查询参数
						int begin = (page - 1) * pageSize;// 起始点从0开始
						query.setFirstResult(begin);// 设置抓取记录起点索引
						query.setMaxResults(pageSize);// 设置最大抓取数量
						System.out.println("size"+query.list().size());
						return query.list();

					}
				});
		return list;
	}

	//查询卖家待发货数量
	@SuppressWarnings("rawtypes")
	public int countWaitSend(int userId) {
		// TODO Auto-generated method stub
		String hql = "select count(*) from OrderInfo o where o.saleStatu=0 and o.statu='0' and o.goodsZr.user.userId = "+userId+"order by o.orderId desc";
		List list = this.getHibernateTemplate().find(hql);
		return Integer.parseInt(list.get(0).toString());
	}

	//查询买家待收货数量
	@SuppressWarnings("rawtypes")
	public int countWaitReceive(int userId) {
		// TODO Auto-generated method stub
		String hql = "select count(*) from OrderInfo o where o.buyStatu=0 and o.statu = '1' and o.user.userId= "+userId+"order by o.orderId desc";
		List list = this.getHibernateTemplate().find(hql);
		return Integer.parseInt(list.get(0).toString());
	}

	//查询买家待评价数量
	@SuppressWarnings("rawtypes")
	public int countWaitEvaluate(int userId) {
		// TODO Auto-generated method stub
		String hql = "select count(*) from OrderInfo o where o.buyStatu=0 and o.statu = '2' and o.user.userId= "+userId+"order by o.orderId desc";
		List list = this.getHibernateTemplate().find(hql);
		return Integer.parseInt(list.get(0).toString());
	}

	//查询买家待发货数量
	@SuppressWarnings("rawtypes")
	public int countWaitSendToBuy(int userId) {
		// TODO Auto-generated method stub
		String hql = "select count(*) from OrderInfo o where o.buyStatu=0 and o.statu = '0' and o.user.userId= "+userId+"order by o.orderId desc";
		List list = this.getHibernateTemplate().find(hql);
		return Integer.parseInt(list.get(0).toString());
	}

	//分页查询用户已卖出商品反馈（重载）
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<OrderInfo> findEvaluateNotNullByUser(final int userId, final int page,
			final int pageSize) {
		// TODO Auto-generated method stub
		List list = (List) this.getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						// 使用session操作
						String hql = "from OrderInfo o where o.goodsZr.user.userId = "+userId+"and  o.evaluate is not null order by o.orderId desc";;
						Query query = session.createQuery(hql);
						// 设置分页查询参数
						int begin = (page - 1) * pageSize;// 起始点从0开始
						query.setFirstResult(begin);// 设置抓取记录起点索引
						query.setMaxResults(pageSize);// 设置最大抓取数量
						System.out.println("size"+query.list().size());
						return query.list();

					}
				});
		return list;
	}

	//查询用户售出商品评价反馈的最大页数
	@SuppressWarnings("rawtypes")
	public int countMaxPageByEvaluateByUser(int userId,int pageSize) {
		// TODO Auto-generated method stub
		String hql = "select count(*) from OrderInfo o where o.goodsZr.user.userId = "+userId+"and  o.evaluate is not null order by o.orderId desc";;
		List list = this.getHibernateTemplate().find(hql);
		int totalSize = Integer.parseInt(list.get(0).toString());
		// 计算最大页
		if (totalSize % pageSize == 0) {
			return totalSize / pageSize;
		} else {
			return totalSize / pageSize + 1;
		}
	}



}
