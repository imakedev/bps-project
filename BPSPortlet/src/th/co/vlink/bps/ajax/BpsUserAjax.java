package th.co.vlink.bps.ajax;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;

import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import th.co.vlink.bps.service.BpsUserService;
import th.co.vlink.bps.util.MailRunnable;
import th.co.vlink.bps.util.Utils;
import th.co.vlink.xstream.BpsTerm;
import th.co.vlink.xstream.BpsTermLog;
import th.co.vlink.xstream.common.VResultMessage;

public class BpsUserAjax {
	private BpsUserService bpsUserService;

	public BpsUserAjax() {
		WebContext ctx = WebContextFactory.get();
		ServletContext servletContext = ctx.getServletContext();
		WebApplicationContext wac = WebApplicationContextUtils
				.getRequiredWebApplicationContext(servletContext);
		bpsUserService = (BpsUserService) wac.getBean("bpsUserService");

	}
	
	public int saveOrUpdateBpsTerm(BpsTerm bpsTerm,String mode){
		String bptIndexChar = bpsTerm.getBptTerm().trim().substring(0, 1);
		bpsTerm.setBptIndexChar(bptIndexChar);
		bpsTerm.setBptCreateDate(new Timestamp(new Date().getTime()));
		return bpsUserService.saveBpsTerm(bpsTerm);
	}
	public int saveOrUpdateBpsTermLog(BpsTermLog bpsTermLog,String subjectMail,String mode){
		String bptIndexChar = bpsTermLog.getBptTerm().trim().substring(0, 1);
		bpsTermLog.setBptIndexChar(bptIndexChar);
		return bpsUserService.saveBpsTermLog(bpsTermLog,subjectMail,mode);
	}
	
	public void sendMail(BpsTerm bpsTerm,String mode) {
		List recipients = new ArrayList();
		String subject = Utils.getProperty("SUBJECT_MAIL");
		String messagebody = "";
		MailRunnable mailRunnable = new MailRunnable(Utils.getProperty("SMTP_PROTOCOL"), Utils.getProperty("SMTP_HOST"), Utils.getProperty("USERNAME"), Utils.getProperty("PASSWORD"), "0", recipients, subject, messagebody, "99");
		Thread thread = new Thread(mailRunnable);
		thread.start();
	}
	public List searchBpsTerm(BpsTerm bpsTerm) {
		List result = null;
		VResultMessage vresultMessage = bpsUserService.searchBpsTerm(bpsTerm);
		if (vresultMessage != null && vresultMessage.getResultListObj() != null
				&& vresultMessage.getMaxRow() != null) {
			result = new ArrayList(2);
			result.add(vresultMessage.getResultListObj());
			result.add(vresultMessage.getMaxRow());
		}
		return result;
	}
	 
	public BpsTerm findBpsTermById(String bptId) {
		return bpsUserService.findBpsTermById(bptId);
	}
	
}
