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
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Projections;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import th.co.vlink.hibernate.bean.BpsTerm;
import th.co.vlink.hibernate.bean.BpsTermVersion;
import th.co.vlink.managers.BpsTermVersionService;
import th.co.vlink.utils.Pagging;
@SuppressWarnings("deprecation")
@Repository
@Transactional
public class HibernateBpsTermVersion extends HibernateCommon implements BpsTermVersionService {
	private static final Logger logger = Logger.getLogger("bpsAppender");
	private SessionFactory sessionAnnotationFactory;
	public SessionFactory getSessionAnnotationFactory() {
		return sessionAnnotationFactory;
	}
	public void setSessionAnnotationFactory(SessionFactory sessionAnnotationFactory) {
		this.sessionAnnotationFactory = sessionAnnotationFactory;
	}
	@Transactional(readOnly=true)
	public BpsTermVersion findBpsTermVersionById(Long bptId)
			throws DataAccessException {
		// TODO Auto-generated method stub
		BpsTermVersion bpsTerm = null;
		 Object obj = findById(sessionAnnotationFactory.getCurrentSession(), "th.co.vlink.hibernate.bean.BpsTermVersion", bptId);
		 if(obj!=null)
			 bpsTerm = (BpsTermVersion)obj;
		 return bpsTerm;	
	}
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor={RuntimeException.class})
	public void saveBpsTermVersion(BpsTermVersion transientInstance)
			throws DataAccessException {
		// TODO Auto-generated method stub
		save(sessionAnnotationFactory.getCurrentSession(), transientInstance);
	}
	@SuppressWarnings("rawtypes")
	@Transactional(readOnly=true)
	public List searchBpsTermVersion(BpsTermVersion persistentInstance)
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
	@SuppressWarnings({ "rawtypes",  "unchecked" })
	@Transactional(readOnly=true)
	public List searchBpsTermVersion(BpsTermVersion instance, Map likeExpression,
			Map leExpression, Map geExpression) throws DataAccessException {
		ArrayList  transList = new ArrayList ();
		Session session = sessionAnnotationFactory.getCurrentSession();
		try {
			Criteria criteria 	= (Criteria) session.createCriteria(instance.getClass().getName());		 
			Long bptvId = instance.getBptvId();
			String bptCreatBy = instance.getBptCreateBy();
			String bptDefinition = instance.getBptDefinition();
			String bptIndexChar = instance.getBptIndexChar();
			String bptShortDesc =instance.getBptShortDesc();
			String bptSource = instance.getBptSource();
			String bptSourceRef = instance.getBptSourceRef();
			BpsTerm bpsTerm = instance.getBpsTerm();
			//BpsGroup bpsGroup = instance.getBpsGroup();
			Timestamp bptCreateDate =instance.getBptCreateDate();			
			Integer bptVersionNumber =instance.getBptVersionNumber();
			  
			Pagging pagging 	= instance.getPagging();
			 
			if(bptvId !=null && bptvId > 0){  
				 criteria.add(Expression.eq("bptvId", bptvId));	
				// iscriteria = true;
			}
			
			if(bptCreatBy !=null && bptCreatBy.trim().length() > 0){  
				 criteria.add(Expression.eq("bptCreatBy", bptCreatBy));	
				// iscriteria = true;
			}
			 
			if(bptDefinition !=null && bptDefinition.trim().length() > 0){ 
				 criteria.add(Expression.eq("bptDefinition", bptDefinition));	
				 //iscriteria = true;
			} 
			if(bptIndexChar !=null && bptIndexChar.trim().length() > 0){ 
				 criteria.add(Expression.eq("bptIndexChar", bptIndexChar));	
				 //iscriteria = true;
			} 
			if(bptShortDesc !=null && bptShortDesc.trim().length() > 0){ 
				 criteria.add(Expression.eq("bptShortDesc", bptShortDesc));	
				 //iscriteria = true;
			} 
			if(bptSource !=null && bptSource.trim().length() > 0){ 
				 criteria.add(Expression.eq("bptSource", bptSource));	
				 //iscriteria = true;
			} 
			if(bptSourceRef !=null && bptSourceRef.trim().length() > 0){  
				 criteria.add(Expression.eq("bptSourceRef", bptSourceRef));	
				// iscriteria = true;
			} 
			if(bptCreateDate != null){ 
				 criteria.add(Expression.eq("bptCreateDate", bptCreateDate));	
				 //iscriteria = true;
			} 
			if(bptVersionNumber != null && bptVersionNumber > 0){ 
				 criteria.add(Expression.eq("bptVersionNumber", bptVersionNumber));	
				 //iscriteria = true;
			} if(bpsTerm !=null && bpsTerm.getBptId()!=null && bpsTerm.getBptId().intValue()!=0){  
				 criteria.add(Expression.eq("bpsTerm.pbtId", bpsTerm.getBptId().intValue()));	
					// iscriteria = true;
				 
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
	 
	private int getSize(Session session, BpsTermVersion instance) throws Exception{
			try {
				 
				Criteria criteria 	= (Criteria) session.createCriteria(instance.getClass().getName());		 
				Long bptvId = instance.getBptvId();
				String bptCreatBy = instance.getBptCreateBy();
				String bptDefinition = instance.getBptDefinition();
				String bptIndexChar = instance.getBptIndexChar();
				String bptShortDesc =instance.getBptShortDesc();
				String bptSource = instance.getBptSource();
				String bptSourceRef = instance.getBptSourceRef();
				BpsTerm bpsTerm = instance.getBpsTerm();
				/*SBpsGroup bpsGroup = instance.getBpsGroup();*/
				Timestamp bptCreateDate =instance.getBptCreateDate();			
				Integer bptVersionNumber =instance.getBptVersionNumber();
			  
				if(bptvId !=null && bptvId > 0){  
					 criteria.add(Expression.eq("bptvId", bptvId));	
					// iscriteria = true;
				}
				
				if(bptCreatBy !=null && bptCreatBy.trim().length() > 0){  
					 criteria.add(Expression.eq("bptCreatBy", bptCreatBy));	
					// iscriteria = true;
				}
				 
				if(bptDefinition !=null && bptDefinition.trim().length() > 0){ 
					 criteria.add(Expression.eq("bptDefinition", bptDefinition));	
					 //iscriteria = true;
				} 
				if(bptIndexChar !=null && bptIndexChar.trim().length() > 0){ 
					 criteria.add(Expression.eq("bptIndexChar", bptIndexChar));	
					 //iscriteria = true;
				} 
				if(bptShortDesc !=null && bptShortDesc.trim().length() > 0){ 
					 criteria.add(Expression.eq("bptShortDesc", bptShortDesc));	
					 //iscriteria = true;
				} 
				if(bptSource !=null && bptSource.trim().length() > 0){ 
					 criteria.add(Expression.eq("bptSource", bptSource));	
					 //iscriteria = true;
				} 
				if(bptSourceRef !=null && bptSourceRef.trim().length() > 0){  
					 criteria.add(Expression.eq("bptSourceRef", bptSourceRef));	
					// iscriteria = true;
				}
				if(bpsTerm !=null && bpsTerm.getBptId()!=null && bpsTerm.getBptId().intValue()!=0){  
					 criteria.add(Expression.eq("bpsTerm.pbtId", bpsTerm.getBptId().intValue()));	
						// iscriteria = true;
					 
				}
				/*if(bpsGroup !=null && bpsGroup.getBpgId() != null && bpsGroup.getBpgId() > 0){  
						 criteria.add(Expression.eq("bpsGroup", bpsGroup.getBpgId()));	
							// iscriteria = true;
				}*/
				 
				if(bptCreateDate != null){ 
					 criteria.add(Expression.eq("bptCreateDate", bptCreateDate));	
					 //iscriteria = true;
				} 
				if(bptVersionNumber != null && bptVersionNumber > 0){ 
					 criteria.add(Expression.eq("bptVersionNumber", bptVersionNumber));	
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
	public void updateBpsTermVersion(BpsTermVersion transientInstance)
			throws DataAccessException {
		// TODO Auto-generated method stub
		update(sessionAnnotationFactory.getCurrentSession(), transientInstance);
	}
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor={RuntimeException.class})
	public void deleteBpsTermVersion(BpsTermVersion persistentInstance)
			throws DataAccessException {
		// TODO Auto-generated method stub
		delete(sessionAnnotationFactory.getCurrentSession(), persistentInstance);
	}

}
