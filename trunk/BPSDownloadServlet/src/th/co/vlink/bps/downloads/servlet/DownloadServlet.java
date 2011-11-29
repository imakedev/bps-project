package th.co.vlink.bps.downloads.servlet;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ResourceBundle;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

/**
 * Servlet implementation class DownloadServlet
 */
public class DownloadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String SCHEMA="DB2INST1";//"appdb"; // 
	private static ResourceBundle bundle;
	static{
		bundle =  ResourceBundle.getBundle( "config" );				
	}
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DownloadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		processAction(request,response);
		//getImage(request,response);
	}
	private void getImage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	 
			String id =  request.getParameter("id");
			String filePath = bundle.getString("richtextImgPath");//+yearStr+"_"+monthStr+"";
			//String filePath="/usr/local/BACKUP_DATA/data/Work/Picture/aoe5.JPG";
			/*response.addHeader("content-disposition",
			        "attachment; filename="+filenameStr.trim());*/
			InputStream in = null;
		      OutputStream out = response.getOutputStream(); 
		      InputStream stream  = null;
		      try {   
		    		  stream = new FileInputStream(filePath+"/"+id);
		    		  in = new BufferedInputStream(stream);
		         while (true) {
		            int data = in.read();
		            if (data == -1) {
		               break;
		            }
		            out.write(data);
		         }
		      }catch (Exception e) {
		    	  e.printStackTrace();
				// TODO: handle exception
			 } finally {
		         if (in != null) {
		            in.close();
		         }
		         if (stream != null) {
		        	 stream.close();
			         } 
		         if (out != null) {
		            out.close();
		         }
		      }
		      out.flush();
		      out.close(); 
	 
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		processAction(request,response);
	}
	/* (non-Javadoc)
	 * @see javax.servlet.GenericServlet#processAction()
	 */
	private void processAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	 
		String hotlink = request.getQueryString();
		String []adminview = hotlink.split("&mode=");
		System.out.println(" adminview size="+adminview);
		if(adminview!=null && adminview.length>1){
			hotlink = adminview[0];
			StringBuffer query = new StringBuffer("select download.*  from "+SCHEMA+".BANPU_BPS_ATTACH_FILE  download where download.BPAF_HOTLINK='"+hotlink.trim()+"'");	 
			
			Context ctx =null;
			try {
				ctx = new InitialContext();
			} catch (NamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}  
			DataSource ds = null;
			try { 
				//ds = (DataSource)ctx.lookup("java:/comp/env/jdbc/appdb");
				ds = (DataSource)ctx.lookup("jdbc/appdb"); 
			} catch (NamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}               
			//org.apache.tomcat.dbcp.dbcp.BasicDataSource basicDs = (org.apache.tomcat.dbcp.dbcp.BasicDataSource)ds;
			com.ibm.ws.rsadapter.jdbc.WSJdbcDataSource basicDs = (com.ibm.ws.rsadapter.jdbc.WSJdbcDataSource)ds;
			Connection con = null;
			try {
				con = basicDs.getConnection();//("oracle", "password");//Connection();
				//con = ds.getConnection();//("oracle", "password");//Connection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}           
			 
			ResultSet result =selectStatement(con,query.toString()); 
			String filePath = null;
			String fileName = null;
			try {
				if(result!=null)
				while (result.next()) { 
					filePath = result.getString("BPAF_FILE_PATH");
					fileName = result.getString("BPAF_FILE_NAME");
				}	
			if(filePath!=null && filePath.length()>0
					&& fileName!=null && fileName.length()>0){
				String filenameStr = fileName.trim().replaceAll(" ","_");
				response.addHeader("content-disposition",
				        "attachment; filename="+filenameStr.trim());
				InputStream in = null;
			      OutputStream out = response.getOutputStream(); 
			      InputStream stream  = null;
			      try {   
			    		  stream = new FileInputStream(filePath);
					         in = new BufferedInputStream(stream);
			         while (true) {
			            int data = in.read();
			            if (data == -1) {
			               break;
			            }
			            out.write(data);
			         }
			      }catch (Exception e) {
			    	  e.printStackTrace();
					// TODO: handle exception
				 } finally {
			         if (in != null) {
			            in.close();
			         }
			         if (stream != null) {
			        	 stream.close();
				         } 
			         if (out != null) {
			            out.close();
			         }
			      }
			      out.flush();
			      out.close(); 
			}
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				try {
					if (result != null) {
						result.close();					
					}
					if (con != null) {
						con.close();					
					}
					if (ctx != null) {
						try {
							ctx.close();
						} catch (NamingException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}					
					}			
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}else{
			getImage(request,response);
		}
		
	}
	 private ResultSet selectStatement(Connection connection,String query)
	    {
	        ResultSet rs = null;
	        if(connection != null)
	          {
	            try
	            {
	                PreparedStatement pst1 = connection.prepareStatement(query);
	                rs = pst1.executeQuery();
	            }
	            catch(SQLException e)
	            {
	                 e.printStackTrace();
	            } 
	        }
	        return rs;
	    }
}
