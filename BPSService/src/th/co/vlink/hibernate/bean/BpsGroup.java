package th.co.vlink.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * The persistent class for the BANPU_BPS_GROUP database table.
 * 
 */
@Entity
@Table(name="BANPU_BPS_GROUP",schema="DB2INST1")
//@Table(name="BANPU_BPS_GROUP")
//@Table(name="BANPU_BPS_GROUP",schema="DB2INST4") // pttep
public class BpsGroup  extends VServiceBean implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="BPG_ID")
	private Long bpgId;

	@Column(name="BPG_GROUP_NAME")
	private String bpgGroupName;

    public BpsGroup() {
    }

	public Long getBpgId() {
		return bpgId;
	}

	public void setBpgId(Long bpgId) {
		this.bpgId = bpgId;
	}

	public String getBpgGroupName() {
		return bpgGroupName;
	}

	public void setBpgGroupName(String bpgGroupName) {
		this.bpgGroupName = bpgGroupName;
	}

}