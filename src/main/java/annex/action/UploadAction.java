/**
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 */
package annex.action;

// import java.io.File;
import java.util.*;
import java.io.File;
//import java.nio.file.*;
// import org.apache.commons.io.FileUtils;
import java.nio.file.Path;
import java.nio.file.Paths;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.activation.*;
import jakarta.servlet.ServletContext;
import org.apache.commons.fileupload2.core.DiskFileItem;
import org.apache.commons.fileupload2.core.DiskFileItemFactory;
import org.apache.commons.fileupload2.core.FileItem; // For Commons FileUpload 2
import org.apache.commons.fileupload2.jakarta.servlet6.JakartaServletFileUpload;
import org.apache.commons.fileupload2.jakarta.servlet6.*;
import org.apache.commons.io.*;
import org.apache.struts2.action.UploadedFilesAware; 
import org.apache.struts2.dispatcher.multipart.UploadedFile;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.parameter.StrutsParameter;
// import org.apache.tika.Tika;
import java.io.InputStream;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import annex.model.*;
import annex.list.*;
import annex.utils.*;

public class UploadAction extends TopAction implements UploadedFilesAware{

    static final long serialVersionUID = 270L;
    static Logger logger = LogManager.getLogger(UploadAction.class);			
    String waiver_id="", task_id="", notes="", hardcopy_location="",
	type="";
    private String contentType, saveDir="";
    private String filename="";
    private String upload="";
    private List<FileUpload> uploads = null;
    private String[] types = {"Application","Warranty Deed","Recorded Waiver","Map","Other"};
    static private Map<String, String> mimeTypes = null;
    private Waiver waiver = null;
    private Task task = null;
    private UploadedFile file;
    private String originalName=null;
    
    @StrutsParameter(depth=2) 
    public void setUpload(UploadedFile file) {
	this.file = file;
    }
    @StrutsParameter(depth=2)
    public void setUploadContentType(String contentType) {
        this.contentType = contentType;
    }    
    @StrutsParameter(depth=1)
    public void setSaveDir(String str) {
	if(str != null)
	    saveDir = str;
    }		
    @StrutsParameter(depth=1)	
    public void setUploadFileName(String val) {
	if(val != null)
	    this.filename = val;

    }
    @StrutsParameter(depth=1)
    public void setAction(String val){
	action = val;
    }
    @Override
    public void withUploadedFiles(List<UploadedFile> uploadedFiles) {
        if (!uploadedFiles.isEmpty()) {
          this.file = uploadedFiles.get(0);
          this.filename = file.getName();
          this.contentType = file.getContentType();
          this.originalName = file.getOriginalName();
        }
    }    
    public String execute() {
	String ret = INPUT;		
	String back = doPrepare();
	prepareMimeTypesMap();
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
	if(action.equals("Save")){
	    if(!hasType()){
		back = "You need to choose file type ";
		addActionError(back);
	    }
	    else if(file != null){
		try{
		    //
		    String file_ext = "pdf";		    
		    if(originalName.indexOf(".") > 0){
			file_ext = originalName.substring(originalName.indexOf(".")+1);
		    }
		    if(contentType != null){
			if(mimeTypes.containsKey(contentType)){
			    file_ext = mimeTypes.get(contentType);
			}
		    }
		    FileUpload upload = new FileUpload();
		    upload.setWaiver_id(waiver_id);
		    upload.setTask_id(task_id);
		    upload.setType(type);
		    upload.setNotes(notes);
		    String new_file_name = upload.genNewFileName(file_ext);
		    upload.setOld_file_name(originalName);
		    upload.setUser_id(user.getId());
		    String year = Helper.getThisYear();
		    //
		    // String filePath = ctx.getRealPath("/") +"WEB-INF"+File.separator+"files"+File.separator+year+File.separator;
		    //
		    String filePath = server_path+File.separator+year+File.separator+new_file_name;
		    File destinationFile = new File(filePath);
		    File tempFile = (File) file.getContent();
		    FileUtils.copyFile(tempFile, destinationFile);		    
		    back = upload.doSave();
		    if(back.equals("")){
			ret = SUCCESS;
			addActionMessage("Save successfully");
			String str = "waiver.action?id="+waiver_id;
			if(!task_id.equals("")){
			    str ="task.action?task_id="+task_id+"&action=";
			}
			try{
			    HttpServletResponse res = ServletActionContext.getResponse();
			    str = url+str;
			    res.sendRedirect(str);
			    return super.execute();
			}catch(Exception ex){
			    System.err.println(ex);
			}
		    }
		    else{
			addActionError(back);
		    }
		}catch(Exception ex){
		    logger.error(ex);
		    addActionError(""+ex);
		}
	    }
	}
	else if(action.equals("Delete")){
	    FileUpload fup = new FileUpload();
	    fup.setId(id);
	    back = fup.doSelect();
	    if(back.equals("")){
		waiver_id=fup.getWaiver_id();
		task_id = fup.getTask_id();
		back = fup.doDelete();
		if(back.equals("")){
		    addActionMessage("Deleted successfully");
		    String str = "waiver.action?id="+waiver_id;
		    if(!task_id.equals("")){
			str ="task.action?task_id="+task_id;
		    }
		    try{
			HttpServletResponse res = ServletActionContext.getResponse();
			str = url+str;
			res.sendRedirect(str);
			return super.execute();
		    }catch(Exception ex){
			logger.error(ex);
		    }
		}
	    }
	    if(!back.equals("")){
		addActionError(back);
		logger.error(back);
	    }
	}
	return ret;
    }
    /**
     * to get file extension from mime type we are building
     * the mimeTypes hashmap
     */
    private void prepareMimeTypesMap(){
	if(mimeTypes == null){
	    mimeTypes = new HashMap<>();
	    mimeTypes.put("image/gif","gif");
	    mimeTypes.put("image/jpeg","jpg");
	    mimeTypes.put("image/png","png");
	    mimeTypes.put("image/tiff","tiff");
	    mimeTypes.put("image/bmp","bmp");
	    mimeTypes.put("text/plain","txt");
	    mimeTypes.put("audio/x-wav","wav");
	    mimeTypes.put("application/pdf","pdf");
	    mimeTypes.put("audio/midi","mid");
	    mimeTypes.put("video/mpeg","mpeg");
	    mimeTypes.put("video/mp4","mp4");
	    mimeTypes.put("video/x-ms-asf","asf");
	    mimeTypes.put("video/x-ms-wmv","wmv");
	    mimeTypes.put("video/x-msvideo","avi");
	    mimeTypes.put("text/html","html");
						
	    mimeTypes.put("application/mp4","mp4");
	    mimeTypes.put("application/x-shockwave-flash","swf");
	    mimeTypes.put("application/msword","doc");
	    mimeTypes.put("application/xml","xml");
	    mimeTypes.put("application/vnd.ms-excel","xls");
	    mimeTypes.put("application/vnd.openxmlformats-officedocument.wordprocessingml.document","docx");
	    mimeTypes.put("application/vnd.ms-powerpoint","ppt");
	}

    }
    @StrutsParameter(depth=1)
    public void setNotes(String val){
	if(val != null)
	    notes = val;
    }
    @StrutsParameter(depth=1)
    public void setWaiver_id(String val){
	if(val != null)
	    waiver_id = val;
    }
    @StrutsParameter(depth=1)
    public void setTask_id(String val){
	if(val != null)
	    task_id = val;
    }
    @StrutsParameter(depth=1)
    public void setType(String val){
	if(val != null && !val.equals("-1"))
	    type = val;
    }
    @StrutsParameter(depth=1)
    public void setHardcopy_location(String val){
	if(val != null)
	    hardcopy_location = val;
    }
    public String getNotes(){
	return notes;
    }
    public String getWaiver_id(){
	if(waiver_id.isEmpty()){
	    getWaiver();
	}
	return waiver_id;
    }
    public String getWaiverNum(){
	getWaiver();
	if(waiver != null)
	    return waiver.getWaiverNum();;
	return "";
    }
    public String getTask_id(){
	return task_id;
    }
    public String getType(){
	logger.debug(" get type");
	if(type.equals("") && hasTask()){
	    getTask();
	    type = task.getSuggested_upload_type();
	    if(task.hasSuggested_upload_type()){
		type = task.getSuggested_upload_type();
	    }
	}
	if(type.equals(""))
	    return "-1";
	return type;
    }
    public boolean hasType(){
	return !type.equals("");
    }
    public String getHardcopy_location(){
	return hardcopy_location;
    }
    @StrutsParameter(depth=1)
    public String[] getTypes(){
	return types;
    }

    public boolean hasTask(){
	return !task_id.equals("");
    }
    @StrutsParameter(depth=2)
    public Waiver getWaiver(){
	if(waiver == null && waiver_id.isEmpty()){
	    getTask();
	    if(task != null)
		waiver_id = task.getWaiver_id();
	}
	logger.debug(" get waiver");
	if(waiver == null && !waiver_id.equals("")){
	    Waiver one = new Waiver(debug, waiver_id);
	    String back = one.doSelect();
	    if(back.equals(""))
		waiver = one;
	    else{
		logger.error(back);
	    }
	}
	return waiver;
    }
    @StrutsParameter(depth=1)
    public Task getTask(){
	if(task == null && !task_id.equals("")){
	    Task one = new Task(debug, task_id);
	    String back = one.doSelect();
	    if(back.equals(""))
		task = one;
	    else{
		logger.error(back);
	    }
	}
	return task;
    }
    public String getTask_name(){
	getTask();
	if(task != null)
	    return task.getName();
	return "";
    }
    @StrutsParameter(depth=1)
    public List<FileUpload> getUploads(){
	logger.debug(" get uploads ");
	if(uploads == null){
	    FileUploadList fl = new FileUploadList();
	    if(!waiver_id.equals(""))
		fl.setWaiver_id(waiver_id);						
	    String back = fl.find();
	    if(back.equals("")){
		List<FileUpload> list = fl.getUploads();
		if(list != null && list.size() > 0){
		    uploads = list;
		}
	    }
	    else{
		logger.error(back);
	    }
	}
	return uploads;
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





































