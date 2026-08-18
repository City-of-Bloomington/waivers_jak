package annex.action;
/**
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 */
import java.util.*;
import java.io.*;
import java.text.*;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletContext;
import org.apache.struts2.ServletActionContext;  
import org.apache.struts2.interceptor.parameter.StrutsParameter;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import annex.model.*;
import annex.list.*;
import annex.utils.*;

public class WaiverAction extends TopAction{

    static final long serialVersionUID = 315L;	
    static Logger logger = LogManager.getLogger(WaiverAction.class);
    //
    Waiver waiver = null;
    List<Waiver> waivers = null;
    List<EmailLog> emailLogs = null;
    String entity_id="", address_id="", waiver_num="";
    String waiversTitle = " Most recent Waivers";
    public String execute(){
	String ret = SUCCESS;
	String back = doPrepare();
	if(!back.equals("")){
	    try{
		HttpServletResponse res = ServletActionContext.getResponse();
		String str = url+"Login";
		res.sendRedirect(str);
		return super.execute();
	    }catch(Exception ex){
		logger.error(back);
	    }	
	}
	getWaiver();
	if(action.equals("Save")){
	    logger.debug("save");		
	    waiver.setAddedBy(user.getId());
	    back = waiver.doSave();
	    if(!back.equals("")){
		addActionError(back);
		logger.error(back);
	    }
	    else{
		id = waiver.getId();
		addActionMessage("Saved Successfully");
		ret = "view";
	    }
	}				
	else if(action.equals("Save Changes")){

	    System.err.println(" doing update ");
	    logger.debug("update");		
	    waiver.setUserId(user.getId()); // we needed for actions					
	    back = waiver.doUpdate();
	    if(!back.equals("")){
		addActionError(back);
		logger.error(back);
	    }
	    else{
		ret = "view";
		addActionMessage("Updated Successfully");
	    }
	}
	else if(action.startsWith("Remove Entity")){
	    logger.debug("remove entity");		
	    getWaiver();
	    back = waiver.doRemoveEntity();
	    if(!back.equals("")){
		addActionError(back);
		logger.error(back);																
	    }
	    else{
		addActionMessage("Deleted Successfully");								
		ret = "edit";
	    }
	}
	else if(action.equals("Delete")){
	    logger.debug("Delete");		
	    getWaiver();
	    back = waiver.doDelete();
	    if(!back.equals("")){
		addActionError(back);
		logger.error(back);		
	    }
	    else{
		addActionMessage("Deleted Successfully");								
	    }
	}
	else if(action.startsWith("Close")){
	    logger.debug("close");		
	    waiver = new Waiver(debug, id);
	    waiver.setClosedBy(user.getId());
	    back = waiver.doClose();
	    if(!back.equals("")){
		addActionError(back);
		logger.error(back);		
	    }
	    else{
		addActionMessage("Closed Successfully");								
		ret = "view";
	    }
	}
	else if(action.startsWith("Remove Entity")){ // remove owner
	    logger.debug("remove entity");		
	    back = waiver.doRemoveEntity();
	    if(!back.equals("")){
		addActionError(back);
		logger.error(back);		
	    }
	    else{
		addActionMessage("Entity removed Successfully");
	    }
	    ret = "edit";
	}
	else if(action.startsWith("Remove Addr")){ // remove owner
	    logger.debug("remove addr");		
	    back = waiver.doRemoveAddress();
	    if(!back.equals("")){
		addActionError(back);
		logger.error(back);		
	    }
	    else{
		addActionMessage("Address removed Successfully");
	    }
	    ret = "edit";
	}						
	else if(action.equals("Edit")){
	    logger.debug("Edit");		
	    waiver = new Waiver(debug, id, waiver_num);
	    back = waiver.doSelect();
	    if(!back.equals("")){
		addActionError(back);
		logger.error(back);		
	    }
	    ret = "edit";
	}				
	else if(!id.isEmpty() || !waiver_num.isEmpty()){
	    ret = "view";
	    logger.debug("view");		
	    waiver = new Waiver(debug, id, waiver_num);
	    back = waiver.doSelect();
	    if(!back.equals("")){
		addActionError(back);
		logger.error(back);		
	    }
	}
	return ret;
    }
    @StrutsParameter(depth=2)
    public Waiver getWaiver(){ 
	if(waiver == null){
	    if(!id.isEmpty() || !waiver_num.isEmpty()){
		waiver = new Waiver(debug, id, waiver_num);
	    }
	    else{
		waiver = new Waiver();
	    }
	    if(!entity_id.equals(""))
		waiver.setEntityId(entity_id);
	    if(!address_id.equals(""))
		waiver.setAddressId(address_id);
	}		
	return waiver;
    }
    @StrutsParameter(depth=1)    
    public void setId(String val){
	if(val != null)
	    id = val;
    }
    @StrutsParameter(depth=1)
    public void setWaiver(Waiver val){
	if(val != null)
	    waiver = val;
    }
    public String getWaiver_id(){
	return id;
    }
    public String getWaiversTitle(){
	return waiversTitle;
    }
    @StrutsParameter(depth=1)
    public void setAction2(String val){
	if(val != null && !val.equals(""))		
	    action = val;
    }
    public String getId(){
	if(id.equals("") && waiver != null){
	    id = waiver.getId();
	}
	return id;
    }
    public String getWaiverNum(){
	if(waiver_num.isEmpty() && waiver != null){
	    waiver_num = waiver.getWaiverNum();
	}
	return waiver_num;
    }
    @StrutsParameter(depth=1)
    public void setWaiverNum(String val){
	if(val != null && !val.isEmpty())		
	    waiver_num = val;
    }
    @StrutsParameter(depth=1)
    public void setEntityId(String val){
	if(val != null && !val.equals(""))		
	    entity_id = val;
    }
    @StrutsParameter(depth=1)
    public void setAddressId(String val){
	if(val != null && !val.equals(""))		
	    address_id = val;
    }
    public String getDeedInstrumentNum(){
	return waiver.getDeedInstrumentNum();
    }
    public String getWaiverInstrumentNum(){
	return waiver.getWaiverInstrumentNum();
    }
    public String getAddEntityName(){
	return waiver.getEntityName();
    }
    public String getDeedBook(){
	return waiver.getDeedBook();
    }
    public String getDeedPage(){
	return waiver.getDeedPage();
    }
    public String getWaiverBook(){
	return waiver.getWaiverBook();
    }
    public String getWaiverPage(){
	return waiver.getWaiverPage();
    }		
    public String getParcelPin(){
	return waiver.getParcelPin();
    }
    public String getAcreage(){
	return waiver.getAcreage();
    }
    public String getAcrage(){
	return waiver.getAcrage();
    }
    public String getSecTwpRangeDir(){
	return waiver.getSecTwpRangeDir();
    }
    public String getDevelopmentSubdivision(){
	return waiver.getDevelopmentSubdivision();
    }
    public String getLot(){
	return waiver.getLot();
    }

    public String getEntityName(){
	return ""; // auto_complete 
    }
    public String getLegalDescription(){
	return waiver.getLegalDescription();
    }
    public String getParcelTaxId(){
	return waiver.getParcelTaxId();
    }
		
    public String getMappedDate(){
	return waiver.getMappedDate();
    }
    public String getGisNotes(){
	return waiver.getGisNotes();
    }
    public String getNotes(){
	return waiver.getNotes();
    }		
		
    public String getHookupAddress(){
	return waiver.getHookupAddress();
    }
    public String getRecorderDate(){
	return waiver.getRecorderDate();
    }
    public String getScannedDate(){
	return waiver.getScannedDate();
    }		
    public String getInOutCity(){
	return waiver.getInOutCity();
    }
    public String getPaperVerifiedDate(){
	return waiver.getPaperVerifiedDate();
    }

		
    public boolean getImported(){
	return waiver.getImported();
    }
    // needed to know if no printing is needed anymore
    public boolean isSigned(){
	return waiver.isOpen();
    }
    public String getAddedBy(){
	return waiver.getAddedBy();
    }
    public String getClosedBy(){
	return waiver.getClosedBy();
    }
    public String getClosedDate(){
	return waiver.getClosedDate();
    }		
    public String getStatus(){
	return waiver.getStatus();
    }
    public boolean isOpen(){
	return waiver.isOpen();
    }
    public boolean isClosed(){
	return waiver.isClosed();
    }		
    // added date, for old data we use signed_date
    public String getDate(){
	return waiver.getDate();
    }
    public String getSignedDate(){
	return waiver.getSignedDate();
    }		
    public String getExpireDate(){
	return waiver.getExpireDate();
    }
    public String getEntitiesInfo(){
	return waiver.getEntitiesInfo();
    }
    public String getWaiverBookPage(){
	return waiver.getWaiverBookPage();
    }
    public String getDeedBookPage(){
	return waiver.getDeedBookPage();
    }
    public String getLotAcreage(){
	return waiver.getLotAcreage();
    }		
    public String getLotAcrage(){
	return getLotAcreage();
    }
    public String getAddressInfo(){
	return waiver.getAddressInfo();
    }
    // for address
    public boolean isInvalidAddr(){
	return waiver.isInvalidAddr();
    }
    public boolean isBusiness(){
	return waiver.isBusiness();
    }
    public boolean isTrust(){
	return waiver.isTrust();
    }
    public boolean hasAddresses(){
	return waiver.hasAddresses();
    }
    public List<Address> getAddresses(){
	return waiver.getAddresses();
    }
    public boolean hasGisNotes(){
	return waiver.hasGisNotes();
    }
    public boolean hasMoreTasks(){
	return waiver.hasMoreTasks();
    }
    public List<Task> getTasks(){
	return waiver.getTasks();
    }
    public boolean hasCompletedTasks(){
	return waiver.hasCompletedTasks();
    }
    public List<Task> getCompletedTasks(){
	return waiver.getCompletedTasks();
    }
    public boolean hasUploads(){
	return waiver.hasUploads();
    }
    public List<FileUpload> getUploads(){
	return waiver.getUploads();
    }
    // most recent
    @StrutsParameter(depth=2)
    public List<Waiver> getWaivers(){
	logger.debug("get waivers");		
	if(waivers == null){
	    WaiverList dl = new WaiverList();
	    dl.setStatus("Open");
	    String back = dl.find();
	    waivers = dl.getWaivers();
	}		
	return waivers;
    }
    public boolean hasEntities(){
	return waiver.hasEntities();
    }
    public boolean hasEmailLogs(){
	getWaiver();
	if(!waiver.getId().equals("")){
	    EmailLogList ell = new EmailLogList(debug, waiver.getId());
	    String back = ell.find();
	    if(back.equals("")){
		List<EmailLog> logs = ell.getEmailLogs();
		if(logs != null && logs.size() > 0){
		    emailLogs = logs;
		}
	    }
	    else{
		logger.error(back);		
	    }
	    return emailLogs != null && emailLogs.size() > 0;
	}
	return false;
    }
    @StrutsParameter(depth=3)    
    public List<Entity> getEntities(){
	return waiver.getEntities();
    }
    @StrutsParameter(depth=2)
    public List<EmailLog> getEmailLogs(){
	logger.debug("email logs");		
	return emailLogs;
    }		
    @Override  
    public void withSession(Map<String, Object> map) {  
	sessionMap=map;  
    }
    @Override
    public void withServletContext(ServletContext ctx) {
        this.ctx = ctx;
    }
}





































