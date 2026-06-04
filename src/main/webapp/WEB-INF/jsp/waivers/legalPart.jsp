<%@ taglib prefix="s" uri="/struts-tags" %>

<table border="1" width="80%">
    <caption>Legal Input</caption>
    <tr>
    <th>Signed Date </th>
	<td><s:textfield name="waiver.signedDate" value="%{signedDate}" size="10" maxlength="10" class="date" required="true" />
	</td>
    </tr>
    <tr>
	<th>Waiver Notes </th>
	<td><s:textarea name="waiver.notes" value="%{notes}" rows="5" cols="50" />
	</td>
    </tr>
</table>


