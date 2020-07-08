package com.atguigu.controller.portal;

import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * PortalHome
 * @author
 */
@Controller
@RequestMapping("/PortalHome")
public class PortalHomeController {
	
	/**
	 * 	onuse	20200103	检查
	 * */
	@RequestMapping("/videoPage")
	public String videoPage(HttpSession session) throws Exception{
		

		return "portal/subject/video";

	}
	
	/**
	 * 	onuse	20200103	检查
	 * */
	@RequestMapping("/InsShowPage")
	public String InsShowPage(HttpSession session) throws Exception{
		

		return "portal/subject/InsShowPage";

	}

}
