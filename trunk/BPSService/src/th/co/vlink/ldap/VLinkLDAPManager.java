package th.co.vlink.ldap;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.ResourceBundle;

import javax.naming.Context;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.directory.Attribute;
import javax.naming.directory.DirContext;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;
import javax.naming.ldap.InitialLdapContext;
import javax.naming.ldap.LdapContext;
 

/**
 * @author Chatchai
 * 
 */
public class VLinkLDAPManager {
	private static String LDAP_URL;

	/**
	 * @param args
	 */
	public static final ResourceBundle myResources = ResourceBundle
			.getBundle("ldap");

	/*public VLinkLDAPManager(String ldap_url) {
		if(!(ldap_url!=null && ldap_url.trim().length()>0)){
			
		}
			this.LDAP_URL = ldap_url;
	}*/

	private static String root_user;
	private static String root_password;
	private static String BASE_SEARCH;
	static {
		root_user = myResources.getString("ROOT_USER_DEFAULT");
		root_password = myResources.getString("ROOT_PASSWORD_DEFAULT");
		LDAP_URL= myResources.getString("LDAP_URL");
		BASE_SEARCH= myResources.getString("BASE_SEARCH");
	//	 System.out.println("root_user="+root_user);
	}

	private DirContext connectLDAP(boolean secureConnection)
			throws NamingException {
		DirContext ctx = null;
		// -----------------------------------------------
		// Set up the environment for creating the initial
		// context.
		// -----------------------------------------------
		Properties props = new Properties();
		props.setProperty(Context.INITIAL_CONTEXT_FACTORY,
				GeneralDefs.LDAP_PROVIDER);
		props.setProperty(Context.PROVIDER_URL, LDAP_URL);
		props.setProperty(Context.URL_PKG_PREFIXES,
				GeneralDefs.URL_CONTEXT_PREFIX);
		props.setProperty(Context.REFERRAL, GeneralDefs.REFERRALS_IGNORE);
		if (secureConnection) {
			props.setProperty(Context.SECURITY_AUTHENTICATION,
					GeneralDefs.UPDATE_SECURITY_LEVEL);
			// --------------------------------------------------
			// specify the root username
			// --------------------------------------------------
			// props.setProperty(Context.SECURITY_PRINCIPAL,
			// GeneralDefs.ROOT_USER);
			props.setProperty(Context.SECURITY_PRINCIPAL, root_user);
			// --------------------------------------------------
			// specify the root password
			// --------------------------------------------------
			/*
			 * props.setProperty(Context.SECURITY_CREDENTIALS,
			 * GeneralDefs.ROOT_PASSWORD);
			 */
			props.setProperty(Context.SECURITY_CREDENTIALS, root_password);

			// --------------------------------------------------
		}
		// search does not need root user id and password.
		else {
			props.setProperty(Context.SECURITY_AUTHENTICATION,
					GeneralDefs.SEARCH_SECURITY_LEVEL);
		}
		// -----------------------------------------------
		// Get the environment properties (props) for
		// creating initial context and specifying LDAP
		// service provider parameters.
		// -----------------------------------------------
		// ctx = new InitialDirContext(props);

		ctx = new InitialLdapContext(props, null);
		return ctx;
	}

	public DirContext getDirContext()
			throws NamingException {		
		return connectLDAP(false);	 
	}

	private String getLdapValue(NamingEnumeration ne) {
		String values = "";
		while (ne.hasMoreElements()) {
			Object neObj;
			try {
				neObj = ne.next();
				if (neObj != null && neObj.toString().length() > 0)
					values = values + neObj.toString() ;//+ "^";
			} catch (NamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		/*if (values.length() > 0)
			values = values.substring(0, values.length() - 1);*/
		return values;
	}

	public List getAllUsers(String userName) {

		ArrayList usersList = new ArrayList();
		String filter =  "(objectclass=inetOrgPerson)";
		if(userName!=null && userName.trim().length()>0)
		filter = "(&(objectclass=inetOrgPerson)(uid="+userName.trim()+"*))";

		DirContext ctx = null;
		LdapContext lctx = null;
		int index=0;
		try {
			ctx = connectLDAP(false);
			lctx = (LdapContext) ctx;
			//String sortKey = "uid";
			/*lctx.setRequestControls(new Control[] { new SortControl(sortKey,
					Control.CRITICAL) });*/
			//lctx.setRequestControls(new Control[] ());

			SearchControls constraints = new SearchControls();
			//constraints.setCountLimit(10000l);
			constraints.setSearchScope(SearchControls.ONELEVEL_SCOPE);
			NamingEnumeration results = lctx.search(BASE_SEARCH,
					filter, constraints);
			
			if (results.hasMoreElements()) {
				while (results.hasMoreElements()) {

					SearchResult sr = (SearchResult) results.next();
					Attribute attr;
					NamingEnumeration ne;
				//	NtcPerson ntcPerson = new NtcPerson();
					// Iterate through the attributes..
					for (NamingEnumeration a = sr.getAttributes().getAll(); a
							.hasMore();) {
						attr = (Attribute) a.next();
						if (attr.getID() != null) {
							// uid , givenname,sn,displayname,mail,cn,maildomain
							if (attr.getID().equals("uid")) {
								ne = attr.getAll();
								Class[] c = new Class[1];
								c[0] = String.class;
								String[] s = new String[1];
								s[0] = getLdapValue(ne);
								index++;
								//if(s[0].equals("wpsadmin"))
							/*	Object idObj = ntcPerson.getClass()
										.getMethod("setNlpUserId", c)
										.invoke(ntcPerson, s);*/
								// ntcPerson.setNlpUserId(getLdapValue(ne));
							}
							if (attr.getID().equals("givenname")) {
								ne = attr.getAll();
								while (ne.hasMoreElements()) {
									Object neObj = ne.next();
									String givenname = neObj.toString();
									//ntcPerson.setNlpGivenName(givenname);
								}
							}
							if (attr.getID().equals("sn")) {
								ne = attr.getAll();
								while (ne.hasMoreElements()) {
									Object neObj = ne.next();
									String sn = neObj.toString();
									//ntcPerson.setNlpSn(sn);
								}
							}
							if (attr.getID().equals("displayname")) {
								ne = attr.getAll();
								while (ne.hasMoreElements()) {
									Object neObj = ne.next();
									String displayname = neObj.toString();
								//	ntcPerson.setNlpDisplayName(displayname);
								}
							}
							if (attr.getID().equals("mail")) {
								ne = attr.getAll();
								while (ne.hasMoreElements()) {
									Object neObj = ne.next();
									String mail = neObj.toString();
									usersList.add(mail);
									/*if(mail.equals("wpsadmin@pttep.com"))
									*/
									//ntcPerson.setNlpMail(mail);
								}
							}
							if (attr.getID().equals("maildomain")) {
								ne = attr.getAll();
								while (ne.hasMoreElements()) {
									Object neObj = ne.next();
									String maildomain = neObj.toString();
									//ntcPerson.setNlpMailDomain(maildomain);
								}
							}
							if (attr.getID().equals("cn")) {
								ne = attr.getAll();
								String cn = "";
								while (ne.hasMoreElements()) {
									Object neObj = ne.next();
									cn = cn + neObj.toString() + ",";
								}
								if (cn.length() > 0)
									cn = cn.substring(0, cn.length() - 1);
								//ntcPerson.setNlpCn(cn);
							}

						}

					}
					
					// End add group name

				}
			} else {
			}
		} catch (Exception e) {
			e.printStackTrace();

		}
		// always close the directory context when you are done
		finally {
			try {
				if (null != lctx)
					lctx.close();
				if (null != ctx)
					ctx.close();
			} catch (Exception e2) {
			}
		}
		return usersList;

	}  
	public List<String> getMailMemberOfGroup(String group) {

		ArrayList usersList = new ArrayList();
		String filter =  "(&(objectclass=*)("+group+"))"; 
		DirContext ctx = null;
		LdapContext lctx = null;
		int index=0;
		List<String> member=new ArrayList<String>();
		List<String> mails=null;
		try {
			ctx = connectLDAP(false);
			lctx = (LdapContext) ctx; 
			SearchControls constraints = new SearchControls(); 
			constraints.setSearchScope(SearchControls.SUBTREE_SCOPE);
			NamingEnumeration results = lctx.search(BASE_SEARCH,
					filter, constraints);  
			if (results.hasMoreElements()) {
				while (results.hasMoreElements()) {
					SearchResult sr = (SearchResult) results.next();				
					Attribute attr;
					NamingEnumeration ne; 
					for (NamingEnumeration a = sr.getAttributes().getAll(); a
							.hasMore();) {
						attr = (Attribute) a.next();
						if (attr.getID() != null) {
							// uid , givenname,sn,displayname,mail,cn,maildomain
							if (attr.getID().equals("member")) {
								ne = attr.getAll();
								while (ne.hasMoreElements()) {
									Object neObj = ne.next();
									  member.add(neObj.toString());
								}
							} 
							if (attr.getID().equals("mail")) {
								ne = attr.getAll();
								while (ne.hasMoreElements()) {
									Object neObj = ne.next();
									String mail = neObj.toString();
									usersList.add(mail); 
								}
							} 
						}
					}
					// End add group name
				}
			} else {
			}
			if(member.size()>0){
				mails =new ArrayList<String>(member.size());
				for (String string : member) {
					String []dns= string.split(",");
					String base_search="";
					for (int i = 1; i < dns.length; i++) {
						base_search=base_search+dns[i]+((i!=(dns.length-1))?",":"");
					}
					filter =  "(&(objectclass=*)("+dns[0]+"))";
					results = lctx.search(base_search,
							filter, constraints); 
					//CN=Chutima Pimthong,OU=TH,O=BPG
					if (results.hasMoreElements()) {
						while (results.hasMoreElements()) {
							SearchResult sr = (SearchResult) results.next();
							Attribute attr;
							NamingEnumeration ne; 
							for (NamingEnumeration a = sr.getAttributes().getAll(); a
									.hasMore();) {
								attr = (Attribute) a.next();
								if (attr.getID() != null) { 
									if (attr.getID().equals("mail")) {
										ne = attr.getAll(); 
										while (ne.hasMoreElements()) {
											Object neObj = ne.next(); 
											mails.add(neObj.toString()); 
										}
									} 
							  }
							}
						}
					} 
				}
			}
		} catch (Exception e) {
			e.printStackTrace();

		}
		// always close the directory context when you are done
		finally {
			try {
				if (null != lctx)
					lctx.close();
				if (null != ctx)
					ctx.close();
			} catch (Exception e2) {
			}
		}
		return mails;

	}  

	/*public static void main(String[] args) {

		VLinkLDAPManager manager = new VLinkLDAPManager();
		List<String> mails=manager.getMailMemberOfGroup("CN=00_COS");
		System.out.println(mails);
	}*/
}
