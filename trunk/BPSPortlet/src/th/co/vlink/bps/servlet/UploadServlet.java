package th.co.vlink.bps.servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import java.util.ResourceBundle;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
 

/**
 * Servlet implementation class UploadServlet
 */
public class UploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static ResourceBundle bundle;
	static{
		  //bundle =  ResourceBundle.getBundle( "org/restlet/example/book/restlet/ch8/mailApplication" );
		bundle =  ResourceBundle.getBundle( "config" );				
	}
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UploadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	        System.out.println();       
	        String ndPathFileGen=null;
	     // Create a factory for disk-based file items
	        DiskFileItemFactory factory = new DiskFileItemFactory();

	        // Set factory constraints
	      /*  factory.setSizeThreshold(yourMaxMemorySize);
	        factory.setRepository(yourTempDirectory);*/
	        
	        factory.setSizeThreshold(4096);
            factory.setRepository(new File(getServletContext().getRealPath("/tmp")));


	        // Create a new file upload handler
	        ServletFileUpload upload = new ServletFileUpload(factory);

	        // Set overall request size constraint
	        upload.setSizeMax(1000000000);
	     // Parse the request
	     //FileItemIterator iter=null;
	     Iterator iter = null;//
		try {
			if(ServletFileUpload.isMultipartContent(request)){
				 List items = upload.parseRequest(request);
				 iter=items.iterator();
			}
				//iter = upload.getItemIterator(request);
		} catch (FileUploadException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		 
		if(iter!=null)
			while (iter.hasNext()) {
			   //  FileItemStream item = iter.next();
				
			     FileItem item = (FileItem) iter.next();
			     //DiskFileItem item = (DiskFileItem) iter.next();
			    // DiskFileItem item2 = (DiskFileItem) item;
			    // FileItem FileItem=null;
			    // String name = item.getFieldName();			     
			    // InputStream stream = item.openStream();			     
			     if (item.isFormField()) {
			         /*System.out.println("Form field " + name + " with value "
			             + Streams.asString(stream) + " detected.");*/ 
			    	 System.out.println("FieldName = "+item.getFieldName()+" value="+item.getString());

			     } else {
			    	// DiskFileItem disk_item = (DiskFileItem) item;
			    	 String fieldName = item.getFieldName();
                     String fileName = item.getName();
                    
                     String contentType = item.getContentType();
                     boolean isInMemory = item.isInMemory();
                     long sizeInBytes = item.getSize();

                     Random generator = new Random();
                     String randomGen = Integer.toString(generator.nextInt());
                     String s = item.getName();
                     s = FilenameUtils.getName(s);
                     System.out.println("save file "+fileName+" file name "+s);
                    /* fullFile = new File("C:\\vlink\\upload\\flv\\"+s);
                     item.write(fullFile);
                     fileLength = (int) fullFile.length();
                    // fileOutputStream = new FileOutputStream(randomGen);
                     System.out.println("fileLength=>"+fileLength);

                     fullFile = new File(randomGen);
                     item.write(fullFile);
                     fileLength = (int) fullFile.length();
                     fileInputStream = new FileInputStream(randomGen);

			         System.out.println("File field " + name + " with file name "
			             + item.getName() + " detected."); */
			         // Process the input stream

						FileOutputStream fos = null;

						try {  
							byte []filesize = item.get(); 
							if(filesize.length>0){									
								long current = System.currentTimeMillis();
							org.joda.time.DateTime    dt1  = new org.joda.time.DateTime (new Date().getTime()); 
								
							  String monthStr= dt1.getMonthOfYear()+"";
							  String yearStr= dt1.getYear()+"";
							  monthStr = monthStr.length()>1?monthStr:"0"+monthStr;
							  //String ndFilePath = "/usr/local/Work/TestDownload/"+yearStr+"_"+monthStr+"";
							  String ndFilePath = bundle.getString("richtextImgPath");//+yearStr+"_"+monthStr+"";
							  String path =ndFilePath;
							  createDirectoryIfNeeded(path);
							  String filename =s ;// multipart.getOriginalFilename();
							  String []filenameSplit  =filename.split("\\.");
							  String extension ="";
							  if(filenameSplit!=null && filenameSplit.length>0){
								  extension =filenameSplit[filenameSplit.length-1];
							  }
							 ndPathFileGen =current+""+genToken()+"."+extension; 
						//	 FileInputStream fin= new FileInputStream(file)
							 fos = new FileOutputStream(path+"/"+ndPathFileGen);								
							 fos.write(filesize);
							}
						}catch (Exception e) {
							// TODO: handle exception
							e.printStackTrace();
						}
						finally{
							if(fos!=null)
								try {
									fos.close();
								} catch (IOException e) {
									// TODO Auto-generated catch block
									e.printStackTrace();
								}	 
						}  
			    }
			}
		
	     String jsonStr="{\"id\":\""+ndPathFileGen+"\"}";
	     PrintWriter wt = null;
			try {
				response.setContentType("application/json;charset=UTF-8");
				wt = response.getWriter();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			wt.write(jsonStr);

		}
	 private void createDirectoryIfNeeded(String directoryName)
	 {
	   File theDir = new File(directoryName);

	   // if the directory does not exist, create it
	   if (!theDir.exists())
	   {
		   boolean cancreate = theDir.mkdir();
	   }
	  
	 }
	 private void deleteOldFile(String realPathFile){
		 File f1 = new File(realPathFile);
		 if(f1.exists())				
			 f1.delete();	
	 }
	 private String genToken(){
			StringBuffer sb = new StringBuffer();
		    for (int i = 36; i > 0; i -= 12) {
		      int n = Math.min(12, Math.abs(i));
		      sb.append(org.apache.commons.lang.StringUtils.leftPad(Long.toString(Math.round(Math.random() * Math.pow(36, n)), 36), n, '0'));
		    }
		    return sb.toString();
	 }
}