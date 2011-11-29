package th.co.vlink.managers;

import org.springframework.dao.DataAccessException;

import th.co.vlink.hibernate.bean.CopWorkProcedureMailUser;

public interface CopWorkProcedureMailUserService {
	public CopWorkProcedureMailUser getCopWorkProcedureMailUser()throws DataAccessException  ;
}
