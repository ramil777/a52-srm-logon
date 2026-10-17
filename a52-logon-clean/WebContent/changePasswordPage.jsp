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
<%@ include file="/mobile/changePasswordPageMobile.jsp" %>
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
					<td valign="top"><div class="urBrandImage"><sap:brandimage type="main"/></div></td>
					<td width="100%"></td>
					<td>					
						<table height="360px" cellPadding="0" cellSpacing="0">
							<tr>								
								<td valign="top"><div class="urProductName"><sap:brandimage type="second"/></div></td>
							</tr>							
							<tr>
								<td valign="top" align="left">							
										<div class="urLogonData">										
											<!-- data table starts after this line -->
											<sap:form type="changepassword">
											<% if(isRTLMode){ %>
                        <input type="hidden" name="sap_rtl" value="true">
                      <% } %>
											<table class="urLogonTable" cellSpacing="3px" cellPadding="0" valign="top">																									
												<tr><td colspan="3" height="60px">
													<div class="urMessageArea">																					
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
												<!-- header line -->
												<tr><td align="left" colspan="3">
													<div class="urTxtH3"><%=logonLocale.get("CHANGE_PASSWORD")%></div>
												</td></tr>
												<!-- old password -->
												<tr><td>
													<sap:label type="oldPassword" styleClass="urLblStdNew" flagReqClass="urLblReq"/>
												</td>
												<td>
													<sap:input type="oldPassword" styleClass="urEdfTxtEnbl" style="width:170px"/>
												</td>
												<td width="100%">&nbsp;</td></tr>
												<!-- new password -->
												<tr><td>
													<sap:label type="newPassword" styleClass="urLblStdNew" flagReqClass="urLblReq"/>
												</td>
												<td>
													<sap:input type="newPassword" styleClass="urEdfTxtEnbl" style="width:170px"/>
												</td>
												<td>&nbsp;</td></tr>
												<!-- retype new password -->
												<tr><td>
													<sap:label type="confirmPassword" styleClass="urLblStdNew" flagReqClass="urLblReq"/>
												</td>
												<td>
													<sap:input type="confirmPassword" styleClass="urEdfTxtEnbl" style="width:170px"/>
												</td>
												<td>&nbsp;</td></tr>
												<!-- submit buttons -->
												<tr><td>&nbsp;</td><td align="right">
													<sap:button type="changePassword" styleClass="urBtnStdNew"/>
													<sap:button type="cancelChangePassword" styleClass="urBtnStdNew"/>
												</td>
												<td>&nbsp;</td></tr>												
											</table>
											</sap:form>
											<!-- data table ends before this line -->
										</div>																	
								</td>
							</tr>
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

