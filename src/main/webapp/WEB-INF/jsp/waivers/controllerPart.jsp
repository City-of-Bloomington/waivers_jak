<%@ taglib prefix="s" uri="/struts-tags" %>
<table border="1" width="80%">
    <caption>Controller's Input</caption> 
    <tr>
	<th>Paper Verified Date </th>
	<td><s:textfield name="waiver.paperVerifiedDate" value="%{paperVerifiedDate}" size="10" maxlength="10" class="date" />
	</td>
    </tr>			
    <tr>
	<th>Controller Notes </th>
	<td><s:textarea name="waiver.controllerNotes" value="%{controllerNotes}" rows="5" cols="70" />
	</td>
    </tr>
    <tr>
	<th>Waiver Notes </th>
	<td><s:textarea name="waiver.notes" value="%{notes}" rows="5" cols="50" />
	</td>
    </tr>
</table>
