package th.co.vlink.hibernate.bean;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;


/**
 * The persistent class for the NTC_CALENDAR database table.
 * 
 */
@Entity
@Table(name="BANPU_BPS_ATTACH_FILE",schema="DB2INST1")
public class BpsAttachFile  extends VServiceBean implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
//	@SequenceGenerator(name="OFFICEAPPLICATION.OFFICE_CALENDAR_SEQ" ,sequenceName="OFFICEAPPLICATION.OFFICE_CALENDAR_SEQ" ,allocationSize=1)
//	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="OFFICEAPPLICATION.OFFICE_CALENDAR_SEQ")
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="BPAF_ID")
	private Long bpafId;

	@Column(name="BPAF_FILE_NAME")
	private String bpafFileName;
	@Column(name="BPAF_FILE_PATH")
	private String bpafFilePath;
	@Column(name="BPT_TERM_ID")
	private BpsTerm bptId;
	public Long getBpafId() {
		return bpafId;
	}
	public void setBpafId(Long bpafId) {
		this.bpafId = bpafId;
	}
	public String getBpafFileName() {
		return bpafFileName;
	}
	public void setBpafFileName(String bpafFileName) {
		this.bpafFileName = bpafFileName;
	}
	public String getBpafFilePath() {
		return bpafFilePath;
	}
	public void setBpafFilePath(String bpafFilePath) {
		this.bpafFilePath = bpafFilePath;
	}
	public BpsTerm getBptId() {
		return bptId;
	}
	public void setBptId(BpsTerm bptId) {
		this.bptId = bptId;
	}
	
}