package th.co.vlink.utils;

import java.lang.reflect.Method;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.PropertyUtils;


/**
 * @author Chatchai Pimtun
 *
 */
 
public class BeanUtility {

	
	public static void copyProperties(String prefix, Object destination, Object source){
		
		Map 	  fieldMap	= null;
		Iterator  iterator  = null;
		Map.Entry entry     = null;
		String    key       = "";
		Object    oValue    = null;
		String    keyPrefix = "";	
//		String    beanName  = "";
		Object    obj       = null;
		String    className = "";
		String	  value		= "";
		Object 	  nValue	= null;
		try{

//			//System.out.println("*****************************************************************************");
			
			if(!prefix.equals("")){
				keyPrefix = prefix + ".";
				keyPrefix = keyPrefix.substring(0,1).toLowerCase()+keyPrefix.substring(1, keyPrefix.length());
				//System.out.println("prefix is : " + keyPrefix + "xxx");
			}
			
//			beanName = destination.getClass().getName();
			//System.out.println("Describe Bean " + beanName);
			
			fieldMap = PropertyUtils.describe(destination);
			
			iterator = fieldMap.entrySet().iterator();
			
			while(iterator.hasNext()){
				entry  = (Map.Entry)iterator.next();
				key    = (String)entry.getKey();		
				oValue = entry.getValue();
				if(oValue==null){
					oValue = "";
				}
				//System.out.println("**************** "+key+"="+value);
				value = (String)oValue.toString();
				
				if(key.equals("class")){
				}else if(isSubClass(value)){
//					System.out.println("isSubClass '" + keyPrefix+key +"'");
					className = BeanUtility.getClassName(value);
					obj       = BeanUtility.newInstance(className);
					
					//send key as prefix of subclass
					BeanUtility.copyProperties(keyPrefix+key, obj, source);

					if(obj != null){
						BeanUtils.setProperty(destination,key,obj);
					}
				}else if(isList(value)){
					//System.out.println(">>>>>>>>>>>>>> is List(Under Construction) "+keyPrefix+key);
//					nValue = this.getListValue(keyPrefix+key, source);
//					BeanUtils.setProperty(destination,key,nValue);
				}else{
//					nValue = BeanUtility.getMapValue(keyPrefix+key, source, destination, key);
					nValue = BeanUtility.getObjectValueByKey(keyPrefix+key, source, destination, key);
					if(nValue != null){
//						System.out.println("Set property '"     + keyPrefix + key + 
//								 "' to instance of '" + beanName + 
//								 "' with value '"     + nValue   + "'.");
						BeanUtils.setProperty(destination,key,nValue);
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	private static boolean isSubClass(String str){
		boolean result = false;
		try{
			Class.forName(BeanUtility.getClassName(str));
			result = true;
		}catch (Exception e){
			result = false;
		}
		
		return result;
	}

	private static boolean isList(String value){
		boolean isList    = false;
		try{
			isList = value.startsWith("[")&&
					 value.endsWith("]");
			
			if(isList){
				return isList;
			}
		}catch (Exception e){
			isList = false;
		}
		
		return isList;
	}

	private static String getClassName(String value){
		String  className = "";
		boolean isList    = false;
		int     start     = -1;
		try{
			isList = value.startsWith("[")&&
					 value.endsWith("]");

			if(isList){
//				//System.out.println(">>>>>>>>>>>> is List : "+value);
				start = 1;
			}else{
				start = 0;
			}
			if(value.indexOf("@") > -1){
				className = value.substring(start,value.indexOf("@"));
//				//System.out.println("Input is : '" + value + "' , Class Name is : '" + className + "'");
			}
			
			return className;
			
		}finally{
		}
	}
	
	private static Object newInstance(String className)throws Exception{
		Class  clazz  = null;
		Object obj    = null;
		try{
			clazz = Class.forName(className);
			obj   = clazz.newInstance();
//			System.out.println("New instance bean for '" + className + "' success.");
			return obj;
		}catch(Exception e){
			e.printStackTrace();
			throw new Exception("New instance bean for '" + className + "' fail.");
		}finally{
			clazz = null;
		}
	}

	//success case : source name xxxx.xxxx
	//success case : source name xxxxFull.xxxx
	//bug case : source name xxxx.xxxxFull or xxxx.xxxx.xxxxFull
	//bug case : source name xxxxFull.xxxxFull
	//xxxx is source object
//	private static Object getMapValue(String sKey,Object source, Object destination, String dKey)throws Exception{
//		Object    obj     	 	= null;
//		try{
//			
//			if(sKey.indexOf("DTO") > -1){
//				sKey = sKey.replaceAll("DTO","");
//			}
//			
//			try{
//				obj = PropertyUtils.getProperty(source, sKey);
//				
//				obj = BeanUtility.changeType(obj, destination, dKey);
//				
//			}catch(NoSuchMethodException e){
//				try{
//					if(sKey.indexOf(".") > -1){
//						sKey = sKey.substring(0, sKey.indexOf(".")) + "Full" + sKey.substring(sKey.indexOf("."), sKey.length());
//					}else{
//						sKey = sKey + "Full";
//					}
//					
//					obj = PropertyUtils.getProperty(source, sKey);
//					
//					obj = BeanUtility.changeType(obj, destination, dKey);
//					
//				}catch(NoSuchMethodException re){
//					//System.out.println(":::::::::::::::::::::::::::::::::::: "+obj);
////					re.printStackTrace();
//				}catch(Exception re){
////					System.out.println(">>>>>>> source : "+source+ " : "+sKey);
////					re.printStackTrace();
//				}
//			}catch(Exception e){
//				e.printStackTrace();
//			}finally{
////				//System.out.println("::::: key="+sKey+"="+obj);
//			}
////
////			if(obj == null){
////				//System.out.println(">>>> Can not find value from key '" + sKey + "'.");
////			}else{
////				//System.out.println(">>>> get value from key '" + sKey + "'. value="+obj);
////			}
//			return obj;
//		}catch(Exception e){
//			e.printStackTrace();
//			throw new Exception("Get map value fail.");
//		}
//	}
	
//	private static Object getListValue(String sKey,Object source)throws Exception{
//		Object    obj     	 	= null;
//		try{
//			
//			if(sKey.endsWith("List")){
//
//				if(sKey.indexOf("List") == sKey.lastIndexOf("List")){
//					sKey = sKey.replaceFirst("List","s");
//				}else{
//					sKey = sKey.substring(0,sKey.lastIndexOf("List")) + "s";
//				}
//			}
//			
//			try{
//				
//				obj = PropertyUtils.getProperty(source, sKey);
//				
//			}catch(NoSuchMethodException e){
//			}catch(Exception e){
//			}finally{
//				//System.out.println(":::::List key="+sKey+"="+obj);
//			}
//
//			return obj;
//		}catch(Exception e){
//			e.printStackTrace();
//			throw new Exception("Get map value fail.");
//		}
//	}

	
	public static void copyProperties(Object destination, Object source){

		try{
			Class cSource 		= source.getClass();
			Class cDestination 	= destination.getClass();
			//Class [] classArray = {cDestination};
			Method[] methodsSrc = cSource.getMethods();
			Method[] methodDest  = cDestination.getMethods();
			int sizeDest  = methodDest.length;
			int size = methodsSrc.length;
			for(int i=0; i<size; i++){
				Method method = methodsSrc[i];
				String methodName = method.getName(); 
				
				if(methodName.length() > 3){
					if(methodName.startsWith("get") && !"getClass".equals(methodName)){
						 //System.out.println("methodName="+methodName);
						 
						for(int j=0;j<sizeDest;j++){
							
							Method method2 = methodDest[j];
							String methodNameDest = method2.getName(); 
							//System.out.println("methodName="+methodName+" methodNameDest="+methodNameDest);
							if(methodName.equals(methodNameDest)){
								Class cSrcType	= method.getReturnType();
								Class cDestType	= method2.getReturnType();									
								
								boolean isExceptType = (cDestType == long.class || cSrcType == long.class) 		||
													   (cDestType == Long.class || cSrcType == Long.class) 	||
													   (cDestType == double.class || cSrcType == double.class) 	||
													   (cDestType == Double.class || cSrcType == Double.class) 	||
													   ((cDestType == Date.class && cSrcType == String.class)||(cDestType == String.class && cSrcType == Date.class))||
													   ((cDestType == Timestamp.class && cSrcType == String.class)||(cDestType == String.class && cSrcType == Timestamp.class));
								
								if(method.getReturnType() == cDestType || isExceptType){
									
									String fieldName = methodName.substring(3);
									fieldName = fieldName.substring(0,1).toLowerCase() + fieldName.substring(1);
									
									Object[] obj 	= null;
									Object value	= method.invoke(source, obj);
									
									//for set Date
 									if(value != null){
										if(cDestType == Date.class && cSrcType == String.class){
											value = Converter.StringToDate(value);
										}else if(cDestType == String.class && cSrcType == Date.class){
											value = Converter.DateToString(value);
										}else if(cDestType == double.class && cSrcType == String.class){
											value = Converter.StringToDouble(value);
										}else if(cDestType == String.class && cSrcType == double.class){
											value = Converter.DoubleToString(value);
										}else if(cDestType == Date.class && cSrcType == Date.class){
											value = Converter.toUtilDate(value);
										}else if(cDestType == Long.class && cSrcType == String.class){
											value = Converter.StringToLong(value);
										}else if(cDestType == Timestamp.class && cSrcType == String.class){
											if(value!=null && !value.toString().equals("") && !value.toString().equals(" ")){
												 Pattern p = Pattern.compile("\\d{2}/\\d{2}/\\d{4} \\d{2}:\\d{2}:\\d{2}.\\d+");
												  Matcher m = p.matcher(value.toString()); 
												  boolean result = m.matches();
												  if(result)
												  value = Converter.StringToTimestamp(value);
												/*  System.out
														.println("chatchai debug time="+result);*/
											}
											
										}else if(cDestType == String.class && cSrcType == Timestamp.class){											 
											value = Converter.TimestampToString(value);
										} 
 									}
									
									if(value != null){
										//System.out.println("value is not null");
										BeanUtils.setProperty(destination, fieldName, value);
									}
							}
						}
					//	System.out.println("methodDest="+methodDest);
						
						}
					}
				}
			}
			//System.out.println(">>>>> "+BeanUtils.describe(destination));
		}catch(Exception e){
			e.printStackTrace();
		}
	
	}
	
	private static Object changeType(Object objSrc, Object destination, String dKey) throws Exception{
		if(objSrc instanceof Date){
			
			Class objDest = PropertyUtils.getPropertyType(destination, dKey);
//			//System.out.println("Value Dest : "+objDest.getName());
			if(objDest == Date.class){
				objSrc = ConvertDate.toUtilDate((Date)objSrc);
			}else{
				objSrc = Converter.DateToString((Date)objSrc);
			}
//		}else if(objSrc instanceof Long){
//			objSrc = Converter.LongToString(objSrc);
		}
		return objSrc;
	}
	
	private static Object getObjectValueByKey(String sKey, Object source, Object destination, String dKey){
		Object value = null;
		if(sKey == null || "".equals(sKey)){
			return null;
		}
		
		try{
			if(sKey.indexOf("DTO") > -1){
				sKey = sKey.replaceAll("DTO","");
			}
			
			if(sKey.indexOf(".") > -1){
				String[] arrKey = sKey.split("\\.");
				String strNewKey = getKeyHaveObject(arrKey[0], source);
				if(!"".equals(strNewKey)){
					int sizeKey = arrKey.length;
					boolean haveObj = false;
					for(int i=1;i<sizeKey;i++){
						strNewKey = strNewKey + "." + arrKey[i];
						
						strNewKey = getKeyHaveObject(strNewKey, source); 
						if(!"".equals(strNewKey)){
							haveObj = true;
						}else{
							haveObj = false;
							break;
						}
					}
					if(haveObj){
						value = PropertyUtils.getProperty(source, strNewKey);
						value = BeanUtility.changeType(value, destination, dKey);
					}
				}
			}else{
				String strNewKey = getKeyHaveObject(sKey, source); 
				if(!"".equals(strNewKey)){
					value = PropertyUtils.getProperty(source, strNewKey);
					value = BeanUtility.changeType(value, destination, dKey);
				}
			}
//			System.out.println(":::::::::::: value : "+value);
		}catch(Exception e){
			e.printStackTrace();
		}

		return value;
		
	}
	
	private static String getKeyHaveObject(String sKey, Object obj){
		String oKey = "";
		try{
			PropertyUtils.getProperty(obj, sKey);

		}catch(NoSuchMethodException e){
			try{
				sKey = sKey + "Full";
				PropertyUtils.getProperty(obj, sKey);

			}catch(NoSuchMethodException re){
				sKey = oKey;
			}catch(Exception re){
				sKey = oKey;
			}
		}catch(Exception e){
			sKey = oKey;
		}
		return sKey;
	}
}
