package th.co.vlink.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.vlink.hibernate.bean.BpsTermLog;
import th.co.vlink.hibernate.bean.BpsGroup;

public interface BpsTermLogService {
	public int deleteBpsTermLog(BpsTermLog persistentInstance)
			throws DataAccessException;

	public BpsTermLog findBpsTermLogById(Long bptId) throws DataAccessException;
	public BpsGroup findBpsGroupById(Long bpgId) throws DataAccessException;
	@SuppressWarnings("rawtypes")
	public List searchBpsTermLog(BpsTermLog persistentInstance, String searchKey,
			String indexChar, String orderColumn, String orderBy)
			throws DataAccessException;
	public Long saveBpsTermLog(BpsTermLog transientInstance)throws DataAccessException;
}
