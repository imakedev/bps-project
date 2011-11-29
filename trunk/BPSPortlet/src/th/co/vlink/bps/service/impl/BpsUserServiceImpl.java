package th.co.vlink.bps.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;

import th.co.vlink.bps.service.BpsUserService;
import th.co.vlink.bps.service.mail.MailRunnable;
import th.co.vlink.constant.ServiceConstant;
import th.co.vlink.xstream.BpsAttachFile;
import th.co.vlink.xstream.BpsGroup;
import th.co.vlink.xstream.BpsTerm;
import th.co.vlink.xstream.BpsTermLog;
import th.co.vlink.xstream.VUser;
import th.co.vlink.xstream.common.VResultMessage;

public class BpsUserServiceImpl extends PostCommon implements BpsUserService {
	private static ResourceBundle bundle;
	static{
		  //bundle =  ResourceBundle.getBundle( "org/restlet/example/book/restlet/ch8/mailApplication" );
		bundle =  ResourceBundle.getBundle( "sendmail" );				
	}
	// BPS_GROUP
	public VResultMessage searchBpsGroup(BpsGroup bpsGroup) {
		// TODO Auto-generated method stub
		bpsGroup.setServiceName(ServiceConstant.BPS_GROUP_SEARCH);
		 
		return postMessage(bpsGroup,bpsGroup.getClass().getName(),"bpsGroups/",true);
	}

	// BPS_TERM 
	public BpsTerm findBpsTermById(String bpgId) {
		// TODO Auto-generated method stub
		BpsTerm bpsTerm = new BpsTerm();
		bpsTerm.setBptId(new Long(bpgId));
		bpsTerm.setServiceName(ServiceConstant.BPS_TERM_FIND_BY_ID);
		VResultMessage resultMessage = postMessage(bpsTerm,bpsTerm.getClass().getName(),"bpsTerms/",true);
		return (BpsTerm)resultMessage.getResultListObj().get(0);
	}

	public VResultMessage searchBpsTerm(BpsTerm bpsTerm) {
		// TODO Auto-generated method stub
		bpsTerm.setServiceName(ServiceConstant.BPS_TERM_SEARCH);
		return postMessage(bpsTerm,bpsTerm.getClass().getName(),"bpsTerms/",true);
	}
	// BPS_FILE
	public BpsAttachFile findBpsAttachFileById(String bpgId) {
		// TODO Auto-generated method stub
		BpsAttachFile bpsAttachFile = new BpsAttachFile();
		bpsAttachFile.setBpafId(new Long(bpgId));
		bpsAttachFile.setServiceName(ServiceConstant.BPS_ATTACH_FILE_FIND_BY_ID);
		VResultMessage resultMessage = postMessage(bpsAttachFile,bpsAttachFile.getClass().getName(),"bpsAttachFiles/",true);
		return (BpsAttachFile)resultMessage.getResultListObj().get(0);
	}

	public VResultMessage searchBpsAttachFile(BpsAttachFile bpsAttachFile) {
		// TODO Auto-generated method stub
		bpsAttachFile.setServiceName(ServiceConstant.BPS_ATTACH_FILE_SEARCH);
		return postMessage(bpsAttachFile,bpsAttachFile.getClass().getName(),"bpsAttachFiles/",true);
	}
	
	public int saveBpsTerm(BpsTerm bpsTerm) {
		bpsTerm.setServiceName(ServiceConstant.BPS_TERM_SAVE);
		VResultMessage resultMessage=postMessage(bpsTerm,bpsTerm.getClass().getName(),"bpsTerms/",true);
		bpsTerm = (BpsTerm)resultMessage.getResultListObj().get(0);
		return bpsTerm.getUpdateRecord();
	}

	public int updateBpsTerm(BpsTerm bpsTerm) {
		bpsTerm.setServiceName(ServiceConstant.BPS_TERM_UPDATE);
		VResultMessage resultMessage =postMessage(bpsTerm,bpsTerm.getClass().getName(),"bpsTerms/",true);
		bpsTerm = (BpsTerm)resultMessage.getResultListObj().get(0);
		return bpsTerm.getUpdateRecord();
	}

	public int saveBpsTermLog(BpsTermLog bpsTerm,String subjectMail,String mode) {
		// TODO Auto-generated method stub
		try{
		VResultMessage resultMessage=null;
		bpsTerm.setBptMailTo("COS Staff");
		bpsTerm.setBptMailForm(bpsTerm.getBptCreateBy()); 
		bpsTerm.setBptMaiilSubject(subjectMail);
		bpsTerm.setServiceName(ServiceConstant.BPS_TERM_LOG_SAVE);
		 resultMessage=postMessage(bpsTerm,bpsTerm.getClass().getName(),"bpsTermLogs/",true);
		bpsTerm = (BpsTermLog)resultMessage.getResultListObj().get(0);
		VUser vuser =new VUser();
		vuser.setServiceName(ServiceConstant.COP_WORKPROCEDURE_MAIL_USER);
		resultMessage=postMessage(vuser,vuser.getClass().getName(),"bpsUserLdaps/",true);
		vuser = (VUser)resultMessage.getResultListObj().get(0);
		vuser.setBaseDN("CN=00_COS_WCM");
		vuser.setServiceName(ServiceConstant.LDAP_GROUP_FIND_BY_ID);
		resultMessage=postMessage(vuser,vuser.getClass().getName(),"bpsUserLdaps/",true);
		List<VUser> users =resultMessage.getResultListObj();
		String subject="COS Portal: Banpu Term and Definition (Request)";
		if(mode.equals("comment")){
			subject="COS Portal: Banpu Term and Definition (Comment)";
		}
		StringBuffer sb =new StringBuffer();
		sb.append("<table width=\"700\" border=\"0\" cellspacing=\"\"5\" cellpadding=\"0\">");
		sb.append("<tr>");		 
		sb.append("<th colspan=\"2\"><h3>"+subject+"</h3></th>");
		sb.append("</tr>");
		sb.append("<tr>");
		sb.append("   <td height=\"25\"><strong>Subject:</strong></td>");
		sb.append("   <td align=\"left\">"+subjectMail+"</td>");
		sb.append(" </tr>");
		sb.append(" <tr>");
		sb.append("   <td width=\"109\" height=\"25\"><strong>Term:</strong></td>");
		sb.append("   <td width=\"576\" align=\"left\">"+bpsTerm.getBptTerm()+"</td>");
		sb.append(" </tr>");
		sb.append(" <tr>");
		sb.append("   <td height=\"25\"><strong>Link:</strong></td>");
		sb.append("   <td align=\"left\"><a href=\"http://10.2.0.94/wps/myportal/LogsTerms?id="+bpsTerm.getUpdateRecord()+"&mode="+mode+"\" target=\"_blank\">http://10.2.0.94:10040/wps/myportal/COS/BPSLog?id="+bpsTerm.getUpdateRecord()+"</a></td>");
		sb.append(" </tr>");
		sb.append("</table>");
		/*<br>
		<table width="700" border="0" cellspacing="5" cellpadding="0">
		 <tr>
		   <th colspan="2"><h3>COS Portal: Banpu Term and Definition (Request)</h3></th>
		 </tr>
		 <tr>
		   <td height="25"><strong>Subject:</strong></td>
		   <td align="left">ccccc</td>
		 </tr>
		 <tr>
		   <td width="109" height="25"><strong>Term:</strong></td>
		   <td width="576" align="left">ccccc</td>
		 </tr>
		 <tr>
		   <td height="25"><strong>Link:</strong></td>
		   <td align="left"><a href="#">cccccc</a></td>
		 </tr>
		</table>*/
		 

		if(users!=null && users.size()>0){
			List recipients =new ArrayList(users.size());
			for (VUser vUser2 : users) {
				recipients.add(vUser2.getEmail());
			} 
			recipients=new ArrayList<String>(1);
			recipients.add(vuser.getUserid());
	 	MailRunnable mailRunnable = new MailRunnable(bundle.getString("SMTP_PROTOCOL"),bundle.getString("SMTP_HOST"),vuser.getUserid(),vuser.getPassword(),"0",
				recipients,subjectMail,sb.toString(),"99"); 
		Thread mailThread = new Thread(mailRunnable);
		mailThread.start(); 
		}
		return bpsTerm.getUpdateRecord();
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return 0;
	}

	public int updateBpsTermLog(BpsTermLog bpsTerm) {
		// TODO Auto-generated method stub
		bpsTerm.setServiceName(ServiceConstant.BPS_TERM_LOG_UPDATE);
		VResultMessage resultMessage =postMessage(bpsTerm,bpsTerm.getClass().getName(),"bpsTermLogs/",true);
		bpsTerm = (BpsTermLog)resultMessage.getResultListObj().get(0);
		return bpsTerm.getUpdateRecord();
	}
	public static void main(String[] args) {
		BpsUserServiceImpl impl=new BpsUserServiceImpl();
		BpsGroup gr =new BpsGroup();
		gr.setBpgId(2l);
		BpsTermLog log =new BpsTermLog();
		log.setBpsGroup(gr);
		impl.saveBpsTermLog(log, "Test","comment");
	}
}
