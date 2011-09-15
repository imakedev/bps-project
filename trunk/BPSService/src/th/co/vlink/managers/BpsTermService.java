package th.co.vlink.managers;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import th.co.vlink.hibernate.bean.BpsTerm;

public interface BpsTermService {
	public void saveBpsTerm(BpsTerm transientInstance) throws DataAccessException;
	public void updateBpsTerm(BpsTerm transientInstance) throws DataAccessException ;
	public void deleteBpsTerm(BpsTerm persistentInstance) throws DataAccessException ;	
	public BpsTerm findBpsTermById(Long bptId)throws DataAccessException  ;
	@SuppressWarnings("unchecked")
	public  List searchBpsTerm(BpsTerm persistentInstance)throws DataAccessException  ;
	public List searchBpsTerm(BpsTerm instance,Map likeExpression ,Map leExpression ,Map geExpression)throws DataAccessException  ;

}
