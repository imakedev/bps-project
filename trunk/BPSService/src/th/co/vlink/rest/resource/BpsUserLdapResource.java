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
import th.co.vlink.hibernate.bean.CopWorkProcedureMailUser;
import th.co.vlink.ldap.VLinkLDAPManager;
import th.co.vlink.managers.CopWorkProcedureMailUserService;
import th.co.vlink.utils.Pagging;
import th.co.vlink.xstream.VUser;
import th.co.vlink.xstream.common.FeedModel;
import th.co.vlink.xstream.common.VResultMessage;

public class BpsUserLdapResource extends BaseResource {

	private static final Logger logger = Logger.getLogger("bpsAppender");  
	private static final String BPS_TITLE = "BPS Term And Definition Collection";
	private CopWorkProcedureMailUserService copWorkProcedureMailUserService;
	private com.sun.syndication.feed.atom.Feed feed;
	private com.thoughtworks.xstream.XStream xstream;
	//private String nraId=null;;
	@Override
	public void init(Context context, Request request, Response response) {
		// TODO Auto-generated method stub
		super.init(context, request, response);

	}

	public BpsUserLdapResource() {
		super();
		logger.debug("into constructor BpsUserLdapResource");
		// TODO Auto-generated constructor stub
	}

	public BpsUserLdapResource(Context context, Request request, Response response) {
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
			xstream.processAnnotations(VUser.class);// or xstream.autodetectAnnotations(true); (Auto-detect  Annotations)
			VUser xbpsTerm = new VUser();
			Object ntcCalendarObj = xstream.fromXML(in);
			if (ntcCalendarObj != null) {
				xbpsTerm = (VUser) ntcCalendarObj;
				if (xbpsTerm != null) {
					 
					if (xbpsTerm.getServiceName() != null
							&& !xbpsTerm.getServiceName().equals("")) {
						logger.debug(" BPS servicename = "
								+ xbpsTerm.getServiceName());
						String serviceName = xbpsTerm.getServiceName();
						if(serviceName.equals(ServiceConstant.LDAP_GROUP_FIND_BY_ID)){
							VLinkLDAPManager manager = new VLinkLDAPManager();
						//	VUser
						List<String>mails=	manager.getMailMemberOfGroup(xbpsTerm.getBaseDN());
						if(mails!=null && mails.size()>0){
							VResultMessage vresultMessage = new VResultMessage();
							List<VUser> vusers = new ArrayList<VUser>(mails.size());
							for (String mail : mails) {
								VUser vuser = new VUser();
								vuser.setEmail(mail);
								vusers.add(vuser);
							} 
							vresultMessage.setResultListObj(vusers);
							export(entity, vresultMessage, xstream);
						}
						//COP_WORKPROCEDURE_MAIL_USER
						 	//List list = manager.getAllUsers(partEmail);
							/*th.co.vlink.hibernate.bean.VUser ntcCalendarReturn = bpsTermService.findVUserById(bpsTerm.getBptId());
							if(ntcCalendarReturn!=null){
								VResultMessage vresultMessage = new VResultMessage();
								List<VUser> xntcCalendars = new ArrayList<VUser>(1);
								VUser xntcCalendarReturn = new VUser();
								BeanUtility.copyProperties(xntcCalendarReturn, ntcCalendarReturn);								
								th.co.vlink.xstream.BpsGroup xbpsGroup = new th.co.vlink.xstream.BpsGroup();
								BeanUtility.copyProperties(xbpsGroup, ntcCalendarReturn.getBpsGroup());
								xntcCalendarReturn.setBpsGroup(xbpsGroup);
								xntcCalendars.add(xntcCalendarReturn);
								vresultMessage.setResultListObj(xntcCalendars);
								export(entity, vresultMessage, xstream);
							}*/
						} 
						else if(serviceName.equals(ServiceConstant.LDAP_USER_FIND_BY_ID)){
							/*logger.info("xntcCalendar.getBpsGroup()="+xbpsTerm.getBpsGroup());
							logger.info("ntcCalendar.getBpsGroup()="+bpsTerm.getBpsGroup());
							java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							bpsTerm.setBptCreateDate(timeStampStartDate);
							int updateRecord=(bpsTermService.saveVUser(bpsTerm)).intValue();
							returnUpdateRecord(entity,xbpsTerm,updateRecord);*/
						}
						else if(serviceName.equals(ServiceConstant.COP_WORKPROCEDURE_MAIL_USER)){
							CopWorkProcedureMailUser copWorkProcedureMailUser =copWorkProcedureMailUserService.getCopWorkProcedureMailUser();
							if(copWorkProcedureMailUser!=null){
								VResultMessage vresultMessage = new VResultMessage();
								List<VUser> xntcCalendars = new ArrayList<VUser>(1);
								VUser xntcCalendarReturn = new VUser();
								xntcCalendarReturn.setUserid(copWorkProcedureMailUser.getUser());
								xntcCalendarReturn.setPassword(copWorkProcedureMailUser.getPassword()); 
								xntcCalendars.add(xntcCalendarReturn);
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
		 
		List result = null;//bpsTermService.searchVUser(ntcCalendar);
		return result;
	}
	@Override
	protected  List<FeedModel>  getFeedMedels(List ntcCalendars) {
		// TODO Auto-generated method stub
		List<FeedModel> feedModels = new ArrayList<FeedModel>(
				ntcCalendars.size());
	 
		return feedModels;
	}

	 
	private void returnUpdateRecord(Representation entity,th.co.vlink.xstream.VUser xbpsTerm,int updateRecord){
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.vlink.xstream.VUser> xbpsTerms = new ArrayList<th.co.vlink.xstream.VUser>(1);
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

	public CopWorkProcedureMailUserService getCopWorkProcedureMailUserService() {
		return copWorkProcedureMailUserService;
	}

	public void setCopWorkProcedureMailUserService(
			CopWorkProcedureMailUserService copWorkProcedureMailUserService) {
		this.copWorkProcedureMailUserService = copWorkProcedureMailUserService;
	}

}
