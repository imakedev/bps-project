package th.co.vlink.xstream;

import java.io.Serializable;

import th.co.vlink.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;
@XStreamAlias("bpsGroup")
public class BpsGroup  extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;
	@XStreamAlias("bpgId")
	private Long bpgId;
	@XStreamAlias("bpgGroupName")
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