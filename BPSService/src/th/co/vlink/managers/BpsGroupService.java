package th.co.vlink.managers;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import th.co.vlink.hibernate.bean.BpsGroup;

public interface BpsGroupService {
	public Long saveBpsGroup(BpsGroup transientInstance) throws DataAccessException;
	public int updateBpsGroup(BpsGroup transientInstance) throws DataAccessException ;
	public int deleteBpsGroup(BpsGroup persistentInstance) throws DataAccessException ;
	public int checkDuplicateGroup(BpsGroup persistentInstance) throws DataAccessException ;	
	public BpsGroup findBpsGroupById(Long bpgId)throws DataAccessException  ;
	@SuppressWarnings("rawtypes")
	public  List searchBpsGroup(BpsGroup persistentInstance)throws DataAccessException  ;
	@SuppressWarnings("rawtypes")
	public List searchBpsGroup(BpsGroup instance,Map likeExpression ,Map leExpression ,Map geExpression)throws DataAccessException  ;

}
