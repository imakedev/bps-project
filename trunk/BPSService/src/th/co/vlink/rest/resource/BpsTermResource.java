package th.co.vlink.rest.resource;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
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
			BpsTerm xntcCalendar = new BpsTerm();
			Object ntcCalendarObj = xstream.fromXML(in);
			if (ntcCalendarObj != null) {
				xntcCalendar = (BpsTerm) ntcCalendarObj;
				if (xntcCalendar != null) {
					th.co.vlink.hibernate.bean.BpsTerm ntcCalendar = new th.co.vlink.hibernate.bean.BpsTerm();
					BeanUtility.copyProperties(ntcCalendar, xntcCalendar); 
					if(xntcCalendar.getBpsGroup()!=null && xntcCalendar.getBpsGroup().getBpgId()!=null
							&&xntcCalendar.getBpsGroup().getBpgId().intValue()!=0){
						BpsGroup bpsGroup = new BpsGroup();
						bpsGroup.setBpgId(xntcCalendar.getBptId());
						ntcCalendar.setBpsGroup(bpsGroup);
					}
					if (xntcCalendar.getServiceName() != null
							&& !xntcCalendar.getServiceName().equals("")) {
						logger.debug(" BPS servicename = "
								+ xntcCalendar.getServiceName());
						String serviceName = xntcCalendar.getServiceName();
						if(serviceName.equals(ServiceConstant.BPS_TERM_FIND_BY_ID)){
							th.co.vlink.hibernate.bean.BpsTerm ntcCalendarReturn = bpsTermService.findBpsTermById(ntcCalendar.getBptId());
							if(ntcCalendarReturn!=null){
								VResultMessage vresultMessage = new VResultMessage();
								List<BpsTerm> xntcCalendars = new ArrayList<BpsTerm>(1);
								BpsTerm xntcCalendarReturn = new BpsTerm();
								BeanUtility.copyProperties(xntcCalendarReturn, ntcCalendarReturn);
								xntcCalendars.add(xntcCalendarReturn);
								vresultMessage.setResultListObj(xntcCalendars);
								export(entity, vresultMessage, xstream);
							}
						} 
						if(serviceName.equals(ServiceConstant.BPS_TERM_SAVE)){
							logger.info("xntcCalendar.getBpsGroup()="+xntcCalendar.getBpsGroup());
							logger.info("ntcCalendar.getBpsGroup()="+ntcCalendar.getBpsGroup());
							bpsTermService.saveBpsTerm(ntcCalendar);
						}
						else if(serviceName.equals(ServiceConstant.BPS_TERM_UPDATE)){
							bpsTermService.updateBpsTerm(ntcCalendar);
						}
						else if(serviceName.equals(ServiceConstant.BPS_TERM_DELETE)){
							bpsTermService.deleteBpsTerm(ntcCalendar);
						}
						else if(serviceName.equals(ServiceConstant.BPS_TERM_SEARCH)){
							Pagging page = xntcCalendar.getPagging(); 
							ntcCalendar.setPagging(page);		 
							
							List result = (List) bpsTermService.searchBpsTerm(ntcCalendar, xntcCalendar.getLikeExpression(), 
									xntcCalendar.getLeExpression(), xntcCalendar.getGeExpression());
							if (result != null && result.size() == 2) {
								java.util.List<th.co.vlink.hibernate.bean.BpsTerm> ntcCalendars = (java.util.List<th.co.vlink.hibernate.bean.BpsTerm>) result
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
		List result = bpsTermService.searchBpsTerm(ntcCalendar);
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

	private List<BpsTerm> getxBpsTermObject(
			java.util.List<th.co.vlink.hibernate.bean.BpsTerm> ntcCalendars) {
		List<BpsTerm> xntcCalendars = new ArrayList<BpsTerm>(
				ntcCalendars.size());
		for (th.co.vlink.hibernate.bean.BpsTerm ntcCalendar : ntcCalendars) {
			BpsTerm xntcCalendar = new BpsTerm();
			BeanUtility.copyProperties(xntcCalendar, ntcCalendar); 
			xntcCalendars.add(xntcCalendar);
		}
		return xntcCalendars;
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
