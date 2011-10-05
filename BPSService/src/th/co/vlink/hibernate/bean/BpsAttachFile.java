package th.co.vlink.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


/**
 * The persistent class for the NTC_CALENDAR database table.
 * 
 */
@Entity
//@Table(name="BANPU_BPS_ATTACH_FILE",schema="DB2INST1")
@Table(name="BANPU_BPS_ATTACH_FILE")
//@Table(name="BANPU_BPS_ATTACH_FILE",schema="DB2INST4") // pttep
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

	
	@Column(name="BPAF_FILE_SIZE")
	private String bpafFileSize;
	
	@Column(name="BPAF_HOTLINK")
	private String bpafHotLink;
	@ManyToOne
	@JoinColumn(name="BPT_TERM_ID")
	private BpsTerm bpsTerm;
	
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
	public BpsTerm getBpsTerm() {
		return bpsTerm;
	}
	public void setBpsTerm(BpsTerm bpsTerm) {
		this.bpsTerm = bpsTerm;
	}
	public String getBpafFileSize() {
		return bpafFileSize;
	}
	public void setBpafFileSize(String bpafFileSize) {
		this.bpafFileSize = bpafFileSize;
	}
	public String getBpafHotLink() {
		return bpafHotLink;
	}
	public void setBpafHotLink(String bpafHotLink) {
		this.bpafHotLink = bpafHotLink;
	}
	 
	
}