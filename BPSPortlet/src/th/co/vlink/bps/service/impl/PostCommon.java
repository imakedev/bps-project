package th.co.vlink.bps.service.impl;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ByteArrayEntity;
import org.apache.http.impl.client.DefaultHttpClient;

import th.co.vlink.constant.ServiceConstant;
import th.co.vlink.utils.Pagging;
import th.co.vlink.xstream.common.VResultMessage;
import th.co.vlink.xstream.common.VServiceXML;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.Dom4JDriver;
 
public class PostCommon {
	public static final int PAGE_SIZE = 5; 
	public VResultMessage postMessage(VServiceXML vserviceXML,String className,String endPoint,boolean isReturn) {
		//HttpPost httppost = new HttpPost(ServiceConstant.hostReference+endPoint); 
		HttpPost httppost = new HttpPost("http://localhost:3000/v1/"+endPoint);
		XStream xstream = new XStream(new Dom4JDriver());
		Class c  = null;
		try {
			  c = Class.forName(className);
		} catch (ClassNotFoundException e2) {
			e2.printStackTrace();
		}
		xstream.processAnnotations(c);
		//vserviceXML
		//NtcFaq ntcFaq = (NtcFaq)vserviceXML;
		int startIndex = 0;
		/*if(ntcFaq.getPagging()==null){
			th.or.ntc.utils.Pagging  p = new th.or.ntc.utils.Pagging();
			p.setPageNo(1);
			p.setPageSize(PAGE_SIZE);
			ntcFaq.setPagging(p);
		}
		startIndex = ntcFaq.getPagging().getPageNo()==1?0:(ntcFaq.getPagging().getPageNo()-1)*ntcFaq.getPagging().getPageSize();
		ntcFaq.getPagging().setStartIndex(startIndex);*/
		if(vserviceXML.getPagging()==null){
			Pagging p = new Pagging();
			p.setPageNo(1);
			p.setPageSize(PAGE_SIZE);
			vserviceXML.setPagging(p);
		}
		startIndex = vserviceXML.getPagging().getPageNo()==1?0:(vserviceXML.getPagging().getPageNo()-1)*vserviceXML.getPagging().getPageSize();
		vserviceXML.getPagging().setStartIndex(startIndex);
		//String xString = xstream.toXML(ntcFaq); 
		String xString = xstream.toXML(vserviceXML);
//		System.out.println("xString\n"+xString);
		ByteArrayEntity entity = null;
		try {
			entity = new ByteArrayEntity(xString.getBytes("UTF-8"));
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		httppost.setEntity(entity); 
		HttpClient httpclient = new DefaultHttpClient(); 
		HttpResponse response = null;
		HttpEntity resEntity = null;
		try {
			response = httpclient.execute(httppost);
			resEntity = response.getEntity();
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		VResultMessage  vresultMessage = null; 
		InputStream in = null;
	if (isReturn) {
	 if (resEntity != null) {
	
			try {
			/*	System.out.println("1 Response content length: "
						+ resEntity.getContentLength());
				System.out.println("1 Chunked?: " + resEntity.isChunked());*/
				in = resEntity.getContent();
				xstream.processAnnotations(VResultMessage.class); 
//				xstream.processAnnotations(th.or.ntc.xstream.OfficeCalendar.class); 
			/*	xstream.processAnnotations(th.or.ntc.xstream.NtcRadioApprovalGroup.class); 
				*/ 
				Object obj = xstream.fromXML(in);
//				System.out.println("obj : "+obj.getClass());
				if(obj!=null){
					vresultMessage = (VResultMessage)obj; 
					 
					int maxRow = 0;
					if(vresultMessage.getMaxRow()!=null && !vresultMessage.getMaxRow().equals(""))
						maxRow = Integer.parseInt(vresultMessage.getMaxRow());
					//int pageSize = ntcFaq.getPagging().getPageSize();
					int pageSize = 0;
					if(vserviceXML.getPagging()!=null )
						pageSize = vserviceXML.getPagging().getPageSize();				
					int lastpage = (maxRow/pageSize)+((maxRow%pageSize)==0?0:1);
					vresultMessage.setLastpage(lastpage+"");
				}
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					if(in!=null)
					in.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			/*System.out.println("2 Response content length: "
					+ resEntity.getContentLength());
			System.out.println("2 Chunked?: " + resEntity.isChunked());*/
		}
	}
		httpclient.getConnectionManager().shutdown();
		return    vresultMessage ;
	}
}
