/**
 * 
 */
package th.co.vlink.utils;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

/**
 * @author Chatchai Pimtun
 *
 */
public class NumberUtility {

	private static final char []thaiNumber = {'0','1','2','3','4','5','6','7','8','9'};
	private static final char []usNumber = {'0','1','2','3','4','5','6','7','8','9'};
	public static final char[]numberThaiKey = {'0','1','2','3','4','5','6','7','8','9'};
	public static final String[]numberThaiValue = {"\u0E50","\u0E51","\u0E52","\u0E53",
							"\u0E54","\u0E55","\u0E56","\u0E57","\u0E58","\u0E59"};
	private static Map mapNumberThai = new HashMap()  ;
	
	public static String changeNumberFormat(String allString,Locale locale){
		
		if(Locale.getDefault().getLanguage().equalsIgnoreCase(locale.getLanguage())){
			
			allString = allString.replace('0', thaiNumber[0]);
			allString = allString.replace('1', thaiNumber[1]);
			allString = allString.replace('2', thaiNumber[2]);
			allString = allString.replace('3', thaiNumber[3]);
			allString = allString.replace('4', thaiNumber[4]);
			allString = allString.replace('5', thaiNumber[5]);
			allString = allString.replace('6', thaiNumber[6]);
			allString = allString.replace('7', thaiNumber[7]);
			allString = allString.replace('8', thaiNumber[8]);
			allString = allString.replace('9', thaiNumber[9]);
			
		}else{
			
			 
			allString = allString.replace('0', usNumber[0]);
			allString = allString.replace('1', usNumber[1]);
			allString = allString.replace('2', usNumber[2]);
			allString = allString.replace('3', usNumber[3]);
			allString = allString.replace('4', usNumber[4]);
			allString = allString.replace('5', usNumber[5]);
			allString = allString.replace('6', usNumber[6]);
			allString = allString.replace('7', usNumber[7]);
			allString = allString.replace('8', usNumber[8]);
			allString = allString.replace('9', usNumber[9]);
			
		}
		return allString;
	}
//	@SuppressWarnings("unchecked")
	public static String changeNumberToThai(String num_eng){
		 
		//if(mapNumberThai.size()>0)
		/*for (int i = 0; i < numberThaiKey.length; i++) {
			mapNumberThai.put(numberThaiKey[i],numberThaiValue[i]);
		}*/
			StringBuffer buffer = new StringBuffer();
		/*for (int i = 0; i < num_eng.length(); i++) {
			System.out.println(num_eng.charAt(i));
			buffer.append(mapNumberThai.get(num_eng.charAt(i))!=null?mapNumberThai.get(num_eng.charAt(i))
					:num_eng.charAt(i));
		}*/
		return buffer.toString();
	}
	public static String changeNumberFormatToThai(String numberString){ 
			/*numberString = numberString.replace("0", numberThaiValue[0]);
			numberString = numberString.replace("1", numberThaiValue[1]);
			numberString = numberString.replace("2", numberThaiValue[2]);
			numberString = numberString.replace("3", numberThaiValue[3]);
			numberString = numberString.replace("4", numberThaiValue[4]);
			numberString = numberString.replace("5", numberThaiValue[5]);
			numberString = numberString.replace("6", numberThaiValue[6]);
			numberString = numberString.replace("7", numberThaiValue[7]);
			numberString = numberString.replace("8", numberThaiValue[8]);
			numberString = numberString.replace("9", numberThaiValue[9]);*/
			return numberString;
		}
	public static String usNumber(String allString){
		
		return allString;
	}
	
	public static Double StringToDouble(String strDouble) {
		Double doubleValue = null;
		try {
			if (strDouble != null && !strDouble.trim().equals("")) {
				doubleValue = new Double(strDouble.replaceAll(",",""));
			}
		} catch (Exception e) {
			doubleValue = null;
		}
		return doubleValue;
	}
	
	public static String DoubleToString(Double doubleValue) {
		if (doubleValue == null) 
			return "0.00";
		 else 
			return doubleValue.toString();		
	}
	
	public static Long StringToLong(String strLong) {
		Long longValue = null;
		try {
			if (strLong != null && !strLong.trim().equals("")) {
				longValue = new Long(strLong);
			}
		} catch (Exception e) {
			longValue = null;
		}
		return longValue;
	}
	
	public static String LongToString(Long longValue) {
		if (longValue == null) 
			return "";
		 else 
			return longValue.toString();		
	}

}
