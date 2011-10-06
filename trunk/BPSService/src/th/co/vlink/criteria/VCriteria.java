/**
 * 
 */
package th.co.vlink.criteria;

import java.io.Serializable;

/**
 * @author Chatchai Pimtun 
 *
 */
public class VCriteria  implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String key; // column in table
	private String value; // value in column
	private String orderBy;
	private String orderColumn;
	private String indexChar;
	public VCriteria(){
		 
	}
	public String getOrderBy() {
		return orderBy;
	}

	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}

	public String getOrderColumn() {
		return orderColumn;
	}

	public void setOrderColumn(String orderColumn) {
		this.orderColumn = orderColumn;
	}

	public VCriteria(String key,String value){
		this.key = key;
		this.value = value;
	}
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getIndexChar() {
		return indexChar;
	}
	public void setIndexChar(String indexChar) {
		this.indexChar = indexChar;
	}
	

}
