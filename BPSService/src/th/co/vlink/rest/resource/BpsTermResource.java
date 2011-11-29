package th.co.vlink.rest.resource;

import java.io.IOException;
import java.io.InputStream;
import java.io.Reader;
import java.math.BigInteger;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.restlet.Context;
import org.restlet.data.Request;
import org.restlet.data.Response;
import org.restlet.resource.Representation;
import org.restlet.resource.ResourceException;
import org.restlet.resource.Variant;

import th.co.vlink.constant.ServiceConstant;
import th.co.vlink.hibernate.bean.BpsGroup;
import th.co.vlink.managers.BpsTermService;
import th.co.vlink.utils.BeanUtility;
import th.co.vlink.utils.Pagging;
import th.co.vlink.xstream.BpsTerm;
import th.co.vlink.xstream.common.FeedModel;
import th.co.vlink.xstream.common.VResultMessage;

public class BpsTermResource extends BaseResource {

	private static final Logger logger = Logger.getLogger("bpsAppender");  
	private static final String BPS_TITLE = "BPS Term And Definition Collection";
	private BpsTermService bpsTermService;
	private com.sun.syndication.feed.atom.Feed feed;
	private com.thoughtworks.xstream.XStream xstream;
	//private String nraId=null;;
	@Override
	public void init(Context context, Request request, Response response) {
		// TODO Auto-generated method stub
		super.init(context, request, response);

	}

	public BpsTermResource() {
		super();
		logger.debug("into constructor BpsTermResource");
		// TODO Auto-generated constructor stub
	}

	public BpsTermResource(Context context, Request request, Response response) {
		super(context, request, response);
		logger.debug("into constructor context, request, response");
	}

	/*
	 * POST
	 * 
	 * @see
	 * org.restlet.resource.Resource#acceptRepresentation(org.restlet.resource
	 * .Representation)
	 */
	@Override
	public void acceptRepresentation(Representation entity)
			throws ResourceException {
		// TODO Auto-generated method stub
		logger.debug("into Post BTS");
		InputStream in = null;
		try {
			in = entity.getStream();
			xstream.processAnnotations(BpsTerm.class);// or xstream.autodetectAnnotations(true); (Auto-detect  Annotations)
			BpsTerm xbpsTerm = new BpsTerm();
			Object ntcCalendarObj = xstream.fromXML(in);
			if (ntcCalendarObj != null) {
				xbpsTerm = (BpsTerm) ntcCalendarObj;
				if (xbpsTerm != null) {
					th.co.vlink.hibernate.bean.BpsTerm bpsTerm = new th.co.vlink.hibernate.bean.BpsTerm();
					BeanUtility.copyProperties(bpsTerm, xbpsTerm); 
					if(xbpsTerm.getBpsGroup()!=null && xbpsTerm.getBpsGroup().getBpgId()!=null
							&&xbpsTerm.getBpsGroup().getBpgId().intValue()!=0){
						BpsGroup bpsGroup = new BpsGroup();
						bpsGroup.setBpgId(xbpsTerm.getBpsGroup().getBpgId());
						bpsTerm.setBpsGroup(bpsGroup);
					}
					if (xbpsTerm.getServiceName() != null
							&& !xbpsTerm.getServiceName().equals("")) {
						logger.debug(" BPS servicename = "
								+ xbpsTerm.getServiceName());
						String serviceName = xbpsTerm.getServiceName();
						if(serviceName.equals(ServiceConstant.BPS_TERM_FIND_BY_ID)){
							th.co.vlink.hibernate.bean.BpsTerm ntcCalendarReturn = bpsTermService.findBpsTermById(bpsTerm.getBptId());
							if(ntcCalendarReturn!=null){
								VResultMessage vresultMessage = new VResultMessage();
								List<BpsTerm> xntcCalendars = new ArrayList<BpsTerm>(1);
								BpsTerm xntcCalendarReturn = new BpsTerm();
								BeanUtility.copyProperties(xntcCalendarReturn, ntcCalendarReturn);								
								th.co.vlink.xstream.BpsGroup xbpsGroup = new th.co.vlink.xstream.BpsGroup();
								BeanUtility.copyProperties(xbpsGroup, ntcCalendarReturn.getBpsGroup());
								xntcCalendarReturn.setBpsGroup(xbpsGroup);
								xntcCalendars.add(xntcCalendarReturn);
								vresultMessage.setResultListObj(xntcCalendars);
								export(entity, vresultMessage, xstream);
							}
						} 
						if(serviceName.equals(ServiceConstant.BPS_TERM_SAVE)){
							logger.info("xntcCalendar.getBpsGroup()="+xbpsTerm.getBpsGroup());
							logger.info("ntcCalendar.getBpsGroup()="+bpsTerm.getBpsGroup());
							java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							bpsTerm.setBptCreateDate(timeStampStartDate);
							int updateRecord=(bpsTermService.saveBpsTerm(bpsTerm)).intValue();
							returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}
						else if(serviceName.equals(ServiceConstant.BPS_TERM_UPDATE)){
							java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							bpsTerm.setBptCreateDate(timeStampStartDate);
							int updateRecord=bpsTermService.updateBpsTerm(bpsTerm);
							returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}
						else if(serviceName.equals(ServiceConstant.BPS_TERM_UPDATE_VERSION)){
							java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							bpsTerm.setBptCreateDate(timeStampStartDate);
							int updateRecord=bpsTermService.updateBpsTermVersion(bpsTerm);
							returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}
						
						else if(serviceName.equals(ServiceConstant.BPS_TERM_DELETE)){
							int updateRecord=bpsTermService.deleteBpsTerm(bpsTerm);
							returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}
						else if(serviceName.equals(ServiceConstant.BPS_TERM_SEARCH)){
							Pagging page = xbpsTerm.getPagging(); 
							bpsTerm.setPagging(page);		 
							
							/*List result = (List) bpsTermService.searchBpsTerm(bpsTerm  ,xbpsTerm.getVcriteria().getKey(),
									xbpsTerm.getVcriteria().getIndexChar(),xbpsTerm.getVcriteria().getOrderColumn(),
									xbpsTerm.getVcriteria().getOrderBy());*/
							List result = (List) bpsTermService.searchBpsTermSQL(bpsTerm  ,xbpsTerm.getVcriteria().getKey(),
									xbpsTerm.getVcriteria().getIndexChar(),xbpsTerm.getVcriteria().getOrderColumn(),
									xbpsTerm.getVcriteria().getOrderBy());
							
							if (result != null && result.size() == 2) {
								/*java.util.List<th.co.vlink.hibernate.bean.BpsTerm> ntcCalendars = (java.util.List<th.co.vlink.hibernate.bean.BpsTerm>) result
										.get(0);*/
								java.util.ArrayList<Object[]> ntcCalendars = (java.util.ArrayList<Object[]>) result
										.get(0);
								 
								String faqs_size = (String) result.get(1);
//								logger.debug("NtcCalendar=" + ntcCalendars + ",faqs_size="
//										+ faqs_size);
								VResultMessage vresultMessage = new VResultMessage();

								List<BpsTerm> xntcCalendars = new ArrayList<BpsTerm>();
								if (faqs_size != null && !faqs_size.equals(""))
									vresultMessage.setMaxRow(faqs_size);
								if (ntcCalendars != null && ntcCalendars.size() > 0) {
									xntcCalendars = getxBpsTermObject(ntcCalendars);
								}
								vresultMessage.setResultListObj(xntcCalendars);
								export(entity, vresultMessage, xstream);
							}
						}
						
					} else {
						// forumServiceHibernate.saveVForum(vforum);
					}
				}

			}

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if (in != null)
					in.close();

			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/*
	 * GET
	 * 
	 * @see
	 * org.restlet.resource.Resource#represent(org.restlet.resource.Variant)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Representation represent(Variant variant) throws ResourceException {

		// TODO Auto-generated method stub 
		logger.debug("into GET BPS_TITLE");		 
				return exportFeed(variant, BPS_TITLE);		 
	}
	

	/*
	 * getFeedModel
	 */

	@Override
	public List search(Pagging pagging) {
		// TODO Auto-generated method stub		
		th.co.vlink.hibernate.bean.BpsTerm ntcCalendar = new th.co.vlink.hibernate.bean.BpsTerm();
		/*if(this.mpaId!=null)
			msoPollVote.setMpqId(new Long(this.mpaId));*/
		ntcCalendar.setPagging(pagging);
		List result = null;//bpsTermService.searchBpsTerm(ntcCalendar);
		return result;
	}
	@Override
	protected  List<FeedModel>  getFeedMedels(List ntcCalendars) {
		// TODO Auto-generated method stub
		List<FeedModel> feedModels = new ArrayList<FeedModel>(
				ntcCalendars.size());
		int size = ntcCalendars.size();
		for (int i = 0; i < size; i++) {
			th.co.vlink.hibernate.bean.BpsTerm ntcCalendar = (th.co.vlink.hibernate.bean.BpsTerm)ntcCalendars.get(i);
			FeedModel feedModel = new FeedModel();
			feedModel.setId(ntcCalendar.getBptId().toString());
			feedModel.setTitle(ntcCalendar.getBptTerm());
			feedModels.add(feedModel);
		}
		return feedModels;
	}

	/*private List<BpsTerm> getxBpsTermObject(
			java.util.List<th.co.vlink.hibernate.bean.BpsTerm> ntcCalendars) {
		List<BpsTerm> xntcCalendars = new ArrayList<BpsTerm>(
				ntcCalendars.size());
		for (th.co.vlink.hibernate.bean.BpsTerm ntcCalendar : ntcCalendars) {
			BpsTerm xntcCalendar = new BpsTerm();
			BeanUtility.copyProperties(xntcCalendar, ntcCalendar); 			
			th.co.vlink.xstream.BpsGroup xbpsGroup = new th.co.vlink.xstream.BpsGroup();
			BeanUtility.copyProperties(xbpsGroup, ntcCalendar.getBpsGroup()); 
			xntcCalendar.setBpsGroup(xbpsGroup);
			xntcCalendars.add(xntcCalendar);
		}
		return xntcCalendars;
	} */
	private String getClobMessage(org.hibernate.lob.SerializableClob clob){
		/*ntcCalendar[5]!=null?(String)ntcCalendar[5]:null
				org.hibernate.lob.SerializableClob clob = webBoardTopicIntraDTO.getWbttraMessageClob();*/
		String message=null; 
		Reader bodyOut = null;
		 if(clob!=null){
		try {
			bodyOut = clob.getCharacterStream();
			 StringBuffer b  = new StringBuffer();
			 char[] charbuf = new char[4096];
			 try {
				for (int k = bodyOut.read(charbuf); k > 0; k = bodyOut.read(charbuf))	{
						b.append(charbuf, 0, k);
				 }
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			 message = b.toString();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}finally{
			try {
				bodyOut.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
		}
		
		/*
			 try {
				 
			 } catch (Throwable e) {
				// TODO Auto-generated catch block
				 e.printStackTrace();
		 	}*/
		
			 //webBoardTopicInter.setWbtiMessage(b.toString());
			 
			 
		 }
	   return message;
	}
	private List<BpsTerm> getxBpsTermObject(
			java.util.ArrayList<Object[]> ntcCalendars) {
		List<BpsTerm> xntcCalendars = new ArrayList<BpsTerm>(
				ntcCalendars.size());
		//System.out.println("ntcCalendars.length"+ntcCalendars.size());
	 
		for (Object[] ntcCalendar : ntcCalendars) {
			BpsTerm xntcCalendar = new BpsTerm();
			xntcCalendar.setBptId(ntcCalendar[1]!=null?((BigInteger)ntcCalendar[1]).longValue():null);
			if(ntcCalendar[2]!=null){
				th.co.vlink.xstream.BpsGroup xbpsGroup = new th.co.vlink.xstream.BpsGroup();
				xbpsGroup.setBpgId(ntcCalendar[2]!=null?((BigInteger)ntcCalendar[2]).longValue():null);
				xbpsGroup.setBpgGroupName(ntcCalendar[15]!=null?((String)ntcCalendar[15]):null);
				xntcCalendar.setBpsGroup(xbpsGroup);
			} 
			xntcCalendar.setBptCreateBy(ntcCalendar[3]!=null?(String)ntcCalendar[3]:null);
			xntcCalendar.setBptCreateDate(ntcCalendar[4]!=null?(Timestamp)ntcCalendar[4]:null);
			//
			
			 
			 
			xntcCalendar.setBptDefinition(ntcCalendar[5]!=null?getClobMessage((org.hibernate.lob.SerializableClob)(ntcCalendar[5])):null);
			xntcCalendar.setBptDefinitionSearch(ntcCalendar[6]!=null?getClobMessage((org.hibernate.lob.SerializableClob)(ntcCalendar[6])):null);
			xntcCalendar.setBptIndexChar(ntcCalendar[7]!=null?(String)ntcCalendar[7]:null);
			xntcCalendar.setBptShortDesc(ntcCalendar[8]!=null?(String)ntcCalendar[8]:null);
			xntcCalendar.setBptSource(ntcCalendar[9]!=null?(String)ntcCalendar[9]:null);
			xntcCalendar.setBptSourceRef(ntcCalendar[10]!=null?(String)ntcCalendar[10]:null);
			xntcCalendar.setBptTerm(ntcCalendar[11]!=null?(String)ntcCalendar[11]:null);
			xntcCalendar.setBptUpdateBy(ntcCalendar[12]!=null?(String)ntcCalendar[12]:null);
			xntcCalendar.setBptUpdateDate(ntcCalendar[13]!=null?(Timestamp)ntcCalendar[13]:null);
			xntcCalendar.setBptVersionNumber(ntcCalendar[14]!=null?(Integer)ntcCalendar[14]:null);
			//xntcCalendar.setBptId(ntcCalendar[1]!=null?(Long)ntcCalendar[1]:null);
		//	BeanUtility.copyProperties(xntcCalendar, ntcCalendar); 			
			
			//BeanUtility.copyProperties(xbpsGroup, ntcCalendar.getBpsGroup()); 
			//xntcCalendar.setBpsGroup(xbpsGroup);
			xntcCalendars.add(xntcCalendar);
		}
		/*for (Object[] ntcCalendar : ntcCalendars) {
			BpsTerm xntcCalendar = new BpsTerm();
			BeanUtility.copyProperties(xntcCalendar, ntcCalendar); 			
			th.co.vlink.xstream.BpsGroup xbpsGroup = new th.co.vlink.xstream.BpsGroup();
			BeanUtility.copyProperties(xbpsGroup, ntcCalendar.getBpsGroup()); 
			xntcCalendar.setBpsGroup(xbpsGroup);
			xntcCalendars.add(xntcCalendar);
		}*/
		return xntcCalendars;
	} 
	private void returnUpdateRecord(Representation entity,th.co.vlink.xstream.BpsTerm xbpsTerm,int updateRecord){
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.vlink.xstream.BpsTerm> xbpsTerms = new ArrayList<th.co.vlink.xstream.BpsTerm>(1);
		xbpsTerm.setUpdateRecord(updateRecord);
		xbpsTerms.add(xbpsTerm);
		vresultMessage.setResultListObj(xbpsTerms);
		export(entity, vresultMessage, xstream);
	}
 
	public BpsTermService getBpsTermService() {
		return bpsTermService;
	}

	public void setBpsTermService(BpsTermService bpsTermService) {
		this.bpsTermService = bpsTermService;
	}

	public com.sun.syndication.feed.atom.Feed getFeed() {
		return feed;
	}

	public void setFeed(com.sun.syndication.feed.atom.Feed feed) {
		this.feed = feed;
	}

	public com.thoughtworks.xstream.XStream getXstream() {
		return xstream;
	}

	public void setXstream(com.thoughtworks.xstream.XStream xstream) {
		this.xstream = xstream;
	}

}
