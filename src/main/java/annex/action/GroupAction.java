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

public class GroupAction extends TopAction{

    static final long serialVersionUID = 290L;	
    static Logger logger = LogManager.getLogger(GroupAction.class);
    //
    User user = null;
    Type group = null;
    List<Type> groups = null;
    String groupsTitle = "Current groups";
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
	getGroup();
	if(action.equals("Save")){
	    logger.debug(" action save ");
	    back = group.doSave();
	    if(!back.equals("")){
		addActionError(back);
		logger.error(back);								
	    }
	    else{
		addActionMessage("Added Successfully");
	    }
	}				
	else if(action.startsWith("Save")){
	    logger.debug(" action update ");
	    back = group.doUpdate();
	    if(!back.equals("")){
		addActionError(back);
		logger.error(back);									
	    }
	    else{
		addActionMessage("Updated Successfully");
	    }
	}
	else{		
	    if(!id.equals("")){
		back = group.doSelect();
		if(!back.equals("")){
		    addActionError(back);
		}
	    }
	}
	return ret;
    }
    @StrutsParameter(depth=1)
    public Type getGroup(){ 
	if(group == null){
	    group = new Type();
	    group.setId(id);
	    group.setTable_name("`groups`");
	}		
	return group;
    }
    @StrutsParameter(depth=1)
    public void setGroup(Group val){
	if(val != null){
	    group = val;
	    group.setTable_name("`groups`");
	}
    }
    public String getId(){
	return id;
    }
    public String getName(){
	return group.getName();
    }
    public boolean isInactive(){
	return group.getInactive();
    }
	
    @StrutsParameter(depth=0)
    public String getGroupsTitle(){
	return groupsTitle;
    }
    @StrutsParameter(depth=0)
    public void setAction2(String val){
	if(val != null && !val.equals(""))		
	    action = val;
    }
    @StrutsParameter(depth=2)
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





































