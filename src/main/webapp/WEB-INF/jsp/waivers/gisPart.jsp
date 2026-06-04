<%@ taglib prefix="s" uri="/struts-tags" %>
<!--
 * @copyright Copyright (C) 2014-2015 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
-->
<table border="1" width="80%">
    <caption>GIS Input</caption>
    <tr>
	<th>Mapped Date </th>
	<td><s:textfield name="waiver.mappedDate" value="%{mappedDate}" size="10" maxlength="10" class="date" required="true" />
	</td>
    </tr>
    <tr>
	<th>In/Out City </th>
	<td><s:radio name="waiver.inOutCity" value="%{inOutCity}" list="#{'IN':'IN','OUT':'OUT'}" /> 
	</td>
    </tr>
    <tr>
	<th>GIS Notes </th>
	<td><s:textarea name="waiver.gisNotes" value="%{gisNotes}" rows="5" cols="50" />
	</td>
    </tr>
    <tr>
	<th>Waiver Notes </th>
	<td><s:textarea name="waiver.notes" value="%{notes}" rows="5" cols="50" />
	</td>
    </tr>
</table>
