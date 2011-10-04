package th.co.vlink.hibernate;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

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

import th.co.vlink.hibernate.bean.BpsGroup;
import th.co.vlink.hibernate.bean.BpsTerm;
import th.co.vlink.managers.BpsTermService;
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
		return save(sessionAnnotationFactory.getCurrentSession(), transientInstance);
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
	public List searchBpsTerm(BpsTerm instance,String searchKey ) throws DataAccessException {
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
			System.out.println("search key="+searchKey);
			System.out.println("bptTerm="+bptTerm);
			if(bpsGroup!=null)
				System.out.println("bpsGroup="+bpsGroup.getBpgId
					());
			 
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
			if(bptTerm !=null && bptTerm.trim().length() > 0){   	
				if(searchKey!=null){
					  //1=by term ,2 =by Difinition , 3 all
						if(searchKey.equals("1")){ 
							 criteria.add(Expression.like("bptTerm", "%"+bptTerm.trim()+"%").ignoreCase());
						}else if(searchKey.equals("2")){
							//bptDefinitionSearch
							 criteria.add(Expression.like("bptDefinition", "%"+bptTerm.trim()+"%").ignoreCase());
						}else if(searchKey.equals("3")){
							criteria.add(Expression.or
									 (Expression.like("bptTerm", "%"+bptTerm.trim()+"%").ignoreCase(),
									 Expression.like("bptDefinition", "%"+bptTerm.trim()+"%").ignoreCase()));
							/*
							 crit.add(Expression.or
									 (Expression.eq("lngInsuranceId",new Long(3)),
									  Expression.eq("lngInsuranceId",new Long(6))));*/
						} 
				}else{
					 criteria.add(Expression.like("bptTerm", "%"+bptTerm.trim()+"%").ignoreCase());
				}
				
					// iscriteria = true;
			}if(bpsGroup !=null && bpsGroup.getBpgId() != null && bpsGroup.getBpgId() > 0){  
					 criteria.add(Expression.eq("bpsGroup.bpgId", bpsGroup.getBpgId()));	
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
			 String size = String.valueOf(getSize(session, instance,searchKey)); 
			 
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
	 private int getSize(Session session, BpsTerm instance,String searchKey) throws Exception{
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
				if(bptTerm !=null && bptTerm.trim().length() > 0){ 
					if(searchKey!=null){
						  //1=by term ,2 =by Difinition , 3 all
							if(searchKey.equals("1")){ 
								 criteria.add(Expression.like("bptTerm", "%"+bptTerm.trim()+"%").ignoreCase());
							}else if(searchKey.equals("2")){
								//bptDefinitionSearch
								 criteria.add(Expression.like("bptDefinition", "%"+bptTerm.trim()+"%").ignoreCase());
							}else if(searchKey.equals("3")){
								criteria.add(Expression.or
										 (Expression.like("bptTerm", "%"+bptTerm.trim()+"%").ignoreCase(),
										 Expression.like("bptDefinition", "%"+bptTerm.trim()+"%").ignoreCase()));
								/*
								 crit.add(Expression.or
										 (Expression.eq("lngInsuranceId",new Long(3)),
										  Expression.eq("lngInsuranceId",new Long(6))));*/
							} 
					}else{
						 criteria.add(Expression.like("bptTerm", "%"+bptTerm.trim()+"%").ignoreCase());
					}
						// iscriteria = true;
				}if(bpsGroup !=null && bpsGroup.getBpgId() != null && bpsGroup.getBpgId() > 0){  
						 criteria.add(Expression.eq("bpsGroup.bpgId", bpsGroup.getBpgId()));	
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
	public int deleteBpsTerm(BpsTerm persistentInstance)
			throws DataAccessException {
		// TODO Auto-generated method stub
		return delete(sessionAnnotationFactory.getCurrentSession(), persistentInstance);
	}

}
