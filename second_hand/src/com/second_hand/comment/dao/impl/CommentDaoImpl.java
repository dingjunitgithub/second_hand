package com.second_hand.comment.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.second_hand.comment.dao.CommentDao;
import com.second_hand.model.Comment;

public class CommentDaoImpl extends HibernateDaoSupport implements CommentDao {

	//新增留言信息
	public boolean add(Comment comments) {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(comments);
		return true;
	}

	//根据商品Id查找留言
	@SuppressWarnings("unchecked")
	public List<Comment> findByGoodsId(int goodsid) {
		// TODO Auto-generated method stub
		String hql = "from Comment c where c.goodsZr.goodsZrId = "+goodsid+"and c.autoType=0 order by c.comId";
		List<Comment> list = this.getHibernateTemplate().find(hql);
		return list;
	}

	//删除留言
	public boolean delete(int id) {
		// TODO Auto-generated method stub
		Comment comment;
		try {
			comment = findById(id);
			this.getHibernateTemplate().delete(comment);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	//根据留言编号查询留言信息
	public Comment findById(int id) {
		// TODO Auto-generated method stub
		return (Comment)this.getHibernateTemplate().get(Comment.class,id);
	}
	
	//查询所有留言信息
	@SuppressWarnings("unchecked")
	public List<Comment> findAllComment() {
		// TODO Auto-generated method stub
		String hql = "from Comment";
		List<Comment> list = this.getHibernateTemplate().find(hql);
		return list;
	}

	//分页查找我的留言信息
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<Comment> findByPage(final int page, final int pageSize, final int userId) {
		// TODO Auto-generated method stub
		List list = (List) this.getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						// 使用session操作
						String hql = "from Comment c where c.user.userId = "+userId+"";
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

	//查询我的留言总条数，用于分页
	@SuppressWarnings("rawtypes")
	public int countMaxPage(int pageSize, int userId) throws Exception {
		// TODO Auto-generated method stub
		String hql = "select count(*) from Comment c where c.user.userId = "+userId;
		List list = this.getHibernateTemplate().find(hql);
		int totalSize = Integer.parseInt(list.get(0).toString());
		// 计算最大页
		if (totalSize % pageSize == 0) {
			return totalSize / pageSize;
		} else {
			return totalSize / pageSize + 1;
		}
	}

	//分页查询给我的留言且已回复的留言
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<Comment> findAllCommentByPageToMeYes(final int page, final int pageSize,
			final int userId) {
		// TODO Auto-generated method stub
		List list = (List) this.getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						// 使用session操作
						String hql = "from Comment c where c.toUser.userId = "+userId+"and c.revertSta=1";
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

	//查询给我的留言且已回复的留言总条数
	@SuppressWarnings("rawtypes")
	public int countMaxPageToMeYes(int pageSize, int userId)
			throws Exception {
		// TODO Auto-generated method stub
		String hql = "select count(*) from Comment c where c.toUser.userId= "+userId+"and c.revertSta=1";
		List list = this.getHibernateTemplate().find(hql);
		int totalSize = Integer.parseInt(list.get(0).toString());
		// 计算最大页
		if (totalSize % pageSize == 0) {
			return totalSize / pageSize;
		} else {
			return totalSize / pageSize + 1;
		}
	}

	//分页查询留言
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<Comment> findAllCommentByPage(final int page, final int pageSize) {
		// TODO Auto-generated method stub
		List list = (List) this.getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						// 使用session操作
						String hql = "from Comment";
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

	//查询总留言条数
	@SuppressWarnings("rawtypes")
	public int countMaxPageByAllComment(int pageSize) throws Exception {
		// TODO Auto-generated method stub
		String hql = "select count(*) from Comment";
		List list = this.getHibernateTemplate().find(hql);
		int totalSize = Integer.parseInt(list.get(0).toString());
		// 计算最大页
		if (totalSize % pageSize == 0) {
			return totalSize / pageSize;
		} else {
			return totalSize / pageSize + 1;
		}
	}

	//更新留言信息
	public Comment update(Comment comment) {
		// TODO Auto-generated method stub
		try {
			this.getHibernateTemplate().update(comment);
			return comment;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	//分页查询给我的留言但未回复的留言
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<Comment> findAllCommentByPageToMeNo(final int page, final int pageSize,
			final int userId) {
		// TODO Auto-generated method stub
		List list = (List) this.getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						// 使用session操作
						String hql = "from Comment c where c.toUser.userId = "+userId+"and c.revertSta=0";
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

	//查询给我的留言但未回复的总条数
	@SuppressWarnings("rawtypes")
	public int countMaxPageToMeNo(int pageSize, int userId) throws Exception {
		// TODO Auto-generated method stub
		String hql = "select count(*) from Comment c where c.toUser.userId= "+userId+"and c.revertSta=0";
		List list = this.getHibernateTemplate().find(hql);
		int totalSize = Integer.parseInt(list.get(0).toString());
		// 计算最大页
		if (totalSize % pageSize == 0) {
			return totalSize / pageSize;
		} else {
			return totalSize / pageSize + 1;
		}
	}

	//根据留言Id查询所有关于其的回复
	@SuppressWarnings("unchecked")
	public List<Comment> findAllRevert(int comId) {
		// TODO Auto-generated method stub
		String hql = "from Comment c where c.oldComId = "+comId+"";
		List<Comment> list = this.getHibernateTemplate().find(hql);
		return list;
	}

	//查询用户待回复的留言条数
	@SuppressWarnings("rawtypes")
	public int countWaitRevert(int userId) {
		// TODO Auto-generated method stub
		String hql = "from Comment c where c.toUser.userId= "+userId+"and c.revertSta=0";
		List list = this.getHibernateTemplate().find(hql);
		return list.size();
	}

	//查询某商品的系统自动提示，便于商品发货后删除
	@SuppressWarnings("unchecked")
	public List<Comment> findCommentByGoodsZrIdAndAuto(int goodsZrId) {
		// TODO Auto-generated method stub
		//c.autoType=1 说明是系统的自动提示
		String hql = "from Comment c where c.autoType=1 and c.goodsZr.goodsZrId = "+goodsZrId+"";
		List<Comment> list = this.getHibernateTemplate().find(hql);
		return list;
	}

}
