package th.co.vlink.bps.service.impl;

import java.util.List;

import th.co.vlink.bps.service.BpsAdminService;
import th.co.vlink.constant.ServiceConstant;
import th.co.vlink.xstream.BpsAttachFile;
import th.co.vlink.xstream.BpsGroup;
import th.co.vlink.xstream.BpsTerm;
import th.co.vlink.xstream.BpsTermLog;
import th.co.vlink.xstream.BpsTermVersion;
import th.co.vlink.xstream.common.VResultMessage;
 
public class BpsAdminServiceImpl extends PostCommon implements BpsAdminService {
    // BPS_GROUP
	public int saveBpsGroup(BpsGroup bpsGroup) {
		bpsGroup.setServiceName(ServiceConstant.BPS_GROUP_SAVE);
		VResultMessage resultMessage=postMessage(bpsGroup,bpsGroup.getClass().getName(),"bpsGroups/",true);
		bpsGroup = (BpsGroup)resultMessage.getResultListObj().get(0);
		return bpsGroup.getUpdateRecord();
	}

	public int updateBpsGroup(BpsGroup bpsGroup) {
		bpsGroup.setServiceName(ServiceConstant.BPS_GROUP_UPDATE);
		VResultMessage resultMessage =postMessage(bpsGroup,bpsGroup.getClass().getName(),"bpsGroups/",true);
		bpsGroup = (BpsGroup)resultMessage.getResultListObj().get(0);
		return bpsGroup.getUpdateRecord();
	}

	public int deleteBpsGroup(String key) {
		BpsGroup bpsGroup = new BpsGroup();
		bpsGroup.setBpgId(Long.parseLong(key));
		bpsGroup.setServiceName(ServiceConstant.BPS_GROUP_DELETE);
		VResultMessage resultMessage =postMessage(bpsGroup,bpsGroup.getClass().getName(),"bpsGroups/",true);
		bpsGroup = (BpsGroup)resultMessage.getResultListObj().get(0);
		return bpsGroup.getUpdateRecord();
	}

	public BpsGroup findBpsGroupById(String bpgId) {
		BpsGroup bpsGroup = new BpsGroup();
		bpsGroup.setBpgId(new Long(bpgId));
		bpsGroup.setServiceName(ServiceConstant.BPS_GROUP_FIND_BY_ID);
		VResultMessage resultMessage = postMessage(bpsGroup,bpsGroup.getClass().getName(),"bpsGroups/",true);
		return (BpsGroup)resultMessage.getResultListObj().get(0);

	}

	public VResultMessage searchBpsGroup(BpsGroup bpsGroup) {
		bpsGroup.setServiceName(ServiceConstant.BPS_GROUP_SEARCH);
		return postMessage(bpsGroup,bpsGroup.getClass().getName(),"bpsGroups/",true);

	}
	public int checkDuplicateGroup(String groupName) {
		BpsGroup bpsGroup = new BpsGroup();
		bpsGroup.setBpgGroupName(groupName);
		bpsGroup.setServiceName(ServiceConstant.BPS_GROUP_CHECK_DUPLICATE);
		VResultMessage resultMessage =postMessage(bpsGroup,bpsGroup.getClass().getName(),"bpsGroups/",true);
		bpsGroup = (BpsGroup)resultMessage.getResultListObj().get(0);
		return bpsGroup.getUpdateRecord();
	}
    // BPS_TERM
	public int saveBpsTerm(BpsTerm bpsTerm) {
		bpsTerm.setServiceName(ServiceConstant.BPS_TERM_SAVE);
		VResultMessage resultMessage =postMessage(bpsTerm,bpsTerm.getClass().getName(),"bpsTerms/",true);
		bpsTerm = (BpsTerm)resultMessage.getResultListObj().get(0);
		return bpsTerm.getUpdateRecord();
	}

	public int updateBpsTerm(BpsTerm bpsTerm) {
		bpsTerm.setServiceName(ServiceConstant.BPS_TERM_UPDATE);
		VResultMessage resultMessage =postMessage(bpsTerm,bpsTerm.getClass().getName(),"bpsTerms/",true);
		bpsTerm = (BpsTerm)resultMessage.getResultListObj().get(0);
		return bpsTerm.getUpdateRecord();
	}
	public int updateBpsTermVersion(BpsTerm bpsTerm) {
		// TODO Auto-generated method stub
		bpsTerm.setServiceName(ServiceConstant.BPS_TERM_UPDATE_VERSION);
		VResultMessage resultMessage =postMessage(bpsTerm,bpsTerm.getClass().getName(),"bpsTerms/",true);
		bpsTerm = (BpsTerm)resultMessage.getResultListObj().get(0);
		return bpsTerm.getUpdateRecord();
	}

	public int deleteBpsTerm(String key) {
		BpsTerm bpsTerm = new BpsTerm();
		bpsTerm.setBptId(Long.parseLong(key));
		bpsTerm.setServiceName(ServiceConstant.BPS_TERM_DELETE);
		VResultMessage resultMessage =postMessage(bpsTerm,bpsTerm.getClass().getName(),"bpsTerms/",true);
		bpsTerm = (BpsTerm)resultMessage.getResultListObj().get(0);
		return bpsTerm.getUpdateRecord();
	}

	public BpsTerm findBpsTermById(String bpgId) {
		BpsTerm bpsTerm = new BpsTerm();
		bpsTerm.setBptId(new Long(bpgId));
		bpsTerm.setServiceName(ServiceConstant.BPS_TERM_FIND_BY_ID);
		VResultMessage resultMessage = postMessage(bpsTerm,bpsTerm.getClass().getName(),"bpsTerms/",true);
		return (BpsTerm)resultMessage.getResultListObj().get(0);

	}

	public VResultMessage searchBpsTerm(BpsTerm bpsTerm) {
		bpsTerm.setServiceName(ServiceConstant.BPS_TERM_SEARCH);
		return postMessage(bpsTerm,bpsTerm.getClass().getName(),"bpsTerms/",true);

	}
	// BPS_TERM_LOG
	public int deleteBpsTermLog(String key) {
		BpsTermLog bpsTermLog = new BpsTermLog();
		bpsTermLog.setBptlId(Long.parseLong(key));
		bpsTermLog.setServiceName(ServiceConstant.BPS_TERM_LOG_DELETE);
		VResultMessage resultMessage =postMessage(bpsTermLog,bpsTermLog.getClass().getName(),"bpsTermLogs/",true);
		bpsTermLog = (BpsTermLog)resultMessage.getResultListObj().get(0);
		return bpsTermLog.getUpdateRecord();
	}

	public BpsTermLog findBpsTermLogById(String bptlId) {
		BpsTermLog bpsTermLog = new BpsTermLog();
		bpsTermLog.setBptlId(new Long(bptlId));
		bpsTermLog.setServiceName(ServiceConstant.BPS_TERM_LOG_FIND_BY_ID);
		VResultMessage resultMessage = postMessage(bpsTermLog,bpsTermLog.getClass().getName(),"bpsTermLogs/",true);
		return (BpsTermLog)resultMessage.getResultListObj().get(0);

	}

	public VResultMessage searchBpsTermLog(BpsTermLog bpsTermLog) {
		bpsTermLog.setServiceName(ServiceConstant.BPS_TERM_LOG_SEARCH); 
		VResultMessage resultMessage =postMessage(bpsTermLog,bpsTermLog.getClass().getName(),"bpsTermLogs/",true);
		return resultMessage;

	}
	// BPS_TERM_VERSION
	public VResultMessage searchBpsTermVersion(BpsTermVersion bpsTermVersion) {
		bpsTermVersion.setServiceName(ServiceConstant.BPS_TERM_VERSION_SEARCH);
		return postMessage(bpsTermVersion,bpsTermVersion.getClass().getName(),"bpsTermVersions/",true);

	
	}
	
	public BpsTermVersion findBpsTermVersionById(String bpgId) {
		BpsTermVersion bpsTermVersion = new BpsTermVersion();
		bpsTermVersion.setBptvId(new Long(bpgId));
		bpsTermVersion.setServiceName(ServiceConstant.BPS_TERM_VERSION_FIND_BY_ID);
		VResultMessage resultMessage = postMessage(bpsTermVersion,bpsTermVersion.getClass().getName(),"bpsTermVersions/",true);
		return (BpsTermVersion)resultMessage.getResultListObj().get(0);

	}
	// BPS_FILE
	public int saveBpsAttachFile(BpsAttachFile bpsAttachFile) {
		bpsAttachFile.setServiceName(ServiceConstant.BPS_ATTACH_FILE_SAVE);
		//postMessage(bpsAttachFile,bpsAttachFile.getClass().getName(),"bpsAttachFiles/",false);
		VResultMessage resultMessage =postMessage(bpsAttachFile,bpsAttachFile.getClass().getName(),"bpsAttachFiles/",true);
		bpsAttachFile = (BpsAttachFile)resultMessage.getResultListObj().get(0);
		return bpsAttachFile.getUpdateRecord();
	}
 

	public int deleteBpsAttachFile(String key) {
		BpsAttachFile bpsAttachFile = new BpsAttachFile();
		bpsAttachFile.setBpafId(Long.parseLong(key));
		bpsAttachFile.setServiceName(ServiceConstant.BPS_ATTACH_FILE_DELETE); 
		VResultMessage resultMessage =postMessage(bpsAttachFile,bpsAttachFile.getClass().getName(),"bpsAttachFiles/",true);
		bpsAttachFile = (BpsAttachFile)resultMessage.getResultListObj().get(0);
		return bpsAttachFile.getUpdateRecord();
	}

	public BpsAttachFile findBpsAttachFileById(String bpgId) {
		BpsAttachFile bpsAttachFile = new BpsAttachFile();
		bpsAttachFile.setBpafId(new Long(bpgId));
		bpsAttachFile.setServiceName(ServiceConstant.BPS_ATTACH_FILE_FIND_BY_ID);
		VResultMessage resultMessage = postMessage(bpsAttachFile,bpsAttachFile.getClass().getName(),"bpsAttachFiles/",true);
		return (BpsAttachFile)resultMessage.getResultListObj().get(0);

	}

	public VResultMessage searchBpsAttachFile(BpsAttachFile bpsAttachFile) {
		bpsAttachFile.setServiceName(ServiceConstant.BPS_ATTACH_FILE_SEARCH);
		return postMessage(bpsAttachFile,bpsAttachFile.getClass().getName(),"bpsAttachFiles/",true);

	}
	public void testBpsGroup(){
		 BpsGroup bpsGroup=new BpsGroup();
		// bpsGroup.setBpgId(1L);
		 bpsGroup.setBpgGroupName("Group K");
		 /*VResultMessage vresultMessage =searchBpsGroup(bpsGroup);
		 if(vresultMessage!=null && vresultMessage.getResultListObj()!=null){
		 }
		 */
		
		saveBpsGroup(bpsGroup);
		//  updateBpsGroup(bpsGroup);
		// BpsGroup group= findBpsGroupById("1");
		//  deleteBpsGroup("1");
	}
	public void testBpsTerm(){
		/* BpsGroup bpsGroup=new BpsGroup();
		 bpsGroup.setBpgId(2L);*/
		 BpsTerm bpsTerm=new BpsTerm();
		// bpsTerm.setBpsGroup(bpsGroup);
		 bpsTerm.setBptId(1L);
		 
		 String bptTerm="liferay";
		 String orderBy="desc";
		 String orderColumn="BPT_TERM";
		 String indexChar="l";
		 String searchBy="2";
		 bpsTerm.setBptTerm(bptTerm);
		 bpsTerm.getVcriteria().setKey(searchBy);
		/* Pagging page=new Pagging();
		 page.setPageNo(2);
		 page.setPageSize(20);
		 bpsTerm.setPagging(page);*/
			//bpsTerm.setBptTerm(bptTerm);
			bpsTerm.getVcriteria().setValue(bptTerm) ;
			bpsTerm.getVcriteria().setOrderBy(orderBy);
			bpsTerm.getVcriteria().setOrderColumn(orderColumn);
			bpsTerm.getVcriteria().setIndexChar(indexChar);
		  bpsTerm.setBptDefinition("bptTerm");
		  bpsTerm.setBptDefinitionSearch("bptTerm");
		 VResultMessage vresultMessage =searchBpsTerm(bpsTerm);
		 if(vresultMessage!=null && vresultMessage.getResultListObj()!=null){
			 List xx = vresultMessage.getResultListObj();
			 for (int i = 0; i < xx.size(); i++) {
				 BpsTerm term = (BpsTerm)xx.get(i);
			}
		 }
		 
		
		//saveBpsTerm(bpsTerm);
		//   updateBpsTerm(bpsTerm);
		// BpsTerm group= findBpsTermById("1");
		 //  deleteBpsTerm("2");
	}
	public void testBpsTermVersion(){
		 BpsTerm bpsTerm=new BpsTerm(); 
		 bpsTerm.setBptId(1L);
		 BpsTermVersion bpsTermVersion=new BpsTermVersion();
		 bpsTermVersion.setBptvId(1L);
		 bpsTermVersion.setBpsTerm(bpsTerm);
		 bpsTermVersion.setBptTerm("Term A");
		 bpsTermVersion.setBptDefinition("BptDefinitio Term A");
		 VResultMessage vresultMessage =searchBpsTermVersion(bpsTermVersion);
		 if(vresultMessage!=null && vresultMessage.getResultListObj()!=null){
		 }
		 
		
	//	saveBpsTerm(bpsTerm)ermVersion(bpsTermVersion);
		//  updateBpsGroup(bpsGroup);
		// BpsGroup group= findBpsGroupById("1");
		//  deleteBpsGroup("1");
	}
	public void testBpsAttachFile(){
		 BpsTerm bpsTerm=new BpsTerm(); 
		 bpsTerm.setBptId(1L);
		 BpsAttachFile bpsAttachFile=new BpsAttachFile();
	//	 bpsAttachFile.setBpafId(1L);
		 bpsAttachFile.setBpsTerm(bpsTerm);
	//	 bpsAttachFile.setBpafFileName("BpafFileName B");
	//	 bpsAttachFile.setBpafFilePath("BpafFilePath B");
		 VResultMessage vresultMessage =searchBpsAttachFile(bpsAttachFile);
		 if(vresultMessage!=null && vresultMessage.getResultListObj()!=null){
		 }
		 
		
	//	saveBpsAttachFile(bpsAttachFile);
		//  updateBpsAttacheFile(bpsAttachFile);
		// BpsAttacheFile group= findBpsAttacheFileById("1");
		//  deleteBpsAttacheFile("1");
	}
	 /*public static void main(String[] args) {
		 BpsAdminServiceImpl imp =new BpsAdminServiceImpl();
		// imp.testBpsGroup();
		 imp.testBpsTerm();
		 //imp.testBpsAttachFile();
	}*/

	
}
