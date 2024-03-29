package th.co.vlink.managers;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import th.co.vlink.hibernate.bean.BpsAttachFile;

public interface BpsAttachFileService {
	public Long saveBpsAttachFile(BpsAttachFile transientInstance) throws DataAccessException;
	public int updateBpsAttachFile(BpsAttachFile transientInstance) throws DataAccessException ;
	public int deleteBpsAttachFile(BpsAttachFile persistentInstance) throws DataAccessException ;	
	public BpsAttachFile findBpsAttachFileById(Long ncId)throws DataAccessException  ;
	@SuppressWarnings("rawtypes")
	public  List searchBpsAttachFile(BpsAttachFile persistentInstance)throws DataAccessException  ;
	@SuppressWarnings("rawtypes")
	public List searchBpsAttachFile(BpsAttachFile instance,Map likeExpression ,Map leExpression ,Map geExpression)throws DataAccessException  ;

}
