package th.co.vlink.utils.properties;

import java.io.File;
import java.io.FileInputStream;
import java.util.Enumeration;
import java.util.Properties;
import java.util.ResourceBundle;

public class GlobalProperties {

	private static Properties props = null;
	private static ResourceBundle bundle;
	
	private static String filename = "MessageResources";

//	public static void init() {
//		System.out.println("initial global properties.");
//		props = new Properties();
//		try {
//			ClassLoader classLoader = ClassLoader.getSystemClassLoader();
//			InputStream input = (InputStream) classLoader
//					.getResourceAsStream(filename);
//			props.load(input);
//			input.close();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
	
	public static void init() {
		if(props == null){
			//System.out.println("initial global properties.");
			
			if ( bundle == null ) bundle = ResourceBundle.getBundle( filename );
			
			props = new Properties();
	        for (Enumeration keys = bundle.getKeys (); keys.hasMoreElements ();)
	        {
	            final String key = (String) keys.nextElement ();
	            final String value = bundle.getString (key);
	            
	            props.put (key, value);
	        } 
		}
	}

	public static String getProperty(String key) {
		return props.getProperty(key);
	}

	public static int getIntProperty(String key) {
		return Integer.parseInt(props.getProperty(key));
	}

	public static boolean getBooleanProperty(String key) {
		return Boolean.valueOf(props.getProperty(key)).booleanValue();
	}

	public static String getProperty(String key, String defaultValue) {
		String value = props.getProperty(key);
		if (value == null) {
			return defaultValue;
		}
		return value;
	}

	public static Properties getProperties(String propertyFileName) {
		return loadProp(new File(propertyFileName));
	}

	private static Properties loadProp(File propFile) {
		try {
			FileInputStream input = new FileInputStream(propFile);
			Properties prop = new Properties();
			prop.load(input);
			input.close();
			return prop;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}
