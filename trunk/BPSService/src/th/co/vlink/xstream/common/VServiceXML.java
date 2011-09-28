package th.co.vlink.xstream.common;

import java.io.Serializable;
import java.util.Map;

import th.co.vlink.criteria.VCriteria;
import th.co.vlink.utils.Pagging;

import com.thoughtworks.xstream.annotations.XStreamAlias;
/**
 * @author Chatchai Pimtun (Admin)
 *
 */
@XStreamAlias("vservicexml")
public class VServiceXML implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@XStreamAlias("servicename")
	private String serviceName;
	
	@XStreamAlias("fieldId")
	private String fieldId;
	
	private int updateRecord;
	
	public String getFieldId() {
		return fieldId;
	}
	public void setFieldId(String fieldId) {
		this.fieldId = fieldId;
	}
	@XStreamAlias("likeExpression")
	private Map likeExpression;
	
	@XStreamAlias("likeFirstExpression")
	private Map likeFirstExpression;
	
	@XStreamAlias("likeEndExpression")
	private Map likeEndExpression;
	
	@XStreamAlias("leExpression")
	private Map leExpression;
	
	@XStreamAlias("geExpression")
	private Map geExpression;
	
	@XStreamAlias("neExpression")
	private Map neExpression;
	
	@XStreamAlias("pagging")
	private Pagging pagging;
	
	@XStreamAlias("vcriteria")
	private VCriteria vcriteria;
	
	public VServiceXML() {
		pagging = new Pagging();
		vcriteria = new VCriteria();
		
	}
	public VCriteria getVcriteria() {
		return vcriteria;
	}
	public void setVcriteria(VCriteria vcriteria) {
		this.vcriteria = vcriteria;
	}
	public Pagging getPagging() {
		return pagging;
	}
	public void setPagging(Pagging pagging) {
		this.pagging = pagging;
	}
	public String getServiceName() {
		return serviceName;
	}
	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}
	public Map getLikeExpression() {
		return likeExpression;
	}
	public void setLikeExpression(Map likeExpression) {
		this.likeExpression = likeExpression;
	}
	public Map getLeExpression() {
		return leExpression;
	}
	public void setLeExpression(Map leExpression) {
		this.leExpression = leExpression;
	}
	public Map getGeExpression() {
		return geExpression;
	}
	public void setGeExpression(Map geExpression) {
		this.geExpression = geExpression;
	}
	public Map getLikeFirstExpression() {
		return likeFirstExpression;
	}
	public void setLikeFirstExpression(Map likeFirstExpression) {
		this.likeFirstExpression = likeFirstExpression;
	}
	public Map getLikeEndExpression() {
		return likeEndExpression;
	}
	public void setLikeEndExpression(Map likeEndExpression) {
		this.likeEndExpression = likeEndExpression;
	}
	public Map getNeExpression() {
		return neExpression;
	}
	public void setNeExpression(Map neExpression) {
		this.neExpression = neExpression;
	}
	public int getUpdateRecord() {
		return updateRecord;
	}
	public void setUpdateRecord(int updateRecord) {
		this.updateRecord = updateRecord;
	}

}
