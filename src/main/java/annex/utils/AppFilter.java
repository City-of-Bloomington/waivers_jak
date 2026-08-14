package annex.utils;
/**
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 */
import java.io.IOException;
import java.util.Enumeration;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.ServletContext;
import jakarta.servlet.annotation.WebFilter;

public class AppFilter implements Filter {
    public static String POLICY = "frame-src 'none'; img-src 'self' data:; object-src 'none';frame-ancestors 'self';";    
    private ServletContext ctx = null;
    public void init(FilterConfig config) throws ServletException {
	ctx = config.getServletContext();
    }
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
	throws IOException, ServletException {
	/**
	HttpServletRequest req = (HttpServletRequest) request;
	HttpServletResponse res = (HttpServletResponse) response;
	HttpSession session = req.getSession(false);
	System.err.println(" filter is called ");
	if (session == null || session.getAttribute("user") == null) {
	    res.sendRedirect("login"); 
	} else {
	    chain.doFilter(request, response); // continue to servlet
	}
	*/
    }
}

