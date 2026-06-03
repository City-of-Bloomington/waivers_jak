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

public class FilesImportAction extends TopAction{

    static final long serialVersionUID = 290L;	
    static Logger logger = LogManager.getLogger(FilesImportAction.class);
    //
    // old file
    String file_name = "c:\\webapps\\waivers\\docs\\pdf_list.txt";
		
    FilesImport fimport = null;
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
	if(action.equals("Import")){
	    getFimport();
	    back = fimport.doImport(file_name);
	    if(!back.equals("")){
		addActionError(back);
	    }
	    else{
		addActionMessage("Save Successfully");
	    }
	}				
	else{		
	    getFimport();
	}
	return ret;
    }
    @StrutsParameter(depth=1)
    public FilesImport getFimport(){ 
	if(fimport == null){
	    fimport = new FilesImport();
	}		
	return fimport;
    }

    @StrutsParameter(depth=1)
    public void setFimport(FilesImport val){
	if(val != null){
	    fimport = val;
	}
    }
    @StrutsParameter(depth=0)
    public String getFile_name(){
	return file_name;
    }
    @StrutsParameter(depth=0)
    public void setFile_name(String val){
	if(val != null)
	    file_name = val;
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





































