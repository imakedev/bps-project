package th.co.vlink.xstream;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.Column;

import th.co.vlink.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;

@XStreamAlias("bpsTermVersion")
public class BpsTermVersion extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Long bptvId;
	private String bptCreateBy;
	private Timestamp bptCreateDate;
	private String bptDefinition;
	private String bptDefinitionSearch;
	private String bptShortDesc;
	private String bptSource;
	private String bptSourceRef;
	private Integer bptVersionNumber; 
	private String bptTerm;
	@XStreamAlias("bpsTerm")
	private BpsTerm bpsTerm;

    public BpsTermVersion() {
    }

	public Long getBptvId() {
		return this.bptvId;
	}

	public void setBptvId(Long bptvId) {
		this.bptvId = bptvId;
	}

	public String getBptCreateBy() {
		return this.bptCreateBy;
	}

	public void setBptCreateBy(String bptCreateBy) {
		this.bptCreateBy = bptCreateBy;
	}

	public Timestamp getBptCreateDate() {
		return this.bptCreateDate;
	}

	public void setBptCreateDate(Timestamp bptCreateDate) {
		this.bptCreateDate = bptCreateDate;
	}

	public String getBptDefinition() {
		return this.bptDefinition;
	}

	public void setBptDefinition(String bptDefinition) {
		this.bptDefinition = bptDefinition;
	}

	

	public String getBptShortDesc() {
		return this.bptShortDesc;
	}

	public void setBptShortDesc(String bptShortDesc) {
		this.bptShortDesc = bptShortDesc;
	}

	public String getBptSource() {
		return this.bptSource;
	}

	public void setBptSource(String bptSource) {
		this.bptSource = bptSource;
	}

	public String getBptSourceRef() {
		return this.bptSourceRef;
	}

	public void setBptSourceRef(String bptSourceRef) {
		this.bptSourceRef = bptSourceRef;
	}

	public Integer getBptVersionNumber() {
		return this.bptVersionNumber;
	}

	public void setBptVersionNumber(Integer bptVersionNumber) {
		this.bptVersionNumber = bptVersionNumber;
	}

	public BpsTerm getBpsTerm() {
		return bpsTerm;
	}

	public void setBpsTerm(BpsTerm bpsTerm) {
		this.bpsTerm = bpsTerm;
	}

	public String getBptTerm() {
		return bptTerm;
	}

	public void setBptTerm(String bptTerm) {
		this.bptTerm = bptTerm;
	}

	public String getBptDefinitionSearch() {
		return bptDefinitionSearch;
	}

	public void setBptDefinitionSearch(String bptDefinitionSearch) {
		this.bptDefinitionSearch = bptDefinitionSearch;
	}

	 
	
}