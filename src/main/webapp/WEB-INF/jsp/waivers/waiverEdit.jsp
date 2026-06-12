<%@  include file="../gui/header.jsp" %>
<!--
 * @copyright Copyright (C) 2014-2015 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
-->
<h1>Edit Waiver <s:property value="waiverNum" /></h1>
    <s:if test="hasActionErrors()">
	<div>
	    <s:actionerror/>
	</div>
    </s:if>
    <s:elseif test="hasActionMessages()">
	<div>
	    <s:actionmessage/>
	</div>
    </s:elseif>
    <s:form action="waiver" id="form_id" method="post">
	<s:set var="waiver_id" value="%{id}" scope="application" />
	
	<s:hidden name="action2" id="action2" value="" />
	<s:hidden name="waiver.id" value="%{id}" />
	<s:hidden name="id" value="%{id}" />	
	<s:hidden name="waiver.date" value="%{date}" />
	<s:hidden name="waiver.status" value="%{status}" />
	<s:hidden name="waiver.addedBy" value="%{addedBy}" />
	<s:hidden name="waiver.addAddrIds" id="add_addr_ids" value="" />
	<s:hidden name="waiver.addEntityIds" id="entity_ids" value="" />	
	<h3>Instructions</h3>
	<ul>
	    <li>* Required field </li>
	    <li>For single parcel tax ID (xx-xx-xx-xxx-xxx.xxx-xxx format) </li>
	    <li>For multiple parcel tax ID add one at a time in this box, it will be automatically appended to the box below. Multiple tax id's should be space separated.</li>
	    <li>Entity name is either a person, business or trust</li>
	    <li>You can add a new entity to the waiver by clicking on 'New Entity'</li>
	    <li>Or you can add an existing entity to the waiver by using 'Search Entiy' field by start typing the entity name and then select from the list</li>			
	    <li>You can remove one or more of current entities (if any) from the waiver by clicking on remove button next to their name</li>
	    <li>You can edit entity name and type by clicking on 'Edit' next to their name</li>
	    <li>You can add a new address to the waiver by clicking on 'New Address'</li>
	    <li>You can edit an address by clicking on 'Edit' button next to the address</li>
	    <li>You may delete and address by clicking on 'Remove' button next to the address</li>
	    
	    <li>You can add attachment files by clicking on 'Attachment' </li>
	    <li>You may Close this waiver if it is not valid or no more progress can be made by clicking on 'Close This Waiver' button </li>
	    <li>To work on next task, click on 'Next' button </li>			
	    <li>After you are done with data entry, hit the 'Save Changes' button</li>			
	</ul>
	<h3>Entities</h3>
	<s:if test="hasEntities()">
	    <table width="80%" border="1">
		<caption>Entity(ies)</caption>
		<s:iterator value="entities">
		    <tr>
			<td><s:property value="info" /></td>
			<td><a href="<s:property value='#application.url' />entity.action?id=<s:property value='id' />&waiver_id=<s:property value='waiver_id' />">Edit</a>
			</td>
			<td><a href="<s:property value='#application.url'/>waiver.action?action=Remove+Entity&entityId=<s:property value='id' />&id=<s:property value='waiver_id' />">Remove</a></td>
		    </tr>
		</s:iterator>
	    </table>
	</s:if>
	<p>Note: To add a new entity click on 'New Entity' or to add an existing entity use 'Search Entity' </p>
	<b>Add Entity</b><br />
	<li><button onclick="windowOpener('<s:property value='#application.url' />entity.action?type=popup&waiver_id=<s:property value='waiver.id' />','_blank', 'menubar=no,toolbar=no,location=no,toolbar=no,scrollbars=no,resizable=yes,top=500,left=500,width=500,height=500');return false;">New Entity</button>	</li>
	<b>To search for an existing entity, start typing the name to pick from the list.</b><br />
	<b>Search Entity</b>						
	<li><s:textfield name="waiver.entityName" value="" size="25" maxlength="80" id="entity_name" /> Entity ID:<s:textfield name="waiver.addEntityId" value="" size="10" maxlength="10" id="entity_id" /> 
	</li>

	<h3>Service Address(es)</h3>			
	<s:if test="hasAddresses()">
	    <table width="80%" border="1">
		<caption>Current Address(es)</caption>
		<s:iterator value="addresses">
		    <tr>
			<td><s:property value="addressInfo" /></td>
			<td><a href="<s:property value='#application.url' />address.action?id=<s:property value='id' />&action=Edit">Edit</a></td>
			<td><a href="<s:property value='#application.url'/>waiver.action?addressId=<s:property value='id' />&id=<s:property value='waiver.id' />&action=Remove+Address">Remove</a></td>
		    </tr>
		</s:iterator>
	    </table>
	</s:if>
	<b> <button onclick="windowOpener('<s:property value='#application.url' />address.action?type=popup&waiver_id=<s:property value='id' />','_blank', 'menubar=no,toolbar=no,location=no,toolbar=no,scrollbars=no,resizable=yes,top=500,left=500,width=500,height=500');return false;">Add New Address</button></b><br />
	<table border="1" width="80%">
	    <caption>Waiver Info</caption>
	    <tr>
		<td>Waiver Num </td>
		<td><s:textfield name="waiver.waiverNum" value="%{waiverNum}" size="10" maxlength="15"  /> </td>
	    </tr>
	    <tr>
		<td>Waiver Instrument # </td>
		<td><s:textfield name="waiver.waiverInstrumentNum" value="%{waiverInstrumentNum}" size="20" maxlength="70" /></td>
	    </tr>			
	    <tr>
		<td>Deed Instrument # </td>
		<td><s:textfield name="waiver.deedInstrumentNum" value="%{deedInstrumentNum}" size="20" maxlength="70" /> </td>
	    </tr>
	    <tr>
		<td>Deed Book </td>
		<td><s:textfield name="waiver.deedBook" value="%{deedBook}" size="10" maxlength="30" />Deed Page <s:textfield name="waiver.deedPage" value="%{deedPage}" size="10" maxlength="30" /> </td>
	    </tr>
	    <tr>
		<td>Waiver Book </td>
		<td><s:textfield name="waiver.waiverBook" value="%{waiverBook}" size="10" maxlength="30" />Waiver Page <s:textfield name="waiver.waiverPage" value="%{waiverPage}" size="10" maxlength="30" /> </td>
	    </tr>			
	    <tr>
		<td>Parcel PIN</td>
		<td>
		    <input type="text" name="waiver.parcelPin2" value="" size="2" maxlength="2" id="pin_id_1" placeHolder="xx" class="tax_number" />-
		    <input type="text" name="waiver.parcelPin2" value="" size="2" maxlength="2" id="pin_id_2" placeHolder="xx" class="tax_number" />-
		    <input type="text" name="waiver.parcelPin2" value="" size="2" maxlength="2" id="pin_id_3" placeHolder="xx" class="tax_number" />-
		    <input type="text" name="waiver.parcelPin2" value="" size="3" maxlength="3" id="pin_id_4" placeHolder="xxx" class="tax_number" />-
		    <input type="text" name="waiver.parcelPin2" value="" size="3" maxlength="3" id="pin_id_5" placeHolder="xxx" class="tax_number" />.
		    <input type="text" name="waiver.parcelPin2" value="" size="3" maxlength="3" id="pin_id_6" placeHolder="xxx" class="tax_number" />-
		    <input type="text" name="waiver.parcelPin2" value="" size="3" maxlength="3" id="pin_id_7" placeHolder="xxx" class="tax_number" />
		</td>
	    </tr>
	    <tr>
		<td>Parcel PIN </td>
		<td><s:textarea name="waiver.parcelPin" value="%{parcelPin}" rows="3" cols="25" id="pin_id_multiple" title="For parcel state pin use space to separate" /> </td>
	    </tr>			
	    <tr>
		<td>Parcel tax ID </td>
		<td>
		    <input type="text" name="waiver.parcelTaxId2" value="" size="3" maxlength="3" id="tax_id_1" placeHolder="xxx"/> -
		    <input type="text" name="waiver.parcelTaxId2" value="" size="5" maxlength="5" id="tax_id_2"  placeHolder="xxxxx" /> -
		    <input type="text" name="waiver.parcelTaxId2" value="" size="2" maxlength="2" id="tax_id_3"  placeHolder="xx"/> (enter one at a time)
		</td>
	    </tr>		
	    <tr>
		<td>Parcel tax ID </td>
		<td><s:textarea name="waiver.parcelTaxId" value="%{parcelTaxId}" rows="3" id="tax_id_multiple" title="For multiple tax ids use space to separate"/> </td>
	    </tr>
	    <tr>
		<td>Legal description </td>
		<td><s:textarea name="waiver.legalDescription" value="%{legalDescription}" rows="5" cols="50"  required="required" /> </td>
	    </tr>
	    <tr>
		<td>Township Section Range </td>
		<td><s:textfield name="waiver.secTwpRangeDir" size="30" maxlength="50" value="%{secTwpRangeDir}" /> </td>
	    </tr>
	    <tr>
		<td>Lot </td>
		<td><s:textfield name="waiver.lot" size="30" maxlength="50" value="%{lot}" /> </td>
	    </tr>
	    <tr>			
		<td>Acreage</td>
		<td> <s:textfield name="waiver.acreage" size="20" maxlength="10" value="%{acreage}" />	</td>
	    </tr>			
	    <tr>
		<td>Develop/Subdiv </td>
		<td><s:textfield name="waiver.developmentSubdivision" size="30" maxlength="10" value="%{developmentSubdivision}" /> </td>
	    </tr>
	    <tr>
		<td>In/Out City</td>
		<td><s:radio name="waiver.inOutCity" value="%{inOutCity}" list="#{'IN':'IN','OUT':'OUT'}" /> 
		</td>
	    </tr>
	    <tr>
		<td>Waiver Notes </td>
		<td><s:textarea name="waiver.notes" value="%{notes}" rows="5" cols="50"  /> </td>
	    </tr>
	    <tr>
		<td>GIS Notes </td>
		<td><s:textarea name="waiver.gisNotes" value="%{gisNotes}" rows="5" cols="50"  /> </td>
	    </tr>
	    <tr>
		<td>Signed Date </td>
		<td><s:textfield name="waiver.signedDate" value="%{signedDate}" size="10"  class="date" maxlength="10" /> </td>
	    </tr>
	    <tr>
		<td>Recorded Date </td>
		<td><s:textfield name="waiver.recorderDate" value="%{recorderDate}" size="10"  class="date" maxlength="10" /> </td>
	    </tr>
	    <tr>
		<td>Mapped Date </td>
		<td><s:textfield name="waiver.mappedDate" value="%{mappedDate}" size="10"  class="date" maxlength="10" /> </td>
	    </tr>
	    <s:if test="needExpireDate()">			
		<tr>
		    <td>Expire Date </td>
		    <td><s:textfield name="waiver.expireDate" value="%{expireDate}" size="10"  class="date" maxlength="10" /> </td>
		</tr>
	    </s:if>				
	    <s:if test="imported" > 		
		<tr>
		    <td></td>
		    <td>Imported from Spreadsheet </td>
		</tr>
	    </s:if>		
	    <s:if test="hasAdded_by()">
		<tr>
		    <td>Added by </td>
		    <td><s:property value="%{addedByUser}" /> 
		    </td>
		</tr>
	    </s:if>
	    <tr>
		<td>Added date </td>
		<td><s:property value="%{date}" /> 
		</td>
	    </tr>
	    <tr>
		<td>Status </td>  
		<td><s:property value="%{status}" /> 
		</td>  
	    </tr> 
	    <tr>
		<td colspan="2">
		    <s:submit name="action" type="button" value="Save Changes"/>
		</td>
	    </tr>
	    <s:if test="canBePrinted()">
		<tr>
		    <td>
			<a href="<s:property value='#application.url'/>WaiverRtf?id=<s:property value='%{waiver.id}' />">Printable Waiver </a>
		    </td>
		</tr>
	    </s:if>
	</table>
	<ul>	
	    <s:if test="status == 'Open'">
		<s:if test="hasMoreTasks()">
		    <s:iterator var="one" value="tasks">
			<li>
			    <s:if test="canBeClaimedBy(#session.user)"> 
				<a href="<s:property value='#application.url'/>task.action?task_id=<s:property value='task_id' />">Next: <s:property value="alias" /> (<s:property value="group" />)</a>
			    </s:if>
			    <s:else>
				<a href="<s:property value='#application.url'/>task.action?task_id=<s:property value='task_id' />&action=Edit" id="a_disabled"  disabled="disabled">Next: <s:property value='alias' /> (<s:property value="group" /> disabled)</a>
			    </s:else>
			</li>
		    </s:iterator>
		</s:if>
		<li><a href="<s:property value='#application.url'/>waiver.action?id=<s:property value='id' />&action=Close" title="If you close this waiver no more changes can be done to it">Close This Waiver</a></li>
	    </s:if>
	    <li>
		<a href="<s:property value='#application.url' />doUpload.action?waiver_id=<s:property value='id' />">Attachments</a>
	    </li>
	</ul>
    </s:form>
    <s:if test="hasCompletedTasks()" >
	<s:set var="tasksTitle" value="'Completed Tasks'" />
	<s:set var="tasks" value="%{completedTasks}" />
	<%@  include file="../tasks/tasks.jsp" %>			
    </s:if>
    <s:if test="hasUploads()">
	<s:set var="attachmentsTitle" value="'Attachments'" />
	<s:set var="uploads" value="%{uploads}" />
	<%@  include file="../attachments/fileUploads.jsp" %>
    </s:if>
    <s:if test="hasEmailLogs()">
	<s:set var="logsTitle" value="'Email Logs'" />
	<s:set var="emailLogs" value="%{emailLogs}" />
	<%@  include file="../logs/emailLogs.jsp" %>	
    </s:if>
    <%@  include file="../gui/footer.jsp" %>
