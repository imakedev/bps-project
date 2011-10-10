package th.co.vlink.hibernate;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Projections;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import th.co.vlink.hibernate.bean.BpsGroup;
import th.co.vlink.hibernate.bean.BpsTerm;
import th.co.vlink.hibernate.bean.BpsTermVersion;
import th.co.vlink.managers.BpsTermService;
import th.co.vlink.utils.BeanUtility;
import th.co.vlink.utils.Pagging;
@SuppressWarnings("deprecation")
@Repository
@Transactional
public class HibernateBpsTerm extends HibernateCommon implements BpsTermService {
	private static final Logger logger = Logger.getLogger("bpsAppender");
	private SessionFactory sessionAnnotationFactory;
	public SessionFactory getSessionAnnotationFactory() {
		return sessionAnnotationFactory;
	}
	public void setSessionAnnotationFactory(SessionFactory sessionAnnotationFactory) {
		this.sessionAnnotationFactory = sessionAnnotationFactory;
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
	public Long saveBpsTerm(BpsTerm transientInstance)
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
			BpsTermVersion version = new BpsTermVersion();
			BeanUtility.copyProperties(version, transientInstance);
			transientInstance.setBptId(returnId);
			version.setBpsTerm(transientInstance);
			session.save(version);
			} finally {
				if (session != null) {
					session = null;
				} 
			}
			return returnId; 
	}
	/*@SuppressWarnings("rawtypes")
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
	}*/
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Transactional(readOnly=true)
	public List searchBpsTerm(BpsTerm instance,String searchKey,String indexChar,String orderColumn,
			String orderBy) throws DataAccessException {
		ArrayList  transList = new ArrayList ();
		Session session = sessionAnnotationFactory.getCurrentSession();
		try {
			//Criteria criteria 	= (Criteria) session.createCriteria(instance.getClass().getName());
			
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
			System.out.println("search key="+searchKey);
			System.out.println("bptTerm="+bptTerm);
			if(bpsGroup!=null)
				System.out.println("bpsGroup="+bpsGroup.getBpgId());
			StringBuffer sb =new StringBuffer(" select bpsTerm from BpsTerm bpsTerm ");
			
			boolean iscriteria = false;
			if(bptId !=null && bptId > 0){  
				//criteria.add(Expression.eq("bptId", bptId));	
				 sb.append(iscriteria?(" and bpsTerm.bptId="+bptId+""):(" where bpsTerm.bptId="+bptId+""));
				  iscriteria = true;
			}
			/*
			if(bptCreatBy !=null && bptCreatBy.trim().length() > 0){  
				 criteria.add(Expression.eq("bptCreatBy", bptCreatBy));	
				// iscriteria = true;
			}
			 
			if(bptDefinition !=null && bptDefinition.trim().length() > 0){ 
				 criteria.add(Expression.eq("bptDefinition", bptDefinition));	
				 //iscriteria = true;
			} 
			if(bptIndexChar !=null && bptIndexChar.trim().length() > 0){ 
				 criteria.add(Expression.eq("bptIndexChar", bptIndexChar).ignoreCase());	
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
			}*/
			boolean isSearchByKeyWord=false;
			if(bptTerm !=null && bptTerm.trim().length() > 0){   	
				if(searchKey!=null){
					  //1=by term ,2 =by Difinition , 3 all
						if(searchKey.equals("1")){ 
							// criteria.add(Expression.like("bptTerm", "%"+bptTerm.trim()+"%").ignoreCase());
							 sb.append(iscriteria?(" and lower(bpsTerm.bptTerm) like '%"+bptTerm.trim().toLowerCase()+"%'"):(" where lower(bpsTerm.bptTerm) like '%"+bptTerm.trim().toLowerCase()+"%'"));
							  iscriteria = true;
						}else if(searchKey.equals("2")){
							//bptDefinitionSearch
							// criteria.add(Expression.like("bptDefinitionSearch", "%"+bptTerm.trim()+"%").ignoreCase());
							sb.append(iscriteria?(" and lower(bpsTerm.bptDefinitionSearch) like '%"+bptTerm.trim().toLowerCase()+"%'"):(" where lower(bpsTerm.bptDefinitionSearch) like '%"+bptTerm.trim().toLowerCase()+"%'"));
							  iscriteria = true;
						}else if(searchKey.equals("3")){
							/*criteria.add(Expression.or
									 (Expression.like("bptTerm", "%"+bptTerm.trim()+"%").ignoreCase(),
									 Expression.like("bptDefinitionSearch", "%"+bptTerm.trim()+"%").ignoreCase()));*/
							sb.append(iscriteria?(" and (lower(bpsTerm.bptTerm) like '%"+bptTerm.trim().toLowerCase()+"%' " +
									" or lower(bpsTerm.bptDefinitionSearch) like  '%"+bptTerm.trim().toLowerCase()+"%' ) "):(" where (lower(bpsTerm.bptTerm) like '%"+bptTerm.trim().toLowerCase()+"%' " +
									" or lower(bpsTerm.bptDefinitionSearch) like  '%"+bptTerm.trim().toLowerCase()+"%' ) "));
							  iscriteria = true;
						} 
				}else{
					 //criteria.add(Expression.like("bptTerm", "%"+bptTerm.trim()+"%").ignoreCase());
					sb.append(iscriteria?(" and lower(bpsTerm.bptTerm) like '%"+bptTerm.trim().toLowerCase()+"%'"):(" where lower(bpsTerm.bptTerm) like '%"+bptTerm.trim().toLowerCase()+"%'"));
					  iscriteria = true;
				}
				isSearchByKeyWord=true;
					// iscriteria = true;
			}if(bpsGroup !=null && bpsGroup.getBpgId() != null && bpsGroup.getBpgId() > 0){  
					// criteria.add(Expression.eq("bpsGroup.bpgId", bpsGroup.getBpgId()));
				sb.append(iscriteria?(" and bpsTerm.bpsGroup.bpgId="+bpsGroup.getBpgId()+""):(" where bpsTerm.bpsGroup.bpgId="+bpsGroup.getBpgId()+""));
				  iscriteria = true;
						// iscriteria = true;
			}
			if(!isSearchByKeyWord)
			if(indexChar !=null &&  indexChar.length() > 0){  
				// criteria.add(Expression.like("bptTerm", indexChar+"%").ignoreCase());	
				 sb.append(iscriteria?(" and lower(bpsTerm.bptTerm) like '"+indexChar.toLowerCase()+"%'"+""):(" where lower(bpsTerm.bptTerm) like '"+indexChar.toLowerCase()+"%'"+""));
				  iscriteria = true;
					// iscriteria = true;
			}
			
			 
			/*if(bptCreateDate != null){ 
				 criteria.add(Expression.eq("bptCreateDate", bptCreateDate));	
				 //iscriteria = true;
			} 
			if(bptVersionNumber != null && bptVersionNumber > 0){ 
				 criteria.add(Expression.eq("bptVersionNumber", bptVersionNumber));	
				 //iscriteria = true;
			}  */
			/*if(orderBy.equalsIgnoreCase("asc"))
				criteria.addOrder(Order.asc(orderColumn));
			else
				criteria.addOrder(Order.desc(orderColumn));*/
			if(orderBy.equalsIgnoreCase("asc"))
				 sb.append( " order by bpsTerm."+orderColumn+" asc");
			else
				sb.append( " order by bpsTerm."+orderColumn+" desc");
		
			Query query =session.createQuery(sb.toString());
			// set pagging.
			 String size = String.valueOf(getSize(session, instance,searchKey,indexChar,orderColumn,
						orderBy)); 
			 System.out.println(" first Result="+(pagging.getPageSize()* (pagging.getPageNo() - 1))); 
			 
			 query.setFirstResult(pagging.getPageSize() * (pagging.getPageNo() - 1));
			 query.setMaxResults(pagging.getPageSize());
			 
			 List l = query.list();  
			 transList.add(l); 
		 	 transList.add(size); 
			return transList;
		} catch (Exception re) {
			//re.printStackTrace();
			logger.error("find by property name failed", re);
			 
		}
		return transList;
	}
	 private int getSize(Session session, BpsTerm instance,String searchKey,String indexChar,String orderColumn,
				String orderBy) throws Exception{
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
				  
			//	Pagging pagging 	= instance.getPagging();
				 
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
					 criteria.add(Expression.eq("bptIndexChar", bptIndexChar).ignoreCase());	
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
				boolean isSearchByKeyWord=false;
				if(bptTerm !=null && bptTerm.trim().length() > 0){ 
					if(searchKey!=null){
						  //1=by term ,2 =by Difinition , 3 all
							if(searchKey.equals("1")){ 
								 criteria.add(Expression.like("bptTerm", "%"+bptTerm.trim()+"%").ignoreCase());
							}else if(searchKey.equals("2")){
								//bptDefinitionSearch
								 criteria.add(Expression.like("bptDefinitionSearch", "%"+bptTerm.trim()+"%").ignoreCase());
							}else if(searchKey.equals("3")){
								criteria.add(Expression.or
										 (Expression.like("bptTerm", "%"+bptTerm.trim()+"%").ignoreCase(),
										 Expression.like("bptDefinitionSearch", "%"+bptTerm.trim()+"%").ignoreCase()));
							} 
					}else{
						 criteria.add(Expression.like("bptTerm", "%"+bptTerm.trim()+"%").ignoreCase());
					}
					isSearchByKeyWord=true;
						// iscriteria = true;
				}if(bpsGroup !=null && bpsGroup.getBpgId() != null && bpsGroup.getBpgId() > 0){  
						 criteria.add(Expression.eq("bpsGroup.bpgId", bpsGroup.getBpgId()));	
							// iscriteria = true;
				}
				if(!isSearchByKeyWord)
				if(indexChar !=null &&  indexChar.length() > 0){  
					 criteria.add(Expression.like("bptTerm", indexChar+"%").ignoreCase());	
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
	public int updateBpsTerm(BpsTerm transientInstance)
			throws DataAccessException {
		// TODO Auto-generated method stub
		return update(sessionAnnotationFactory.getCurrentSession(), transientInstance);
	}
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor={RuntimeException.class})
	public int updateBpsTermVersion(BpsTerm transientInstance)
			throws DataAccessException {
		// TODO Auto-generated method stub
		Session session =sessionAnnotationFactory.getCurrentSession();
		int canUpdate = 0;
		try{
			Query query=session.createQuery("select max(bptVersionNumber) from BpsTermVersion bpsTermVersion where bpsTerm.bptId=:bptId");
			query.setParameter("bptId", transientInstance.getBptId());
			Object obj  = query.uniqueResult();
			int max=0;
			if(obj!=null)
				max=((Integer)obj).intValue();
			transientInstance.setBptVersionNumber(max+1);
			
			session.update(transientInstance);
		
		/*	if(obj!=null){
				returnId =(Long) obj;
			}*/
			BpsTermVersion version = new BpsTermVersion();
			BeanUtility.copyProperties(version, transientInstance);
			transientInstance.setBptId(transientInstance.getBptId());
			version.setBpsTerm(transientInstance);
			session.save(version);
			canUpdate=1;
			}
		catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
				if (session != null) {
					session = null;
				} 
			}
			return canUpdate; 
		//return update(sessionAnnotationFactory.getCurrentSession(), transientInstance);
	}
	
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor={RuntimeException.class})
	public int deleteBpsTerm(BpsTerm persistentInstance)
			throws DataAccessException {
		// TODO Auto-generated method stub
		return delete(sessionAnnotationFactory.getCurrentSession(), persistentInstance);
	}
	 
}
