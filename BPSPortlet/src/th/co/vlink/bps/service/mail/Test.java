package th.co.vlink.bps.service.mail;

import java.util.ArrayList;
import java.util.List;

public class Test { 
	public static void main(String[] args) {
		/*public MailRunnable(String protocal_,String  host_,String email_ ,String  password_,String  useAuthen_,
				List recipients
				,String subject,String messagebody,String sessionId) {
			prop.put("mail.smtp.host", "SMTP-Relay.pttep.com");   
			prop.put("mail.smtp.port", "25");
			prop.put("protocol", "smtp");
		}*/
		//siripornp@
		List recipients =new ArrayList();
		recipients.add("zuser9_t@banpu.co.th");
		MailRunnable mailRunnable = new MailRunnable("smtp","210.1.21.6","zuser9_t@banpu.co.th","Pass2011","0",
				recipients,"Send Mail","+_+","99");			
		Thread mailThread = new Thread(mailRunnable);
		mailThread.start(); 
	}
}
