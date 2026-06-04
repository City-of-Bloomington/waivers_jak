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
	<td><s:property value="#mappedDate" />
	</td>
    </tr>
    <tr>
	<th>In/Out City </th>
	<td><s:property value="#inOutCity" /> 
	</td>
    </tr>
    <tr>
	<th>GIS Notes </th>
	<td><s:property value="#gisNotes" />
	</td>
    </tr>
    <tr>
	<th>Waiver Notes </th>
	<td><s:property value="%{notes}" />
	</td>
    </tr>
</table>
