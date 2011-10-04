package th.co.vlink.hibernate;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Projections;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import th.co.vlink.hibernate.bean.BpsAttachFile;
import th.co.vlink.hibernate.bean.BpsTerm;
import th.co.vlink.managers.BpsAttachFileService;
import th.co.vlink.utils.Pagging;
@SuppressWarnings("deprecation")
@Repository
@Transactional
public class HibernateBpsAttachFile extends HibernateCommon implements BpsAttachFileService{
	private static final Logger logger = Logger.getLogger("bpsAppender");
	private SessionFactory sessionAnnotationFactory;
	public SessionFactory getSessionAnnotationFactory() {
		return sessionAnnotationFactory;
	}
	public void setSessionAnnotationFactory(SessionFactory sessionAnnotationFactory) {
		this.sessionAnnotationFactory = sessionAnnotationFactory;
	}
	@Transactional(readOnly=true)
	public BpsAttachFile findBpsAttachFileById(Long bpafId)
			throws DataAccessException {
		// TODO Auto-generated method stub
		BpsAttachFile bpsAttachFile = null;
		 Object obj = findById(sessionAnnotationFactory.getCurrentSession(), "th.co.vlink.hibernate.bean.BpsAttachFile", bpafId);
		 if(obj!=null)
			 bpsAttachFile = (BpsAttachFile)obj;
		 return bpsAttachFile;	
	}
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor={RuntimeException.class})
	public Long saveBpsAttachFile(BpsAttachFile transientInstance)
			throws DataAccessException {
		// TODO Auto-generated method stub
		return save(sessionAnnotationFactory.getCurrentSession(), transientInstance);
	}
	@SuppressWarnings("rawtypes")
	@Transactional(readOnly=true)
	public List searchBpsAttachFile(BpsAttachFile persistentInstance)
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
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Transactional(readOnly=true)
	public List searchBpsAttachFile(BpsAttachFile instance, Map likeExpression,
			Map leExpression, Map geExpression) throws DataAccessException {
		ArrayList  transList = new ArrayList ();
		Session session = sessionAnnotationFactory.getCurrentSession();
		try {
			Criteria criteria 	= (Criteria) session.createCriteria(instance.getClass().getName());		 
			Long bpafId = instance.getBpafId();
			String bpafFileName = instance.getBpafFileName();
			String bpafFilePath = instance.getBpafFilePath();
			BpsTerm bpsTerm = instance.getBpsTerm();
			  
			 Pagging pagging 	= instance.getPagging();
			 
			if(bpafId !=null && bpafId > 0){  
				 criteria.add(Expression.eq("bpafId", bpafId));	
				// iscriteria = true;
			}
			 
			if(bpafFileName !=null && bpafFileName.trim().length() > 0){ 
				 criteria.add(Expression.eq("bpafFileName", bpafFileName));	
				 //iscriteria = true;
			} 
			if(bpafFilePath !=null && bpafFilePath.trim().length() > 0){ 
				 criteria.add(Expression.eq("bpafFilePath", bpafFilePath));	
				 //iscriteria = true;
			} 
			if(bpsTerm !=null && bpsTerm.getBptId() != null && bpsTerm.getBptId().intValue()!= 0){ 
				 criteria.add(Expression.eq("bpsTerm.bptId", bpsTerm.getBptId()));	
				 //iscriteria = true;
			} 
			
//				criteria.addOrder(Order.asc("ncStartTime"));
			 
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
	 private int getSize(Session session, BpsAttachFile instance) throws Exception{
			try {
				 
				Criteria criteria 	= (Criteria) session.createCriteria(instance.getClass().getName());		 
				Long bpafId = instance.getBpafId();
				String bpafFileName = instance.getBpafFileName();
				String bpafFilePath = instance.getBpafFilePath();
				BpsTerm bpsTerm = instance.getBpsTerm();
				  
			  
				if(bpafId !=null && bpafId > 0){  
					 criteria.add(Expression.eq("bpafId", bpafId));	
					// iscriteria = true;
				}
				 
				if(bpafFileName !=null && bpafFileName.trim().length() > 0){ 
					 criteria.add(Expression.eq("bpafFileName", bpafFileName));	
					 //iscriteria = true;
				} 
				if(bpafFilePath !=null && bpafFilePath.trim().length() > 0){ 
					 criteria.add(Expression.eq("bpafFilePath", bpafFilePath));	
					 //iscriteria = true;
				} 
				if(bpsTerm !=null && bpsTerm.getBptId() != null && bpsTerm.getBptId().intValue()!= 0){ 
					 criteria.add(Expression.eq("bpsTerm.bptId", bpsTerm.getBptId()));	
					 //iscriteria = true;
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
	public int updateBpsAttachFile(BpsAttachFile transientInstance)
			throws DataAccessException {
		// TODO Auto-generated method stub
		return update(sessionAnnotationFactory.getCurrentSession(), transientInstance);
	}
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor={RuntimeException.class})
	public int deleteBpsAttachFile(BpsAttachFile persistentInstance)
			throws DataAccessException {
		// TODO Auto-generated method stub
		return delete(sessionAnnotationFactory.getCurrentSession(), persistentInstance);
	}

}
