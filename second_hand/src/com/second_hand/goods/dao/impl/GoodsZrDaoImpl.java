package com.second_hand.goods.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.second_hand.goods.dao.GoodsZrDao;
import com.second_hand.model.GoodsZr;

public class GoodsZrDaoImpl extends HibernateDaoSupport implements
GoodsZrDao {

	//新增商品转让信息
	public boolean add(GoodsZr shGoodsZr) {
		this.getHibernateTemplate().saveOrUpdate(shGoodsZr);
		return true;
	}

	//更新转让信息
	public void update(GoodsZr shGoodsZr) {
		this.getHibernateTemplate().saveOrUpdate(shGoodsZr);
	}

	//分页查询正在出售商品转让信息（首页显示）
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<GoodsZr> findByPage(final int page, final int pageSize,final int cityId) {
		List list = (List) this.getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						// 使用session操作
						String hql;
						//这里考虑用户的定位信息
						if(cityId==1){
							hql = "from GoodsZr g where g.statu = '0' order by g.goodsZrId desc";
						}else{
							hql = "from GoodsZr g where g.statu = '0' and g.user.depart.school.city.cityId="+cityId+" order by g.goodsZrId desc";
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

	//根据关键字分页查询正在出售转让信息
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<GoodsZr> findByKeyword(final int page, final int pageSize, final String keyword,final int cityId) {
		List list = (List) this.getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						// 使用session操作
						String hql ;
						if(cityId==1){
							hql = "from GoodsZr g where g.statu = '0' and g.goodsName like '%"+keyword+"%' order by g.goodsZrId desc";
						}else{
							hql = "from GoodsZr g where g.statu = '0'  and g.user.depart.school.city.cityId="+cityId+" and g.goodsName like '%"+keyword+"%' order by g.goodsZrId desc";
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

	//根据商品类型分页查询正在出售的转让信息
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<GoodsZr> findByGoodsclass(final int page, final int pageSize,
			final String goodsclass,final int cityId) {
		List list = (List) this.getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						// 使用session操作
						String hql ;
						if(cityId==1){
							hql = "from GoodsZr g where g.statu = '0' and g.classes.className = '"+goodsclass+"' order by g.goodsZrId desc";
						}else{
							hql = "from GoodsZr g where g.statu = '0' and g.user.depart.school.city.cityId="+cityId+" and g.classes.className = '"+goodsclass+"' order by g.goodsZrId desc";
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

	//分页查询用户转让信息（根据出售状态statu的不同选择性查询）
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<GoodsZr> findByPageByUser(final int page, final int pageSize, final int userid,final int condition) {
		List list = (List) this.getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						// 使用session操作
						String hql="";
						if(condition==2){
							//正在出售的商品g.statu=0
							System.out.println("conditiona:"+condition);
							hql = "from GoodsZr g where g.statu='0' and g.user.userId = "+userid;
						}else if(condition==3){
							//查询已售出的商品
							System.out.println("conditionb:"+condition);
							hql = "from GoodsZr g where g.statu='2' and g.user.userId = "+userid;
						}else if(condition==4){
							//停售的商品g.statu=1
							System.out.println("conditionc:"+condition);
							hql = "from GoodsZr g where g.statu='1' and g.user.userId = "+userid;
						}else{
							//所有
							System.out.println("conditiond:"+condition);
							hql = "from GoodsZr g where g.user.userId = "+userid;
						}

						Query query = session.createQuery(hql);
						// 设置分页查询参数
						int begin = (page - 1) * pageSize;// 起始点从0开始
						query.setFirstResult(begin);// 设置抓取记录起点索引
						query.setMaxResults(pageSize);// 设置最大抓取数量
						System.out.println("size:"+query.list().size());
						return query.list();
					}
				});
		return list;
	}

	//根据每页大小查询正在出售的商品转让信息的最大页数
	@SuppressWarnings("rawtypes")
	public int countMaxPage(int pageSize,int cityId){
		String hql;
		if(cityId==1){
			hql = "select count(*) from GoodsZr g where g.statu = '0'";
		}else{
			hql = "select count(*) from GoodsZr g where g.statu = '0' and g.user.depart.school.city.cityId="+cityId;
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


	//根据关键字查询正在出售转让信息的最大页数
	@SuppressWarnings("rawtypes")
	public int countMaxPageByKeyword(int pageSize, String keyword,final int cityId) {
		String hql;
		if(cityId==1){
			hql = "select count(*) from GoodsZr g where g.statu = '0'   and g.goodsName like '%"+keyword+"%'";
		}else{
			hql = "select count(*) from GoodsZr g where g.statu = '0'  and g.user.depart.school.city.cityId="+cityId+" and g.goodsName like '%"+keyword+"%'";
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

	//根据商品类型查询正在出售的转让信息的最大页数
	@SuppressWarnings("rawtypes")
	public int countMaxPageByGoodsclass(int pageSize, String goodsclass,final int cityId){
		String hql;
		if(cityId==1){
			hql = "select count(*) from GoodsZr g where g.statu = '0' and g.classes.className = '"+goodsclass+"' order by g.goodsZrId desc";
		}else{
			hql = "select count(*) from GoodsZr g where  g.statu = '0'  and g.user.depart.school.city.cityId="+cityId+" and  g.classes.className = '"+goodsclass+"'";
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

	//根据id查找转让信息
	public GoodsZr findById(int id) {
		// TODO Auto-generated method stub
		return (GoodsZr)this.getHibernateTemplate().get(GoodsZr.class,id);
	}

	//删除转让信息
	public boolean delete(int id) {
		// TODO Auto-generated method stub
		GoodsZr goodsZr;
		try {
			goodsZr = findById(id);
			this.getHibernateTemplate().delete(goodsZr);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	//查询用户转让信息的最大页数（根据出售状态statu的不同选择性查询）
	@SuppressWarnings("rawtypes")
	public int countMaxPageByUser(int pageSize, int userId,int condition) {
		// TODO Auto-generated method stub
		String hql="";
		if(condition==2){
			//正在出售的商品g.statu=0
			hql = "select count(*) from GoodsZr g where g.statu='0' and g.user.userId = "+userId;
		}else if(condition==3){
			//查询售出的商品
			hql = "select count(*) from GoodsZr g where g.statu='2' and g.user.userId = "+userId;
		}else if(condition==4){
			//停售的商品g.statu=1
			hql = "select count(*) from GoodsZr g where g.statu='1' and g.user.userId = "+userId;
		}else{
			//所有
			hql = "select count(*) from GoodsZr g where g.user.userId = "+userId;
		}
		List list = this.getHibernateTemplate().find(hql);

		int totalSize = Integer.parseInt(list.get(0).toString());
		System.out.println("totolsize:"+totalSize);
		// 计算最大页
		if (totalSize % pageSize == 0) {
			return totalSize / pageSize;
		} else {
			return totalSize / pageSize + 1;
		}

	}

	//分页查询用户的更多闲置
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<GoodsZr> findMoreByPageByUser(final int page, final int pageSize, final int userid) {
		// TODO Auto-generated method stub
		List list = (List) this.getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						// 使用session操作
						String hql;
						hql = "from GoodsZr g where g.statu = '0' and g.user.userId = "+userid;
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

	//查询用户更多闲置的最大页数
	@SuppressWarnings("rawtypes")
	public int countMaxPageMoreByUser(int pageSize, int userId) {
		// TODO Auto-generated method stub
		String hql = "select count(*) from GoodsZr g where g.statu = '0' and g.user.userId = "+userId;
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
