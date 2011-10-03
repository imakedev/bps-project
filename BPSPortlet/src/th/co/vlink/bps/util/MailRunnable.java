package th.co.vlink.bps.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.NoSuchProviderException;
import javax.mail.Session;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.apache.commons.lang.StringEscapeUtils;
import org.springframework.web.multipart.MultipartFile;
 

import com.sun.mail.smtp.SMTPTransport;

public class MailRunnable implements Runnable {
	String subject = null;
	String messagebody = null;
	String sessionId= null;
	String protocal=null;
	String  host=null;
	String email =null;
	String  password=null;
	String  useAuthen=null;
	List recipients=null;
	public MailRunnable(String protocal_,String  host_,String email_ ,String  password_,String  useAuthen_,
			List recipients
			,String subject,String messagebody,String sessionId) {
		this.subject = subject;
		this.messagebody = messagebody;
		this.sessionId = sessionId;
		this.protocal=protocal_;
		this. host=host_;
		this.email =email_;
		this. password=password_;
		this. useAuthen=useAuthen_;
		this.recipients=recipients;
	}
	public void run() { 
		File temp  = null;
		Properties props = new Properties();
		    // XXX - could use Session.getTransport() and Transport.connect()
		    // XXX - assume we're using SMTP
		    //if (mailhost != null)		
	/*	String protocal =protocal_;
		String host =host_;
		String useAuthen = useAuthen_;
		String email = email_;
		String password = password_; */
	    boolean isAuthen = false;
			//props.put("mail.transport.protocol", protocal);//"smtp");
	    props.put("protocol", protocal);//"smtp");
		/*	if(protocal!=null && protocal.toLowerCase().equals("smtp"))
				props.put("mail.smtp.starttls.enable","true");*/
			props.put("mail.smtp.host", host);//"smtp.gmail.com");
			props.put("mail.smtp.port","25");
			
			 
			//props.put("mail.smtp.ssl.enable", "true");
			if(useAuthen!=null && useAuthen.equals("1")){
				isAuthen = true;
			}
			if(isAuthen)
			  props.put("mail.smtp.auth", "true");
			// Get a Session object 
		   
		    
		   /* Construct the message and send it.
		     */
		   // MimeMessage msg = new MimeMessage(session); 
		    
		  /*  try {
				msg.setFrom(new InternetAddress(email));//"chatchai@vlink.co.th"));
			} catch (AddressException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} catch (MessagingException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}*/
			
		//	String[] recipients=null;
			//if(ntcNewsLetterRecipient!=null && ntcNewsLetterRecipient.size()>0){
			 	int size = recipients.size();
				//recipients= new String[1];
			 	for (int i = 0; i < size; i++) {
					
					 //Session session = Session.getInstance(props, null);
					 Session session = Session.getDefaultInstance(props, null);
					    session.setDebug(true);
				//	NtcNewsLetterRecipient ntcNewsLetterRecipient = (NtcNewsLetterRecipient)ntcNewsLetterRecipientList.get(i);
				//	recipients[0] = "siripornc@pttep.com";//ntcNewsLetterRecipient.getNnlrAddress().trim();
				/*		recipients[0] = "chatchai@vlink.co.th";//ntcNewsLetterRecipient.getNnlrAddress().trim();
					System.out.println(" sent mail loopxx  email "+recipients[0]);*/
			/*else{
				recipients= new String[0];
			}*/
			MimeMessage msgArray[] = null;// new MimeMessage(session); 
			try {
				msgArray = new MimeMessage[1];//recipients.length];  
		    	InternetAddress[] addressTo = new InternetAddress[1];//recipients.length];
		    	Date date = new Date();
		    	StringBuffer sb = new StringBuffer();
				sb.append("<HTML>\n");
				sb.append("<HEAD>\n");
				sb.append("<TITLE>\n");
				sb.append(" PTTEP " + "\n");
				sb.append("</TITLE>\n");
				sb.append("</HEAD>\n");
				sb.append("<BODY>\n");
				sb.append(messagebody);
				sb.append("\n");
				sb.append("</BODY>\n");
				sb.append("</HTML>\n");
				MimeBodyPart mbp1 = new MimeBodyPart(); 
				String message = StringEscapeUtils.unescapeHtml(sb.toString());
				mbp1.setContent(message, "text/html; charset=UTF-8");		
				
				Multipart mp = new MimeMultipart();
				mp.addBodyPart(mbp1);				 
				
				/*if(multipartRequest!=null){							 
				MultipartFile multipart = multipartRequest.getFile("file");
					if(multipart!=null){
						FileOutputStream fos = null;
						
						try {
							byte []filesize = multipart.getBytes();
							if(filesize.length>0){
							 MimeBodyPart mbp2 = new MimeBodyPart();
							 temp = File.createTempFile(sessionId,".howto"); 
							 temp.deleteOnExit();
							 fos = new FileOutputStream(temp.getAbsolutePath());
							
							 fos.write(filesize); 
							 
							 	mbp2.attachFile(temp);
								mbp2.setFileName(multipart.getOriginalFilename());
								mp.addBodyPart(mbp2);
							}
						} catch (IOException e1) {
							// TODO Auto-generated catch block
							e1.printStackTrace();
						}finally{
							if(fos!=null)
								try {
									fos.close();
								} catch (IOException e) {
									// TODO Auto-generated catch block
									e.printStackTrace();
								}	
							 
						} 
					}
				}*/
				InternetAddress addressFrom  = new InternetAddress(email);
		    	//for (int i = 0; i < recipients.length; i++) {
					addressTo[0] = new InternetAddress(((String)recipients.get(i)).trim(),false);
					msgArray[0] = new MimeMessage(session);
					msgArray[0].setFrom(addressFrom); 
					msgArray[0].setRecipient(Message.RecipientType.TO,addressTo[0]);
					msgArray[0].setSentDate(date);
					 try {
						 msgArray[0].setSubject(subject);
						 msgArray[0].setHeader("Content-Transfert-Encoding","8Bit");
						 msgArray[0].setContent(mp);
					 } catch (MessagingException e1) {
							// TODO Auto-generated catch block
							e1.printStackTrace();
					 }
				//} 
			} catch (AddressException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} catch (MessagingException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
	
			
		    SMTPTransport t =null;
			try {
				t = (SMTPTransport)session.getTransport("smtp");
			} catch (NoSuchProviderException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		     
				try {
					//if(isAuthen)
					//	t.connect(host, email, password);
					//else
						t.connect();
						//for (int i = 0; i < msgArray.length; i++) {
							System.out.println("Chatchai Debug==>"+msgArray[0].getAllRecipients().toString());
						//	t.sendMessage(arg0, arg1)send(msgArray[i]);
							t.sendMessage(msgArray[0], msgArray[0].getAllRecipients());
						
						//}
						
				} catch (MessagingException e) {
					// TODO Auto-generated catch block
					//e.printStackTrace();
					//e.printStackTrace();
					//continue;
					e.printStackTrace();
				} 
				  finally {			 
			    	try {
						t.close();
					} catch (MessagingException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					if(temp!=null){
						if(temp.exists() && temp.isFile())
							temp.delete();
					}
			    } 
			}
		//}
	
	}
}
