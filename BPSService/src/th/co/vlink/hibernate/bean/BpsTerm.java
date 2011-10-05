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
 * The persistent class for the BANPU_BPS_TERM database table.
 * 
 */
@Entity
//@Table(name="BANPU_BPS_TERM",schema="DB2INST1")
@Table(name="BANPU_BPS_TERM")
//@Table(name="BANPU_BPS_TERM",schema="DB2INST4") // pttep
public class BpsTerm  extends VServiceBean implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
//	@SequenceGenerator(name="OFFICEAPPLICATION.OFFICE_CALENDAR_SEQ" ,sequenceName="OFFICEAPPLICATION.OFFICE_CALENDAR_SEQ" ,allocationSize=1)
//	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="OFFICEAPPLICATION.OFFICE_CALENDAR_SEQ")
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="BPT_ID")
	private Long bptId;

	@Column(name="BPT_TERM")
	private String bptTerm;
	@Column(name="BPT_SHORT_DESC")
	private String bptShortDesc;
	@Lob()
	@Column(name="BPT_DEFINITION")	
	private String bptDefinition;
	@Lob()
	@Column(name="BPT_DEFINITION_SEARCH")
	private String bptDefinitionSearch;
	@Column(name="BPT_SOURCE_REF")
	private String bptSourceRef;
	@Column(name="BPT_SOURCE")
	private String bptSource;
	@Column(name="BPT_INDEX_CHAR")
	private String bptIndexChar;
	@Column(name="BPT_CREATE_BY")
	private String bptCreateBy;
	@Column(name="BPT_CREATE_DATE")
	private Timestamp bptCreateDate;
	@Column(name="BPT_VERSION_NUMBER")
	private Integer bptVersionNumber;
	
	@Column(name="BBT_STATUS")
	private String bptStatus;
	
	@ManyToOne
	@JoinColumn(name="BPG_GROUP_ID")
	private BpsGroup bpsGroup;
	
//	@OneToMany(mappedBy="bpsAttachFile",fetch=FetchType.LAZY)
//	private Set<BpsAttachFile> bpsAttachFiles;
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
	public String getBptShortDesc() {
		return bptShortDesc;
	}
	public void setBptShortDesc(String bptShortDesc) {
		this.bptShortDesc = bptShortDesc;
	}
	public String getBptDefinition() {
		return bptDefinition;
	}
	public void setBptDefinition(String bptDefinition) {
		this.bptDefinition = bptDefinition;
	}
	public String getBptSourceRef() {
		return bptSourceRef;
	}
	public void setBptSourceRef(String bptSourceRef) {
		this.bptSourceRef = bptSourceRef;
	}
	public String getBptSource() {
		return bptSource;
	}
	public void setBptSource(String bptSource) {
		this.bptSource = bptSource;
	}
	public String getBptIndexChar() {
		return bptIndexChar;
	}
	public void setBptIndexChar(String bptIndexChar) {
		this.bptIndexChar = bptIndexChar;
	}
	public String getBptCreateBy() {
		return bptCreateBy;
	}
	public void setBptCreateBy(String bptCreateBy) {
		this.bptCreateBy = bptCreateBy;
	}
	public Timestamp getBptCreateDate() {
		return bptCreateDate;
	}
	public void setBptCreateDate(Timestamp bptCreateDate) {
		this.bptCreateDate = bptCreateDate;
	}
	public Integer getBptVersionNumber() {
		return bptVersionNumber;
	}
	public void setBptVersionNumber(Integer bptVersionNumber) {
		this.bptVersionNumber = bptVersionNumber;
	}
	public BpsGroup getBpsGroup() {
		return bpsGroup;
	}
	public void setBpsGroup(BpsGroup bpsGroup) {
		this.bpsGroup = bpsGroup;
	}
	/*public Set<BpsAttachFile> getBpsAttachFiles() {
		return bpsAttachFiles;
	}
	public void setBpsAttachFiles(Set<BpsAttachFile> bpsAttachFiles) {
		this.bpsAttachFiles = bpsAttachFiles;
	}*/
	public String getBptDefinitionSearch() {
		return bptDefinitionSearch;
	}
	public void setBptDefinitionSearch(String bptDefinitionSearch) {
		this.bptDefinitionSearch = bptDefinitionSearch;
	}
	public String getBptStatus() {
		return bptStatus;
	}
	public void setBptStatus(String bptStatus) {
		this.bptStatus = bptStatus;
	}

}