package th.co.vlink.hibernate;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import th.co.vlink.hibernate.bean.BpsGroup;
import th.co.vlink.hibernate.bean.BpsTermLog;
import th.co.vlink.managers.BpsTermLogService;
import th.co.vlink.utils.Pagging;

@SuppressWarnings("deprecation")
@Repository
@Transactional
public class HibernateBpsTermLog  extends HibernateCommon implements BpsTermLogService {
	private static final Logger logger = Logger.getLogger("bpsAppender");
	private SessionFactory sessionAnnotationFactory;
	public SessionFactory getSessionAnnotationFactory() {
		return sessionAnnotationFactory;
	}
	public void setSessionAnnotationFactory(SessionFactory sessionAnnotationFactory) {
		this.sessionAnnotationFactory = sessionAnnotationFactory;
	}
	@Transactional(readOnly=true)
	public BpsTermLog findBpsTermLogById(Long bptId)
			throws DataAccessException {
		// TODO Auto-generated method stub
		BpsTermLog bpsTerm = null;
		 Object obj = findById(sessionAnnotationFactory.getCurrentSession(), "th.co.vlink.hibernate.bean.BpsTermLog", bptId);
		 if(obj!=null)
			 bpsTerm = (BpsTermLog)obj;
		 return bpsTerm;	
	}
	@Transactional(readOnly=true)
	public BpsGroup findBpsGroupById(Long bpgId) throws DataAccessException {
		// TODO Auto-generated method stub
		BpsGroup bpsGroup = null;
		 Object obj = findById(sessionAnnotationFactory.getCurrentSession(), "th.co.vlink.hibernate.bean.BpsGroup", bpgId);
		 if(obj!=null)
			 bpsGroup = (BpsGroup)obj;
		 return bpsGroup;
	}
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor={RuntimeException.class})
	public Long saveBpsTermLog(BpsTermLog transientInstance)
			throws DataAccessException {
		// TODO Auto-generated method stub
		Session session=sessionAnnotationFactory.getCurrentSession();
		transientInstance.setBptVersionNumber(1);
		/*Long id=save(session, transientInstance);
		BpsTermVersion version = new BpsTermVersion();
		BeanUtility.copyProperties(version, transientInstance);
		transientInstance.setBptId(id);
		version.setBpsTerm(transientInstance);
		save(session, version);*/
		Long returnId  = null;
		try{
			Object obj = session.save(transientInstance);
		
			if(obj!=null){
				returnId =(Long) obj;
			} 
			} finally {
				if (session != null) {
					session = null;
				} 
			}
			return returnId; 
	}
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor={RuntimeException.class})
	public int deleteBpsTermLog(BpsTermLog persistentInstance)
			throws DataAccessException {
		// TODO Auto-generated method stub
		return delete(sessionAnnotationFactory.getCurrentSession(), persistentInstance);
	}
	 @SuppressWarnings({ "rawtypes", "unchecked" })
	 @Transactional(readOnly=true)
	 public List searchBpsTermLog(BpsTermLog instance,String searchKey,String indexChar,String orderColumn,
				String orderBy) throws DataAccessException {
			ArrayList  transList = new ArrayList ();
			Session session = sessionAnnotationFactory.getCurrentSession();
			Long bptlId=instance.getBptlId();
			try {
				Pagging pagging 	= instance.getPagging();
				StringBuffer sb =new StringBuffer(" select bpsTerm from BpsTermLog bpsTerm "); 
				if(bptlId!=null && bptlId.intValue()!=0){
					sb.append("where bpsTerm.bptlId=:bptlId");
				}
				sb.append(" order by bpsTerm.bptlId asc ");
				Query query =session.createQuery(sb.toString());
				if(bptlId!=null && bptlId.intValue()!=0){
					query.setParameter("bptlId",bptlId);
				}
				// set pagging.
				 String size = String.valueOf(getSize(session, instance,searchKey,indexChar,orderColumn,
							orderBy));  
				 query.setFirstResult(pagging.getPageSize() * (pagging.getPageNo() - 1));
				 query.setMaxResults(pagging.getPageSize()); 
				 List l = query.list();   
				 transList.add(l); 
			 	 transList.add(size); 
				return transList;
			} catch (Exception re) {
				//re.printStackTrace();
				logger.error("find by property name failed", re);
				re.printStackTrace();
				 
			}
			return transList;
		}
	 private int getSize(Session session, BpsTermLog instance,String searchKey,String indexChar,String orderColumn,
				String orderBy) throws Exception{
			try {
				Long bptlId = instance.getBptlId();
				
				StringBuffer sb =new StringBuffer(" select count(bpsTerm) from BpsTermLog bpsTerm "); 
				if(bptlId!=null && bptlId.intValue()!=0){
					sb.append("where bpsTerm.bptlId=:bptlId");
				}
				Query query =session.createQuery(sb.toString());
				if(bptlId!=null && bptlId.intValue()!=0){
					query.setParameter("bptlId",bptlId);
				}
					// criteria.setProjection(Projections.rowCount()); 
					 return ((Long)query.uniqueResult()).intValue(); 
			} catch (HibernateException re) {
				logger.error("HibernateException",re);
				throw re;
			} catch (Exception e) {
				logger.error("Exception",e);
				throw e;
			}
		}
	
}
