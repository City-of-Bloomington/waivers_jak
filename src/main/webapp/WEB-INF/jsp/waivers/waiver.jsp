<%@  include file="../gui/header.jsp" %>
<!--
 * @copyright Copyright (C) 2014-2015 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
-->
<h1>New Waiver</h1>
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
<s:form action="waiver" id="form_id" method="post" tooltipDelay="500">
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
	<li>You can add a new address to the waiver by clicking on 'New Address'</li>			
	<li>After you are done with data entry, hit the 'Save' button</li>
    </ul>
    <b> Note: To add a new entity click on 'New Entity' or to add an existing entity use 'Search Entity'</b><br /> 
    <li><button onclick="windowOpener('<s:property value='#application.url' />entity.action?type=popup','_blank', 'menubar=no,toolbar=no,location=no,toolbar=no,scrollbars=no,resizable=yes,top=500,left=500,width=500,height=500');return false;">Add New Entity</button></li>
    <b> Note: To add an existing entity to this waiver, start typing the name to pick from the list </b><br />
    <li> Entity Name:<s:textfield name="waiver.entityName" value="%{waiver.entityName}" size="20" maxlength="80" id="entity_name" /> Entity ID: <s:textfield name="waiver.addEntityId" value="%{addEntityId}" size="10" maxlength="10" id="entity_id" /><div id="entity_names">&nbsp;</div></li>
    <li>Service address: <button onclick="windowOpener('<s:property value='#application.url' />address.action?type=popup','_blank', 'menubar=no,toolbar=no,location=no,toolbar=no,scrollbars=no,resizable=yes,top=500,left=500,width=500,height=500');return false;">New Address</button><span id="addr_bulk_id">&nbsp;</span></li>
    <table border="1" width="80%">
	<caption>Waiver Info</caption>
	<tr>
	    <dt>Waiver # </dt>
	    <td><s:textfield name="waiver.waiverNum" value="%{waiverNum}" size="10" maxlength="15"  required="required" /> </td>
	</tr>
	<tr>
	    <dt>Waiver Instrument # </dt>
	    <td><s:textfield name="waiver.waiverInstrumentNum" value="%{instrumentNum}" size="10" maxlength="15" /></td>
	</tr>						
	<tr>
	    <dt>Deed Instrument # </dt>
	    <td><s:textfield name="waiver.deedInstrumentNum" value="%{deedInstrumentNum}" size="10" maxlength="70" title="Enter instrument number, deed book number" /> </td>
	</tr>
	<tr>
	    <td>Deed Book </td>
	    <td><s:textfield name="waiver.deedBook" size="5" maxlength="10" value="%{deedBook}" />Page:<s:textfield name="waiver.deedPage" size="5" maxlength="10" value="%{deedPage}" /> </td>
	</tr>
	<tr>
	    <td>Parcel PIN</td>
	    <td><input type="text" name="waiver.parcelPin2" value="" size="2" maxlength="2" id="pin_id_1" placeHolder="xx" class="pin_number"/>-
		<input type="text" name="waiver.parcelPin2" value="" size="2" maxlength="2" id="pin_id_2" placeHolder="xx" class="pin_number"/>-
		<input type="text" name="waiver.parcelPin2" value="" size="2" maxlength="2" id="pin_id_3" placeHolder="xx" class="pin_number"/>-
		<input type="text" name="waiver.parcelPin2" value="" size="3" maxlength="3" id="pin_id_4" placeHolder="xxx" class="pin_number"/>-
		<input type="text" name="waiver.parcelPin2" value="" size="3" maxlength="3" id="pin_id_5" placeHolder="xxx" class="pin_number"/>.
		<input type="text" name="waiver.parcelPin2" value="" size="3" maxlength="3" id="pin_id_6" placeHolder="xxx" class="pin_number"/>-
		<input type="text" name="waiver.parcelPin2" value="" size="3" maxlength="3" id="pin_id_7" placeHolder="xxx" class="pin_number"/></td>
	</tr>
	<tr>
	    <td>Parcel PIN </td>
	    <td><s:textarea name="waiver.parcelPin" value="%{parcelPin}" rows="3" cols="25" id="pin_id_multiple" title="For parcel state pin use space to separate" /> </td>
	</tr>
	<tr>
	    <td>Parcel Tax ID</td>
	    <td>
		<input type="text" name="waiver.parcelTaxId2" value="" size="3" maxlength="3" id="tax_id_1" class="tax_number" placeHolder="xxx"/> -
		<input type="text" name="waiver.parcelTaxId2" value="" size="5" maxlength="5" id="tax_id_2" class="tax_number" placeHolder="xxxxx" /> -
		<input type="text" name="waiver.parcelTaxId2" value="" size="2" maxlength="2" id="tax_id_3" class="tax_number" placeHolder="xx"/>
		(enter one at a time) </td>
	</tr>			
	<tr>
	    <td>Parcel Tax ID </td>
	    <td><s:textarea name="waiver.parcelTaxId" value="%{parcelTaxId}" rows="3" cols="25" id="tax_id_multiple" title="For multiple tax ids use space to separate" />(old records) </td>
	</tr>
	<tr>
	    <td>Legal description </td>
	    <td><s:textarea name="waiver.legalDescription" value="%{legalDescription}" rows="5" cols="50"  required="required" /> </td>
	</tr>
	<tr>
	    <td>Township Sec. Range </td>
	    <td><s:textfield name="waiver.secTwpRangeDir" size="30" maxlength="50" value="%{secTwpRangeDir}" /> </td>
	</tr>
	<tr>
	    <td>Lot </td>
	    <td><s:textfield name="waiver.lot" size="15" maxlength="30" value="%{lot}" /></td>
	</tr>
	<tr>
	    <td>Acreage </td>
	    <td><s:textfield name="waiver.acreage" size="10" maxlength="10" value="%{acreage}" />	</td>
	</tr>			
	<tr>
	    <td>Develop./Subdiv. </td>
	    <td><s:textfield name="waiver.developmentSubdivision" size="30" maxlength="128" value="%{developmentSubdivision}" /> </td>
	</tr>			
	<tr>
	    <td>In City Limits</td>
	    <td><s:radio name="waiver.inOutCity" value="%{inOutCity}" list="#{'IN':'IN','OUT':'OUT'}" /> 
	    </td>
	</tr>
	<tr>
	    <td>Waiver Notes </td>
	    <td><s:textarea name="waiver.notes" value="%{notes}" rows="5" cols="50"  /> </td>
	</tr>
	<tr>
	    <td></td>
	    <td><s:submit name="action" type="button" value="Save" class="fn1-btn"/></td>
	</tr>
    </table>
</s:form>
<s:if test="waivers != null">
    <s:set var="waiversTitle" value="waiversTitle" />
    <s:set var="waivers" value="waivers" />
    <%@  include file="waivers.jsp" %>			
</s:if>
<%@  include file="../gui/footer.jsp" %>

