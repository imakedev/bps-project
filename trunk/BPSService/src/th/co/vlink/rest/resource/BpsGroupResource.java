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
import th.co.vlink.managers.BpsGroupService;
import th.co.vlink.utils.BeanUtility;
import th.co.vlink.utils.Pagging;
import th.co.vlink.xstream.common.FeedModel;
import th.co.vlink.xstream.common.VResultMessage;

public class BpsGroupResource extends BaseResource {

	private static final Logger logger = Logger.getLogger("BtsLog");  
	private static final String BPS_TITLE = "BPS Term And Definition Collection";
	private BpsGroupService bpsGroupService;
	private com.sun.syndication.feed.atom.Feed feed;
	private com.thoughtworks.xstream.XStream xstream;
	//private String nraId=null;;
	@Override
	public void init(Context context, Request request, Response response) {
		// TODO Auto-generated method stub
		super.init(context, request, response);

	}

	public BpsGroupResource() {
		super();
		logger.debug("into constructor BpsGroupResource");
		// TODO Auto-generated constructor stub
	}

	public BpsGroupResource(Context context, Request request, Response response) {
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
			xstream.processAnnotations(th.co.vlink.xstream.BpsGroup.class);// or xstream.autodetectAnnotations(true); (Auto-detect  Annotations)
			th.co.vlink.xstream.BpsGroup xntcCalendar = new th.co.vlink.xstream.BpsGroup();
			Object ntcCalendarObj = xstream.fromXML(in);
			if (ntcCalendarObj != null) {
				xntcCalendar = (th.co.vlink.xstream.BpsGroup) ntcCalendarObj;
				if (xntcCalendar != null) {
					th.co.vlink.hibernate.bean.BpsGroup ntcCalendar = new th.co.vlink.hibernate.bean.BpsGroup();
					BeanUtility.copyProperties(ntcCalendar, xntcCalendar); 
					if (xntcCalendar.getServiceName() != null
							&& !xntcCalendar.getServiceName().equals("")) {
						logger.debug(" BPS servicename = "
								+ xntcCalendar.getServiceName());
						String serviceName = xntcCalendar.getServiceName();
						if(serviceName.equals(ServiceConstant.BPS_GROUP_FIND_BY_ID)){
							th.co.vlink.hibernate.bean.BpsGroup ntcCalendarReturn = bpsGroupService.findBpsGroupById(ntcCalendar.getBpgId());
							if(ntcCalendarReturn!=null){
								VResultMessage vresultMessage = new VResultMessage();
								List<BpsGroup> xntcCalendars = new ArrayList<BpsGroup>(1);
								BpsGroup xntcCalendarReturn = new BpsGroup();
								BeanUtility.copyProperties(xntcCalendarReturn, ntcCalendarReturn);
								xntcCalendars.add(xntcCalendarReturn);
								vresultMessage.setResultListObj(xntcCalendars);
								export(entity, vresultMessage, xstream);
							}
						} 
						if(serviceName.equals(ServiceConstant.BPS_GROUP_SAVE)){
							bpsGroupService.saveBpsGroup(ntcCalendar);
						}
						else if(serviceName.equals(ServiceConstant.BPS_GROUP_UPDATE)){
							bpsGroupService.updateBpsGroup(ntcCalendar);
						}
						else if(serviceName.equals(ServiceConstant.BPS_GROUP_DELETE)){
							bpsGroupService.deleteBpsGroup(ntcCalendar);
						}
						else if(serviceName.equals(ServiceConstant.BPS_GROUP_SEARCH)){
							Pagging page = xntcCalendar.getPagging(); 
							ntcCalendar.setPagging(page);		 
							
							List result = (List) bpsGroupService.searchBpsGroup(ntcCalendar, xntcCalendar.getLikeExpression(), 
									xntcCalendar.getLeExpression(), xntcCalendar.getGeExpression());
							if (result != null && result.size() == 2) {
								java.util.List<th.co.vlink.hibernate.bean.BpsGroup> ntcCalendars = (java.util.List<th.co.vlink.hibernate.bean.BpsGroup>) result
										.get(0);
								String faqs_size = (String) result.get(1);
//								logger.debug("NtcCalendar=" + ntcCalendars + ",faqs_size="
//										+ faqs_size);
								VResultMessage vresultMessage = new VResultMessage();

								List<th.co.vlink.xstream.BpsGroup> xntcCalendars = new ArrayList<th.co.vlink.xstream.BpsGroup>();
								if (faqs_size != null && !faqs_size.equals(""))
									vresultMessage.setMaxRow(faqs_size);
								if (ntcCalendars != null && ntcCalendars.size() > 0) {
									xntcCalendars = getxBpsGroupObject(ntcCalendars);
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
		th.co.vlink.hibernate.bean.BpsGroup ntcCalendar = new th.co.vlink.hibernate.bean.BpsGroup();
		/*if(this.mpaId!=null)
			msoPollVote.setMpqId(new Long(this.mpaId));*/
		ntcCalendar.setPagging(pagging);
		List result = bpsGroupService.searchBpsGroup(ntcCalendar);
		return result;
	}
	@Override
	protected  List<FeedModel>  getFeedMedels(List ntcCalendars) {
		// TODO Auto-generated method stub
		List<FeedModel> feedModels = new ArrayList<FeedModel>(
				ntcCalendars.size());
		int size = ntcCalendars.size();
		for (int i = 0; i < size; i++) {
			th.co.vlink.hibernate.bean.BpsGroup ntcCalendar = (th.co.vlink.hibernate.bean.BpsGroup)ntcCalendars.get(i);
			FeedModel feedModel = new FeedModel();
			feedModel.setId(ntcCalendar.getBpgId()+"");
			feedModel.setTitle(ntcCalendar.getBpgGroupName());
			feedModels.add(feedModel);
		}
		return feedModels;
	}

	private List<th.co.vlink.xstream.BpsGroup> getxBpsGroupObject(
			java.util.List<th.co.vlink.hibernate.bean.BpsGroup> ntcCalendars) {
		List<th.co.vlink.xstream.BpsGroup> xntcCalendars = new ArrayList<th.co.vlink.xstream.BpsGroup>(
				ntcCalendars.size());
		for (th.co.vlink.hibernate.bean.BpsGroup ntcCalendar : ntcCalendars) {
			th.co.vlink.xstream.BpsGroup xntcCalendar = new th.co.vlink.xstream.BpsGroup();
			BeanUtility.copyProperties(xntcCalendar, ntcCalendar); 
			xntcCalendars.add(xntcCalendar);
		}
		return xntcCalendars;
	} 
 
 
	public BpsGroupService getBpsGroupService() {
		return bpsGroupService;
	}

	public void setBpsGroupService(BpsGroupService bpsGroupService) {
		this.bpsGroupService = bpsGroupService;
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
