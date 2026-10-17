<%@ page import="com.sap.tc.logging.Location" %>
<%@ page import="java.util.regex.Pattern,java.util.regex.Matcher" %>
<%

String DeviceGroup = (String)request.getAttribute("DeviceGroup");
String DeviceType = (String)request.getAttribute("DeviceType");
Location loc = Location.getLocation("com.sap.engine.services.security.authentication");

if (DeviceType == null) {
	loc.debugT("\"DeviceType\" is null, trying to evaluate regular expressions.");
	
	String userAgent = request.getHeader("User-Agent");
	loc.debugT("User-Agent header is \"{0}\".", new Object[] {userAgent});
	
	if (userAgent != null) {
		userAgent = userAgent.toLowerCase();
		
		final String REGEX_SMART_PHONE = "(.*)mobile(.*)";
		final String REGEX_TABLET = "(.*)android(.*)|(.*)ipad(.*)|(.*)ipod(.*)";
		
		Pattern pattern = Pattern.compile(REGEX_SMART_PHONE, Pattern.CASE_INSENSITIVE);
		Matcher matcher = pattern.matcher(userAgent);
		if (userAgent.matches(REGEX_SMART_PHONE)) {
			DeviceType = "DeviceType.Smartphone";
			loc.debugT("Regular expression for smart phone matched successfully. Expression is \"{0}\".", new Object[] {REGEX_SMART_PHONE} );
		} else if (userAgent.matches(REGEX_TABLET)) {
			DeviceType = "DeviceType.Tablet";
			loc.debugT("Regular expression for tablet matched successfully. Expression is \"{0}\".", new Object[] {REGEX_TABLET});
		} else {
			loc.debugT("No regular expression matched successfully. Server tried \"{0}\" and \"{1}\".", new Object[] {REGEX_SMART_PHONE, REGEX_TABLET});
		}
	} else {
		loc.debugT("User-Agent header is not present in the current request. Mobile logon page will not be available.");
	}
	
}

%>