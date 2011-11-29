package th.co.vlink.xstream;

import java.io.Serializable;

import th.co.vlink.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;
@XStreamAlias("vuser")
public class VUser extends VServiceXML  implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String baseDN;
	private String userid;
	private String email;
	private String password;
	public String getBaseDN() {
		return baseDN;
	}
	public void setBaseDN(String baseDN) {
		this.baseDN = baseDN;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}

}
