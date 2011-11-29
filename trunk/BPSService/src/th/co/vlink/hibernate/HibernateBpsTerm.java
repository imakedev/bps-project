package th.co.vlink.hibernate;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Order;
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
	private static final String SHEMA="DB2INST1";//"DB2ADMIN";
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
	
	public List searchBpsTerm_bk(BpsTerm instance,String searchKey,String indexChar,String orderColumn,
			String orderBy) throws DataAccessException {
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
			/*if(bpsGroup!=null)
				logger.info("bpsGroup="+bpsGroup.getBpgId());*/
			StringBuffer sb =new StringBuffer(" select bpsTerm from BpsTerm bpsTerm ");
			
			boolean iscriteria = false;
			if(bptId !=null && bptId > 0){  
				criteria.add(Expression.eq("bptId", bptId));	
				 /*sb.append(iscriteria?(" and bpsTerm.bptId="+bptId+""):(" where bpsTerm.bptId="+bptId+""));
				  iscriteria = true;*/
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
				//sb.append(iscriteria?(" and bpsTerm.bpsGroup.bpgId="+bpsGroup.getBpgId()+""):(" where bpsTerm.bpsGroup.bpgId="+bpsGroup.getBpgId()+""));
				/*sb.append(iscriteria?(" and bpsTerm.bpsGroup.bpgId="+bpsGroup.getBpgId()+""):(" where bpsTerm.bpsGroup.bpgId="+bpsGroup.getBpgId()+""));
				  iscriteria = true;*/
						// iscriteria = true;
			}
			/*if(!isSearchByKeyWord)
			if(indexChar !=null &&  indexChar.length() > 0){  
				// criteria.add(Expression.like("bptTerm", indexChar+"%").ignoreCase());	
				// sb.append(iscriteria?(" and lower(bpsTerm.bptTerm) like '"+indexChar.toLowerCase()+"%'"+""):(" where lower(bpsTerm.bptTerm) like '"+indexChar.toLowerCase()+"%'"+""));
				 sb.append(iscriteria?(" and lower(bpsTerm.bptTerm) like '"+indexChar.toLowerCase()+"%'"+""):(" where lower(bpsTerm.bptTerm) like '"+indexChar.toLowerCase()+"%'"+""));
				  iscriteria = true;
					// iscriteria = true;
			}
			*/
			if(!isSearchByKeyWord)
				if(indexChar !=null &&  indexChar.length() > 0){  
					 criteria.add(Expression.like("bptTerm", indexChar+"%").ignoreCase());	
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
			if(orderBy.equalsIgnoreCase("asc"))
				criteria.addOrder(Order.asc(orderColumn));
			else
				criteria.addOrder(Order.desc(orderColumn));
			/*if(orderBy.equalsIgnoreCase("asc"))
				 sb.append( " order by bpsTerm."+orderColumn+" asc");
			else
				sb.append( " order by bpsTerm."+orderColumn+" desc");*/
		
			//Query query =session.createQuery(sb.toString());
			// set pagging.
			 String size = String.valueOf(getSize(session, instance,searchKey,indexChar,orderColumn,
						orderBy)); 
			 logger.info(" first Result="+(pagging.getPageSize()* (pagging.getPageNo() - 1))); 
			 
			 /*query.setFirstResult(pagging.getPageSize() * (pagging.getPageNo() - 1));
			 query.setMaxResults(pagging.getPageSize());*/
			 criteria.setFirstResult(pagging.getPageSize() * (pagging.getPageNo() - 1));
			 criteria.setMaxResults(pagging.getPageSize());
			 
			 List l = criteria.list();  
			 //logger.info(" chatchai debug size = "+l.size());
			 //logger.info(" chatchai debug size 2 = "+size);
			 transList.add(l); 
		 	 transList.add(size); 
			return transList;
		} catch (Exception re) {
			//re.printStackTrace();
			logger.error("find by property name failed", re);
			 
		}
		return transList;
	}
	private int getSizeSQL(Session session, BpsTerm instance,String searchKey,String indexChar,String orderColumn,
			String orderBy) throws Exception{
		try {
			 
		//	Long bptId = instance.getBptId();
			 
			String bptTerm = instance.getBptTerm();
			BpsGroup bpsGroup = instance.getBpsGroup();
			/*Timestamp bptCreateDate =instance.getBptCreateDate();			
			Integer bptVersionNumber =instance.getBptVersionNumber();*/
			 
			//select count(bpsterm0_.BPT_ID) as col_0_0_ from BANPU_BPS_TERM bpsterm0_ where lcase(cast(bpsterm0_.BPT_DEFINITION_SEARCH as varchar(32672))) like '%liferay%'
			StringBuffer sb =new StringBuffer(" select count(bpsTerm.BPT_ID) from "+SHEMA+".BANPU_BPS_TERM bpsTerm ");
			
			boolean iscriteria = false;
			/*if(bptId !=null && bptId > 0){  
				 sb.append(iscriteria?(" and bpsTerm.bptId="+bptId+""):(" where bpsTerm.bptId="+bptId+""));
				  iscriteria = true;
			}*/
			boolean isSearchByKeyWord=false;
			if(bptTerm !=null && bptTerm.trim().length() > 0){   	
				if(searchKey!=null){
					  //1=by term ,2 =by Difinition , 3 all
						if(searchKey.equals("1")){ 
							//sb.append(iscriteria?(" and lcase(bpsTerm.bptTerm) like '%"+bptTerm.trim().toLowerCase()+"%'"):(" where lcase(bpsTerm.bptTerm) like '%"+bptTerm.trim().toLowerCase()+"%'"));
							sb.append(iscriteria?(" and lcase(bpsTerm.BPT_TERM) like '%"+bptTerm.trim().toLowerCase()+"%'"):(" where lcase(bpsTerm.BPT_TERM) like '%"+bptTerm.trim().toLowerCase()+"%'"));
							
							iscriteria = true;
						}else if(searchKey.equals("2")){
							//sb.append(iscriteria?(" and lcase(cast(bpsTerm.bptDefinitionSearch as string)) like '%"+bptTerm.trim().toLowerCase()+"%'"):(" where lcase(cast(bpsTerm.bptDefinitionSearch as string)) like '%"+bptTerm.trim().toLowerCase()+"%'"));
							sb.append(iscriteria?(" and lcase(cast(bpsTerm.BPT_DEFINITION_SEARCH as varchar(32672))) like '%"+bptTerm.trim().toLowerCase()+"%'"):(" where lcase(cast(bpsTerm.BPT_DEFINITION_SEARCH as varchar(32672))) like '%"+bptTerm.trim().toLowerCase()+"%'"));
							
							iscriteria = true;
						}else if(searchKey.equals("3")){
							/*sb.append(iscriteria?(" and (lcase(bpsTerm.bptTerm) like '%"+bptTerm.trim().toLowerCase()+"%' " +
									" or lcase(cast(bpsTerm.bptDefinitionSearch as string )) like  '%"+bptTerm.trim().toLowerCase()+"%' ) "):(" where (lcase(bpsTerm.bptTerm) like '%"+bptTerm.trim().toLowerCase()+"%' " +
									" or lcase(cast(bpsTerm.bptDefinitionSearch as string )) like  '%"+bptTerm.trim().toLowerCase()+"%' ) "));*/
							sb.append(iscriteria?(" and (lcase(bpsTerm.BPT_TERM) like '%"+bptTerm.trim().toLowerCase()+"%' " +
									" or lcase(cast(bpsTerm.BPT_DEFINITION_SEARCH as varchar(32672) )) like  '%"+bptTerm.trim().toLowerCase()+"%' ) "):(" where (lcase(bpsTerm.BPT_TERM) like '%"+bptTerm.trim().toLowerCase()+"%' " +
									" or lcase(cast(bpsTerm.BPT_DEFINITION_SEARCH as varchar(32672) )) like  '%"+bptTerm.trim().toLowerCase()+"%' ) "));
							  iscriteria = true;
						} 
				}else{
					sb.append(iscriteria?(" and lcase(bpsTerm.BPT_TERM) like '%"+bptTerm.trim().toLowerCase()+"%'"):(" where lcase(bpsTerm.BPT_TERM) like '%"+bptTerm.trim().toLowerCase()+"%'"));
					  iscriteria = true;
				}
				isSearchByKeyWord=true;
			}if(bpsGroup !=null && bpsGroup.getBpgId() != null && bpsGroup.getBpgId() > 0){  
				sb.append(iscriteria?(" and bpsTerm.BPG_GROUP_ID="+bpsGroup.getBpgId()+""):(" where bpsTerm.BPG_GROUP_ID="+bpsGroup.getBpgId()+""));
		        iscriteria = true;
			}
			if(!isSearchByKeyWord)
			if(indexChar !=null &&  indexChar.length() > 0){  
				 sb.append(iscriteria?(" and lower(bpsTerm.BPT_TERM) like '"+indexChar.toLowerCase()+"%'"+""):(" where lower(bpsTerm.BPT_TERM) like '"+indexChar.toLowerCase()+"%'"+""));
				  iscriteria = true;
			}
			//Query query =session.createQuery(sb.toString());
			SQLQuery query =session.createSQLQuery(sb.toString());
				// criteria.setProjection(Projections.rowCount()); 
				 return ((Integer)query.uniqueResult()).intValue(); 
		} catch (HibernateException re) {
			logger.error("HibernateException",re);
			throw re;
		} catch (Exception e) {
			logger.error("Exception",e);
			throw e;
		}
	}
	private int getSize(Session session, BpsTerm instance,String searchKey,String indexChar,String orderColumn,
			String orderBy) throws Exception{
		try {
			 
			Long bptId = instance.getBptId();
			 
			String bptTerm = instance.getBptTerm();
			BpsGroup bpsGroup = instance.getBpsGroup();
			Timestamp bptCreateDate =instance.getBptCreateDate();			
			Integer bptVersionNumber =instance.getBptVersionNumber();
			 
			 
			StringBuffer sb =new StringBuffer(" select count(bpsTerm) from BpsTerm bpsTerm ");
			
			boolean iscriteria = false;
			if(bptId !=null && bptId > 0){  
				 sb.append(iscriteria?(" and bpsTerm.bptId="+bptId+""):(" where bpsTerm.bptId="+bptId+""));
				  iscriteria = true;
			}
			boolean isSearchByKeyWord=false;
			if(bptTerm !=null && bptTerm.trim().length() > 0){   	
				if(searchKey!=null){
					  //1=by term ,2 =by Difinition , 3 all
						if(searchKey.equals("1")){ 
							sb.append(iscriteria?(" and lcase(bpsTerm.bptTerm) like '%"+bptTerm.trim().toLowerCase()+"%'"):(" where lcase(bpsTerm.bptTerm) like '%"+bptTerm.trim().toLowerCase()+"%'"));
							  iscriteria = true;
						}else if(searchKey.equals("2")){
							sb.append(iscriteria?(" and lcase(cast(bpsTerm.bptDefinitionSearch as string)) like '%"+bptTerm.trim().toLowerCase()+"%'"):(" where lcase(cast(bpsTerm.bptDefinitionSearch as string)) like '%"+bptTerm.trim().toLowerCase()+"%'"));
							  iscriteria = true;
						}else if(searchKey.equals("3")){
							sb.append(iscriteria?(" and (lcase(bpsTerm.bptTerm) like '%"+bptTerm.trim().toLowerCase()+"%' " +
									" or lcase(cast(bpsTerm.bptDefinitionSearch as string )) like  '%"+bptTerm.trim().toLowerCase()+"%' ) "):(" where (lcase(bpsTerm.bptTerm) like '%"+bptTerm.trim().toLowerCase()+"%' " +
									" or lcase(cast(bpsTerm.bptDefinitionSearch as string )) like  '%"+bptTerm.trim().toLowerCase()+"%' ) "));
							  iscriteria = true;
						} 
				}else{
					sb.append(iscriteria?(" and lcase(bpsTerm.bptTerm) like '%"+bptTerm.trim().toLowerCase()+"%'"):(" where lcase(bpsTerm.bptTerm) like '%"+bptTerm.trim().toLowerCase()+"%'"));
					  iscriteria = true;
				}
				isSearchByKeyWord=true;
			}if(bpsGroup !=null && bpsGroup.getBpgId() != null && bpsGroup.getBpgId() > 0){  
				sb.append(iscriteria?(" and bpsTerm.bpsGroup.bpgId="+bpsGroup.getBpgId()+""):(" where bpsTerm.bpsGroup.bpgId="+bpsGroup.getBpgId()+""));
		        iscriteria = true;
			}
			if(!isSearchByKeyWord)
			if(indexChar !=null &&  indexChar.length() > 0){  
				 sb.append(iscriteria?(" and lower(bpsTerm.bptTerm) like '"+indexChar.toLowerCase()+"%'"+""):(" where lower(bpsTerm.bptTerm) like '"+indexChar.toLowerCase()+"%'"+""));
				  iscriteria = true;
			}
			Query query =session.createQuery(sb.toString());
			
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
	 private int getSize_bk(Session session, BpsTerm instance,String searchKey,String indexChar,String orderColumn,
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
				}
				*/
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
	 @SuppressWarnings({ "rawtypes", "unchecked" })
	 @Transactional(readOnly=true)
	 public List searchBpsTermSQL(BpsTerm instance,String searchKey,String indexChar,String orderColumn,
				String orderBy) throws DataAccessException {
			ArrayList  transList = new ArrayList ();
			Session session = sessionAnnotationFactory.getCurrentSession();
			try {
				String bptTerm = instance.getBptTerm();
				BpsGroup bpsGroup = instance.getBpsGroup();
				  
				Pagging pagging 	= instance.getPagging();
				logger.info("search key="+searchKey);
				logger.info("bptTerm="+bptTerm);
				if(bpsGroup!=null)
					logger.info("bpsGroup="+bpsGroup.getBpgId());
				String resultStr="rownumber_," + //0
						" bpsterm.BPT_ID as BPT_ID," + //1
						" bpsterm.BPG_GROUP_ID as BPG_GROUP_ID," + //2
						" bpsterm.BPT_CREATE_BY as BPT_CREATE_BY," + //3
						" bpsterm.BPT_CREATE_DATE as BPT_CREATE_DATE," + //4
						" bpsterm.BPT_DEFINITION as BPT_DEFINITION," + //5
						" bpsterm.BPT_DEFINITION_SEARCH as BPT_DEFINITION_SEARCH," + //6
						" bpsterm.BPT_INDEX_CHAR as BPT_INDEX_CHAR," + //7
						" bpsterm.BPT_SHORT_DESC as BPT_SHORT_DESC," + //8
						" bpsterm.BPT_SOURCE as BPT_SOURCE," + //9
						" bpsterm.BPT_SOURCE_REF as BPT_SOURCE_REF," + //10
						" bpsterm.BPT_TERM as BPT_TERM," + //11
						" bpsterm.BPT_UPDATE_BY as BPT_UPDATE_BY," + //12
						" bpsterm.BPT_UPDATE_DATE as BPT_UPDATE_DATE," + //13
						" bpsterm.BPT_VERSION_NUMBER as BPT_VERSION_NUMBER ,"+ //14
						" bpsgroup.BPG_GROUP_NAME as BPG_GROUP_NAME "; //15
				StringBuffer sb =new StringBuffer(" as "+resultStr +" from "+SHEMA+".BANPU_BPS_TERM bpsterm  , "+SHEMA+".BANPU_BPS_GROUP bpsgroup " +
						" where bpsterm.BPG_GROUP_ID=bpsgroup.BPG_ID " );
				String overStr =" ";
				//boolean iscriteria = false;
				boolean iscriteria = true;
					/* select count(bpsterm0_.BPT_ID) as col_0_0_ from BANPU_BPS_TERMbpsterm where lcase(cast(bpsterm0_.BPT_DEFINITION_SEARCH as varchar(32672))) like '%liferay%'
				   select * from ( select rownumber() over(order by bpsterm0_.BPT_TERM asc) as rownumber_, bpsterm0_.BPT_ID as BPT1_1_, bpsterm0_.BPG_GROUP_ID as BPG14_1_, bpsterm0_.BPT_CREATE_BY as BPT2_1_, bpsterm0_.BPT_CREATE_DATE as BPT3_1_, bpsterm0_.BPT_DEFINITION as BPT4_1_, bpsterm0_.BPT_DEFINITION_SEARCH as BPT5_1_, bpsterm0_.BPT_INDEX_CHAR as BPT6_1_, bpsterm0_.BPT_SHORT_DESC as BPT7_1_, bpsterm0_.BPT_SOURCE as BPT8_1_, bpsterm0_.BPT_SOURCE_REF as BPT9_1_, bpsterm0_.BPT_TERM as BPT10_1_, bpsterm0_.BPT_UPDATE_BY as BPT11_1_, bpsterm0_.BPT_UPDATE_DATE as BPT12_1_, bpsterm0_.BPT_VERSION_NUMBER as BPT13_1_ from BANPU_BPS_TERM bpsterm0_ where lcase(cast(bpsterm0_.BPT_DEFINITION_SEARCH as varchar(32672))) like '%liferay%' order by bpsterm0_.BPT_TERM asc ) as temp_ where rownumber_ <= ?
 
  				   select * from ( select rownumber() over(order by bpsterm0_.BPT_TERM asc) as rownumber_, bpsterm0_.BPT_ID as BPT1_1_, bpsterm0_.BPG_GROUP_ID as BPG14_1_, bpsterm0_.BPT_CREATE_BY as BPT2_1_, bpsterm0_.BPT_CREATE_DATE as BPT3_1_, bpsterm0_.BPT_DEFINITION as BPT4_1_, bpsterm0_.BPT_DEFINITION_SEARCH as BPT5_1_, bpsterm0_.BPT_INDEX_CHAR as BPT6_1_, bpsterm0_.BPT_SHORT_DESC as BPT7_1_, bpsterm0_.BPT_SOURCE as BPT8_1_, bpsterm0_.BPT_SOURCE_REF as BPT9_1_, bpsterm0_.BPT_TERM as BPT10_1_, bpsterm0_.BPT_UPDATE_BY as BPT11_1_, bpsterm0_.BPT_UPDATE_DATE as BPT12_1_, bpsterm0_.BPT_VERSION_NUMBER as BPT13_1_ from BANPU_BPS_TERM bpsterm0_ where bpsterm0_.BPG_GROUP_ID=2 order by bpsterm0_.BPT_TERM asc ) as temp_ where rownumber_ <= ?
  
 				   select count(bpsterm0_.BPT_ID) as col_0_0_ from BANPU_BPS_TERM bpsterm0_ where lcase(cast(bpsterm0_.BPT_DEFINITION_SEARCH as varchar(32672))) like '%liferay%'
				   select * from ( select rownumber() over(order by bpsterm0_.BPT_TERM desc) as rownumber_, bpsterm0_.BPT_ID as BPT1_1_, bpsterm0_.BPG_GROUP_ID as BPG14_1_, bpsterm0_.BPT_CREATE_BY as BPT2_1_, bpsterm0_.BPT_CREATE_DATE as BPT3_1_, bpsterm0_.BPT_DEFINITION as BPT4_1_, bpsterm0_.BPT_DEFINITION_SEARCH as BPT5_1_, bpsterm0_.BPT_INDEX_CHAR as BPT6_1_, bpsterm0_.BPT_SHORT_DESC as BPT7_1_, bpsterm0_.BPT_SOURCE as BPT8_1_, bpsterm0_.BPT_SOURCE_REF as BPT9_1_, bpsterm0_.BPT_TERM as BPT10_1_, bpsterm0_.BPT_UPDATE_BY as BPT11_1_, bpsterm0_.BPT_UPDATE_DATE as BPT12_1_, bpsterm0_.BPT_VERSION_NUMBER as BPT13_1_ from BANPU_BPS_TERM bpsterm0_ where lcase(cast(bpsterm0_.BPT_DEFINITION_SEARCH as varchar(32672))) like '%liferay%' order by bpsterm0_.BPT_TERM desc ) as temp_ where rownumber_ <= ?

				   select count(bpsterm0_.BPT_ID) as col_0_0_ from BANPU_BPS_TERM bpsterm0_ where lcase(cast(bpsterm0_.BPT_DEFINITION_SEARCH as varchar(32672))) like '%liferay%'
				   select * from ( select rownumber() over(order by cast(bpsterm0_.BPT_DEFINITION as varchar(32672)) asc) as rownumber_, bpsterm0_.BPT_ID as BPT1_1_, bpsterm0_.BPG_GROUP_ID as BPG14_1_, bpsterm0_.BPT_CREATE_BY as BPT2_1_, bpsterm0_.BPT_CREATE_DATE as BPT3_1_, bpsterm0_.BPT_DEFINITION as BPT4_1_, bpsterm0_.BPT_DEFINITION_SEARCH as BPT5_1_, bpsterm0_.BPT_INDEX_CHAR as BPT6_1_, bpsterm0_.BPT_SHORT_DESC as BPT7_1_, bpsterm0_.BPT_SOURCE as BPT8_1_, bpsterm0_.BPT_SOURCE_REF as BPT9_1_, bpsterm0_.BPT_TERM as BPT10_1_, bpsterm0_.BPT_UPDATE_BY as BPT11_1_, bpsterm0_.BPT_UPDATE_DATE as BPT12_1_, bpsterm0_.BPT_VERSION_NUMBER as BPT13_1_ from BANPU_BPS_TERM bpsterm0_ where lcase(cast(bpsterm0_.BPT_DEFINITION_SEARCH as varchar(32672))) like '%liferay%' order by cast(bpsterm0_.BPT_DEFINITION as varchar(32672)) asc ) as temp_ where rownumber_ <= ?

				   select count(bpsterm0_.BPT_ID) as col_0_0_ from BANPU_BPS_TERM bpsterm0_ where lcase(cast(bpsterm0_.BPT_DEFINITION_SEARCH as varchar(32672))) like '%liferay%'
				   select * from ( select rownumber() over(order by bpsgroup1_.BPG_GROUP_NAME asc) as rownumber_, bpsterm0_.BPT_ID as BPT1_1_, bpsterm0_.BPG_GROUP_ID as BPG14_1_, bpsterm0_.BPT_CREATE_BY as BPT2_1_, bpsterm0_.BPT_CREATE_DATE as BPT3_1_, bpsterm0_.BPT_DEFINITION as BPT4_1_, bpsterm0_.BPT_DEFINITION_SEARCH as BPT5_1_, bpsterm0_.BPT_INDEX_CHAR as BPT6_1_, bpsterm0_.BPT_SHORT_DESC as BPT7_1_, bpsterm0_.BPT_SOURCE as BPT8_1_, bpsterm0_.BPT_SOURCE_REF as BPT9_1_, bpsterm0_.BPT_TERM as BPT10_1_, bpsterm0_.BPT_UPDATE_BY as BPT11_1_, bpsterm0_.BPT_UPDATE_DATE as BPT12_1_, bpsterm0_.BPT_VERSION_NUMBER as BPT13_1_ from BANPU_BPS_TERM bpsterm0_, BANPU_BPS_GROUP bpsgroup1_ where bpsterm0_.BPG_GROUP_ID=bpsgroup1_.BPG_ID and (lcase(cast(bpsterm0_.BPT_DEFINITION_SEARCH as varchar(32672))) like '%liferay%') order by bpsgroup1_.BPG_GROUP_NAME asc ) as temp_ where rownumber_ <= ?

				   select count(bpsterm0_.BPT_ID) as col_0_0_ from BANPU_BPS_TERM bpsterm0_ where lcase(cast(bpsterm0_.BPT_DEFINITION_SEARCH as varchar(32672))) like '%liferay%'
				   select * from ( select rownumber() over(order by bpsterm0_.BPT_SOURCE asc) as rownumber_, bpsterm0_.BPT_ID as BPT1_1_, bpsterm0_.BPG_GROUP_ID as BPG14_1_, bpsterm0_.BPT_CREATE_BY as BPT2_1_, bpsterm0_.BPT_CREATE_DATE as BPT3_1_, bpsterm0_.BPT_DEFINITION as BPT4_1_, bpsterm0_.BPT_DEFINITION_SEARCH as BPT5_1_, bpsterm0_.BPT_INDEX_CHAR as BPT6_1_, bpsterm0_.BPT_SHORT_DESC as BPT7_1_, bpsterm0_.BPT_SOURCE as BPT8_1_, bpsterm0_.BPT_SOURCE_REF as BPT9_1_, bpsterm0_.BPT_TERM as BPT10_1_, bpsterm0_.BPT_UPDATE_BY as BPT11_1_, bpsterm0_.BPT_UPDATE_DATE as BPT12_1_, bpsterm0_.BPT_VERSION_NUMBER as BPT13_1_ from BANPU_BPS_TERM bpsterm0_ where lcase(cast(bpsterm0_.BPT_DEFINITION_SEARCH as varchar(32672))) like '%liferay%' order by bpsterm0_.BPT_SOURCE asc ) as temp_ where rownumber_ <= ?


				 */
				boolean isSearchByKeyWord=false;
				if(bptTerm !=null && bptTerm.trim().length() > 0){   	
					if(searchKey!=null){
						  //1=by term ,2 =by Difinition , 3 all
							if(searchKey.equals("1")){ 
								 sb.append(iscriteria?(" and lcase(bpsterm.BPT_TERM) like '%"+bptTerm.trim().toLowerCase()+"%'"):(" where lcase(bpsterm.BPT_TERM) like '%"+bptTerm.trim().toLowerCase()+"%'"));
								 iscriteria = true;
							}else if(searchKey.equals("2")){
								sb.append(iscriteria?(" and lcase(cast(bpsterm.BPT_DEFINITION_SEARCH as varchar(32672))) like '%"+bptTerm.trim().toLowerCase()+"%'"):(" where lcase(cast(bpsterm.BPT_DEFINITION_SEARCH as varchar(32672))) like '%"+bptTerm.trim().toLowerCase()+"%'"));
								  iscriteria = true;
							}else if(searchKey.equals("3")){
								sb.append(iscriteria?(" and (lcase(bpsTerm.BPT_TERM) like '%"+bptTerm.trim().toLowerCase()+"%' " +
										" or lcase(cast(bpsTerm.BPT_DEFINITION_SEARCH as varchar(32672))) like  '%"+bptTerm.trim().toLowerCase()+"%' ) "):(" where (lcase(bpsTerm.BPT_TERM) like '%"+bptTerm.trim().toLowerCase()+"%' " +
										" or lcase(cast(bpsTerm.BPT_DEFINITION_SEARCH as varchar(32672))) like  '%"+bptTerm.trim().toLowerCase()+"%' ) "));
								 iscriteria = true;
								  
							} 
					}else{
						sb.append(iscriteria?(" and lcase(bpsTerm.BPT_TERM) like '%"+bptTerm.trim().toLowerCase()+"%'"):(" where lcase(bpsTerm.BPT_TERM) like '%"+bptTerm.trim().toLowerCase()+"%'"));
						  iscriteria = true;
					}
					isSearchByKeyWord=true;
				}if(bpsGroup !=null && bpsGroup.getBpgId() != null && bpsGroup.getBpgId() > 0){  
					sb.append(iscriteria?(" and bpsTerm.BPG_GROUP_ID="+bpsGroup.getBpgId()+""):(" where bpsTerm.BPG_GROUP_ID="+bpsGroup.getBpgId()+""));
					  iscriteria = true;
				}
				if(!isSearchByKeyWord)
				if(indexChar !=null &&  indexChar.length() > 0){  
					 sb.append(iscriteria?(" and lower(bpsTerm.BPT_TERM) like '"+indexChar.toLowerCase()+"%'"+""):(" where lower(bpsTerm.BPT_TERM) like '"+indexChar.toLowerCase()+"%'"+""));
					  iscriteria = true;
				}
				logger.info(" xxxxxxxxxxxx ="+orderColumn);
				if(orderBy.equalsIgnoreCase("asc")){
					if("BPT_DEFINITION_SEARCH".equals(orderColumn) || "BPT_DEFINITION".equals(orderColumn)){
						overStr="order by cast(bpsterm."+orderColumn+" as varchar(30106)) asc";
					}
					else if("BPG_GROUP_NAME".equals(orderColumn)){
						overStr="order by bpsgroup."+orderColumn+" asc";
					}
					else {
						overStr="order by bpsterm."+orderColumn+" asc";
					}
				}
				else{
					if("BPT_DEFINITION_SEARCH".equals(orderColumn)  || "BPT_DEFINITION".equals(orderColumn)){
						overStr="order by cast(bpsterm."+orderColumn+" as varchar(30106)) desc";
					}
					else if("BPG_GROUP_NAME".equals(orderColumn)){
						overStr="order by bpsgroup."+orderColumn+" asc";
					}
					else{
						overStr="order by bpsterm."+orderColumn+" desc";
					}
				}
				int first=pagging.getPageSize() * (pagging.getPageNo() - 1);
				int end=pagging.getPageSize();
				SQLQuery query =session.createSQLQuery("select * from ( select rownumber() over( "+overStr+" ) "+sb.toString() +" ) as bps " +
						"where  rownumber_ between "+first+" and "+(first+end));
				
				//where rownumber_ between ?+1 and ?
				//logger.info("chatchai debug ==select * from ( select rownumber() over( "+overStr+" ) "+sb.toString() +" ) as bps ");
				// set pagging.
				 String size = String.valueOf(getSizeSQL(session, instance,searchKey,indexChar,orderColumn,
							orderBy)); 
				 logger.info(" first Result="+(pagging.getPageSize()* (pagging.getPageNo() - 1))); 
				 
				/* query.setFirstResult(pagging.getPageSize() * (pagging.getPageNo() - 1));
				 query.setMaxResults(pagging.getPageSize());*/
				 
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
				logger.info("search key="+searchKey);
				logger.info("bptTerm="+bptTerm);
				if(bpsGroup!=null)
					logger.info("bpsGroup="+bpsGroup.getBpgId());
				StringBuffer sb =new StringBuffer(" select bpsTerm from BpsTerm bpsTerm ");
				
				boolean iscriteria = false;
				if(bptId !=null && bptId > 0){  
					//criteria.add(Expression.eq("bptId", bptId));	
					 sb.append(iscriteria?(" and bpsTerm.bptId="+bptId+""):(" where bpsTerm.bptId="+bptId+""));
					  iscriteria = true;
				}
				/* select count(bpsterm0_.BPT_ID) as col_0_0_ from BANPU_BPS_TERM bpsterm0_ where lcase(cast(bpsterm0_.BPT_DEFINITION_SEARCH as varchar(32672))) like '%liferay%'
				   select * from ( select rownumber() over(order by bpsterm0_.BPT_TERM asc) as rownumber_, bpsterm0_.BPT_ID as BPT1_1_, bpsterm0_.BPG_GROUP_ID as BPG14_1_, bpsterm0_.BPT_CREATE_BY as BPT2_1_, bpsterm0_.BPT_CREATE_DATE as BPT3_1_, bpsterm0_.BPT_DEFINITION as BPT4_1_, bpsterm0_.BPT_DEFINITION_SEARCH as BPT5_1_, bpsterm0_.BPT_INDEX_CHAR as BPT6_1_, bpsterm0_.BPT_SHORT_DESC as BPT7_1_, bpsterm0_.BPT_SOURCE as BPT8_1_, bpsterm0_.BPT_SOURCE_REF as BPT9_1_, bpsterm0_.BPT_TERM as BPT10_1_, bpsterm0_.BPT_UPDATE_BY as BPT11_1_, bpsterm0_.BPT_UPDATE_DATE as BPT12_1_, bpsterm0_.BPT_VERSION_NUMBER as BPT13_1_ from BANPU_BPS_TERM bpsterm0_ where lcase(cast(bpsterm0_.BPT_DEFINITION_SEARCH as varchar(32672))) like '%liferay%' order by bpsterm0_.BPT_TERM asc ) as temp_ where rownumber_ <= ?
 
 				   select count(bpsterm0_.BPT_ID) as col_0_0_ from BANPU_BPS_TERM bpsterm0_ where lcase(cast(bpsterm0_.BPT_DEFINITION_SEARCH as varchar(32672))) like '%liferay%'
				   select * from ( select rownumber() over(order by bpsterm0_.BPT_TERM desc) as rownumber_, bpsterm0_.BPT_ID as BPT1_1_, bpsterm0_.BPG_GROUP_ID as BPG14_1_, bpsterm0_.BPT_CREATE_BY as BPT2_1_, bpsterm0_.BPT_CREATE_DATE as BPT3_1_, bpsterm0_.BPT_DEFINITION as BPT4_1_, bpsterm0_.BPT_DEFINITION_SEARCH as BPT5_1_, bpsterm0_.BPT_INDEX_CHAR as BPT6_1_, bpsterm0_.BPT_SHORT_DESC as BPT7_1_, bpsterm0_.BPT_SOURCE as BPT8_1_, bpsterm0_.BPT_SOURCE_REF as BPT9_1_, bpsterm0_.BPT_TERM as BPT10_1_, bpsterm0_.BPT_UPDATE_BY as BPT11_1_, bpsterm0_.BPT_UPDATE_DATE as BPT12_1_, bpsterm0_.BPT_VERSION_NUMBER as BPT13_1_ from BANPU_BPS_TERM bpsterm0_ where lcase(cast(bpsterm0_.BPT_DEFINITION_SEARCH as varchar(32672))) like '%liferay%' order by bpsterm0_.BPT_TERM desc ) as temp_ where rownumber_ <= ?

				   select count(bpsterm0_.BPT_ID) as col_0_0_ from BANPU_BPS_TERM bpsterm0_ where lcase(cast(bpsterm0_.BPT_DEFINITION_SEARCH as varchar(32672))) like '%liferay%'
				   select * from ( select rownumber() over(order by cast(bpsterm0_.BPT_DEFINITION as varchar(32672)) asc) as rownumber_, bpsterm0_.BPT_ID as BPT1_1_, bpsterm0_.BPG_GROUP_ID as BPG14_1_, bpsterm0_.BPT_CREATE_BY as BPT2_1_, bpsterm0_.BPT_CREATE_DATE as BPT3_1_, bpsterm0_.BPT_DEFINITION as BPT4_1_, bpsterm0_.BPT_DEFINITION_SEARCH as BPT5_1_, bpsterm0_.BPT_INDEX_CHAR as BPT6_1_, bpsterm0_.BPT_SHORT_DESC as BPT7_1_, bpsterm0_.BPT_SOURCE as BPT8_1_, bpsterm0_.BPT_SOURCE_REF as BPT9_1_, bpsterm0_.BPT_TERM as BPT10_1_, bpsterm0_.BPT_UPDATE_BY as BPT11_1_, bpsterm0_.BPT_UPDATE_DATE as BPT12_1_, bpsterm0_.BPT_VERSION_NUMBER as BPT13_1_ from BANPU_BPS_TERM bpsterm0_ where lcase(cast(bpsterm0_.BPT_DEFINITION_SEARCH as varchar(32672))) like '%liferay%' order by cast(bpsterm0_.BPT_DEFINITION as varchar(32672)) asc ) as temp_ where rownumber_ <= ?

				   select count(bpsterm0_.BPT_ID) as col_0_0_ from BANPU_BPS_TERM bpsterm0_ where lcase(cast(bpsterm0_.BPT_DEFINITION_SEARCH as varchar(32672))) like '%liferay%'
				   select * from ( select rownumber() over(order by bpsgroup1_.BPG_GROUP_NAME asc) as rownumber_, bpsterm0_.BPT_ID as BPT1_1_, bpsterm0_.BPG_GROUP_ID as BPG14_1_, bpsterm0_.BPT_CREATE_BY as BPT2_1_, bpsterm0_.BPT_CREATE_DATE as BPT3_1_, bpsterm0_.BPT_DEFINITION as BPT4_1_, bpsterm0_.BPT_DEFINITION_SEARCH as BPT5_1_, bpsterm0_.BPT_INDEX_CHAR as BPT6_1_, bpsterm0_.BPT_SHORT_DESC as BPT7_1_, bpsterm0_.BPT_SOURCE as BPT8_1_, bpsterm0_.BPT_SOURCE_REF as BPT9_1_, bpsterm0_.BPT_TERM as BPT10_1_, bpsterm0_.BPT_UPDATE_BY as BPT11_1_, bpsterm0_.BPT_UPDATE_DATE as BPT12_1_, bpsterm0_.BPT_VERSION_NUMBER as BPT13_1_ from BANPU_BPS_TERM bpsterm0_, BANPU_BPS_GROUP bpsgroup1_ where bpsterm0_.BPG_GROUP_ID=bpsgroup1_.BPG_ID and (lcase(cast(bpsterm0_.BPT_DEFINITION_SEARCH as varchar(32672))) like '%liferay%') order by bpsgroup1_.BPG_GROUP_NAME asc ) as temp_ where rownumber_ <= ?

				   select count(bpsterm0_.BPT_ID) as col_0_0_ from BANPU_BPS_TERM bpsterm0_ where lcase(cast(bpsterm0_.BPT_DEFINITION_SEARCH as varchar(32672))) like '%liferay%'
				   select * from ( select rownumber() over(order by bpsterm0_.BPT_SOURCE asc) as rownumber_, bpsterm0_.BPT_ID as BPT1_1_, bpsterm0_.BPG_GROUP_ID as BPG14_1_, bpsterm0_.BPT_CREATE_BY as BPT2_1_, bpsterm0_.BPT_CREATE_DATE as BPT3_1_, bpsterm0_.BPT_DEFINITION as BPT4_1_, bpsterm0_.BPT_DEFINITION_SEARCH as BPT5_1_, bpsterm0_.BPT_INDEX_CHAR as BPT6_1_, bpsterm0_.BPT_SHORT_DESC as BPT7_1_, bpsterm0_.BPT_SOURCE as BPT8_1_, bpsterm0_.BPT_SOURCE_REF as BPT9_1_, bpsterm0_.BPT_TERM as BPT10_1_, bpsterm0_.BPT_UPDATE_BY as BPT11_1_, bpsterm0_.BPT_UPDATE_DATE as BPT12_1_, bpsterm0_.BPT_VERSION_NUMBER as BPT13_1_ from BANPU_BPS_TERM bpsterm0_ where lcase(cast(bpsterm0_.BPT_DEFINITION_SEARCH as varchar(32672))) like '%liferay%' order by bpsterm0_.BPT_SOURCE asc ) as temp_ where rownumber_ <= ?


				 */
				boolean isSearchByKeyWord=false;
				if(bptTerm !=null && bptTerm.trim().length() > 0){   	
					if(searchKey!=null){
						  //1=by term ,2 =by Difinition , 3 all
							if(searchKey.equals("1")){ 
								// criteria.add(Expression.like("bptTerm", "%"+bptTerm.trim()+"%").ignoreCase());
								// sb.append(iscriteria?(" and lower(bpsTerm.bptTerm) like '%"+bptTerm.trim().toLowerCase()+"%'"):(" where lower(bpsTerm.bptTerm) like '%"+bptTerm.trim().toLowerCase()+"%'"));
								 sb.append(iscriteria?(" and lcase(bpsTerm.bptTerm) like '%"+bptTerm.trim().toLowerCase()+"%'"):(" where lcase(bpsTerm.bptTerm) like '%"+bptTerm.trim().toLowerCase()+"%'"));
								  iscriteria = true;
							}else if(searchKey.equals("2")){
								//bptDefinitionSearch
								// criteria.add(Expression.like("bptDefinitionSearch", "%"+bptTerm.trim()+"%").ignoreCase());
								sb.append(iscriteria?(" and lcase(cast(bpsTerm.bptDefinitionSearch as string)) like '%"+bptTerm.trim().toLowerCase()+"%'"):(" where lcase(cast(bpsTerm.bptDefinitionSearch as string)) like '%"+bptTerm.trim().toLowerCase()+"%'"));
								//sb.append(iscriteria?(" and lower(cast(bpsTerm.bptDefinitionSearch as varchar(32672) ) ) like '%"+bptTerm.trim().toLowerCase()+"%'"):(" where lower(cast(bpsTerm.bptDefinitionSearch as varchar(32672))) like '%"+bptTerm.trim().toLowerCase()+"%'"));
								  iscriteria = true;
							}else if(searchKey.equals("3")){
								/*criteria.add(Expression.or
										 (Expression.like("bptTerm", "%"+bptTerm.trim()+"%").ignoreCase(),
										 Expression.like("bptDefinitionSearch", "%"+bptTerm.trim()+"%").ignoreCase()));*/
								/*sb.append(iscriteria?(" and (lower(bpsTerm.bptTerm) like '%"+bptTerm.trim().toLowerCase()+"%' " +
										" or lower(bpsTerm.bptDefinitionSearch) like  '%"+bptTerm.trim().toLowerCase()+"%' ) "):(" where (lower(bpsTerm.bptTerm) like '%"+bptTerm.trim().toLowerCase()+"%' " +
										" or lower(bpsTerm.bptDefinitionSearch) like  '%"+bptTerm.trim().toLowerCase()+"%' ) "));*/
								sb.append(iscriteria?(" and (lcase(bpsTerm.bptTerm) like '%"+bptTerm.trim().toLowerCase()+"%' " +
										" or lcase(cast(bpsTerm.bptDefinitionSearch as string)) like  '%"+bptTerm.trim().toLowerCase()+"%' ) "):(" where (lcase(bpsTerm.bptTerm) like '%"+bptTerm.trim().toLowerCase()+"%' " +
										" or lcase(cast(bpsTerm.bptDefinitionSearch as string)) like  '%"+bptTerm.trim().toLowerCase()+"%' ) "));
								/*sb.append(iscriteria?(" and (lower(bpsTerm.bptTerm) like '%"+bptTerm.trim().toLowerCase()+"%' " +
										" or lower(cast(bpsTerm.bptDefinitionSearch as varchar(32672))) like  '%"+bptTerm.trim().toLowerCase()+"%' ) "):(" where (lower(char(bpsTerm.bptTerm)) like '%"+bptTerm.trim().toLowerCase()+"%' " +
										" or lower(cast(bpsTerm.bptDefinitionSearch as varchar(32672))) like  '%"+bptTerm.trim().toLowerCase()+"%' ) "));*/
								  iscriteria = true;
								  
							} 
					}else{
						 //criteria.add(Expression.like("bptTerm", "%"+bptTerm.trim()+"%").ignoreCase());
						//sb.append(iscriteria?(" and lower(bpsTerm.bptTerm) like '%"+bptTerm.trim().toLowerCase()+"%'"):(" where lower(bpsTerm.bptTerm) like '%"+bptTerm.trim().toLowerCase()+"%'"));
						sb.append(iscriteria?(" and lcase(bpsTerm.bptTerm) like '%"+bptTerm.trim().toLowerCase()+"%'"):(" where lcase(bpsTerm.bptTerm) like '%"+bptTerm.trim().toLowerCase()+"%'"));
						  iscriteria = true;
					}
					isSearchByKeyWord=true;
						// iscriteria = true;
				}if(bpsGroup !=null && bpsGroup.getBpgId() != null && bpsGroup.getBpgId() > 0){  
						// criteria.add(Expression.eq("bpsGroup.bpgId", bpsGroup.getBpgId()));
					//sb.append(iscriteria?(" and bpsTerm.bpsGroup.bpgId="+bpsGroup.getBpgId()+""):(" where bpsTerm.bpsGroup.bpgId="+bpsGroup.getBpgId()+""));
					sb.append(iscriteria?(" and bpsTerm.bpsGroup.bpgId="+bpsGroup.getBpgId()+""):(" where bpsTerm.bpsGroup.bpgId="+bpsGroup.getBpgId()+""));
					  iscriteria = true;
							// iscriteria = true;
				}
				if(!isSearchByKeyWord)
				if(indexChar !=null &&  indexChar.length() > 0){  
					// criteria.add(Expression.like("bptTerm", indexChar+"%").ignoreCase());	
					// sb.append(iscriteria?(" and lower(bpsTerm.bptTerm) like '"+indexChar.toLowerCase()+"%'"+""):(" where lower(bpsTerm.bptTerm) like '"+indexChar.toLowerCase()+"%'"+""));
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
				logger.info(" xxxxxxxxxxxx ="+orderColumn);
				if(orderBy.equalsIgnoreCase("asc")){
					if("bptDefinitionSearch".equals(orderColumn) || "bptDefinition".equals(orderColumn))
						sb.append( " order by cast(bpsTerm."+orderColumn+" as string) asc");
					else
						sb.append( " order by bpsTerm."+orderColumn+" asc");
				}
				else{
					if("bptDefinitionSearch".equals(orderColumn)  || "bptDefinition".equals(orderColumn))
						sb.append( " order by cast(bpsTerm."+orderColumn+" as string) desc");
					else
						sb.append( " order by bpsTerm."+orderColumn+" desc");
				}
			
				Query query =session.createQuery(sb.toString());
				// set pagging.
				 String size = String.valueOf(getSize(session, instance,searchKey,indexChar,orderColumn,
							orderBy)); 
				 logger.info(" first Result="+(pagging.getPageSize()* (pagging.getPageNo() - 1))); 
				 
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
