<%@  include file="../gui/header.jsp" %>
<!--
 * @copyright Copyright (C) 2014-2015 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
	-->
<h1>Waiver <s:property value="waiverNum" /></h1>
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
<s:if test="isOpen()">
    <b>Instructions</b>
    <ul>
	<li>To make changes click on 'Edit' button </li>		
	<li>To work on next task, click on 'Next' button </li>
	<li>You can add attachment files by clicking on 'Attachment' </li>
	<li>You may Close this waiver if it is not valid or no more progress can be made by clicking on 'Close This Waiver' button </li>
    </ul>
</s:if>
<table border="1" width="90%">
    <caption>Waiver Info </caption>
    <s:if test="isBusiness" >
	<tr>
	    <td>Is Business? </td>
	    <td>Yes</td>
	</tr>
    </s:if>
    <s:if test="isTrust" >
	<tr>
	    <td>Is Trust? </td>
	    <td>Yes</td>
	</tr>
    </s:if>	
    <s:if test="hasEntities()">
	<tr>
	    <s:if test="isBusiness" >			
		<td>Entity(ies)</td>
	    </s:if>
	    <s:else>
		<td>Owner(s)</td>				
	    </s:else>
	    <td><s:property value="entitiesInfo" /></td>
	</tr>
    </s:if>
    <tr>
	<td>Service address(es) </td>
	<td><s:property value="%{addressInfo}" /> <s:if test="invalidAddr" >(Invalid) </s:if> </td>
    </tr>	
    <tr>
	<td>Waiver Instrument # </td>
	<td><s:property value="%{waiverInstrumentNum}" /> </td>
    </tr><tr>
	<td>Deed Instrument # </td>
	<td><s:property value="%{deedInstrumentNum}" /> </td>
    </tr><tr>
	<td>Deed Book/Page </td>
	<td><s:property value="%{deedBookPage}" /></td>
    </tr><tr>
	<td>Parcel Pin </td>
	<td><s:property value="%{parcelPin}" /> </td>
    </tr><tr>
	<td>Parcel Tax ID </td>
	<td><s:property value="%{parcelTaxId}" /> </td>
    </tr><tr>
	<td>Waiver Instrument # </td>
	<td><s:property value="%{waiverInstrumentNum}" /> </td>
    </tr><tr>
	<td>Waiver Book/Page </td>
	<td><s:property value="%{waiverBookPage}" /></td>
    </tr><tr>
	<td>Sec, Township, range, dir </td>
	<td><s:property value="%{secTwpRangeDir}" /> </td>
    </tr><tr>
	<td>Legal description </td>
	<td><s:property value="%{legalDescription}"  /> </td>
    </tr><tr>
	<td>Development </td>
	<td><s:property value="%{developmentSubdivision}" /> </td>
    </tr><tr>
	<td>Lot </td>
	<td><s:property value="%{lot}"  /></td>
    </tr><tr>
	<td>Acreage </td>
	<td><s:property value="%{acreage}"  /></td>
    </tr><tr>
	<td>IN/OUT City? </td>
	<td><s:property value="%{inOutCity}" /></td>
    </tr>
    <s:if test="hasNotes()">
	<tr>
	    <td>Waiver Notes </td>
	    <td><s:property value="%{notes}"  /> </td>
	</tr>
    </s:if>
    <tr>	    
	<td>Request date </td>
	<td><s:property value="%{date}" /> 
	</td>
    </tr><tr>
	<td>Signed date </td>
	<td><s:property value="%{signedDate}"  /> </td>
    </tr>
    <s:if test="needExpireDate()">		
	<tr>
	    <td>Expire date </td>
	    <td><s:property value="%{expireDate}" /> 
	    </td>
	</tr>
    </s:if>
    <tr>
	<td>Recorded date </td>
	<td><s:property value="%{recorderDate}"  /> </td>
    </tr><tr>
	<td>Mapped date </td>
	<td><s:property value="%{mappedDate}"  /> </td>
    </tr>
    <s:if test="hasGisNotes()">
	<tr>
	    <td>GIS notes </td>
	    <td><s:property value="%{gisNotes}"  /> </td>
	</tr>
    </s:if>
    <tr>
	<td>Status </td>
	<td><s:property value="%{status}" /> </td>
    </tr>
    <s:if test="imported" > 		
	<tr>
	    <td>Imported </td>
	    <td>Yes</td> 
	</tr>
    </s:if>
    <s:if test="hasAddedBy()">
	<tr>
	    <td>Added by </td>
	    <td><s:property value="%{addedByUser}" /> </td>
	</tr>
    </s:if>
    <s:if test="isClosed()">
	<tr>
	    <td>Closed date </td>
	    <td><s:property value="%{closedDate}" /> </td>
	</tr>
	<tr>
	    <td>Closed by </td> 
	    <td><s:property value="%{closedByUser}" /></td>  
	</tr>
    </s:if>
    <tr>
	<td colspan="2">
	    <a href="<s:property value='#application.url'/>waiver.action?id=<s:property value='id' />&action=Edit">Edit</a>
	</td>
    </tr>
</table>
<ul>    
    <s:if test="isOpen()">
	<s:if test="canBePrinted()">
	    <li>
		    <a href="<s:property value='#application.url'/>WaiverRtf?id=<s:property value='%{id}' />">Printable Waiver </a>
	    </li>
	</s:if>
	<s:if test="hasMoreTasks()">
	    <s:iterator var="one" value="tasks">
		<s:if test="canBeClaimedBy(#session.user)">
		<li>
			<a href="<s:property value='#application.url'/>task.action?task_id=<s:property value='task_id' />&action=Edit">Next: <s:property value='alias' /> (<s:property value="group" />)</a>
		</li>
		</s:if>
		<s:else>
		    <li>
			    <a href="<s:property value='#application.url'/>task.action?task_id=<s:property value='task_id' />&action=Edit" id="a_disabled"  disabled="disabled">Next: <s:property value='alias' /> (<s:property value="group" /> disabled)</a>
		    </li>
		</s:else>
	    </s:iterator>
	</s:if>
	<li>
		<a href="<s:property value='#application.url' />doUpload.action?waiver_id=<s:property value='id' />">Attachments</a> <br />
	</li>
	<li>
	    Note: If you close this waiver no more changes can be made
	    <a href="<s:property value='#application.url'/>waiver.action?id=<s:property value='id' />&action=Close">Close This Waiver</a>
	</li>
    </s:if>
</ul>
<s:if test="hasCompletedTasks()" >
    <s:set var="tasksTitle" value="'Completed Actions'" />
    <s:set var="tasks" value="%{completedTasks}" />
    <%@  include file="../tasks/tasks.jsp" %>			
</s:if>
<s:if test="hasUploads()">
    <s:set var="attachmentsTitle" value="'Attachments'" />
    <s:set var="uploads" value="%{uploads}" />
    <%@  include file="../attachments/fileUploads.jsp" %>			
</s:if>
<s:if test="hasEmailLogs()">
    <s:set var="logsTitle" value="'Notification Logs'" />
    <s:set var="emailLogs" value="%{emailLogs}" />
    <%@  include file="../logs/emailLogsShort.jsp" %>	
</s:if>
<%@  include file="../gui/footer.jsp" %>

