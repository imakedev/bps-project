package th.co.vlink.xstream;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.Column;

import th.co.vlink.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;
@XStreamAlias("bpsTermLog")
public class BpsTermLog extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;
	 
	private Long bptlId;
 
	private String bptCreateBy;
 
	private Timestamp bptCreateDate;
 
	private String bptDefinition;
     
	private String bptDefinitionSearch;
 
	private String bptIndexChar;
 
	private String bptShortDesc;
 
	private String bptSource;
 
	private String bptSourceRef;
 
	private Integer bptVersionNumber;
	
	private String bptTerm; 

	private String bptMailTo; 
	private String bptMailForm; 
	private String bptMaiilSubject; 
	
	@XStreamAlias("bpsGroup")
	private BpsGroup bpsGroup;
 
	private Long bptId;

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
