package th.co.vlink.xstream;

import java.io.Serializable;

import th.co.vlink.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;
@XStreamAlias("vgroup")
public class VGroup extends VServiceXML  implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String baseDN;
	private String groupid;
	private String email;
	public String getBaseDN() {
		return baseDN;
	}
	public void setBaseDN(String baseDN) {
		this.baseDN = baseDN;
	}
	public String getGroupid() {
		return groupid;
	}
	public void setGroupid(String groupid) {
		this.groupid = groupid;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}

}
