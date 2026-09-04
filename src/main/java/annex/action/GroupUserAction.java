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

public class GroupUserAction extends TopAction{

    static final long serialVersionUID = 290L;	
    static Logger logger = LogManager.getLogger(GroupUserAction.class);
    //
    String group_id="", dept="";
    User user = null;
    List<Type> groups = null;
    GroupUser groupUser = null;
    List<User> other_users = null;
    String groupUsersTitle = "Users in this group";
    String otherUsersTitle = "Users not in this group";
    public String execute(){
	String ret = SUCCESS;
	String back = doPrepare();
	getGroupUser();
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
	if(action.startsWith("Add")){
	    logger.debug(" action add ");
	    back = groupUser.doAdd();
	    if(!back.equals("")){
		addActionError(back);
		logger.error(back);
	    }
	    else{
		addActionMessage("Added Successfully");
	    }
	}				
	else if(action.startsWith("Remove")){
	    logger.debug(" action remove ");
	    back = groupUser.doRemove();
	    if(!back.equals("")){
		addActionError(back);
		logger.error(back);
	    }
	    else{
		addActionMessage("Removed Successfully");
	    }
	}
	return ret;
    }
    @StrutsParameter(depth=1)
    public GroupUser getGroupUser(){ 
	if(groupUser == null){
	    groupUser = new GroupUser();
	}		
	return groupUser;
    }
    public String getGroup_id(){
	return groupUser.getGroup_id();
    }
    @StrutsParameter(depth=1)
    public void setGroupUser(GroupUser val){
	if(val != null){
	    groupUser = val;
	}
    }
    public boolean hasOtherUsers(){
	return groupUser.hasOtherUsers();
    }
    @StrutsParameter(depth=2)
    public List<User> getOther_users(){
	return groupUser.getOther_users();
    }
    public boolean hasGroupUsers(){
	return groupUser.hasGroupUsers();
    }    
    @StrutsParameter(depth=2)
    public List<User> getGroup_users(){
	return groupUser.getGroup_users();
    }    
    @StrutsParameter(depth=0) 
    public String getGroupUsersTitle(){
	return groupUsersTitle;
    }
    @StrutsParameter(depth=0) 
    public String getOtherUsersTitle(){
	return otherUsersTitle;
    }
    @StrutsParameter(depth=0)
    public void setAction2(String val){
	if(val != null && !val.equals(""))		
	    action = val;
    }
    @StrutsParameter(depth=1)
    public List<Type> getGroups(){
	logger.debug(" get groups ");
	if(groups == null){
	    TypeList tl = new TypeList(debug, null, "`groups`");
	    String back = tl.find();
	    if(back.equals("")){
		List<Type> ones = tl.getTypes();
		if(ones != null && ones.size() > 0){
		    groups = ones;
		}
	    }
	    else{
		logger.error(back);
	    }
	}
	return groups;
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





































