package th.co.vlink.utils;

public class StringUtil {
	
	public static String subStringDetail(String detail, int begin, int end){
		
		if(null != detail  && detail.length() > end){
			detail = detail.substring(begin, end);
		}
		return detail;
		
	}
	

	public static String encodeThaiString(String a) {
		StringBuffer buffer = new StringBuffer();

		try {
			byte[] b = a.getBytes("ISO8859_1");

			for (int i = 0; i < b.length; i++) {
				//         System.out.println("b[i]"+b[i]);
				if (b[i] >= 0 && b[i] < 127) {
					buffer.append(new String(toPadHexString(0xffff & b[i], 4)));
				} else {
					//             System.out.println((0xff & b[i])+3424);
					buffer.append(new String(toPadHexString(
							(0xff & b[i]) + 3424, 4)));
				}
			}

		} catch (Exception ex) {

		}
		//System.out.print("endcodeThaiString : "+buffer.toString());
		return buffer.toString();

	}
	

	public static String decodeThaiString(String a) {
		StringBuffer s = new StringBuffer();

		byte[] sub = new byte[4];
		for (int i = 0, j = 0; i < a.length(); i++) {
			sub[j++] = (byte) (0xff & a.charAt(i));
			if ((i != 0) && ((i + 1) % 4 == 0)) {
				String ss = new String(sub);
				int c = Integer.parseInt(ss, 16);
				j = 0;
				if (c > 127) {
					c -= 3424;
				}
				if (c == '\t') {
					c = ' ';
				}
				s.append((char) (0xff & c));
			}
		}
		//System.out.println("decodeThaiString : "+s.toString());
		return s.toString();
	}
	
	private static byte[] toPadHexString(int x, int n) {
		String s = Integer.toHexString(x);
		int padln = n - s.length();
		for (int i = 0; i < padln; i++) {
			s = '0' + s;
		}
		return s.getBytes();
	}
	
	public static String formatThai(String thai){
		return decodeThaiString(encodeThaiString(thai));
	}
	
	public static String subUrl(String value, String widthStr, String heightStr){
		int width1 = 1;
		int height = 1;
		int a1 = 1;
		int a2 = 1;
		int h1 = 1;
		int h2 = 1;
		for(int i=0;i<=10;i++){
		width1 = value.indexOf("width", a1);
		height = value.indexOf("height", h1);
		//System.out.println("---"+width1);
		String te1 = "";
		String te2 = "";
		if(width1 > -1){
			a1 = value.indexOf("\"", width1);
			a2 = value.indexOf("\"", a1+1);
			h1 = value.indexOf("\"", height);
			h2 = value.indexOf("\"", h1+1);
			//System.out.println("a1 : "+a1);
			
			te1 = value.substring(width1, a2+1);
			te2 = value.substring(height, h2+1);
			value = value.replaceAll(te1, "width=\""+widthStr+"\"");
			value = value.replaceAll(te2, "height=\""+heightStr+"\"");
			//System.out.println(value);
			//System.out.println("="+width1);
		}else{
			break;
		}

		//System.out.println("w "+width1);
		}
		
		//System.out.println(value);
		return value;
	}
	
	public static void main(String[]args){
		StringUtil util = new StringUtil();
 
	//	System.out.println(encodeThaiString(ab));
//		String dd = util.decodeThaiString(encodeThaiString(ab));
		String a = subUrl("sss width=\"ss\"ss height=\"xxx\"ssss width=\"ss\"ss height=\"xxx\"s", "", "");
		//System.out.println(a);
		
	}

}
