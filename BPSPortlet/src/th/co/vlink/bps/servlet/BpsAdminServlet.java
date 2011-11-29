package th.co.vlink.bps.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import th.co.vlink.bps.json.BpsGroupJSon;
import th.co.vlink.bps.service.BpsAdminService;
import th.co.vlink.xstream.BpsGroup;
import th.co.vlink.xstream.common.VResultMessage;

import com.google.gson.Gson;

/**
 * Servlet implementation class BpsAdminServlet
 */
public class BpsAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	private BpsAdminService bpsAdminService=null;
    public BpsAdminServlet() {
        super();
        /*WebApplicationContext wac = WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext());
		bpsAdminService = (BpsAdminService) wac.getBean("bpsAdminService");*/
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		/*Enumeration e= request.getParameterNames();
		while (e.hasMoreElements()) {
			String object = (String) e.nextElement();
		}*/
		String bpgGroupName=request.getParameter("name_startsWith");
		BpsGroup bpsGroup  =new BpsGroup();
		bpsGroup.setBpgGroupName(bpgGroupName);
		 WebApplicationContext wac = WebApplicationContextUtils
					.getRequiredWebApplicationContext(getServletContext());
			bpsAdminService = (BpsAdminService) wac.getBean("bpsAdminService");
		 VResultMessage vresultMessage = bpsAdminService.searchBpsGroup(bpsGroup);
         if(vresultMessage!=null && vresultMessage.getResultListObj()!=null && vresultMessage.getMaxRow()!=null){
             BpsGroupJSon bpsGroupJSon =new BpsGroupJSon();
             bpsGroupJSon.setTotalResultsCount(Integer.parseInt(vresultMessage.getMaxRow()));
            List<BpsGroup> bpsGroups= vresultMessage.getResultListObj();
            th.co.vlink.bps.json.BpsGroup[] bpsGroups_result=new th.co.vlink.bps.json.BpsGroup[bpsGroups.size()];
            int index=0;
            for (BpsGroup bpsGroup2 : bpsGroups) {
            	th.co.vlink.bps.json.BpsGroup group=new th.co.vlink.bps.json.BpsGroup();
            	group.setBpgId(bpsGroup2.getBpgId());
            	group.setBpgGroupName(bpsGroup2.getBpgGroupName());
            	bpsGroups_result[index]=group;
            	index++;
			}
            bpsGroupJSon.setBpsGroups(bpsGroups_result);
             Gson gson = new Gson();
             String jsonStr = gson.toJson(bpsGroupJSon);   
     		PrintWriter wt = null;
     		try {
     			response.setContentType("application/json;charset=UTF-8");
     			wt = response.getWriter();
     		} catch (IOException e) {
     			// TODO Auto-generated catch block
     			e.printStackTrace();
     		}
     		wt.write(jsonStr);
             /* result = new ArrayList(2);
                 result.add(vresultMessage.getResultListObj());
                 result.add(vresultMessage.getMaxRow());*/
         }
         //{"totalResultsCount":173896,"geonames":[{"countryName":"Indonesia","adminCode1":"07","fclName":"city, village,...","countryCode":"ID","lng":110.405,"fcodeName":"populated place","toponymName":"Ungaran","fcl":"P","name":"Ungaran","fcode":"PPL","geonameId":1622636,"lat":-7.1397222,"adminName1":"Central Java","population":127812}
		/*XStream json = new XStream(new JsonHierarchicalStreamDriver());
		Class[] objs = new Class[1];
		objs[0] = EventDTO.class;
		json.processAnnotations(objs);
		if(todayMap.size()>0){
        	for (Iterator iterator = todayMap.keySet().iterator(); iterator.hasNext();) {
				String key = (String) iterator.next();
				todayDTO.add((EventDTO)todayMap.get(key));
			}
        }
        if(tomorrowMap.size()>0){
        	for (Iterator iterator = tomorrowMap.keySet().iterator(); iterator.hasNext();) {
				String key = (String) iterator.next();
				tomorrowDTO.add((EventDTO)tomorrowMap.get(key));
			}
        }	
		result.add(todayDTO);
		result.add(tomorrowDTO);
		String jsonStr = json.toXML(result);
		PrintWriter wt = null;
		try {
			response.setContentType("application/json;charset=UTF-8");
			wt = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		wt.write(jsonStr);*/
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
