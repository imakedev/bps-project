package th.co.vlink.xstream;

import java.io.Serializable;
import java.sql.Timestamp;

import com.thoughtworks.xstream.annotations.XStreamAlias;

import th.co.vlink.xstream.common.VServiceXML;

@XStreamAlias("bpsTerm")
public class BpsTerm extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;
	@XStreamAlias("bptId")
	private Long bptId;
	@XStreamAlias("bptTerm")
	private String bptTerm;
	@XStreamAlias("bptShortDesc")
	private String bptShortDesc;
	@XStreamAlias("bptDefinition")
	private String bptDefinition;
	@XStreamAlias("bptSourceRef")
	private String bptSourceRef;
	@XStreamAlias("bptSource")
	private String bptSource;
	@XStreamAlias("bptIndexChar")
	private String bptIndexChar;
	@XStreamAlias("bptCreateBy")
	private String bptCreateBy;
	@XStreamAlias("bptCreateDate")
	private Timestamp bptCreateDate;
	@XStreamAlias("bptVersionNumber")
	private Integer bptVersionNumber;
	@XStreamAlias("bpsGroup")
	private BpsGroup bpsGroup;

	// @OneToMany(mappedBy="bpsAttachFile",fetch=FetchType.LAZY)
	// private Set<BpsAttachFile> bpsAttachFiles;
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
	/*
	 * public Set<BpsAttachFile> getBpsAttachFiles() { return bpsAttachFiles; }
	 * public void setBpsAttachFiles(Set<BpsAttachFile> bpsAttachFiles) {
	 * this.bpsAttachFiles = bpsAttachFiles; }
	 */

}