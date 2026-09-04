package annex.action;
/**
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 */
import java.util.*; 
import jakarta.servlet.ServletContext;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.action.ServletContextAware;
import org.apache.struts2.action.SessionAware;  
import org.apache.struts2.interceptor.parameter.StrutsParameter;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import annex.model.*;
import annex.list.*;
import annex.utils.*;

public class WelcomeAction extends TopAction 
    implements SessionAware, ServletContextAware{
    private static final long serialVersionUID = 330L;
    static Logger logger = LogManager.getLogger(WelcomeAction.class);
    private ServletContext ctx;
    private Map<String, Object> sessionMap;
    private User user;
    String action = "", id="";
    //
    // if we have global list we can set them here and will
    // be available for all pages
    //
    public String execute(){
	String ret = SUCCESS;
	doPrepare();
	if(user == null){
	    getUser();
	    // ret = LOGIN;
	}
	return ret;
    }
    @StrutsParameter(depth=1)
    public void setAction(String val){
	action = val;
    }
    public String getAction(){
	return action;
    }
    @StrutsParameter(depth=1)
    public void setId(String val){
	id = val;
    }
    public String getId(){
	return id;
    }
    @Override  
    public void withSession(Map<String, Object> map) {  
	sessionMap = map;  
    }
    @Override  	
    public void withServletContext(ServletContext ctx) {  
        this.ctx = ctx;  
    }  	 
}


