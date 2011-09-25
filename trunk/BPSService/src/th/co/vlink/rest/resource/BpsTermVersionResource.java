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
import th.co.vlink.managers.BpsTermVersionService;
import th.co.vlink.utils.BeanUtility;
import th.co.vlink.utils.Pagging;
import th.co.vlink.xstream.BpsTermVersion;
import th.co.vlink.xstream.common.FeedModel;
import th.co.vlink.xstream.common.VResultMessage;

public class BpsTermVersionResource extends BaseResource {

	private static final Logger logger = Logger.getLogger("bpsAppender");  
	private static final String BPS_TITLE = "BPS Term And Definition Collection";
	private BpsTermVersionService bpsTermVersionService;
	private com.sun.syndication.feed.atom.Feed feed;
	private com.thoughtworks.xstream.XStream xstream;
	//private String nraId=null;;
	@Override
	public void init(Context context, Request request, Response response) {
		// TODO Auto-generated method stub
		super.init(context, request, response);

	}

	public BpsTermVersionResource() {
		super();
		logger.debug("into constructor BpsTermResourceVersionResource");
		// TODO Auto-generated constructor stub
	}

	public BpsTermVersionResource(Context context, Request request, Response response) {
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
			xstream.processAnnotations(BpsTermVersion.class);// or xstream.autodetectAnnotations(true); (Auto-detect  Annotations)
			BpsTermVersion xbpsTermVersion = new BpsTermVersion();
			Object bpsTermVersionObj = xstream.fromXML(in);
			if (bpsTermVersionObj != null) {
				xbpsTermVersion = (BpsTermVersion) bpsTermVersionObj;
				if (xbpsTermVersion != null) {
					th.co.vlink.hibernate.bean.BpsTermVersion bpsTermVersion = new th.co.vlink.hibernate.bean.BpsTermVersion();
					BeanUtility.copyProperties(bpsTermVersion, xbpsTermVersion); 
					if(xbpsTermVersion.getBpsTerm()!=null && xbpsTermVersion.getBpsTerm().getBptId()!=null
							&& xbpsTermVersion.getBpsTerm().getBptId().intValue()!=0){
						th.co.vlink.hibernate.bean.BpsTerm bpsTerm=new th.co.vlink.hibernate.bean.BpsTerm();
						bpsTerm.setBptId(xbpsTermVersion.getBpsTerm().getBptId());
						bpsTermVersion.setBpsTerm(bpsTerm);
					}
					if (xbpsTermVersion.getServiceName() != null
							&& !xbpsTermVersion.getServiceName().equals("")) {
						logger.debug(" BPS servicename = "
								+ xbpsTermVersion.getServiceName());
						String serviceName = xbpsTermVersion.getServiceName();
						if(serviceName.equals(ServiceConstant.BPS_TERM_VERSION_FIND_BY_ID)){
							th.co.vlink.hibernate.bean.BpsTermVersion bpsTermVersionReturn = bpsTermVersionService.findBpsTermVersionById(bpsTermVersion.getBptvId());
							if(bpsTermVersionReturn!=null){
								VResultMessage vresultMessage = new VResultMessage();
								List<BpsTermVersion> xbpsTermVersions = new ArrayList<BpsTermVersion>(1);
								BpsTermVersion xbpsTermVersionReturn = new BpsTermVersion();
								BeanUtility.copyProperties(xbpsTermVersionReturn, bpsTermVersionReturn);
								xbpsTermVersions.add(xbpsTermVersionReturn);
								vresultMessage.setResultListObj(xbpsTermVersions);
								export(entity, vresultMessage, xstream);
							}
						} 
						if(serviceName.equals(ServiceConstant.BPS_TERM_VERSION_SAVE)){
							bpsTermVersionService.saveBpsTermVersion(bpsTermVersion);
						}
						else if(serviceName.equals(ServiceConstant.BPS_TERM_VERSION_UPDATE)){
							bpsTermVersionService.updateBpsTermVersion(bpsTermVersion);
						}
						else if(serviceName.equals(ServiceConstant.BPS_TERM_VERSION_DELETE)){
							bpsTermVersionService.deleteBpsTermVersion(bpsTermVersion);
						}
						else if(serviceName.equals(ServiceConstant.BPS_TERM_VERSION_SEARCH)){
							Pagging page = xbpsTermVersion.getPagging(); 
							bpsTermVersion.setPagging(page);		 
							
							List result = (List) bpsTermVersionService.searchBpsTermVersion(bpsTermVersion, xbpsTermVersion.getLikeExpression(), 
									xbpsTermVersion.getLeExpression(), xbpsTermVersion.getGeExpression());
							if (result != null && result.size() == 2) {
								java.util.List<th.co.vlink.hibernate.bean.BpsTermVersion> bpsTermVersions = (java.util.List<th.co.vlink.hibernate.bean.BpsTermVersion>) result
										.get(0);
								String faqs_size = (String) result.get(1);
//								logger.debug("NtcCalendar=" + bpsTermVersions + ",faqs_size="
//										+ faqs_size);
								VResultMessage vresultMessage = new VResultMessage();

								List<BpsTermVersion> xbpsTermVersions = new ArrayList<BpsTermVersion>();
								if (faqs_size != null && !faqs_size.equals(""))
									vresultMessage.setMaxRow(faqs_size);
								if (bpsTermVersions != null && bpsTermVersions.size() > 0) {
									xbpsTermVersions = getxBpsTermVersionObject(bpsTermVersions);
								}
								vresultMessage.setResultListObj(xbpsTermVersions);
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
		th.co.vlink.hibernate.bean.BpsTermVersion bpsTermVersion = new th.co.vlink.hibernate.bean.BpsTermVersion();
		/*if(this.mpaId!=null)
			msoPollVote.setMpqId(new Long(this.mpaId));*/
		bpsTermVersion.setPagging(pagging);
		List result = bpsTermVersionService.searchBpsTermVersion(bpsTermVersion);
		return result;
	}
	@Override
	protected  List<FeedModel>  getFeedMedels(List bpsTermVersions) {
		// TODO Auto-generated method stub
		List<FeedModel> feedModels = new ArrayList<FeedModel>(
				bpsTermVersions.size());
		int size = bpsTermVersions.size();
		for (int i = 0; i < size; i++) {
			th.co.vlink.hibernate.bean.BpsTermVersion bpsTermVersion = (th.co.vlink.hibernate.bean.BpsTermVersion)bpsTermVersions.get(i);
			FeedModel feedModel = new FeedModel();
			feedModel.setId(bpsTermVersion.getBptvId().toString());
			//feedModel.setTitle(bpsTermVersion.getBptTerm());
			feedModels.add(feedModel);
		}
		return feedModels;
	}

	private List<BpsTermVersion> getxBpsTermVersionObject(
			java.util.List<th.co.vlink.hibernate.bean.BpsTermVersion> bpsTermVersions) {
		List<BpsTermVersion> xbpsTermVersions = new ArrayList<BpsTermVersion>(
				bpsTermVersions.size());
		for (th.co.vlink.hibernate.bean.BpsTermVersion bpsTermVersion : bpsTermVersions) {
			BpsTermVersion xbpsTermVersion = new BpsTermVersion();
			BeanUtility.copyProperties(xbpsTermVersion, bpsTermVersion); 
			xbpsTermVersions.add(xbpsTermVersion);
		}
		return xbpsTermVersions;
	} 
 
  

	public BpsTermVersionService getBpsTermVersionService() {
		return bpsTermVersionService;
	}

	public void setBpsTermVersionService(BpsTermVersionService bpsTermVersionService) {
		this.bpsTermVersionService = bpsTermVersionService;
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
