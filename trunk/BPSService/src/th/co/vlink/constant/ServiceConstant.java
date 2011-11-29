package th.co.vlink.constant;

public class ServiceConstant {
	public static final String hostReference = "http://10.2.0.94:10000/BPSService/RestletServlet/";

	public static final String INTERFACE_RETURN_TYPE = "java.util.List";
	public static final String VOID_RETURN_TYPE = "void";

	// BANPU_BPS_GROUP
	public static final String BPS_GROUP_SAVE = "saveBpsGroup";
	public static final String BPS_GROUP_UPDATE = "updateBpsGroup";
	public static final String BPS_GROUP_DELETE = "deleteBpsGroup";
	public static final String BPS_GROUP_SEARCH = "searchBpsGroup";
	public static final String BPS_GROUP_FIND_BY_ID = "findBpsGroupById";
	public static final String BPS_GROUP_CHECK_DUPLICATE = "checkDuplicateGroup";

	// BANPU_BPS_TERM
	public static final String BPS_TERM_SAVE = "saveBpsTerm";
	public static final String BPS_TERM_UPDATE = "updateBpsTerm";
	public static final String BPS_TERM_UPDATE_VERSION = "updateVersionBpsTerm";
	public static final String BPS_TERM_DELETE = "deleteBpsTerm";
	public static final String BPS_TERM_SEARCH = "searchBpsTerm";
	public static final String BPS_TERM_FIND_BY_ID = "findBpsTermById";

	// BANPU_BPS_TERM_VERSION
	public static final String BPS_TERM_VERSION_SAVE = "saveBpsTermVersion";
	public static final String BPS_TERM_VERSION_UPDATE = "updateBpsTermVersion";
	public static final String BPS_TERM_VERSION_DELETE = "deleteBpsTermVersion";
	public static final String BPS_TERM_VERSION_SEARCH = "searchBpsTermVersion";
	public static final String BPS_TERM_VERSION_FIND_BY_ID = "findBpsTermVersionById";

	// BANPU_BPS_ATTACH_FILE
	public static final String BPS_ATTACH_FILE_SAVE = "saveBpsAttachFile";
	public static final String BPS_ATTACH_FILE_UPDATE = "updateBpsAttachFile";
	public static final String BPS_ATTACH_FILE_DELETE = "deleteBpsAttachFile";
	public static final String BPS_ATTACH_FILE_SEARCH = "searchBpsAttachFile";
	public static final String BPS_ATTACH_FILE_FIND_BY_ID = "findBpsAttachFileById";

	// BANPU_BPS_TERM_LOG
	public static final String BPS_TERM_LOG_SAVE = "saveBpsTermLog";
	public static final String BPS_TERM_LOG_UPDATE = "updateBpsTermLog";
	public static final String BPS_TERM_LOG_DELETE = "deleteBpsTermLog";
	public static final String BPS_TERM_LOG_SEARCH = "searchBpsTermLog";
	public static final String BPS_TERM_LOG_FIND_BY_ID = "findBpsTermLogById";
	
	//LDAP_USER
	public static final String LDAP_USER_FIND_BY_ID = "findUserById";
	//LDAP_GROUP
	public static final String LDAP_GROUP_FIND_BY_ID = "findGrupById";
	//COP_WORKPROCEDURE_MAIL_USER
	public static final String COP_WORKPROCEDURE_MAIL_USER = "getCopWorkProcedureUser";
}
