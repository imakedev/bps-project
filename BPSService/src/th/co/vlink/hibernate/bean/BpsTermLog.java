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
@Entity
@Table(name="BANPU_BPS_TERM_LOG",schema="DB2INST1")
//@Table(name="BANPU_BPS_TERM_LOG")
//@Table(name="BANPU_BPS_TERM_LOG",schema="DB2INST4") // pttep
public class BpsTermLog extends VServiceBean implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="BPTL_ID")
	private Long bptlId;

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
	
	@ManyToOne
	@JoinColumn(name="BPG_GROUP_ID")
	private BpsGroup bpsGroup;
	
	
	//bi-directional many-to-one association to BanpuBpsTerm
	@Column(name="BPT_ID")
	private Long bptId;
	
	@Column(name="BPT_MAIL_TO")
	private String bptMailTo; 
	@Column(name="BPT_MAIL_FORM")
	private String bptMailForm; 
	@Column(name="BPT_MAIL_SUBJECT")
	private String bptMaiilSubject; 

    public BpsTermLog() {
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

	 

	public Long getBptlId() {
		return bptlId;
	}



	public void setBptlId(Long bptlId) {
		this.bptlId = bptlId;
	}




	public Long getBptId() {
		return bptId;
	}



	public void setBptId(Long bptId) {
		this.bptId = bptId;
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



	public BpsGroup getBpsGroup() {
		return bpsGroup;
	}



	public void setBpsGroup(BpsGroup bpsGroup) {
		this.bpsGroup = bpsGroup;
	}



	public String getBptMailTo() {
		return bptMailTo;
	}



	public void setBptMailTo(String bptMailTo) {
		this.bptMailTo = bptMailTo;
	}



	public String getBptMailForm() {
		return bptMailForm;
	}



	public void setBptMailForm(String bptMailForm) {
		this.bptMailForm = bptMailForm;
	}



	public String getBptMaiilSubject() {
		return bptMaiilSubject;
	}



	public void setBptMaiilSubject(String bptMaiilSubject) {
		this.bptMaiilSubject = bptMaiilSubject;
	}

}
