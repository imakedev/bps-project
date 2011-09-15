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
import th.co.vlink.hibernate.bean.BpsTerm;
import th.co.vlink.managers.BpsTermService;
import th.co.vlink.utils.Pagging;

@Repository
@Transactional
public class HibernateBpsTerm extends HibernateCommon implements BpsTermService {
	private static final Logger logger = Logger.getLogger("BpsLog");
	private SessionFactory sessionAnnotationFactory;
	public SessionFactory getSessionAnnotationFactory() {
		return sessionAnnotationFactory;
	}
	public void setSessionAnnotationFactory(SessionFactory sessionAnnotationFactory) {
		this.sessionAnnotationFactory = sessionAnnotationFactory;
	}
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor={RuntimeException.class})
	public void deleteNtcCalendar(BpsTerm persistentInstance)
			throws DataAccessException {
		// TODO Auto-generated method stub
		delete(sessionAnnotationFactory.getCurrentSession(), persistentInstance);
	}
	@Transactional(readOnly=true)
	public BpsTerm findBpsTermById(Long bptId)
			throws DataAccessException {
		// TODO Auto-generated method stub
		BpsTerm bpsTerm = null;
		 Object obj = findById(sessionAnnotationFactory.getCurrentSession(), "th.co.vlink.hibernate.bean.BpsTerm", bptId);
		 if(obj!=null)
			 bpsTerm = (BpsTerm)obj;
		 return bpsTerm;	
	}
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor={RuntimeException.class})
	public void saveBpsTerm(BpsTerm transientInstance)
			throws DataAccessException {
		// TODO Auto-generated method stub
		save(sessionAnnotationFactory.getCurrentSession(), transientInstance);
	}
	@Transactional(readOnly=true)
	public List searchBpsTerm(BpsTerm persistentInstance)
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
	public List searchBpsTerm(BpsTerm instance, Map likeExpression,
			Map leExpression, Map geExpression) throws DataAccessException {
		ArrayList  transList = new ArrayList ();
		Session session = sessionAnnotationFactory.getCurrentSession();
		try {
			Criteria criteria 	= (Criteria) session.createCriteria(instance.getClass().getName());		 
			Long bptId = instance.getBptId();
			String bptCreatBy = instance.getBptCreateBy();
			String bptDefinition = instance.getBptDefinition();
			String bptIndexChar = instance.getBptIndexChar();
			String bptShortDesc =instance.getBptShortDesc();
			String bptSource = instance.getBptSource();
			String bptSourceRef = instance.getBptSourceRef();
			String bptTerm = instance.getBptTerm();
			BpsGroup bpsGroup = instance.getBpsGroup();
			Timestamp bptCreateDate =instance.getBptCreateDate();			
			Integer bptVersionNumber =instance.getBptVersionNumber();
			  
			Pagging pagging 	= instance.getPagging();
			 
			if(bptId !=null && bptId > 0){  
				 criteria.add(Expression.eq("bptId", bptId));	
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
			if(bptTerm !=null && bptTerm.trim().length() > 0){  
				 criteria.add(Expression.eq("bptTerm", bptTerm));	
					// iscriteria = true;
			}if(bpsGroup !=null && bpsGroup.getBpgId() != null && bpsGroup.getBpgId() > 0){  
					 criteria.add(Expression.eq("bpsGroup", bpsGroup.getBpgId()));	
						// iscriteria = true;
			}
			 
			if(bptCreateDate != null){ 
				 criteria.add(Expression.eq("bptCreateDate", bptCreateDate));	
				 //iscriteria = true;
			} 
			if(bptVersionNumber != null && bptVersionNumber > 0){ 
				 criteria.add(Expression.eq("bptVersionNumber", bptVersionNumber));	
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
	 private int getSize(Session session, BpsTerm instance) throws Exception{
			try {
				 
				Criteria criteria 	= (Criteria) session.createCriteria(instance.getClass().getName());		 
				Long bptId = instance.getBptId();
				String bptCreatBy = instance.getBptCreateBy();
				String bptDefinition = instance.getBptDefinition();
				String bptIndexChar = instance.getBptIndexChar();
				String bptShortDesc =instance.getBptShortDesc();
				String bptSource = instance.getBptSource();
				String bptSourceRef = instance.getBptSourceRef();
				String bptTerm = instance.getBptTerm();
				BpsGroup bpsGroup = instance.getBpsGroup();
				Timestamp bptCreateDate =instance.getBptCreateDate();			
				Integer bptVersionNumber =instance.getBptVersionNumber();
				  
				Pagging pagging 	= instance.getPagging();
				 
				if(bptId !=null && bptId > 0){  
					 criteria.add(Expression.eq("bptId", bptId));	
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
				if(bptTerm !=null && bptTerm.trim().length() > 0){  
					 criteria.add(Expression.eq("bptTerm", bptTerm));	
						// iscriteria = true;
				}if(bpsGroup !=null && bpsGroup.getBpgId() != null && bpsGroup.getBpgId() > 0){  
						 criteria.add(Expression.eq("bpsGroup", bpsGroup.getBpgId()));	
							// iscriteria = true;
				}
				 
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
	public void updateBpsTerm(BpsTerm transientInstance)
			throws DataAccessException {
		// TODO Auto-generated method stub
		update(sessionAnnotationFactory.getCurrentSession(), transientInstance);
	}
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor={RuntimeException.class})
	public void deleteBpsTerm(BpsTerm persistentInstance)
			throws DataAccessException {
		// TODO Auto-generated method stub
		delete(sessionAnnotationFactory.getCurrentSession(), persistentInstance);
	}

}
