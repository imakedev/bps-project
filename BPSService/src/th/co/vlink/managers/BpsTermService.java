package th.co.vlink.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.vlink.hibernate.bean.BpsTerm;

public interface BpsTermService {
	// BANPU_BPS_TERM
	public Long saveBpsTerm(BpsTerm transientInstance) throws DataAccessException;
	public int updateBpsTerm(BpsTerm transientInstance) throws DataAccessException ;
	public int updateBpsTermVersion(BpsTerm transientInstance) throws DataAccessException ; 
	public int deleteBpsTerm(BpsTerm persistentInstance) throws DataAccessException ;	
	public BpsTerm findBpsTermById(Long bptId)throws DataAccessException  ;
	@SuppressWarnings("rawtypes")
	public  List searchBpsTerm(BpsTerm persistentInstance,String searchKey,String indexChar,String orderColumn,
			String orderBy)throws DataAccessException  ;
//	@SuppressWarnings("rawtypes")
//	public List searchBpsTerm(BpsTerm instance,Map likeExpression ,Map leExpression ,Map geExpression)throws DataAccessException  ;
	
}
