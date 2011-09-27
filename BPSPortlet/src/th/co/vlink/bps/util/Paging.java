package th.co.vlink.bps.util;

public class Paging {
	public static String getPaging(int pageNo, int pageSize, int totalPage, String host) {
		StringBuffer paggingBuffer = new StringBuffer();
		
		if(pageNo == 1) {
			paggingBuffer.append("<strong>« First</strong>");
			paggingBuffer.append("<strong>« Previous</strong>");
		} else {
			paggingBuffer.append("<a href=\"javascript: clickPage(1)\" class=\"pager-next active\" style=\"cursor:hand\">« First</a>");
			paggingBuffer.append("<a href=\"javascript: clickPage(");
			paggingBuffer.append(pageNo-1);
			paggingBuffer.append(")\" class=\"pager-next active\" style=\"cursor:hand\">« Previous</a>");
		}
		
		if(totalPage-pageNo >= 8) {
			for(int i=pageNo;i<=pageNo+4;i++) {
				if(i == pageNo) {
					paggingBuffer.append("<strong>");
					paggingBuffer.append(i);
					paggingBuffer.append("</strong>");
				} else {
					paggingBuffer.append("<a href=\"javascript: clickPage(");
					paggingBuffer.append(i);
					paggingBuffer.append(")\" class=\"pager-next active\" style=\"cursor:hand\">");
					paggingBuffer.append(i);
					paggingBuffer.append("</a>");
				}
			}
			paggingBuffer.append("<a href=\"javascript: clickPage(");
			paggingBuffer.append(pageNo+5);
			paggingBuffer.append(")\" class=\"pager-next active\" style=\"cursor:hand\">...</a>");
			paggingBuffer.append("<a href=\"javascript: clickPage(");
			paggingBuffer.append(totalPage-1);
			paggingBuffer.append(")\" class=\"pager-next active\" style=\"cursor:hand\">");
			paggingBuffer.append(totalPage-1);
			paggingBuffer.append("</a>");
			paggingBuffer.append("<a href=\"javascript: clickPage(");
			paggingBuffer.append(totalPage);
			paggingBuffer.append(")\" class=\"pager-next active\" style=\"cursor:hand\">");
			paggingBuffer.append(totalPage);
			paggingBuffer.append("</a>");
		} else {
			if(pageNo != 1 && (totalPage-pageNo) < 8) {
				int start = totalPage-7;
				if(start <= 0) {
					start = 1;
				}
				for(int i=start;i<=totalPage;i++) {
					if(i == pageNo) {
						paggingBuffer.append("<strong>");
						paggingBuffer.append(i);
						paggingBuffer.append("</strong>");
					} else {
						paggingBuffer.append("<a href=\"javascript: clickPage(");
						paggingBuffer.append(i);
						paggingBuffer.append(")\" class=\"pager-next active\" style=\"cursor:hand\">");
						paggingBuffer.append(i);
						paggingBuffer.append("</a>");
					}
				}
			} else {
				for(int i=1;i<=totalPage;i++) {
					if(i == pageNo) {
						paggingBuffer.append("<strong>");
						paggingBuffer.append(i);
						paggingBuffer.append("</strong>");
					} else {
						paggingBuffer.append("<a href=\"javascript: clickPage(");
						paggingBuffer.append(i);
						paggingBuffer.append(")\" class=\"pager-next active\" style=\"cursor:hand\">");
						paggingBuffer.append(i);
						paggingBuffer.append("</a>");
					}
				}
			}
		}
		if(pageNo == totalPage) {
			paggingBuffer.append("<strong>Next »</strong>");
			paggingBuffer.append("<strong>Last »</strong>");
		} else {
			paggingBuffer.append("<a href=\"javascript: clickPage(");
			paggingBuffer.append(pageNo+1);
			paggingBuffer.append(")\" class=\"pager-next active\" style=\"cursor:hand\">Next »</a>");
			paggingBuffer.append("<a href=\"javascript: clickPage(");
			paggingBuffer.append(totalPage);
			paggingBuffer.append(")\" class=\"pager-next active\" style=\"cursor:hand\">Last »</a>");
		}
		return paggingBuffer.toString();
	}
}
