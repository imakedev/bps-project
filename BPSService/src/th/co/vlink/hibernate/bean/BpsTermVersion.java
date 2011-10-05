package th.co.vlink.hibernate.bean;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


/**
 * The persistent class for the BANPU_BPS_TERM_VERSION database table.
 * 
 */
@Entity
//@Table(name="BANPU_BPS_TERM_VERSION",schema="DB2INST1")
@Table(name="BANPU_BPS_TERM_VERSION")
//@Table(name="BANPU_BPS_TERM_VERSION",schema="DB2INST4") // ptteppublic class BpsTermVersion extends VServiceBean implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="BPTV_ID")
	private Long bptvId;

	@Column(name="BPT_CREATE_BY")
	private String bptCreateBy;

	@Column(name="BPT_CREATE_DATE")
	private Timestamp bptCreateDate;

    @Lob()
	@Column(name="BPT_DEFINITION")
	private String bptDefinition;
    
    @Lob()
	@Column(name="BPT_DEFINITION_SEARCH")
	private String bptDefinitionSearch;

	@Column(name="BPT_INDEX_CHAR")
	private String bptIndexChar;

	@Column(name="BPT_SHORT_DESC")
	private String bptShortDesc;

	@Column(name="BPT_SOURCE")
	private String bptSource;

	@Column(name="BPT_SOURCE_REF")
	private String bptSourceRef;

	@Column(name="BPT_VERSION_NUMBER")
	private Integer bptVersionNumber;
	
	@Column(name="BPT_TERM")
	private String bptTerm; 
	//bi-directional many-to-one association to BanpuBpsTerm
    @ManyToOne
	@JoinColumn(name="BPT_ID")
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

	public String getBptIndexChar() {
		return this.bptIndexChar;
	}

	public void setBptIndexChar(String bptIndexChar) {
		this.bptIndexChar = bptIndexChar;
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