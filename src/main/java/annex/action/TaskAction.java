package annex.action;
/**
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 */
import java.util.*;
import java.io.*;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletContext;
import org.apache.struts2.ServletActionContext;  
import org.apache.struts2.interceptor.parameter.StrutsParameter;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import annex.model.*;
import annex.list.*;
import annex.utils.*;

public class TaskAction extends TopAction{

    static final long serialVersionUID = 315L;	
    static Logger logger = LogManager.getLogger(TaskAction.class);
    //
    Task task = null;
    Waiver waiver = null;
    List<Task> tasks = null;
    List<EmailLog> emailLogs = null;
    String task_id = "", waiver_id="";
    String tasksTitle = " Most recent tasks";
    List<Group> toBeNotifiedGroups = null;
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
		System.err.println(ex);
	    }	
	}
	getUser();
	getTask();
	if(action.equals("Save")){
	    logger.debug(" action save ");
	    task.setClaimedByIfNotSet(user.getId());
	    back = task.doSave();
	    if(!back.equals("")){
		addActionError(back);
		logger.error(back);
	    }
	    else{
		id = task.getId();
		if(task.hasPartName()){
		    getWaiver();
		    handleWaiverUpdate();
		}								
		addActionMessage("Saved Successfully");
		ret = "view";
	    }
	}				
	else if(action.equals("Save Changes")){
	    logger.debug(" action update ");
	    task.setClaimedByIfNotSet(user.getId());	 // we needed for actions					
	    back = task.doUpdate();
	    if(!back.equals("")){
		addActionError(back);
		logger.error(back);								
	    }
	    else{
		if(task.hasPartName()){
		    getWaiver();
		    handleWaiverUpdate();
		}
		addActionMessage("Updated Successfully");
		ret = "view";
	    }
	}
	else if(action.equals("Delete")){
	    logger.debug(" action delete ");
	    getWaiver();
	    back = task.doDelete();
	    if(!back.equals("")){
		addActionError(back);
		logger.error(back);
	    }
	    else{
		addActionMessage("Deleted Successfully");								
		ret = "search";
	    }
	}
	else if(action.endsWith("Completed")){
	    logger.debug(" action completed ");
	    if(!task.isCompleted()){
		task.setClaimedByIfNotSet(user.getId());
		task.setCompleted(true);
		back = task.doUpdate();
		if(!back.equals("")){
		    addActionError(back);
		    logger.error(back);
		}
		else{
		    waiver = task.getWaiver();
		    List<Task> nextTasks = null;
		    if(task.hasPartName()){
			handleWaiverUpdate();
		    }
		    if(!task.hasNextTask()){
			if(!waiver.hasMoreTasks()){
			    back = waiver.doComplete();
			}
		    }
		    else{
			nextTasks = task.getNextTasks();
		    }
		    //
		    // check if we need to email
		    //
		    if(nextTasks != null && nextTasks.size() > 0){
			for(Task nextTask: nextTasks){
			    // System.err.println(" next task "+nextTask);
			    if(nextTask.isNotificationRequired()){
				System.err.println(" notify required ");
				List<GroupNotification> groupNotifications =
				    nextTask.getGroupNotifications();
				if(groupNotifications != null && groupNotifications.size() > 0){
				    for(GroupNotification one:groupNotifications){
					Group gg = one.getGroup();
					System.err.println(" group "+gg);
					if(gg != null){
					    if(toBeNotifiedGroups == null)
						toBeNotifiedGroups = new ArrayList<>();
					    toBeNotifiedGroups.add(gg);
					}
				    }
				}
				// System.err.println(" process email ");
				back = processEmails();
			    }
			    else{
				System.err.println(" notify not required ");
			    }
			}
		    }
		}
	    }
	    ret = "view";
	    addActionMessage("Completed Successfully");				
	}
	else if(action.equals("Edit")){
	    System.err.println(" task_id "+task_id);
	    back = task.doSelect();
	    if(!back.equals("")){
		addActionError(back);
		logger.error(back);
	    }
	    getWaiver();
	}
	else if(!task_id.equals("")){
	    ret = "view";
	    getWaiver();
	}
	else{
	    getWaiver();
	}
	return ret;
    }
    @StrutsParameter(depth=2)
    public Waiver getWaiver(){
	logger.debug(" action get waiver ");
	if(waiver == null){
	    if(!waiver_id.equals("")){
		waiver = new Waiver(debug, waiver_id);
		waiver.doSelect();
	    }
	    else {
		getTask();
		waiver = task.getWaiver();
		waiver_id = task.getWaiver_id();
	    }
	}		
	return waiver;

    }
    private void handleWaiverUpdate(){
	String back = waiver.updateRelatedPart(task.getPart_name());
	if(!back.equals("")){
	    addActionError(back);
	}
    }
    @StrutsParameter(depth=3)
    public Task getTask(){
	logger.debug(" get task ");
	if(task == null){
	    if(!task_id.equals("")){
		task = new Task(debug, task_id);
		String back = task.doSelect();
		if(!back.equals("")){
		    addActionError(back);
		}
	    }
	    else{
		task = new Task();
	    }
	}		
	return task;
    }
    @StrutsParameter(depth=2)
    public void setTask(Task val){
	if(val != null)
	    task = val;
    }
    @StrutsParameter(depth=1) 
    public String getTasksTitle(){
	return tasksTitle;
    }
    @StrutsParameter(depth=1)
    public void setAction2(String val){
	if(val != null && !val.equals(""))		
	    action = val;
    }
    @StrutsParameter(depth=1)
    public void setTask_id(String val){
	if(val != null && !val.equals(""))		
	    task_id = val;
    }
    
    @StrutsParameter(depth=1)
    public String getTask_id(){
	if(task_id.equals("") && task != null){
	    task_id = task.getTask_id();
	}
	return task_id;
    }
    @StrutsParameter(depth=1)
    public void setWaiver_id(String val){
	if(val != null && !val.equals(""))		
	    waiver_id = val;
    }
    public String getWaiver_id(){
	if(waiver_id.equals("") && waiver != null){
	    waiver_id = waiver.getId();
	}
	else{
	    getTask();
	    waiver_id= task.getWaiver_id();
	}
	return waiver_id;
    }
    public boolean isCompleted(){
	return task.isCompleted();
    }
    public String getCompleted_date(){
	return task.getCompleted_date();
    }
    public String getWaiverNum(){
	if(waiver == null)
	    getWaiver();
	return waiver.getWaiverNum();
    }
    public String getBasicInfo(){
	return waiver.getBasicInfo();
    }
    public String getBasicInfo2(){
	return waiver.getBasicInfo2();
    }
    public String getBasicInfo3(){
	return waiver.getBasicInfo3();
    }
    public boolean isOpen(){
	return waiver.isOpen();
    }
    public String getName(){
	return task.getName();
    }
    public String getPart_name(){
	return task.getPart_name();
    }    
    public String getStart_date(){
	return task.getStart_date();
    }    
    public boolean getRequire_upload(){
	return task.getRequire_upload();
    }
    public boolean isClaimed(){
	return task.isClaimed();
    }
    public boolean hasSecondField(){
	return task.hasSecondField();
    }
    public String getField2_name(){
	return task.getField2_name();
    }
    public String getField2_value(){
	return task.getField2_value();
    }    
    public boolean hasFirstField(){
	return task.hasFirstField();
    }

    public boolean hasPartName(){
	return task.hasPartName();
    }
    public boolean hasPart(){
	return task.hasPart();
    }
    public String getGroupName(){
	return task.getGroupName();
    }
    public boolean hasNextTask(){
	return task.hasNextTask();
    }
    public boolean canBeCompleted(){
	return task.canBeCompleted();
    }
    public User getClaimed_user(){
	return task.getClaimed_user();
    }
    public List<Task> getCompletedTasks(){
	return waiver.getCompletedTasks();
    }
    public boolean canBePrinted(){
	return waiver.canBePrinted();
    }
    public boolean hasUploads(){
	return waiver.hasUploads();
    }
    public List<FileUpload> getUploads(){
	return waiver.getUploads();
    }
    // most recent
    @StrutsParameter(depth=2)
    public List<Task> getTasks(){ 
	if(tasks == null){
	    TaskList dl = new TaskList();
	    String back = dl.find();
	    if(back.equals(""))
		tasks = dl.getTasks();
	    else
		logger.error(back);
	}		
	return tasks;
    }
    
    @StrutsParameter(depth=1)
    public boolean hasEmailLogs(){
	getTask();
	EmailLogList ell = new EmailLogList(debug, task.getWaiver_id(), task.getTask_id());
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
    @StrutsParameter(depth=3)
    public List<EmailLog> getEmailLogs(){
	return emailLogs;
    }		
    private String processEmails(){
	String back = "";
	String subject = "", msg = "";
	getUser();
	String from = user.getUsername()+city_email;
	String to = "", cc = null;
	logger.debug(" process emails ");
	if(waiver == null){
	    back = "No waiver available";
	    return back;
	}
	if(toBeNotifiedGroups != null){
	    for(Group gg:toBeNotifiedGroups){
		to="";cc=null;								
		List<User> users = gg.getUsers();
		for(User one:users){
		    if(one.hasActiveMail() && one.isActive()){
			String receiver = one.getUsername()+city_email;
			// we do not want to send email to himself
			if(from.indexOf(receiver) > -1) continue;
			if(to.equals("")){
			    to = receiver;
			}
			else{
			    if(cc == null || cc.equals("")){
				cc = receiver;
			    }
			    else{
				if(!cc.equals("")) cc +=",";
				cc += receiver;
			    }
			}
		    }
		}
		if(gg.getName().equals("Legal")){
		    subject = " Waiver application and deed received ";
		    msg = " Hi \n\n";
		    msg += " We would like to inform you that the following waiver is\n "+
			" ready to be prepared and signed \n"+
			" Waiver # = "+waiver.getWaiverNum()+"\n"+
			" Address(s): "+waiver.getBasicInfo()+"\n"+
			" Owner(s): "+waiver.getBasicInfo2()+"\n"+
			" Other Waiver Info: "+waiver.getBasicInfo3()+"\n\n"+
			" Thanks\n\n";
		    if(!to.isEmpty()){
			back = sendEmails(to, from, cc, subject, msg);
		    }
		}
		else if(gg.getName().equals("Utilities")){
		    subject = " Waiver ready to be recorded and service connection to proceed ";
		    msg = " Hi \n\n";
		    msg += " We would like to inform you that the following waiver is\n "+
			" ready to be recorded and service connection for \n"+
			" address below to proceed \n\n"+
			" Waiver # = "+waiver.getWaiverNum()+"\n"+
			" Address(s): "+waiver.getBasicInfo()+"\n"+
			" Owner(s): "+waiver.getBasicInfo2()+"\n"+
			" Other Waiver Info: "+waiver.getBasicInfo3()+"\n\n"+
			" Thanks\n\n";
		    if(!to.isEmpty()){
			back = sendEmails(to, from, cc, subject, msg);
		    }
		}
		else if(gg.getName().equals("GIS")){
		    subject = " Waiver ready to be added to GIS map "+waiver.getWaiverNum();
		    msg = " Hi \n\n";
		    msg += " We would like to inform you that the following waiver is\n "+
			" ready to be added to GIS map. \n"+
			" See waiver info below \n\n"+
			" waiver # = "+waiver.getWaiverNum()+"\n"+
			" Address(s): "+waiver.getBasicInfo()+"\n"+
			" Owner(s):"+waiver.getBasicInfo2()+"\n"+
			"Other waiver info: "+waiver.getBasicInfo3()+"\n\n"+
			" Thanks\n\n";
		    //
		    // user does not want to receive emails from helpdesk
		    // so we are hardwiring it
		    to = "helpdesk@bloomington.in.gov";
		    from = "donotreply@bloomington.in.gov";
		    cc = null;
		    if(!to.isEmpty()){
			back = sendEmails(to, from, cc, subject, msg);
		    }
		}
		if(!to.isEmpty()){
		    if(!back.equals("")){
			logger.error(back);
			System.err.println(back);
		    }
		}
	    }
	}
	return back;
    }
    String sendEmails(String to,
		      String from,
		      String cc,
		      String subject,
		      String msg){
	String back = "";
	if(to.equals("")) return msg;
	EmailHandle mail = new EmailHandle(to, from, cc, subject, msg, debug);
	if(activeMail){
	    back = mail.send();
	    EmailLog elog = new EmailLog(debug, task.getWaiver_id(), task.getTask_id(), to, from, cc, subject, msg, back);
	    back += elog.doSave();
	}
	return back;
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





































