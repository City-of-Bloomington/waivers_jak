<!--
 * @copyright Copyright (C) 2014-2015 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
	-->
<%@ taglib prefix="s" uri="/struts-tags" %>
<table border="1" width="80%">
    <caption>Legal Input</caption>
    <tr>
	<th>Signed Date </th>
	<td><s:property value="#signedDate" />
	</td>
    </tr>
    <tr>
	<th>Waiver Notes </th>
	<td><s:property value="%{notes}" />
	</td>
    </tr>
</table>
