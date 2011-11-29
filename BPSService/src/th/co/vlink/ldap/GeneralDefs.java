package th.co.vlink.ldap;
/**
 * @author Chatchai
 * 
 */
public interface GeneralDefs {
//	 -------------------------------------------------
	// LDAP tree search base
	//	 -------------------------------------------------
	//public static String BASE_SEARCH = "cn=users,dc=pttep,dc=com";
	
//	public static String BASE_USER_SEARCH = "dc=kbankproject,dc=com";
	 
	//	 -------------------------------------------------
	//	Attributes to be fetched from EPerson object.
	//	 -------------------------------------------------
	/*public static final String EPERSON_ATTRIBUTE_LIST[] = { "objectclasss","accessHint",
			"accountHint", "audio", "businessCategory", "c", "sn","carLicense",
			"cn", "configPtr", "departmentNumber", "description",
			"destinationIndicator", "displayName", "employeeNumber",
			"employeeType", "facsimileTelephoneNumber", "generationQualifier",
			"givenName", "homeFax", "homePhone", "homePostalAddress",
			"initials", "internationalISDNNumber", "jpegPhoto", "l",
			"labeledURI", "mail", "manager", "middleName", "mobile", "o",
			"organizationalStatus", "otherMailbox", "ou", "pager",
			"personalTitle", "photo", "physicalDeliveryOfficeName",
			"postalAddress", "postalCode", "postOfficeBox",
			"preferredDeliveryMethod", "preferredLanguage",
			"registeredAddress", "roomNumber", "secretary", "seeAlso", "st",
			"street", "telephoneNumber", "teletexTerminalIdentifier",
			"telexNumber", "thumbNailLogo", "thumbNailPhoto", "title", "uid",
			"uniqueIdentifier", "userCertificate", "userPassword",
			"userPKCS12", "userSMIMECertificate", "x121Address",
			"x500UniqueIdentifier"

	};*/
	public static final String EPERSON_ATTRIBUTE_LIST[] = { "uniqueMember",
		"cn","o","ou","userPassword"

};
	
	 

	//	Using Sun JNDI..
	//
	// Initial Context Factory..
	public static String LDAP_PROVIDER = "com.sun.jndi.ldap.LdapCtxFactory";

	// Processing referrals..
	public static String REFERRALS_IGNORE = "ignore";

	//	 -------------------------------------------------
	// LDAP root pwd
	//	 -------------------------------------------------
	//public static String ROOT_PASSWORD = "vl1nk250dm1n";

	//	 -------------------------------------------------
	// LDAP root: this is just cn=root
	//	 -------------------------------------------------
	//public static String ROOT_USER = "cn=root";

	// Security level to be used for LDAP connections..
	public static String SEARCH_SECURITY_LEVEL = "none";

	// security level for updates.
	public static String UPDATE_SECURITY_LEVEL = "simple";

	// Package Prefix for loading URL context factories..
	public static String URL_CONTEXT_PREFIX = "com.sun.jndi.url";

}
