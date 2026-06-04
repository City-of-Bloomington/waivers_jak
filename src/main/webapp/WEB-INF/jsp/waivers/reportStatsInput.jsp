<%@  include file="../gui/header.jsp" %>
<!-- 
 * @copyright Copyright (C) 2014-2015 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
	-->
<s:form action="statsReport" method="post">    
  <h1> Stats Reports </h1>
  <s:if test="hasActionErrors()">
      <div class="errors">
	  <s:actionerror/>
      </div>
  </s:if>
  <s:if test="hasActionMessages()">
      <div class="welcome">
	  <s:actionmessage/>
      </div>
  </s:if>
  
  <table border="1" width="90%">
      <caption>Report Options</caption>
      <tr>
	  <td align="left" valign="top" colspan="2"><label>Report type:</label></td>
      </tr>
      <tr>
	  <td align="left"><s:checkbox name="report.signed" value="%{signed}"  />Signed Waivers</td>
	  <td align="left"> Before and after <s:textfield name="report.signed_date" value="%{signed_date}" required="required" /> date (mm/dd/yyyy)</td>
      </tr>
      <tr>
	  <td colspan="2" valign="top" align="right">
	      <s:submit name="action" type="button" value="Submit" />
	  </td>
      </tr>
  </table>
</s:form>  
<%@  include file="../gui/footer.jsp" %>	






































