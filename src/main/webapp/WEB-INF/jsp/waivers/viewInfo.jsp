<!--
 * @copyright Copyright (C) 2014-2015 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
	-->
<table border="1" width="80%">
    <caption>Waiver Info</caption>
    <s:if test="isBusiness()">
	<tr>
	    <td>Is Business? </td>
	    <td>Yes</td>
	</tr>
    </s:if>
    <s:if test="isTrust()" >
	<tr>
	    <td>Is Trust? </td>
	    <td>Yes</td>
	</tr>
    </s:if>	
    <s:if test="hasEntities()">
	<tr><td colspan="2">
	    <s:set var="entitiesTitle" value="'Entities(s)'" />
	    <s:set var="entities" value="%{entities}" />
	    <%@  include file="../entities/entitiesBasic.jsp" %>
	</td>
	</tr>
    </s:if>	
    <tr>
	<td>Waiver County ID </td>
	<td><s:property value="%{countyWaiverId}" /> </td>
    </tr>
    <tr>
	<td>Service address(es) </td>
	<td><s:property value="%{addressInfo}" /> <s:if test="invalidAddr" >(Invalid) </s:if> </td>
    </tr>
    <tr>
	<td>Legal description </td>
	<td><s:property value="%{legalDescription}"  /> </td>
    </tr>
    <tr>
	<td>Parcel Pin </td>
	<td><s:property value="%{parcelPin}" /> </td>
    </tr>
    <tr>
	<td>Parcel Tax ID </td>
	<td><s:property value="%{parcelTaxId}" /> </td>
    </tr>		
    <tr>
	<td>Waiver Instrument # </td>
	<td><s:property value="%{waiverInstrumentNum}" /> </td>
    </tr>
    <tr>
	<td>Deed Instrument # </td>
	<td><s:property value="%{deedInstrumentNum}" /> </td>
    </tr>		
    <tr>
	<td>Waiver Book/Page </td>
	<td><s:property value="%{waiverBook}" />/<s:property value="%{waiverPage}" /></td>
    </tr>
    <tr>
	<td>Deed Book/Page </td>
	<td><s:property value="%{deedBook}" />/<s:property value="%{deedPage}" /></td>
    </tr>		
    <tr>
	<td>Township Section Range </td>
	<td><s:property value="%{secTwpRangeDir}" /> </td>
    </tr>
    <tr>
	<td>Development </td>
	<td><s:property value="%{developmentSubdivision}" /> </td>
    </tr>
    <tr>
	<td>Lot </td>
	<td><s:property value="%{lot}"  /> </td>
    </tr>
    <tr>
	<td>Acreage </td>
	<td><s:property value="%{acrage}"  /> </td>
    </tr>		
    <tr>
	<td>IN/OUT City? </td>
	<td><s:property value="%{inOutCity}" /></td>
    </tr>
    <tr>
	<td>IN GIS? </td>
	<td><s:if test="inGis" > Yes</s:if><s:else> No</s:else></td> 
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
    </tr>
    <s:if test="needExpireDate()">		
	<tr>
	    <td>Expire date </td>
	    <td><s:property value="%{expireDate}" /> 
	    </td>
	</tr>
    </s:if>
    <tr>
	<td>Signed date </td>
	<td><s:property value="%{signedDate}"  /> </td>
    </tr>		
    <tr>
	<td>Recorder ID </td>
	<td><s:property value="%{recorderId}"  /> </td>
    </tr>
    <tr>
	<td>Recorded date </td>
	<td><s:property value="%{recorderDate}"  /> </td>
    </tr>
    <s:if test="recorder_notes">
	<tr>
	    <td>Recorder notes </td>
	    <td><s:property value="%{recorderNotes}"  /> </td>
	</tr>
    </s:if>
    <tr>
	<td>Paper verified </td>
	<td><s:property value="%{paperVerifiedDate}"  /> </td>
    </tr>
    <tr>
	<td>Controller notes </td>
	<td><s:property value="%{controllerNotes}"  /> </td>
    </tr>
    <tr>
	<td>Mapped date </td>
	<td><s:property value="%{mappedDate}"  /> </td>
    </tr>
    <s:if test="hasGisNotes()">
	<tr>
	    <td>GIS notes </td>
	    <td><s:property value="%{gisNotes}"  /> </td>
	</tr>
    </s:if>
    <s:if test="hasAdded_by()">
	<tr>
	    <td>Other Info Added by </td>
	    <td><s:property value="%{addedByUser}" /> 
	    </td>
	</tr>
    </s:if>
    <s:if test="imported" > 		
	<tr>
	    <td>Imported </td>
	    <td>Yes</td> 
	</tr>
    </s:if>
    <tr>
	<td>Status </td>
	<td><s:property value="%{status}" /> 
	</td>
    </tr>
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
</table>


