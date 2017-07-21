package com.second_hand.sell.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.second_hand.model.Cart;
import com.second_hand.sell.dao.ShopCarDao;

public class ShopCarDaoImpl extends HibernateDaoSupport implements ShopCarDao {

	//添加购物车
	public boolean add(Cart cart) {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(cart);
		return true;
	}

	//根据编号查询
	public Cart findById(int id) {
		// TODO Auto-generated method stub
		return (Cart)this.getHibernateTemplate().get(Cart.class,id);
	}

	//根据商品编号查询
	@SuppressWarnings("unchecked")
	public Cart findByGoodsId(int id) {
		// TODO Auto-generated method stub
		String hql = "from Cart c where c.goodsZr.goodsZrId= "+id;
		List<Cart> list = this.getHibernateTemplate().find(hql);
		return (list != null && list.size() > 0) ? list.get(0) : null;
		
	}

	//根据Id删除
	public boolean delete(int id) {
		// TODO Auto-generated method stub
		Cart cart;
		try {
			cart = findById(id);
			this.getHibernateTemplate().delete(cart);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	//根据商品编号删除
	public boolean deleteByGoodsId(int goodsId) {
		// TODO Auto-generated method stub
		Cart cart;
		try {
			cart = findByGoodsId(goodsId);
			this.getHibernateTemplate().delete(cart);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	//查询购物车最大页数
	@SuppressWarnings("rawtypes")
	public int countMaxPage(int pageSize, int userId) {
		// TODO Auto-generated method stub
		String hql = "select count(*) from Cart c where  c.goodsZr.statu='0' and  c.user.userId = "+userId;
		List list = this.getHibernateTemplate().find(hql);
		int totalSize = Integer.parseInt(list.get(0).toString());
		// 计算最大页
		if (totalSize % pageSize == 0) {
			return totalSize / pageSize;
		} else {
			return totalSize / pageSize + 1;
		}
	}

	//根据商品和用户编号删除
	public boolean deleteByGoodsIdAndUserId(Cart cart) {
		// TODO Auto-generated method stub
		try {
			this.getHibernateTemplate().delete(cart);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	//根据商品编号和用户编号查找
	@SuppressWarnings("unchecked")
	public Cart findByGoodsIdAndUserId(int goodsId, int userId) {
		// TODO Auto-generated method stub
		String hql = "from Cart c where c.goodsZr.goodsZrId= "+goodsId+"and c.user.userId="+userId;
		List<Cart> list = this.getHibernateTemplate().find(hql);
		return (list != null && list.size() > 0) ? list.get(0) : null;
	}

	//分页查询用户购物车信息
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<Cart> findByPage(final int page, final int pageSize, final int userId) {
		// TODO Auto-generated method stub
		List list = (List) this.getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						// 使用session操作
						String hql = "from Cart c where c.goodsZr.statu='0' and c.user.userId = "+userId;
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

	//查询用户购物车数量
	@SuppressWarnings("rawtypes")
	public int recordCount(int userId) {
		// TODO Auto-generated method stub
		String hql = "select count(*) from Cart c where  c.goodsZr.statu='0' and  c.user.userId = "+userId;
		List list = this.getHibernateTemplate().find(hql);
		int totalSize = Integer.parseInt(list.get(0).toString());
		return totalSize;
	}

}
