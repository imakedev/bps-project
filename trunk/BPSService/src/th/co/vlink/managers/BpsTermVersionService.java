package th.co.vlink.managers;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import th.co.vlink.hibernate.bean.BpsTermVersion;

public interface BpsTermVersionService {
	public void saveBpsTermVersion(BpsTermVersion transientInstance) throws DataAccessException;
	public void updateBpsTermVersion(BpsTermVersion transientInstance) throws DataAccessException ;
	public void deleteBpsTermVersion(BpsTermVersion persistentInstance) throws DataAccessException ;	
	public BpsTermVersion findBpsTermVersionById(Long bptId)throws DataAccessException  ;
	@SuppressWarnings("rawtypes")
	public  List searchBpsTermVersion(BpsTermVersion persistentInstance)throws DataAccessException  ;
	@SuppressWarnings("rawtypes")
	public List searchBpsTermVersion(BpsTermVersion instance,Map likeExpression ,Map leExpression ,Map geExpression)throws DataAccessException  ;

}
