package th.co.vlink.rest.resource;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.restlet.Context;
import org.restlet.data.Request;
import org.restlet.data.Response;
import org.restlet.resource.Representation;
import org.restlet.resource.ResourceException;
import org.restlet.resource.Variant;

import th.co.vlink.utils.BeanUtility;
import th.co.vlink.utils.Pagging;
import th.co.vlink.xstream.BpsTerm;
import th.co.vlink.xstream.common.FeedModel;
import th.co.vlink.xstream.common.VResultMessage;

public class BpsGroupLdapResource extends BaseResource {

	private static final Logger logger = Logger.getLogger("bpsAppender");  
	private static final String BPS_TITLE = "BPS Term And Definition Collection";
	private com.sun.syndication.feed.atom.Feed feed;
	private com.thoughtworks.xstream.XStream xstream;
	//private String nraId=null;;
	@Override
	public void init(Context context, Request request, Response response) {
		// TODO Auto-generated method stub
		super.init(context, request, response);

	}

	public BpsGroupLdapResource() {
		super();
		logger.debug("into constructor BpsGroupLdapResource");
		// TODO Auto-generated constructor stub
	}

	public BpsGroupLdapResource(Context context, Request request, Response response) {
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

	private List<BpsTerm> getxBpsTermObject(
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
	} 
	private void returnUpdateRecord(Representation entity,th.co.vlink.xstream.BpsTerm xbpsTerm,int updateRecord){
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.vlink.xstream.BpsTerm> xbpsTerms = new ArrayList<th.co.vlink.xstream.BpsTerm>(1);
		xbpsTerm.setUpdateRecord(updateRecord);
		xbpsTerms.add(xbpsTerm);
		vresultMessage.setResultListObj(xbpsTerms);
		export(entity, vresultMessage, xstream);
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
