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
import th.co.vlink.managers.BpsAttachFileService;
import th.co.vlink.utils.BeanUtility;
import th.co.vlink.utils.Pagging;
import th.co.vlink.xstream.BpsAttachFile;
import th.co.vlink.xstream.common.FeedModel;
import th.co.vlink.xstream.common.VResultMessage;

public class BpsAttachFileResource extends BaseResource {

	private static final Logger logger = Logger.getLogger("bpsAppender");  
	private static final String BPS_TITLE = "BPS Term And Definition Collection";
	private BpsAttachFileService bpsAttachFileService;
	private com.sun.syndication.feed.atom.Feed feed;
	private com.thoughtworks.xstream.XStream xstream;
	//private String nraId=null;;
	@Override
	public void init(Context context, Request request, Response response) {
		// TODO Auto-generated method stub
		super.init(context, request, response);

	}

	public BpsAttachFileResource() {
		super();
		logger.debug("into constructor BpsAttachFileResource");
		// TODO Auto-generated constructor stub
	}

	public BpsAttachFileResource(Context context, Request request, Response response) {
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
			xstream.processAnnotations(BpsAttachFile.class);// or xstream.autodetectAnnotations(true); (Auto-detect  Annotations)
			BpsAttachFile xntcCalendar = new BpsAttachFile();
			Object ntcCalendarObj = xstream.fromXML(in);
			if (ntcCalendarObj != null) {
				xntcCalendar = (BpsAttachFile) ntcCalendarObj;
				if (xntcCalendar != null) {
					th.co.vlink.hibernate.bean.BpsAttachFile ntcCalendar = new th.co.vlink.hibernate.bean.BpsAttachFile();
					BeanUtility.copyProperties(ntcCalendar, xntcCalendar); 
					if(xntcCalendar.getBpsTerm()!=null  && xntcCalendar.getBpsTerm().getBptId()!=null
							&& xntcCalendar.getBpsTerm().getBptId().intValue()!=0){
						th.co.vlink.hibernate.bean.BpsTerm term=new th.co.vlink.hibernate.bean.BpsTerm();
						term.setBptId(xntcCalendar.getBpsTerm().getBptId());
						ntcCalendar.setBpsTerm(term);
					}
					if (xntcCalendar.getServiceName() != null
							&& !xntcCalendar.getServiceName().equals("")) {
						logger.debug(" BPS servicename = "
								+ xntcCalendar.getServiceName());
						String serviceName = xntcCalendar.getServiceName();
						if(serviceName.equals(ServiceConstant.BPS_ATTACH_FILE_FIND_BY_ID)){
							th.co.vlink.hibernate.bean.BpsAttachFile ntcCalendarReturn = bpsAttachFileService.findBpsAttachFileById(ntcCalendar.getBpafId());
							if(ntcCalendarReturn!=null){
								VResultMessage vresultMessage = new VResultMessage();
								List<BpsAttachFile> xntcCalendars = new ArrayList<BpsAttachFile>(1);
								BpsAttachFile xntcCalendarReturn = new BpsAttachFile();
								BeanUtility.copyProperties(xntcCalendarReturn, ntcCalendarReturn);
								xntcCalendars.add(xntcCalendarReturn);
								vresultMessage.setResultListObj(xntcCalendars);
								export(entity, vresultMessage, xstream);
							}
						} 
						if(serviceName.equals(ServiceConstant.BPS_ATTACH_FILE_SAVE)){
							int updateRecord=(bpsAttachFileService.saveBpsAttachFile(ntcCalendar)).intValue();
							returnUpdateRecord(entity,xntcCalendar,updateRecord);
						}
						else if(serviceName.equals(ServiceConstant.BPS_ATTACH_FILE_UPDATE)){ 
							int updateRecord=bpsAttachFileService.updateBpsAttachFile(ntcCalendar);
							returnUpdateRecord(entity,xntcCalendar,updateRecord);
						}
						else if(serviceName.equals(ServiceConstant.BPS_ATTACH_FILE_DELETE)){ 
							int updateRecord=bpsAttachFileService.deleteBpsAttachFile(ntcCalendar);
							returnUpdateRecord(entity,xntcCalendar,updateRecord);
						}
						else if(serviceName.equals(ServiceConstant.BPS_ATTACH_FILE_SEARCH)){
							Pagging page = xntcCalendar.getPagging(); 
							ntcCalendar.setPagging(page);		 
							
							List result = (List) bpsAttachFileService.searchBpsAttachFile(ntcCalendar, xntcCalendar.getLikeExpression(), 
									xntcCalendar.getLeExpression(), xntcCalendar.getGeExpression());
							if (result != null && result.size() == 2) {
								java.util.List<th.co.vlink.hibernate.bean.BpsAttachFile> ntcCalendars = (java.util.List<th.co.vlink.hibernate.bean.BpsAttachFile>) result
										.get(0);
								String faqs_size = (String) result.get(1);
//								logger.debug("NtcCalendar=" + ntcCalendars + ",faqs_size="
//										+ faqs_size);
								VResultMessage vresultMessage = new VResultMessage();

								List<BpsAttachFile> xntcCalendars = new ArrayList<BpsAttachFile>();
								if (faqs_size != null && !faqs_size.equals(""))
									vresultMessage.setMaxRow(faqs_size);
								if (ntcCalendars != null && ntcCalendars.size() > 0) {
									xntcCalendars = getxBpsAttachFileObject(ntcCalendars);
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
		th.co.vlink.hibernate.bean.BpsAttachFile ntcCalendar = new th.co.vlink.hibernate.bean.BpsAttachFile();
		/*if(this.mpaId!=null)
			msoPollVote.setMpqId(new Long(this.mpaId));*/
		ntcCalendar.setPagging(pagging);
		List result = bpsAttachFileService.searchBpsAttachFile(ntcCalendar);
		return result;
	}
	@Override
	protected  List<FeedModel>  getFeedMedels(List ntcCalendars) {
		// TODO Auto-generated method stub
		List<FeedModel> feedModels = new ArrayList<FeedModel>(
				ntcCalendars.size());
		int size = ntcCalendars.size();
		for (int i = 0; i < size; i++) {
			th.co.vlink.hibernate.bean.BpsAttachFile ntcCalendar = (th.co.vlink.hibernate.bean.BpsAttachFile)ntcCalendars.get(i);
			FeedModel feedModel = new FeedModel();
			feedModel.setId(ntcCalendar.getBpafId().toString());
			feedModel.setTitle(ntcCalendar.getBpafFileName());
			feedModels.add(feedModel);
		}
		return feedModels;
	}

	private List<BpsAttachFile> getxBpsAttachFileObject(
			java.util.List<th.co.vlink.hibernate.bean.BpsAttachFile> ntcCalendars) {
		List<BpsAttachFile> xntcCalendars = new ArrayList<BpsAttachFile>(
				ntcCalendars.size());
		for (th.co.vlink.hibernate.bean.BpsAttachFile ntcCalendar : ntcCalendars) {
			BpsAttachFile xntcCalendar = new BpsAttachFile();
			BeanUtility.copyProperties(xntcCalendar, ntcCalendar); 
			xntcCalendars.add(xntcCalendar);
		}
		return xntcCalendars;
	} 
 
 
	public BpsAttachFileService getBpsAttachFileService() {
		return bpsAttachFileService;
	}

	public void setBpsAttachFileService(BpsAttachFileService bpsAttachFileService) {
		this.bpsAttachFileService = bpsAttachFileService;
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
	private void returnUpdateRecord(Representation entity,th.co.vlink.xstream.BpsAttachFile xbpsAttachFile,int updateRecord){
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.vlink.xstream.BpsAttachFile> xbpsAttachFiles = new ArrayList<th.co.vlink.xstream.BpsAttachFile>(1);
		xbpsAttachFile.setUpdateRecord(updateRecord);
		xbpsAttachFiles.add(xbpsAttachFile);
		vresultMessage.setResultListObj(xbpsAttachFiles);
		export(entity, vresultMessage, xstream);
	}

}
