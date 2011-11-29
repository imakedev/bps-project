package th.co.vlink.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="COP_WORKPROCEDURE_MAIL_USER",schema="DB2INST1")
//@Table(name="COP_WORKPROCEDURE_MAIL_USER")
//@Table(name="COP_WORKPROCEDURE_MAIL_USER",schema="DB2INST4") // pttep
public class CopWorkProcedureMailUser extends VServiceBean implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="ID")
	private Integer id;
	
	@Column(name="USER")
	private String user;
	
	@Column(name="PASSWORD")
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
