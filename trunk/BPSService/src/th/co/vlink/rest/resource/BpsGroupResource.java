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
import th.co.vlink.managers.BpsGroupService;
import th.co.vlink.utils.BeanUtility;
import th.co.vlink.utils.Pagging;
import th.co.vlink.xstream.common.FeedModel;
import th.co.vlink.xstream.common.VResultMessage;

public class BpsGroupResource extends BaseResource {

	private static final Logger logger = Logger.getLogger("bpsAppender");  
	private static final String BPS_TITLE = "BPS Groups Collection";
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
			th.co.vlink.xstream.BpsGroup xbpsGroup = new th.co.vlink.xstream.BpsGroup();
			Object bpsGroupObj = xstream.fromXML(in);
			if (bpsGroupObj != null) {
				xbpsGroup = (th.co.vlink.xstream.BpsGroup) bpsGroupObj;
				if (xbpsGroup != null) {
					th.co.vlink.hibernate.bean.BpsGroup bpsGroup = new th.co.vlink.hibernate.bean.BpsGroup();
					BeanUtility.copyProperties(bpsGroup, xbpsGroup); 
					if (xbpsGroup.getServiceName() != null
							&& !xbpsGroup.getServiceName().equals("")) {
						logger.debug(" BPS servicename = "
								+ xbpsGroup.getServiceName());
						String serviceName = xbpsGroup.getServiceName();
						VResultMessage vresultMessage = null;
						List<th.co.vlink.xstream.BpsGroup> xbpsGroups=null;
						if(serviceName.equals(ServiceConstant.BPS_GROUP_FIND_BY_ID)){
							th.co.vlink.hibernate.bean.BpsGroup bpsGroupReturn = bpsGroupService.findBpsGroupById(bpsGroup.getBpgId());
							if(bpsGroupReturn!=null){
								vresultMessage = new VResultMessage();
								xbpsGroups = new ArrayList<th.co.vlink.xstream.BpsGroup>(1);
								th.co.vlink.xstream.BpsGroup xbpsGroupReturn = new th.co.vlink.xstream.BpsGroup();
								BeanUtility.copyProperties(xbpsGroupReturn, bpsGroupReturn);
								xbpsGroups.add(xbpsGroupReturn);
								vresultMessage.setResultListObj(xbpsGroups);
								export(entity, vresultMessage, xstream);
							}
						} 
						if(serviceName.equals(ServiceConstant.BPS_GROUP_SAVE)){							
							int updateRecord=(bpsGroupService.saveBpsGroup(bpsGroup)).intValue();
							returnUpdateRecord(entity,xbpsGroup,updateRecord);
						}
						else if(serviceName.equals(ServiceConstant.BPS_GROUP_UPDATE)){							
							int updateRecord=bpsGroupService.updateBpsGroup(bpsGroup);
							returnUpdateRecord(entity,xbpsGroup,updateRecord); 
						}
						else if(serviceName.equals(ServiceConstant.BPS_GROUP_DELETE)){							
							int updateRecord=bpsGroupService.deleteBpsGroup(bpsGroup);
							returnUpdateRecord(entity,xbpsGroup,updateRecord);
						}
						else if(serviceName.equals(ServiceConstant.BPS_GROUP_CHECK_DUPLICATE)){							
							int updateRecord=bpsGroupService.checkDuplicateGroup(bpsGroup);
							returnUpdateRecord(entity,xbpsGroup,updateRecord);
						}
						
						else if(serviceName.equals(ServiceConstant.BPS_GROUP_SEARCH)){
							Pagging page = xbpsGroup.getPagging(); 
							bpsGroup.setPagging(page);		 
							
							List result = (List) bpsGroupService.searchBpsGroup(bpsGroup, xbpsGroup.getLikeExpression(), 
									xbpsGroup.getLeExpression(), xbpsGroup.getGeExpression());
							System.out.println(" xxx = "+result);
							if (result != null && result.size() == 2) {
								java.util.List<th.co.vlink.hibernate.bean.BpsGroup> bpsGroups = (java.util.List<th.co.vlink.hibernate.bean.BpsGroup>) result
										.get(0);
								String faqs_size = (String) result.get(1);
//								logger.debug("NtcCalendar=" + bpsGroups + ",faqs_size="
//										+ faqs_size);
								vresultMessage = new VResultMessage(); 
								xbpsGroups = new ArrayList<th.co.vlink.xstream.BpsGroup>();
								if (faqs_size != null && !faqs_size.equals(""))
									vresultMessage.setMaxRow(faqs_size);
								if (bpsGroups != null && bpsGroups.size() > 0) {
									xbpsGroups = getxBpsGroupObject(bpsGroups);
								}
								vresultMessage.setResultListObj(xbpsGroups);
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
		th.co.vlink.hibernate.bean.BpsGroup bpsGroup = new th.co.vlink.hibernate.bean.BpsGroup();
		/*if(this.mpaId!=null)
			msoPollVote.setMpqId(new Long(this.mpaId));*/
		bpsGroup.setPagging(pagging);
		List result = bpsGroupService.searchBpsGroup(bpsGroup);
		return result;
	}
	@Override
	protected  List<FeedModel>  getFeedMedels(List bpsGroups) {
		// TODO Auto-generated method stub
		List<FeedModel> feedModels = new ArrayList<FeedModel>(
				bpsGroups.size());
		int size = bpsGroups.size();
		for (int i = 0; i < size; i++) {
			th.co.vlink.hibernate.bean.BpsGroup bpsGroup = (th.co.vlink.hibernate.bean.BpsGroup)bpsGroups.get(i);
			FeedModel feedModel = new FeedModel();
			feedModel.setId(bpsGroup.getBpgId()+"");
			feedModel.setTitle(bpsGroup.getBpgGroupName());
			feedModels.add(feedModel);
		}
		return feedModels;
	}

	private List<th.co.vlink.xstream.BpsGroup> getxBpsGroupObject(
			java.util.List<th.co.vlink.hibernate.bean.BpsGroup> bpsGroups) {
		List<th.co.vlink.xstream.BpsGroup> xbpsGroups = new ArrayList<th.co.vlink.xstream.BpsGroup>(
				bpsGroups.size());
		for (th.co.vlink.hibernate.bean.BpsGroup bpsGroup : bpsGroups) {
			th.co.vlink.xstream.BpsGroup xbpsGroup = new th.co.vlink.xstream.BpsGroup();
			BeanUtility.copyProperties(xbpsGroup, bpsGroup); 
			xbpsGroups.add(xbpsGroup);
		}
		return xbpsGroups;
	} 
 
	private void returnUpdateRecord(Representation entity,th.co.vlink.xstream.BpsGroup xbpsGroup,int updateRecord){
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.vlink.xstream.BpsGroup> xbpsGroups = new ArrayList<th.co.vlink.xstream.BpsGroup>(1);
		xbpsGroup.setUpdateRecord(updateRecord);
		xbpsGroups.add(xbpsGroup);
		vresultMessage.setResultListObj(xbpsGroups);
		export(entity, vresultMessage, xstream);
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
