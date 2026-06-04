<%@ taglib prefix="s" uri="/struts-tags" %>
<!--
 * @copyright Copyright (C) 2014-2015 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
	-->
<table border="1" width="80%">
    <caption>Controller's Input</caption>
    <tr>
	<th>Paper Verified Date </th>
	<td><s:property value="%{paperVerifiedDate}" />
	</td>
    </tr>
    <tr>
	<th>Controller Notes </th>
	<td><s:property value="%{controllerNotes}" />
	</td>
    </tr>
    <tr>
	<th>Waiver Notes </th>
	<td><s:property value="%{notes}" />
	</td>
    </tr>
</table>
