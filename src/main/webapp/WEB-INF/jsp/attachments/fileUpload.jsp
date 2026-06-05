<%@  include file="../gui/header.jsp" %>
<!--
 * @copyright Copyright (C) 2014-2015 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
	-->
<h1>Upload New File</h1>
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
<s:form action="doUpload" method="post" onsubmit="return checkTypeSelection();" enctype="multipart/form-data">
    <s:hidden name="waiver_id" value="%{waiver_id}" />
    <s:if test="hasTask()">
	<s:hidden name="task_id" value="%{task_id}" />
    </s:if>

    <p>* indicate a required field</p>
    <table>
	<caption>Upload File</caption>
	<tr>
	    <td>Waiver #:</td>
	    <td>
		<a href="<s:property value='#application.url' />waiver.action?id=<s:property value='waiver_id' />"><s:property value="waiverNum" /></a>
	    </td>
	</tr>
	<s:if test="hasTask()">
	    <tr>
		<td>Task:</td>
		<td>
		    <a href="<s:property value='#application.url' />task.action?task_id=<s:property value='task_id' />"><s:property value="task_name" /></a>
		</td>
	    </tr>
	</s:if>
	<tr>
	    <td>File:</td>
	    <td><input type="file" name="upload" value="Pick File" />*</td>
	</tr>
	<tr>
	    <td>Document Type:</td>
	    <td><s:select name="type" value="%{type}" list="#{'Application':'Application','Deed':'Deed','Recorded Waiver':'Recorded Waiver','Map':'Map','Other':'Other'}"  headerKey="-1" headerValue="Pick Document Type" id="attach_type_id" /></td>
	</tr>		
	<tr>
	    <td>Notes:</td>
	    <td><s:textarea name="notes" value="%{notes}" row="5" cols="50" /></td>
	</tr>		
	<tr>
	    <td>
		<s:submit name="action" type="button" value="Save" /></td>
	</tr>			
    </table>
</s:form>
<s:if test="uploads != null">
  <s:set var="uploads" value="uploads" />
	<s:set var="attachmentsTitle" value="'Most Recent Attachments'" />
  <%@  include file="fileUploads.jsp" %>	
</s:if>
<%@  include file="../gui/footer.jsp" %>	






































