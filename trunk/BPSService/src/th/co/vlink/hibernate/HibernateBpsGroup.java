package th.co.vlink.hibernate;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.LogicalExpression;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.joda.time.DateTime;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import th.co.vlink.hibernate.bean.BpsGroup;
import th.co.vlink.managers.BpsGroupService;
import th.co.vlink.utils.Pagging;

@Repository
@Transactional
public class HibernateBpsGroup extends HibernateCommon implements BpsGroupService{
	private static final Logger logger = Logger.getLogger("BpsLog");
	private SessionFactory sessionAnnotationFactory;
	public SessionFactory getSessionAnnotationFactory() {
		return sessionAnnotationFactory;
	}
	public void setSessionAnnotationFactory(SessionFactory sessionAnnotationFactory) {
		this.sessionAnnotationFactory = sessionAnnotationFactory;
	}
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor={RuntimeException.class})
	public void deleteNtcCalendar(BpsGroup persistentInstance)
			throws DataAccessException {
		// TODO Auto-generated method stub
		delete(sessionAnnotationFactory.getCurrentSession(), persistentInstance);
	}
	@Transactional(readOnly=true)
	public BpsGroup findBpsGroupById(Long bpgId)
			throws DataAccessException {
		// TODO Auto-generated method stub
		BpsGroup bpsGroup = null;
		 Object obj = findById(sessionAnnotationFactory.getCurrentSession(), "th.co.vlink.hibernate.bean.BpsGroup", bpgId);
		 if(obj!=null)
			 bpsGroup = (BpsGroup)obj;
		 return bpsGroup;	
	}
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor={RuntimeException.class})
	public void saveBpsGroup(BpsGroup transientInstance)
			throws DataAccessException {
		// TODO Auto-generated method stub
		save(sessionAnnotationFactory.getCurrentSession(), transientInstance);
	}
	@Transactional(readOnly=true)
	public List searchBpsGroup(BpsGroup persistentInstance)
			throws DataAccessException {
		// TODO Auto-generated method stub
		Session session = null;
		try {
			session = sessionAnnotationFactory.getCurrentSession();
			return search(session,persistentInstance,null,null,null);
		} catch (Exception re) {
			re.printStackTrace();
			logger.error("error in finding  \n", re);
		}
		return null;
	}
	@Transactional(readOnly=true)
	public List searchBpsGroup(BpsGroup instance, Map likeExpression,
			Map leExpression, Map geExpression) throws DataAccessException {
		ArrayList  transList = new ArrayList ();
		Session session = sessionAnnotationFactory.getCurrentSession();
		try {
			Criteria criteria 	= (Criteria) session.createCriteria(instance.getClass().getName());		 
			Long bpgId = instance.getBpgId();
			String bpgGroupName = instance.getBpgGroupName();
			  
			 Pagging pagging 	= instance.getPagging();
			 
			if(bpgGroupName !=null && bpgGroupName.trim().length() > 0){  
				 criteria.add(Expression.eq("bpgGroupName", bpgGroupName));	
				// iscriteria = true;
			}
		 
				criteria.addOrder(Order.asc("bpgGroupName"));
			 
			// set pagging.
			 String size = String.valueOf(getSize(session, instance)); 
			 
			 criteria.setFirstResult(pagging.getPageSize() * (pagging.getPageNo() - 1));
			 criteria.setMaxResults(pagging.getPageSize());
			 List l = criteria.list();  
			 transList.add(l); 
		 	 transList.add(size); 
			return transList;
		} catch (Exception re) {
			//re.printStackTrace();
			logger.error("find by property name failed", re);
			 
		}
		return transList;
	}
	 private int getSize(Session session, BpsGroup instance) throws Exception{
			try {
				 
				Criteria criteria 	= (Criteria) session.createCriteria(instance.getClass().getName());		 
				Long bpgId = instance.getBpgId();
				String bpgGroupName = instance.getBpgGroupName();
				if(bpgGroupName !=null && bpgGroupName.trim().length() > 0){  
					 criteria.add(Expression.eq("bpgGroupName", bpgGroupName));	
					// iscriteria = true;
				} 
				criteria.setProjection(Projections.rowCount()); 
				return ((Integer)criteria.list().get(0)).intValue(); 
			} catch (HibernateException re) {
				logger.error("HibernateException",re);
				throw re;
			} catch (Exception e) {
				logger.error("Exception",e);
				throw e;
			}
		}
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor={RuntimeException.class})
	public void updateBpsGroup(BpsGroup transientInstance)
			throws DataAccessException {
		// TODO Auto-generated method stub
		update(sessionAnnotationFactory.getCurrentSession(), transientInstance);
	}
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor={RuntimeException.class})
	public void deleteBpsGroup(BpsGroup persistentInstance)
			throws DataAccessException {
		// TODO Auto-generated method stub
		delete(sessionAnnotationFactory.getCurrentSession(), persistentInstance);
	}

}