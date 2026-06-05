<%@  include file="../gui/header.jsp" %>
<!--
 * @copyright Copyright (C) 2014-2015 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
-->
<h1>Search Attachments</h1>
<s:form action="attachSearch" method="post">
  <s:if test="hasActionErrors()">
      <div class="errors">
	  <s:actionerror/>
      </div>
  </s:if>
  <s:elseif test="hasActionMessages()">
      <div class="welcome">
	  <s:actionmessage/>
      </div>
  </s:elseif>
  <p>To add a new attachment, go to waiver or task and click on the 'Attachments' button.
  </p>
  <table>
      <caption>Search Options</caption>
	  <tr>
	      <td>Attachment ID </td>
	      <td><s:textfield name="uploadList.id" value="%{id}" size="10" maxlength="10" /> 
	      </td>
	  </tr>
	  <tr>
	      <td>Waiver ID</td>
	      <td><s:textfield name="uploadList.waiver_id" value="%{waiver_id}" size="10" maxlength="10" /> 
	      </td>
	  </tr>
	  <tr>
	      <td>Date Range </td>
	      <td>from: <s:textfield name="uploadList.date_from" value="%{date_from}" size="10" maxlength="10" cssClass="date" /> to:
		  <s:textfield name="uploadList.date_to" value="%{date_to}" size="10" maxlength="10" cssClass="date" />					
	      </td>
	  </tr>
	  <tr>
	      <td>
		  <s:submit name="action" type="button" value="Submit"/>
	      </td>
	  </tr>
  </table>
</s:form>
<s:if test="uploads != null">
  <s:set var="uploads" value="uploads" />
	<s:set var="uploadsTitle" value="uploadsTitle" />
  <%@  include file="fileUploads.jsp" %>	
</s:if>
<%@  include file="../gui/footer.jsp" %>

