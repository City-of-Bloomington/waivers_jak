/**
 * @copyright Copyright (C) 2014-2015 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 */
package annex.action;
import java.util.*;
import java.io.*;
import java.text.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.struts2.ServletActionContext;  
import org.apache.struts2.dispatcher.SessionMap;  
import org.apache.struts2.action.SessionAware;
import org.apache.struts2.interceptor.parameter.StrutsParameter;
import org.apache.struts2.action.ServletContextAware;  
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import annex.model.*;
import annex.list.*;
import annex.utils.*;

public abstract class TopAction // extends ActionSupport
    implements SessionAware, ServletContextAware{



    static final long serialVersionUID = 240L;
    static Logger logger = LogManager.getLogger(TopAction.class);		
    static boolean debug = false, activeMail=false;
    static String url="", addrUrl="";
    static String server_path="";
    static String city_email="", legal_username = "", utility_username="",
	gis_username="";
    static String LOGIN="login";
    static String INPUT="input";    
    static String SUCCESS="success";
    static String ERROR="error";
    List<String> errors = new ArrayList<>();
    List<String> messages = new ArrayList<>();
    String action="",id="";

    
    User user = null;
    ServletContext ctx;
    Map<String, Object> sessionMap;
    
    @StrutsParameter(depth=0)
    public void setAction(String val){
	if(val != null)
	    action = val;
    }
    @StrutsParameter(depth=0)
    public void setAction2(String val){
	if(val != null && !val.equals(""))
	    action = val;
    }		
    public String getAction(){
	return action;
    }
    @StrutsParameter(depth=0)
    public void setId(String val){
	if(val != null)
	    id = val;
    }
    public String getId(){
	return id;
    }
    @StrutsParameter(depth=1)
    public User getUser(){
	if(user == null && sessionMap != null){
	    user = (User)sessionMap.get("user");
	}
	return user;
    }
    public String execute() throws Exception {
	return SUCCESS;
    }
    public void addActionMessage(String str){
	messages.add(str);
    }
    public void addActionError(String str){
	errors.add(str);
    }
    public boolean hasErrors(){
	return errors.size() > 0;
    }
    public boolean hasMessages(){
	return messages.size() > 0;
    }
    public boolean hasActionErrors(){
	return errors.size() > 0;
    }
    public boolean hasActionMessages(){
	return messages.size() > 0;
    }    
    public List<String> getErrors(){
	return errors;
    }
    public List<String> getMessages(){
	return messages;
    }
    public List<String> getActionErrors(){
	return errors;
    }
    public List<String> getActionMessages(){
	return messages;
    }
    String doPrepare(Map<String, Object>  map){
	sessionMap = map;
	return doPrepare();
    }
    String doPrepare(){
	String back = "";	
	if(sessionMap != null){
	    try{
		user = (User)sessionMap.get("user");
		if(user == null){
		    back = LOGIN;
		}
		if(url.equals("")){
		    String val = ctx.getInitParameter("url");
		if(val != null)
		    url = val;
		val = ctx.getInitParameter("addrUrl");
		if(val != null)
		    addrUrl = val;								
		val = ctx.getInitParameter("server_path");
		if(val != null)
		    server_path = val;
		val = ctx.getInitParameter("city_email");
		if(val != null)
		    city_email = "@"+val;								
		val = ctx.getInitParameter("legal_username");
		if(val != null)
		    legal_username = val;
		val = ctx.getInitParameter("utility_username");
		if(val != null)
		    utility_username = val;
		val = ctx.getInitParameter("gis_username");
		if(val != null)
		    gis_username = val;
		val = ctx.getInitParameter("activeMail");
		if(val != null && val.equals("true"))
		    activeMail = true;								
		}
	    }catch(Exception ex){
		System.out.println(ex);
	    }
	}
	return back;
    }


}





































