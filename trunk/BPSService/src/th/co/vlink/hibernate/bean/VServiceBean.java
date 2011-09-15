package th.co.vlink.hibernate.bean;

import java.io.Serializable;

import th.co.vlink.utils.Pagging;

/**
 * @author Chatchai Pimtun (Admin)
 *
 */
public class VServiceBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Pagging pagging;
	private String fieldId;
	
	public String getFieldId() {
		return fieldId;
	}
	public void setFieldId(String fieldId) {
		this.fieldId = fieldId;
	}
	public VServiceBean() {
		pagging = new Pagging();
	}
	public Pagging getPagging() {
		return pagging;
	}
	public void setPagging(Pagging pagging) {
		this.pagging = pagging;
	}

}
