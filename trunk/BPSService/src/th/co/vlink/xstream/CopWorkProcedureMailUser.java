package th.co.vlink.xstream;

import java.io.Serializable;

import th.co.vlink.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;

@XStreamAlias("copWorkProcedureMailUser")
public class CopWorkProcedureMailUser extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;
	 
	private Integer id;
	 
	private String user; 
	private String password;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	 
	
}
