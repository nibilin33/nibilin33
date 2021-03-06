package com.fase.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fase.iservice.IBlock;
import com.fase.iservice.Iaskpermisson;
import com.fase.iservice.Iufriend;
import com.fase.po.Askpermission;
import com.fase.po.Settime;

@Controller
@RequestMapping(value="/aska")
public class FAskpermissionControl {
	@Resource
	private Iaskpermisson perservice;
	@Resource
	private IBlock ib;
	@Resource
	private Iufriend iu;
	@RequestMapping(value="/aa.action")
	public void allow(@RequestBody Askpermission ask,HttpServletResponse response){

		
	  Settime si=  ib.selectsetting(ask.getFfid());
	  System.out.println(si.getFbefriend());
	  if(si.getFbefriend().equals("公开")){
		 
	    perservice.insertP(ask);
	  }
	  else
		  if(si.getFbefriend().equals("朋友的朋友")){
			  Map<String, Object> param = new HashMap<String, Object>(); 
			  param.put("fuid", ask.getFuid());
			  param.put("askfuid", ask.getFfid());
			 if(iu.isinfriendfriend(param)){
				 perservice.insertP(ask);
			 }
		  }
		try {
	 response.setContentType("application/json");
     response.setHeader("Pragma", "No-cache");
     response.setHeader("Cache-Control", "no-cache");
     response.setCharacterEncoding("UTF-8");
     response.getWriter().print("sucess");
		} catch (IOException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
	}
	@RequestMapping(value="/opennotice.action")
	public void opennotice(HttpServletRequest re,HttpServletResponse response){
		String fuid=re.getParameter("fuid");
		JSONObject jsonobject=new JSONObject();
		List<Askpermission> ask = perservice.selectall(fuid);
		
		jsonobject.put("newnotice", ask);
		System.out.println(jsonobject.toString());
		try {
	 response.setContentType("application/json");
     response.setHeader("Pragma", "No-cache");
     response.setHeader("Cache-Control", "no-cache");
     response.setCharacterEncoding("UTF-8");
     response.getWriter().print(jsonobject);
		} catch (IOException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
	}
	@RequestMapping(value="/updatenotice.action")
	public void notification(@RequestBody Askpermission ask,HttpServletResponse response){
		perservice.updateP(ask);
		try {
	 response.setContentType("application/json");
     response.setHeader("Pragma", "No-cache");
     response.setHeader("Cache-Control", "no-cache");
     response.setCharacterEncoding("UTF-8");
     response.getWriter().print("sucess");
		} catch (IOException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
	}

}
