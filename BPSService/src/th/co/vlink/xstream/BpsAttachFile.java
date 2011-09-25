package th.co.vlink.xstream;

import java.io.Serializable;

import com.thoughtworks.xstream.annotations.XStreamAlias;

import th.co.vlink.xstream.common.VServiceXML;

@XStreamAlias("bpsAttachFile")
public class BpsAttachFile extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;
	@XStreamAlias("bpafId")
	private Long bpafId;
	@XStreamAlias("bpafFileName")
	private String bpafFileName;
	@XStreamAlias("bpafFilePath")
	private String bpafFilePath;
	@XStreamAlias("bpsTerm")
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

	 
}