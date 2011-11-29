package th.co.vlink.hibernate;

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import th.co.vlink.hibernate.bean.CopWorkProcedureMailUser;
import th.co.vlink.managers.CopWorkProcedureMailUserService;
 
@Repository
@Transactional
public class HibernateCopWorkProcedureMailUser extends HibernateCommon implements CopWorkProcedureMailUserService {
	private static final Logger logger = Logger.getLogger("bpsAppender");
	private SessionFactory sessionAnnotationFactory;
	public SessionFactory getSessionAnnotationFactory() {
		return sessionAnnotationFactory;
	}
	public void setSessionAnnotationFactory(SessionFactory sessionAnnotationFactory) {
		this.sessionAnnotationFactory = sessionAnnotationFactory;
	}
	@SuppressWarnings("unchecked")
	public CopWorkProcedureMailUser getCopWorkProcedureMailUser()
			throws DataAccessException {
		// TODO Auto-generated method stub
		
		Query query =sessionAnnotationFactory.getCurrentSession().createQuery("from CopWorkProcedureMailUser ");
		List<CopWorkProcedureMailUser> copWorkProcedureMailUsers=query.list();
		if(copWorkProcedureMailUsers!=null && copWorkProcedureMailUsers.size()>0)
			return (CopWorkProcedureMailUser)copWorkProcedureMailUsers.get(0);
		else
			return null;
	}

}
