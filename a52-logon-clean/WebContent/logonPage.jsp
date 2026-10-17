<%@ page import="com.sap.tc.logging.Location,java.util.regex.Pattern,java.util.regex.Matcher" %>
<%@ page session = "false"%>
<%@ taglib uri="/SapLogon" prefix="sap" %>

<jsp:useBean id="logonLocale" class="com.sap.engine.applications.security.logon.beans.ResourceBean" scope="request"/>

<%@ include file="/frame_enabled.txt" %>
<% String webpath = (String) request.getAttribute("logon.application.real.path"); %>

<%
//In case of NWBC we must deliver just the inner content without any frame around it.
//No margins to the left and top of the page is required as well.
//See sap_user_agent.txt about details for distinguishing nwbc
boolean isRTLMode = false;
boolean uiFrameVisible = true;
String uiFrameAllign = "center";
String uiFrameTopMargin = "margin-top:50px;";
%>
<%@ include file="/deviceType.jsp" %>
<%
boolean otherDevicesEnabled = DeviceGroup != null || DeviceType != null;
// If otherUiLoaded is false, the default login page will be loaded, otherwise a specific login page will be displayed.
boolean otherUiLoaded = false;
%>
<%@ include file="/sap_user_agent.txt" %>
<%
// Here we check which device is in use, and build a login page accordingly.
// If we can't distinguish which device type is in use, we load the default desktop login page.
if (otherDevicesEnabled) {
%> 
<%@ include file="/mobile/logonPageMobile.jsp" %>
<% } %>
<% if (!otherUiLoaded) {%>

<table id="tblFrmUI" width="790px" valign="middle" dir="ltr" align="<%=uiFrameAllign%>" cellPadding="0" cellSpacing="0" style="background-color:#ffffff;<%=uiFrameTopMargin%>">
  <% if(uiFrameVisible){ %>
	<tr class="uiRowAlign">
		<td><img src="<%=webpath%>layout/lf_tl.png" width="29" height="32"></td>
		<td><img src="<%=webpath%>layout/lf_st.png" width="734" height="32"></td>
		<td><img src="<%=webpath%>layout/lf_tr.png" width="27" height="32"></td>
	</tr>
	<% } %>
	<tr>
	  <% if(uiFrameVisible){ %>
		<td class="uiRowAlign">
			<img src="<%=webpath%>layout/lf_sl.png" width="29" height="360">
		</td>
		<% } %>
		<td width="100%">		
		<% if(isRTLMode){ %>
			<table id="tblInnerCnt" dir="rtl" cellpadding="0" cellspacing="0">
		<% } else {%>
      <table id="tblInnerCnt" dir="ltr" cellpadding="0" cellspacing="0">
    <% } %>
				<tr>					
					<td valign="top"><div class="urBrandImage"><span style="display:none" aria-hidden="true"><sap:brandimage type="main"/></span><img src="<%=webpath%>layout/a52-lukoil-branding.jpg" alt="LUKOIL" width="290" height="360"></div></td>
					<td width="100%"></td>
					<td>					
					 <table height="360px" cellPadding="0" cellSpacing="0">					
							<tr>								
								<td valign="top"><div class="urProductName"><span style="display:none" aria-hidden="true"><sap:brandimage type="second"/></span><img src="<%=webpath%>layout/a52-gsrm-title.gif" alt="G-SRM Supplier Relationship Management system" width="325" height="84"></div></td>
							</tr>							
							<tr>
								<td valign="top" align="left">							
										<div class="urLogonData">										
											<!-- data table starts after this line -->
											<sap:form type="logon">
											<% if(isRTLMode){ %>
									      <input type="hidden" name="sap_rtl" value="true">
									    <% } %>
											<table class="urLogonTable" cellSpacing="3px" cellPadding="0" valign="top">																									
												<tr><td colspan="3" height="60px">
													<div class="urMessageArea">
														<!--	Federation Error Message				-->
														<sap:if display="FederateUserWarning">														
															<!-- display error message if there is one -->
															<div class="urMsgBarStd" style="border=0;">
																<sap:errormsg styleClass="urTxtMsg" imageClass="urMsgBarImgWarning" imageHeight="12" imageWidth="12"/>
															</div>					
														</sap:if>														
														<sap:if display="errormsg">
															<!-- display error message if there is one -->
															<div class="urMsgBarErr">
																<sap:errormsg severity="errorMsgId" styleClass="urTxtMsg" imageClass="urMsgBarImgError" imageHeight="12" imageWidth="12"/>
															</div>
														</sap:if>
														<sap:if display="warnmsg">
															<!-- display warning message if there is one -->
															<div class="urMsgBarErr">
																<sap:errormsg severity="warningMsgId" styleClass="urTxtMsg" imageClass="urMsgBarImgWarning" imageHeight="12" imageWidth="12"/>
															</div>
														</sap:if>
														<sap:if display="infomsg">
															<!-- display info message if there is one -->
															<div class="urMsgBarErr">
																<sap:errormsg severity="infoMsgId" styleClass="urTxtMsg" imageClass="urMsgBarImgOk" imageHeight="12" imageWidth="12"/>
															</div>
														</sap:if>
													</div>
												</td></tr>												
												<sap:if display="selfreg">											
													<!-- display self-registration link if supposed to do so -->
													<tr><td colspan="3">
														<sap:link type="selfReg" linkClass="urLnk" textClass="urTxtStd" infoTextClass="urLblStdBar"/>														
													</td></tr>											
												</sap:if>				
												<!-- userid -->
												<tr><td>
													<sap:label type="username" styleClass="urLblStdNew" flagReqClass="urLblReq"/>
												</td>
												<td>
													<sap:input type="username" styleClass="urEdfTxtEnbl" style="width:170px"/>
												</td>
												<td width="100%">&nbsp;</td></tr>
												<!-- password -->
												<tr><td>
													<sap:label type="password" styleClass="urLblStdNew" flagReqClass="urLblReq"/>
												</td>
												<td>
													<sap:input type="password" styleClass="urEdfTxtEnbl" style="width:170px"/>
												</td>
												<td>&nbsp;</td></tr>
												<!-- create certificate -->
												<sap:if display="createcert">
													<tr><td>&nbsp;</td>
													<td>
														<sap:input type="createcert"/>
														<sap:label type="createcert" styleClass="urLblStdNew" flagReqClass="urLblReq"/>
													</td><td width="100%">&nbsp;</td>
													</tr>
												</sap:if>
												<!-- Federate User checkbox -->
												<sap:if display="FederateUserChkBox">
													<!-- display checkbox if a user account federation is required -->
													<tr><td>&nbsp;</td>
													<td>
														<sap:input type="FederateUserCheckbox"/>
														<sap:label type="FederateUserCheckbox" styleClass="urLblStdNew"/>
													</td><td width="100%">&nbsp;</td>
													</tr>
												</sap:if>
												<tr><td width="100%" colspan="3">&nbsp;</td></tr>
												<tr><td>&nbsp;																											
												</td><td align="right">	
													<!-- logon button -->
													<sap:button type="logon" styleClass="urBtnStdNew"/>
													<sap:if display="DisplayCancelButton">
														<!-- display cancel button incase of SP initiated SSO -->
														<sap:button type="cancelIdPLogon" styleClass="urBtnStdNew"/>																
													</sap:if>
												</td>
												<td>&nbsp;</td></tr>												
												<!-- link to certificate logon -->
												<sap:if display="CertLogonLink">
													<tr><td align="left" colspan="3">
														<sap:link type="certlogon" linkClass="urLnk" textClass="urTxtStd"/>														
													</td></tr>
												</sap:if>
												<!-- logon help -->
												<sap:if display="LogonHelpLink">
													<tr><td align="left" colspan="3">
														<sap:link type="logonhelp" linkClass="urLnk" textClass="urTxtStd" infoTextClass="urLblStdBar"/>														
													</td></tr>
												</sap:if>
											</table>
											</sap:form>
										<!-- data table ends before this line -->
										</div>																	
								</td>
							</tr>
							<!-- A53 supplier links: approved legacy URLs -->
							<tr><td align="left"><div class="urTxtStd">
								<div><a class="urLnk" href="https://procurementluoc.lukoil-international.com/regform">Self-registration (for new suppliers)/&#1057;&#1072;&#1084;&#1086;&#1088;&#1077;&#1075;&#1080;&#1089;&#1090;&#1088;&#1072;&#1094;&#1080;&#1103; (&#1076;&#1083;&#1103; &#1085;&#1086;&#1074;&#1099;&#1093; &#1087;&#1086;&#1089;&#1090;&#1072;&#1074;&#1097;&#1080;&#1082;&#1086;&#1074;)</a></div>
								<div><a class="urLnk" href="https://a62.lukoil-international.com/logoff/The_first_time_login.pdf">First time login (English)</a></div>
								<div><a class="urLnk" href="https://a62.lukoil-international.com/logoff/Instruction_for_suppliers_request.pdf">How to create response for request of commercial offers (English)</a></div>
								<div><a class="urLnk" href="https://a62.lukoil-international.com/logoff/The_first_time_login_ru.pdf">&#1055;&#1077;&#1088;&#1074;&#1099;&#1081; &#1074;&#1093;&#1086;&#1076; &#1074; &#1089;&#1080;&#1089;&#1090;&#1077;&#1084;&#1091; (&#1056;&#1091;&#1089;&#1089;&#1082;&#1080;&#1081;)</a></div>
								<div><a class="urLnk" href="https://a62.lukoil-international.com/logoff/Instruction_for_suppliers_request_ru.pdf">&#1055;&#1086;&#1076;&#1072;&#1095;&#1072; &#1087;&#1088;&#1077;&#1076;&#1083;&#1086;&#1078;&#1077;&#1085;&#1080;&#1081; &#1082; &#1079;&#1072;&#1087;&#1088;&#1086;&#1089;&#1091; &#1082;&#1086;&#1084;&#1084;&#1077;&#1088;&#1095;&#1077;&#1089;&#1082;&#1086;&#1075;&#1086; &#1087;&#1088;&#1077;&#1076;&#1083;&#1086;&#1078;&#1077;&#1085;&#1080;&#1103; (&#1056;&#1091;&#1089;&#1089;&#1082;&#1080;&#1081;)</a></div>
								<div><a class="urLnk" href="mailto:Vendors@lukoil-international.uz">&#1055;&#1088;&#1086;&#1073;&#1083;&#1077;&#1084;&#1099; &#1087;&#1088;&#1080; &#1074;&#1093;&#1086;&#1076;&#1077; &#1074; &#1089;&#1080;&#1089;&#1090;&#1077;&#1084;&#1091;/Logon Problems? Vendors@lukoil-international.uz</a></div>
							</div></td></tr>
							<tr>
								<td valign="bottom">									
									<div class="urCopyrightFrame">									 
										<div class="urCopyrightText"><%=logonLocale.get("COPY_RIGHT")%></div>					
										<div class="urCopyrightImage"><img src="<%=webpath%>layout/sap_logo.png" alt="<%=logonLocale.get("SAPAG")%>" title="<%=logonLocale.get("SAPAG")%>" width="55" height="27"></div>
									</div>				
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>			
		</td>		
		<% if(uiFrameVisible){ %>
		<td class="uiRowAlign">
			<img src="<%=webpath%>layout/lf_sr.png" width="27" height="360">
		</td>
		<% } %>
	</tr>
	<% if(uiFrameVisible){ %>
	<tr class="uiRowAlign">
		<td><img src="<%=webpath%>layout/lf_bl.png" width="29" height="32"></td>
		<td>
			<img src="<%=webpath%>layout/lf_sb.png" width="734" height="32"><span class="clip" style="position:absolute;left:50%;margin-left:-149px;"><img src="<%=webpath%>layout/lf_clip.png" width="298" height="32"></span>
		</td>
		<td><img src="<%=webpath%>layout/lf_br.png" width="27" height="32"></td>
	</tr>
	<% } %>
</table>
<% } %> 

<script type="text/javascript">
<!--		
  var docDir = document.dir;    
  if(docDir=="rtl" || docDir=="RTL"){   
     var elTableCnt = document.getElementById("tblInnerCnt");
     if(elTableCnt!=undefined){
       elTableCnt.style.direction="rtl";        
     }     
  }  
  var isFormSubmitted = false;
  if( document.forms ) {		
    document.forms[0].onsubmit=function(){
      if( isFormSubmitted ) {
        return false;
      } else {
        isFormSubmitted = true;
        return true;
      }
    }
  }      
-->
</script>
<%
if (otherDevicesEnabled) {
%> 
<%@ include file="/mobile/mobile_js.txt" %>
<% } %>