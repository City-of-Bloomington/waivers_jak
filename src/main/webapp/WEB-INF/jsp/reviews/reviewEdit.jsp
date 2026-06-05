<%@  include file="../gui/header.jsp" %>
<!--
     * @copyright Copyright (C) 2014-2015 City of Bloomington, Indiana. All rights reserved.
     * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
     * @author W. Sibo <sibow@bloomington.in.gov>
     *
-->
<h1>Review Annexation Waiver <s:property value="waiver_num" /></h1>
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

<s:form action="review" id="form_id" method="post">
    <s:hidden name="action2" id="action2" value="" />
    <s:hidden name="review.id" value="%{id}" />	
    <s:hidden name="waiver.id" value="%{waiver_id}" />
    <s:hidden name="review.waiver_id" value="%{waiver_id}" />	
    * Required field <br />
    ** For multiple parcel tax ID use comma or space to separate them <br />
    <s:if test="hasOwners()">
	*** Mark checkbox and click on 'Remove Owner' to remove the owner from this waiver <br />
    </s:if>
    <div id="hide_info" style="display:block">
	<button name="hide_info" id="hide_info_button">Show Instruction</button>
    </div>
    <div id="show_info" style="display:none">
	<ul id="show_info">
	    <li>If you make any change, please hit the 'Save Changes' button </li>
	    <li>To add a new owner to the waiver, you need to add the owner to the system first</li>
	    <li>To add an existing owner to this waiver start typing in the owner field to pick from the list</li>
	    <li>You can remove one or more of current owners (if any) from the waiver by marking the checkbox infront of their name</li>
	    <li>You can add attachment files by clicking on 'Attachment' </li>
	</ul>
	<button name="show_info" id="show_info_button">Hide Instruction</button>		
    </div>
    <s:if test="hasOwners()">
	<table width="60%" border="1">
	    <caption>Owner(s)</caption>
	    <s:iterator value="owners">
		<tr>
		    <td><input type="checkbox" name="del_owner" value="<s:property value='id' />" />*** </td>
		    <td><s:property value="full_name" /></td>
		    <td><a href="<s:property value='#application.url' />owner.action?id=<s:property value='id' />">Edit</a></td>
		</tr>
	    </s:iterator>
	</table>
    </s:if>
    To add an existing owner to this waiver, start typing the name to pick from the list. To add a new owner click on 'New Owner' <br />
    <table border="1" width="80%">
	<caption>Add Owner </caption>
	<tr>
	    <th>Owner Name</th><td>
		<s:textfield name="waiver.owner_name" value="%{owner_name}" size="25" maxlength="80" id="owner_name" /></td>
	</tr>
	<tr>
	    <th>Owner ID </th>
	    <td><s:textfield name="waiver.add_owner_id" value="%{add_owner_id}" size="10" maxlength="10" id="owner_id" /> or <button onclick="windowOpener('<s:property value='#application.url' />owner.action?type=popup','_blank', 'menubar=no,toolbar=no,location=no,toolbar=no,scrollbars=no,resizable=yes,top=500,left=500,width=500,height=500');return false;">New Owner</button>
	    </td>
	</tr>
    </table>
    <table border="1" width="80%">
	<caption>Waiver Info</caption>
	<tr>
	    <th>Instrument num </th>
	    <td><s:textfield name="waiver.instrument_num" value="%{instrument_num}" size="12" maxlength="70" /> (Deed book)</td>
	</tr>
	<tr>
	    <th>Legal description </th>
	    <td><s:textarea name="waiver.legal_description" value="%{legal_description}" rows="5" cols="50"  /> </td>
	</tr>
	<tr>
	    <th>Parcel tax ID **</th>
	    <td><s:textarea name="waiver.parcel_tax_id" value="%{parcel_tax_id}" rows="3" maxlength="25" /> </td>
	</tr>
	<tr>
		<th>Hookup address </th>
		<td><s:textarea name="waiver.hookup_address" value="%{hookup_address}" rows="3" cols="50" required="true" />* </td>
	</tr>
	<tr>
	    <th>Invalid Address? </th>
		<td><s:checkbox name="waiver.invalid_addr" value="%{invalid_addr}" /> </td> 
	</tr>
	<tr>
	    <th>Is Business? </th>
		<td><s:checkbox name="waiver.isBusiness" value="%{isBusiness}" /> </td> 
	</tr>
	<tr>
	    <th>Notes </th>
		<td><s:textarea name="waiver.notes" value="%{notes}" rows="5" cols="50"  /> </td>
	</tr>
	<tr>
	    <th>Signed Date </th>
		<td><s:textfield name="waiver.signed_date" value="%{signed_date}" size="10" maxlength="10" class="date" /> </td>
	</tr>
	<tr>
	    <th>Recorder ID </th>
		<td><s:textfield name="waiver.recorder_id" value="%{recorder_id}" size="20" maxlength="20" /> </td>
	</tr>
	<tr>
	    <th>Recorder Date </th>
		<td><s:textfield name="waiver.recorder_date" value="%{recorder_date}" size="10" maxlength="10" class="date" /> </td>
	</tr>
	
    </table>
    <table border="1" width="80%">
	<caption>Other Info</caption>
	<tr>
	    <th>Recorder Notes </th>
	    <td><s:textarea name="waiver.recorder_notes" value="%{recorder_notes}" rows="5" cols="50"  /> </td>
	</tr>
	<tr>
		<th>Paper Verified Date </th>
		<td><s:textfield name="waiver.paper_verified_date" value="%{paper_verified_date}" size="10" maxlength="10" class="date" /> </td>
	</tr>
	<tr>
	    <th>Controller Notes </th>
		<td><s:textarea name="waiver.controller_notes" value="%{controller_notes}" rows="5" cols="50"  /> </td>
	</tr>
	<tr>
	    <th>IN/OUT City </th>
		<td><s:radio name="waiver.in_out_city" value="%{in_out_city}" list="#{'IN':'IN','OUT':'OUT'}" /> 
		</td>
	</tr>
	<tr>
	    <th>IN GIS? </th>
		<td><s:checkbox name="waiver.in_gis" value="%{in_gis}" /> Yes 
		</td>
	</tr>
	<tr>
	    <th>Mapped Date </th>
		<td><s:textfield name="waiver.mapped_date" value="%{mapped_date}" size="10" maxlength="10" class="date" /> 
		</td>
	</tr>
	<tr>
	    <th>GIS Notes </th>
		<td><s:textarea name="waiver.gis_notes" value="%{gis_notes}" rows="5" cols="50"  /> </td>
	</tr>
	    <s:if test="waiver.imported" > 		
		<tr>
		    <th>Imported from Excel </th>
		    <td>Yes</td> 
		</tr>
	    </s:if>		
	    <s:if test="waiver.hasAdded_by()">
		<tr>
		    <th>Added by </th>
		    <td><s:property value="%{added_by_user}" /> 
		    </td>
		</tr>
	    </s:if>
	    <tr>
		<th>Added date </th>
		<td><s:property value="%{waiver.date}" /> 
		</td>
	</tr>
	<tr>
	    <th>Expire date </th>
		<td><s:textfield name="waiver.expire_date" value="%{expire_date}" size="10" maxlength="10" class="date" /> </td>
	</tr>
	<tr>
	    <th>Status </th>
		<td><s:radio name="waiver.status" value="%{status}" list="#{'Open':'Open','Closed':'Closed','Completed':'Completed'}" /></td>
	</tr>
	<tr>
	    <td colspan="2">
		You can add your review notes here (if any)<br />
	    </td>
	</tr>
	<tr>
	    <th>Review Notes </th>
	    <td><s:textarea name="review.notes" value="%{notes}" rows="5" cols="50"  /> </td>
	</tr>
	<tr>
	    <td colspan="2">	
		If no more review is needed click on the 'Verified' checkbox below<br />
	    </td>
	</tr>
	<tr>
	    <th>Verified? </th>
	    <td><s:checkbox name="review.verified" value="%{verified}" /> Yes 
	</td>
	</tr>
	<tr>
	    <th>Review Date </th>
	    <td><s:property value="review_date" />
	    </td>
	</tr>
	<tr>
	    <td><s:property value="reviewer" />
	    </td>
	</tr>
	<tr>
	    <td>
		<s:submit name="action" type="button" value="Save Changes" class="fn1-btn"/>
	    </td>
	    <s:if test="hasOwners()">
		<td>
		    <s:submit name="action" type="button" value="Remove Owner" class="fn1-btn"/>
		</td>
	    </s:if>
	</tr>
	<tr>
	    <td>
		<a href="<s:property value='#application.url'/>owner.action?waiver_id=<s:property value='waiver_id' />">Add/Edit Owners</a>
	    </td>
	    <td>
		<a href="<s:property value='#application.url' />doUpload.action?obj_id=<s:property value='waiver_id' />obj_type=Waiver">Attachments</a>
	    </td>
	</tr>
    </table>
    <s:if test="waiver.hasUploads()">
	<s:set var="attachmentsTitle" value="attachmentsTitle" />
	<s:set var="uploads" value="%{uploads}" />
	<%@  include file="../attachments/fileUploads.jsp" %>			
    </s:if>
</s:form>

<%@  include file="../gui/footer.jsp" %>

