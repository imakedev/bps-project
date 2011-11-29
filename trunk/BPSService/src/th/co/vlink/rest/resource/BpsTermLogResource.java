package th.co.vlink.rest.resource;

import java.io.IOException;
import java.io.InputStream;
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
import th.co.vlink.managers.BpsTermLogService;
import th.co.vlink.utils.BeanUtility;
import th.co.vlink.utils.Pagging;
import th.co.vlink.xstream.BpsTermLog;
import th.co.vlink.xstream.common.FeedModel;
import th.co.vlink.xstream.common.VResultMessage;

public class BpsTermLogResource extends BaseResource {

	private static final Logger logger = Logger.getLogger("bpsAppender");  
	private static final String BPS_TITLE = "BPS Term And Definition Collection";
	private BpsTermLogService bpsTermLogService;
	private com.sun.syndication.feed.atom.Feed feed;
	private com.thoughtworks.xstream.XStream xstream;
	//private String nraId=null;;
	@Override
	public void init(Context context, Request request, Response response) {
		// TODO Auto-generated method stub
		super.init(context, request, response);

	}

	public BpsTermLogResource() {
		super();
		logger.debug("into constructor BpsTermResource");
		// TODO Auto-generated constructor stub
	}

	public BpsTermLogResource(Context context, Request request, Response response) {
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
			xstream.processAnnotations(BpsTermLog.class);// or xstream.autodetectAnnotations(true); (Auto-detect  Annotations)
			BpsTermLog xbpsTerm = new BpsTermLog();
			Object ntcCalendarObj = xstream.fromXML(in);
			if (ntcCalendarObj != null) {
				xbpsTerm = (BpsTermLog) ntcCalendarObj;
				if (xbpsTerm != null) {
					th.co.vlink.hibernate.bean.BpsTermLog bpsTerm = new th.co.vlink.hibernate.bean.BpsTermLog();
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
						if(serviceName.equals(ServiceConstant.BPS_TERM_LOG_FIND_BY_ID)){
							th.co.vlink.hibernate.bean.BpsTermLog bpsTermLog = bpsTermLogService.findBpsTermLogById(bpsTerm.getBptlId());
							if(bpsTermLog!=null){
								VResultMessage vresultMessage = new VResultMessage();
								List<BpsTermLog> xntcCalendars = new ArrayList<BpsTermLog>(1);
								BpsTermLog xbpsTermLog = new BpsTermLog();
								BeanUtility.copyProperties(xbpsTermLog, bpsTermLog);				
								//bpsTermLogService.findBpsGroupById(bpsTermLog.getBpsGroup());
								th.co.vlink.hibernate.bean.BpsGroup  bpsGroup=  bpsTermLog.getBpsGroup();
								th.co.vlink.xstream.BpsGroup xbpsGroup = new th.co.vlink.xstream.BpsGroup();
								BeanUtility.copyProperties(xbpsGroup, bpsGroup);
								xbpsTermLog.setBpsGroup(xbpsGroup);
							//	BeanUtility.copyProperties(xbpsGroup, ntcCalendarReturn.getBpsGroup());
								//xntcCalendarReturn.setBpsGroup(xbpsGroup);
								xntcCalendars.add(xbpsTermLog);
								vresultMessage.setResultListObj(xntcCalendars);
								export(entity, vresultMessage, xstream);
							}
						} 
						if(serviceName.equals(ServiceConstant.BPS_TERM_LOG_SAVE)){
							 
							java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							bpsTerm.setBptCreateDate(timeStampStartDate);
							int updateRecord=(bpsTermLogService.saveBpsTermLog(bpsTerm)).intValue();
							returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}
						  
						else if(serviceName.equals(ServiceConstant.BPS_TERM_LOG_DELETE)){
							int updateRecord=bpsTermLogService.deleteBpsTermLog(bpsTerm);
							returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}
						else if(serviceName.equals(ServiceConstant.BPS_TERM_LOG_SEARCH)){
							Pagging page = xbpsTerm.getPagging(); 
							bpsTerm.setPagging(page);		 
							
							List result = (List) bpsTermLogService.searchBpsTermLog(bpsTerm  ,xbpsTerm.getVcriteria().getKey(),
									xbpsTerm.getVcriteria().getIndexChar(),xbpsTerm.getVcriteria().getOrderColumn(),
									xbpsTerm.getVcriteria().getOrderBy());
							if (result != null && result.size() == 2) {
								java.util.List<th.co.vlink.hibernate.bean.BpsTermLog> ntcCalendars = (java.util.List<th.co.vlink.hibernate.bean.BpsTermLog>) result
										.get(0);
								String faqs_size = (String) result.get(1);
//								logger.debug("NtcCalendar=" + ntcCalendars + ",faqs_size="
//										+ faqs_size);
								VResultMessage vresultMessage = new VResultMessage();

								List<BpsTermLog> xntcCalendars = new ArrayList<BpsTermLog>();
								if (faqs_size != null && !faqs_size.equals(""))
									vresultMessage.setMaxRow(faqs_size);
								if (ntcCalendars != null && ntcCalendars.size() > 0) {
									xntcCalendars = getxBpsTermLogObject(ntcCalendars);
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
		th.co.vlink.hibernate.bean.BpsTermLog ntcCalendar = new th.co.vlink.hibernate.bean.BpsTermLog();
		/*if(this.mpaId!=null)
			msoPollVote.setMpqId(new Long(this.mpaId));*/
		ntcCalendar.setPagging(pagging);
		List result = null;//bpsTermLogService.searchBpsTermLog(ntcCalendar);
		return result;
	}
	@Override
	protected  List<FeedModel>  getFeedMedels(List ntcCalendars) {
		// TODO Auto-generated method stub
		List<FeedModel> feedModels = new ArrayList<FeedModel>(
				ntcCalendars.size());
		int size = ntcCalendars.size();
		for (int i = 0; i < size; i++) {
			th.co.vlink.hibernate.bean.BpsTermLog ntcCalendar = (th.co.vlink.hibernate.bean.BpsTermLog)ntcCalendars.get(i);
			FeedModel feedModel = new FeedModel();
			feedModel.setId(ntcCalendar.getBptId().toString());
			feedModel.setTitle(ntcCalendar.getBptTerm());
			feedModels.add(feedModel);
		}
		return feedModels;
	}

	private List<BpsTermLog> getxBpsTermLogObject(
			java.util.List<th.co.vlink.hibernate.bean.BpsTermLog> ntcCalendars) {
		List<BpsTermLog> xntcCalendars = new ArrayList<BpsTermLog>(
				ntcCalendars.size());
		for (th.co.vlink.hibernate.bean.BpsTermLog ntcCalendar : ntcCalendars) {
			BpsTermLog xntcCalendar = new BpsTermLog();
			BeanUtility.copyProperties(xntcCalendar, ntcCalendar); 		
			th.co.vlink.xstream.BpsGroup xbpsGroup = new th.co.vlink.xstream.BpsGroup();
			if(ntcCalendar.getBpsGroup()!=null){
				BeanUtility.copyProperties(xbpsGroup, ntcCalendar.getBpsGroup()); 
			}
			xntcCalendar.setBpsGroup(xbpsGroup);
			//BeanUtility.copyProperties(xbpsGroup, ntcCalendar.getBpsGroup()); 
			//xntcCalendar.setBpsGroup(xbpsGroup);
			xntcCalendars.add(xntcCalendar);
		}
		return xntcCalendars;
	} 
	private void returnUpdateRecord(Representation entity,th.co.vlink.xstream.BpsTermLog xbpsTerm,int updateRecord){
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.vlink.xstream.BpsTermLog> xbpsTerms = new ArrayList<th.co.vlink.xstream.BpsTermLog>(1);
		xbpsTerm.setUpdateRecord(updateRecord);
		xbpsTerms.add(xbpsTerm);
		vresultMessage.setResultListObj(xbpsTerms);
		export(entity, vresultMessage, xstream);
	}
 
	 

	public BpsTermLogService getBpsTermLogService() {
		return bpsTermLogService;
	}

	public void setBpsTermLogService(BpsTermLogService bpsTermLogService) {
		this.bpsTermLogService = bpsTermLogService;
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
