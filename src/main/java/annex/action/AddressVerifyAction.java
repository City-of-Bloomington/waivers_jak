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
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.parameter.StrutsParameter;
import jakarta.servlet.ServletContext;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import annex.model.*;
import annex.list.*;
import annex.utils.*;
/**
 * this code probably is not needed anymore, we are using AddressAction
 * class instead
 */

public class AddressVerifyAction extends TopAction{

    static final long serialVersionUID = 315L;	
    static Logger logger = LogManager.getLogger(AddressVerifyAction.class);
    //
    String waiver_id="";
    Address address = null;
    String[] addrCombs = null; 
    List<Address> addresses = null;
    String addressesTitle = "Addresses";
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
	else if(action.equals("Save")){
	    logger.debug(" action save ");
	    back = doVerify();
	    if(!back.equals("")){
		addActionError(back);
	    }
	    else{
		back = doSave();
		if(!back.equals("")){
		    addActionError(back);
		    logger.error(back);
		}
		else{
		    addActionMessage("Saved Successfully");
		}
	    }
	}
	getWaiver_id();
	if(!waiver_id.equals("")){
	    try{
		HttpServletResponse res = ServletActionContext.getResponse();
		String str = url+"waiver.action?action=Edit&id="+getWaiver_id();
		res.sendRedirect(str);
		return super.execute();
	    }catch(Exception ex){
		System.err.println(ex);
	    }											
	}
	else{
	    getAddress();
	}
	return ret;
    }
    @StrutsParameter(depth=1)
    public Address getAddress(){
	logger.debug(" get address ");
	if(address == null){
	    if(!id.equals("")){
		address = new Address(debug, id);
		String back = address.doSelect();
		if(!back.equals("")){
		    addActionError(back);
		    logger.error(back);
		}
	    }
	    else{
		address = new Address();
	    }
	}
	if(!waiver_id.equals(""))
	    address.setWaiver_id(waiver_id);
	return address;
    }
    @StrutsParameter(depth=1)
    public void setAddress(Address val){
	if(val != null)
	    address = val;
    }
    @StrutsParameter(depth=0)
    public void setWaiver_id(String val){
	if(val != null)
	    waiver_id = val;
    }
    @StrutsParameter(depth=0)    
    public String getWaiver_id(){
	if(waiver_id.equals("")){
	    getAddress();
	    waiver_id = address.getWaiver_id();
	}
	return waiver_id;
    }
    @StrutsParameter(depth=0)
    public String getAddressesTitle(){
	return addressesTitle;
    }
    @StrutsParameter(depth=0)
    public void setAction2(String val){
	if(val != null && !val.equals(""))		
	    action = val;
    }
    @StrutsParameter(depth=1)
    public void setAddrCombos(String[] vals){
	if(vals != null){
	    addrCombs = vals;
	}
    }
    // 
    private String doVerify(){
	String back = "";
	logger.debug(" do verify ");
	if(address != null && address.canVerify()){
	    AddressList adl = new AddressList();
	    back = adl.findSimilarAddr(addrUrl, address.getAddressToVerify());
	    if(back.equals("")){
		addresses = adl.getAddresses();
		if(addresses == null || addresses.size() == 0){
		    address.setInvalid(true);
		}
	    }
	    else{
		logger.error(back);								
	    }
	}
	return back;
    }
    private String doSave(){
	String ret = "";
	if(addrCombs != null){
	    logger.debug(" action save ");
	    for(String str:addrCombs){
		Address addr = new Address();
		addr.setWaiver_id(waiver_id);
		addr.setAddrCombo(str);
		ret += addr.doSave();
	    }
	}
	return ret;
    }
    public boolean hasAddresses(){
	return addresses != null && addresses.size() > 0;
    }
    @StrutsParameter(depth=1)
    public List<Address> getAddresses(){
	return addresses;
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





































