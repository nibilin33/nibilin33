package com.fase.controller;

import java.io.File;
import java.io.IOException;
import java.io.Writer;
import java.lang.annotation.Retention;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import oracle.jdbc.driver.OracleTypes;

import org.apache.commons.lang.StringUtils;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ModelAndView;

import util.MailSender;
import util.SendPhone;

import com.fase.iservice.IBlock;
import com.fase.iservice.IZan;
import com.fase.iservice.Icommentservice;
import com.fase.iservice.Idynamicinfo;
import com.fase.iservice.Ifuser;
import com.fase.iservice.Iufriend;
import com.fase.po.Blocking;
import com.fase.po.College;
import com.fase.po.DynamicInfo;
import com.fase.po.Fuser;
import com.fase.po.Settime;
import com.fase.po.TComment;
import com.fase.po.Ufreind;
import com.fase.po.Zan;

@Controller
@RequestMapping(value ="/user")
public class FuserControl{
	@Resource
	private Ifuser ifuser;
	@Resource
	private Iufriend iuservice;
	@Resource
	private Idynamicinfo  idy;
	@Resource
	private IZan izan;
	@Resource
	private IBlock iblock;
	@Resource
	private Icommentservice fservice;
	@RequestMapping(value="/helpcenter.action")
	public ModelAndView helpcenter(HttpServletRequest re){
		ModelAndView mv=new ModelAndView();
		HttpSession s=re.getSession();
		String fuid=re.getParameter("fuid");
		Fuser us=null;
		if(fuid==null){
		  us=ifuser.selectbyid(fuid);
	  s.setAttribute("current_user", us);
		}
		 mv.setViewName("help");
			return mv;
	}
	@RequestMapping(value="/friendsearch.action")
	public void friendsearch(HttpServletRequest request,HttpServletResponse response){
		 JSONObject jsonObject = new JSONObject();  
	     String s=request.getParameter("friend");
	     System.out.println(s);
	     if(!"".equals(s)){
	       List<Fuser>  hh=ifuser.selectSmartByname(s);
	       System.out.println(hh.size());
	       jsonObject.put("friend", hh);
	       try {
	    	   response.setContentType("application/json");
	           response.setHeader("Pragma", "No-cache");
	           response.setHeader("Cache-Control", "no-cache");
	           response.setCharacterEncoding("UTF-8");
			  response.getWriter().print(jsonObject);
		} catch (IOException e) {
			// TODO ??????????????? catch ???
			e.printStackTrace();
		}
	     }
	     }
	@RequestMapping(value="/{fuid}/yichuhei.action")
	public void yichuhei(@PathVariable("fuid")String fuid,HttpServletRequest res,HttpServletResponse response){
		 Map<String,Object> params=new HashMap<String, Object>();
		 String bfuid=res.getParameter("bfuid");
		 params.put("fuid",fuid);
		 params.put("bfuid", bfuid);
	int n=	 iblock.deleteBlock(params);
	if(n==1){
		 try {
		response.getWriter().print("success");
			} catch (IOException e) {
				
				e.printStackTrace();
			}
	}else
	{
		try {
			response.getWriter().print("wrong");
		} catch (IOException e) {
			// TODO ??????????????? catch ???
			e.printStackTrace();
		}
	}
		
	}
	@RequestMapping(value="/{fuid}/plusfd.action")
	public ModelAndView contactinfo(@PathVariable("fuid")String fuid,HttpServletRequest re){
		ModelAndView mv=new ModelAndView();
		HttpSession s=re.getSession();
		Fuser us=(Fuser) s.getAttribute("current_user");
		if(us==null){
		  us=ifuser.selectbyid(fuid);
	  s.setAttribute("current_user", us);
		}
		 String fff=re.getParameter("srch-term");
	     System.out.println(fff);
	     List<Fuser>  hh=null;
	     if(!"".equals(fff)){
	      hh=ifuser.selectSmartByname(fff);
	     }else
	     {  
	      Fuser u=new Fuser();
	      u.setFliveplace(us.getFliveplace());
	         hh=ifuser.selectByMulti(u);
	     }
	  
	     mv.addObject("pr",hh);
		 mv.setViewName("searchfirend");
			return mv;
	}
	@RequestMapping(value ="/register.action")
	public void RegisterUser(@RequestBody Fuser re,HttpServletResponse response){
		   Fuser user=null;
		   JSONObject json=new JSONObject();
		   
		   //???????????????????????????????????????????????????0?????????????????????
	       boolean flag=ifuser.insertFuser(re);
       if(flag){
   /* if(re.getFemail()!=null){
        		user=ifuser.checkLogin(re.getFemail(),re.getFpassword());
       	}else
        		if(re.getFtel()!=null){
        			 user=ifuser.checkLogin(re.getFtel(),re.getFpassword());
        		}*/
    	   json.put("susucess", "200");
        }else
        {
       json.put("susucess","404");
         }	  
       try {
    	   response.setContentType("application/json");
           response.setHeader("Pragma", "No-cache");
           response.setHeader("Cache-Control", "no-cache");
           response.setCharacterEncoding("UTF-8");
		   response.getWriter().print(json.toString());
	} catch (IOException e) {
		// TODO ??????????????? catch ???
		e.printStackTrace();
	} 
		
	}
	@RequestMapping(value="/upbackground.action")
	public void upbackground(HttpServletRequest request, HttpServletResponse response) throws IllegalStateException, IOException{
		 // ???????????????????????????????????????
	    String username=request.getParameter("uid");
	    Fuser fuser=ifuser.selectbyid(username);
	    String record="";
	  
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
                request.getSession().getServletContext());
        // ?????? request ?????????????????????,??????????????????
        if (multipartResolver.isMultipart(request)) {
            // ??????????????????request
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
            // ??????request?????????????????????
            Iterator<String> iter = multiRequest.getFileNames();
            while (iter.hasNext()) {
                // ???????????????????????????????????????????????????????????????
                int pre = (int) System.currentTimeMillis();
                // ??????????????????
                MultipartFile file = multiRequest.getFile(iter.next());
                if (file != null) {
                    // ???????????????????????????????????????
                    String myFileName = file.getOriginalFilename();
                    String str=myFileName.substring(myFileName.lastIndexOf(".")+1);
               
                  
                    // ????????????????????????,??????????????????????????????????????????????????????
                    if (myFileName.trim() != "") {
                   
                        // ??????????????????????????????
                    	 String fileName =""+pre+"."+str;
                      
                     
                        // ??????????????????
                        String path = "E:/img/" +username;
                     
                        File localFilew = new File(path);
                        if(!localFilew.exists()&&!localFilew.isDirectory()){
                        	localFilew.mkdir();
                        }
                        File localFile=new File(path+"/"+ fileName);
                        record="http://localhost:8080/img/"+username+"/"+fileName;
                        file.transferTo(localFile);
                    }
                }
                // ?????????????????????????????????
                int finaltime = (int) System.currentTimeMillis();
              
            }

        }
     
        fuser.setFbackimage(record);
        ifuser.updateFuser(fuser);
        Writer writer = null;
        try {
        	 response.setCharacterEncoding("utf-8");
  	        response.setContentType("text/html; charset=" + "utf-8");
  	      writer = response.getWriter(); 
  	      writer.write("{\"message\":\"" + record + "\"}");
			  writer.flush();
	            writer.close();
		} catch (IOException e) {
			// TODO ??????????????? catch ???
			e.printStackTrace();
		} 
   
	}

	@RequestMapping(value ="/login.action")
	public ModelAndView  login(@RequestParam("username")String username, @RequestParam("password")String password,HttpServletRequest re){
		ModelAndView model=new ModelAndView();
		//System.out.println(re.getSession().getAttribute("current_user"));
	List<Fuser> use=ifuser.checkLogin(username, password);
	   HttpSession s=re.getSession();
	   System.out.println("jinru"+use);
		if(use.size()>0){
			//model.addObject("current_user",use.get(0));
			Map<String, Object> param = new HashMap<String, Object>(); 
	
			Fuser users=use.get(0);
			users.setFstate(new BigDecimal(1));
	
			ifuser.updateFuser(users); 
			//??????in???????????? 
			param.put("fuid",users.getFuid()); 
			param.put("offset",0);
			param.put("maxs",9);
			param.put("result",OracleTypes.CURSOR); 
		     List<DynamicInfo> dinfo=fenzhuang(param,"selectallowinfo");
			Map<String,Object> friends=new HashMap<String, Object>();
			friends.put("fuid",users.getFuid());
			friends.put("liveplace", users.getFliveplace());
			   friends.put("results", OracleTypes.CURSOR);
			  List<Fuser> friend=ifuser.findfreinds(friends);/*????????????????????????*/
			  List<Ufreind> uf=iuservice.selectall(users.getFuid());
			 Settime setime=iblock.selectsetting(users.getFuid());
	           s.setAttribute("current_user", users);
			  s.setAttribute("dinfo", dinfo);
	          s.setAttribute("addfreinds", friend);
	          s.setAttribute("myf", uf);
	          s.setAttribute("settime",setime);
	          
			  model.setViewName("facebook");
		}else
		{    s.setAttribute("wrong","??????????????????????????????");	
			model.setViewName("index");
		}
	    return model;
        }
	 @RequestMapping(value="/{fuid}/addmore.action")  /* ?????????????????????*/
     public void addmore(@PathVariable("fuid")String fuid,HttpServletResponse response,HttpServletRequest re){
  	  
  	   int offset=Integer.parseInt(re.getParameter("offset"));
  	 int maxs=offset+7;
  	 Map<String, Object> param = new HashMap<String, Object>(); 
		//??????in???????????? 
		param.put("fuid",fuid); 
		param.put("offset",offset);
		param.put("maxs",maxs);
		param.put("result",OracleTypes.CURSOR); 
		 Map<String, Object> param2 = new HashMap<String, Object>(); 
		 param2.put("fuid", fuid);
		 param2.put("result", OracleTypes.INTEGER);
		System.out.println(maxs);
		if(maxs<idy.selectCount(param2)){
     List<DynamicInfo> dinfo=fenzhuang2(param,"selectallowinfo",offset,maxs);
	
	     JSONObject json=new JSONObject();
	     json.put("dinfo", dinfo);
	     try {
	    	   response.setContentType("application/json");
	           response.setHeader("Pragma", "No-cache");
	           response.setHeader("Cache-Control", "no-cache");
	           response.setCharacterEncoding("UTF-8");
			  response.getWriter().print(json);
		} catch (IOException e) {
			// TODO ??????????????? catch ???
			e.printStackTrace();
		} 
		}else
		{
			 try {
				response.getWriter().print("?????????");
			} catch (IOException e) {
				// TODO ??????????????? catch ???
				e.printStackTrace();
			}
		}
	     
     }
	 @RequestMapping(value="/{fuid}/lineadd.action") /*?????????????????????*/
	 public void lineadd(@PathVariable("fuid")String fuid,HttpServletResponse response,HttpServletRequest re){
		   int offset=Integer.parseInt(re.getParameter("offset"));
		  	 int maxs=offset+7;
		  	 Map<String, Object> param = new HashMap<String, Object>(); 
				//??????in???????????? 
				param.put("fuid",fuid); 
				param.put("offset",offset);
				param.put("maxs",maxs);
				param.put("result",OracleTypes.CURSOR); 
		     List<DynamicInfo> dinfo=fenzhuang2(param,"selectdybyid",offset,maxs);
			     JSONObject json=new JSONObject();
			     json.put("dinfo", dinfo);
			     try {
			    	   response.setContentType("application/json");
			           response.setHeader("Pragma", "No-cache");
			           response.setHeader("Cache-Control", "no-cache");
			           response.setCharacterEncoding("UTF-8");
					  response.getWriter().write(json.toString());
				} catch (IOException e) {
					// TODO ??????????????? catch ???
					e.printStackTrace();
				} 
	 }
	@RequestMapping(value="/{fuid}.action")
	public ModelAndView mypage(@PathVariable("fuid")String fuid,HttpServletRequest re){
	
		ModelAndView mv=new ModelAndView();
		Map<String, Object> param = new HashMap<String, Object>(); 
	   HttpSession s=re.getSession();
	   Fuser u=(Fuser) s.getAttribute("current_user");
	   if(u!=null){
		   s.setAttribute("current_user", u);
	   }else
	   {
		  u=ifuser.selectbyid(fuid);
		   s.setAttribute("current_user",u);
	   }
		//??????in???????????? 
		param.put("fuid",fuid); 
		param.put("offset",0);
		param.put("maxs",9);
		param.put("result",OracleTypes.CURSOR); 
	     List<DynamicInfo> dinfo=fenzhuang(param,"selectdybyid");
		mv.addObject("timeline",dinfo);
		mv.setViewName("qqtimeline");
		return mv;
	}
	@RequestMapping(value="/{fuid}/checkin.action")
	public ModelAndView checkin(@PathVariable("fuid")String fuid,HttpServletRequest re){
		ModelAndView mv=new ModelAndView();
		HttpSession s=re.getSession();
		Fuser us=ifuser.selectbyid(fuid);
		s.setAttribute("current_user",us);
		mv.setViewName("checkinplace");
		return mv;
	}
	@RequestMapping(value="/{fuid}/{ffid}.action") /*fuid ?????????ffid ??????*/
	public ModelAndView mypage(@PathVariable("fuid")String fuid,@PathVariable("ffid")String ffid,HttpServletRequest re){
		
		ModelAndView mv=new ModelAndView();
		List<Blocking>en = iblock.selectall(fuid);
		
		for(int i=0;i<en.size();i++){
		if(ffid.equals(en.get(i).getBfuid())){
			mv.setViewName("404");
			return mv;
		}
		
		}
		Settime setime=iblock.selectsetting(fuid);
		if("????????????".equals(setime.getFtimeline())){
			mv.setViewName("404");
			return mv;
		}else
			if("??????".equals(setime.getFtimeline())){
				Map<String ,Object>params =new HashMap<String, Object>();
				params.put("askfuid", fuid);
				params.put("fuid", ffid);
				if(!iuservice.isinfriendfriend(params)){
					mv.setViewName("404");
					return mv;
				}
				
			}
		Map<String, Object> param = new HashMap<String, Object>(); 
		
		//??????in???????????? 
		param.put("fuid",fuid); 
		param.put("offset",0);
		param.put("maxs",9);
		param.put("result",OracleTypes.CURSOR); 
	     List<DynamicInfo> dinfo=fenzhuang(param,"selectdybyid");
		HttpSession s=re.getSession();
		Fuser us=ifuser.selectbyid(ffid);
		
		Fuser vi=ifuser.selectbyid(fuid);
		s.setAttribute("visit", vi);
		s.setAttribute("current_user",us);
		mv.addObject("timeline",dinfo);
		mv.setViewName("qqtimelinetosee");
		return mv;
	}
	@RequestMapping(value="/zan.action")
	public void zan(@RequestBody Zan zan,HttpServletResponse response){
          izan.insertZan(zan);
          int count=izan.getcount(zan.getDid());
	       try {
			  response.getWriter().print(count);
		} catch (IOException e) {
			// TODO ??????????????? catch ???
			e.printStackTrace();
		} 
		
	}
	@RequestMapping(value="/show.action")
	public ModelAndView showagain(HttpServletRequest re){
		ModelAndView model=new ModelAndView();
		 String fuid=re.getParameter("fuid");
		 Map<String, Object> param = new HashMap<String, Object>(); 
				//??????in???????????? 
		 Fuser us=ifuser.selectbyid(fuid);
				param.put("fuid",fuid); 
				param.put("offset",0);
				param.put("maxs",7);
				param.put("result",OracleTypes.CURSOR);
			 List<DynamicInfo> dinfo=fenzhuang(param,"selectallowinfo");
				Map<String,Object> friends=new HashMap<String, Object>();
				friends.put("fuid",us.getFuid());
				friends.put("liveplace", us.getFliveplace());
				   friends.put("results", OracleTypes.CURSOR);
				  List<Fuser> friend=ifuser.findfreinds(friends);/*????????????????????????*/
			 HttpSession s=re.getSession();
			 s.setAttribute("dinfo", dinfo);
			 s.setAttribute("current_user", us);
			  s.setAttribute("addfreinds", friend);
			model.setViewName("facebook");
		    return model;
	}
	@RequestMapping(value ="/out/{uid}.action")
	public ModelAndView out(@PathVariable String uid){
	
		ifuser.checklogOut(uid);
		return new ModelAndView("redirect:http://localhost:8080/fasebooke/index.jsp");	
	}
	@RequestMapping(value="/update.action")
	public void update(@RequestBody Fuser user,HttpServletResponse response,HttpServletRequest re){
		
		    ifuser.updateFuser(user);
		   Fuser us=ifuser.selectuser(user.getFuid());
		    JSONObject json=new JSONObject();
		    json.put("current_user", us);
		 try {
	    	   response.setContentType("application/json");
	           response.setHeader("Pragma", "No-cache");
	           response.setHeader("Cache-Control", "no-cache");
	           response.setCharacterEncoding("UTF-8");
			  response.getWriter().print(json);
		} catch (IOException e) {
			// TODO ??????????????? catch ???
			e.printStackTrace();
		} 
	}
	@RequestMapping(value="/findpass.action")
	public void findpass(HttpServletResponse response,HttpServletRequest re){
		String ask=re.getParameter("findit");
		Fuser answer=ifuser.findlostpass(ask);
	System.out.println(answer.getFemail());
		 try {
			 if(answer==null){
			  response.getWriter().print("wrong");
			 }else{
				 if(answer.getFemail()!=null)
				 MailSender.sendMessage(answer.getFemail(), "hello"+answer.getFname(), "????????????"+answer.getFpassword());
				 else
					 if(answer.getFtel()!=null){
						 SendPhone.sellphone(answer.getFtel(), "????????????"+answer.getFpassword());
					 }
				 response.getWriter().print("success");
			 }
		} catch (Exception e) {
			// TODO ??????????????? catch ???
			e.printStackTrace();
		} 
	
		
	}
	@RequestMapping(value="/deletblock.action")
	public void deletblock(@RequestBody Blocking user,HttpServletResponse response){
		 Map<String,Object> params=new HashMap<String, Object>();
		 params.put("fuid",user.getFuid());
		 params.put("bfuid", user.getBfuid());
	int n=	 iblock.deleteBlock(params);
	if(n==1){
		 try {
		response.getWriter().print("success");
			} catch (IOException e) {
				
				e.printStackTrace();
			}
	}else
	{
		try {
			response.getWriter().print("wrong");
		} catch (IOException e) {
			// TODO ??????????????? catch ???
			e.printStackTrace();
		}
	}
		
	
	}
	@RequestMapping(value="/upsetting.action")
	public void upsetting(@RequestBody Settime user,HttpServletResponse response){
	

		iblock.updatesetting(user);
		 try {
				response.getWriter().print("success");
					} catch (IOException e) {
						// TODO ??????????????? catch ???
						e.printStackTrace();
					}
	}
	@RequestMapping(value="/addblock.action")
	public void addblock(HttpServletResponse response,HttpServletRequest re){
		String fuid=re.getParameter("fuid");
		String target=re.getParameter("target");
		if(!"".equals(target)){
	
		Fuser u=ifuser.selectuser(target);
	
			String bfuid=u.getFuid();
			Blocking b=new Blocking();
			b.setBfuid(bfuid);
			b.setFuid(fuid);
			b.setBlocktype(new BigDecimal(1));
			iblock.insertBlock(b);
		try {
			 response.setHeader("Pragma", "No-cache");
	           response.setHeader("Cache-Control", "no-cache");
	           response.setCharacterEncoding("UTF-8");
			response.getWriter().print("???????????????"+u.getFname()+"???????????????"+","+"??????????????????????????????????????????");
		} catch (IOException e) {
			// TODO ??????????????? catch ???
			e.printStackTrace();
		}
		}
		else{
			try {
				 response.setHeader("Pragma", "No-cache");
		           response.setHeader("Cache-Control", "no-cache");
		           response.setCharacterEncoding("UTF-8");
				response.getWriter().print("?????????????????????");
			} catch (IOException e) {
				// TODO ??????????????? catch ???
				e.printStackTrace();
			}
		}
			
		}
	private List<DynamicInfo> fenzhuang2(Map<String, Object> param,String s,int offset,int maxs){
		 List<DynamicInfo> dinfo=null;
		if("selectallowinfo".equals(s)){
		 dinfo=idy.selectallowinfo(param);
		}else
			if("selectdybyid".equals(s)){
				dinfo=idy.selectdybyid(param);
			}
		
		   for(int i=0;i<dinfo.size();i++){
				 Map<String, Object> paramT = new HashMap<String, Object>(); 
					//??????in???????????? 
					paramT.put("pid",dinfo.get(i).getDid()); 
					paramT.put("offset",0);
					paramT.put("maxs",9);
					paramT.put("result",OracleTypes.CURSOR); 
					List <TComment> findCommentByItemId=fservice.findParentCommentByItemId(paramT);
					for(TComment comment : findCommentByItemId){ 
						List<TComment> replys = new ArrayList<TComment>(); // ????????????????????????  
				        comment.setReplyComment(replys); // ???????????????????????????  
				        String customerId = comment.getCustomerId(); // ?????????????????????Id  
				        Fuser customer = ifuser.selectbyid(customerId); // ??????????????????Id????????????????????????  
				        if(customer.getFheadimage()!=null){
				        customer.setFheadimage(DynamicInfo.imagebase+customer.getFuid()+"/"+customer.getFheadimage());
				     
				        }else
				        {
				        	customer.setFheadimage("http://localhost:8080/img/face/head_male_man_user_64px_1578_easyicon.net.png");
				        }
				        if(customer != null) customer.setFpassword(null);; // ????????????????????????????????????  
				        comment.setCustomer(customer); // ???????????????????????????  
					   buildReplyComment(comment, replys, offset, maxs);
					}		
			dinfo.get(i).setTcomment(findCommentByItemId);
			   List<Zan> tem=izan.selectbyFdid(dinfo.get(i).getDid());
			   dinfo.get(i).setSendwords(dinfo.get(i).getSendwords().trim());
			   dinfo.get(i).setDinazansize(tem.size());
			   dinfo.get(i).setDianzan(tem);
			   Fuser us=ifuser.selectbyid(dinfo.get(i).getFuid());
			   if(dinfo.get(i).getSendimage()!=null){
				   if(dinfo.get(i).getSendimage().contains("city")){
				
					     String str="|"+dinfo.get(i).getSendimage();
					     dinfo.get(i).setSendimage(str);
				   }else{
			  String[] ary1=dinfo.get(i).getSendimage().split("-");
			  Object[]ary=new String[ary1.length+1];
			for(int j=0;j<ary1.length;j++){
				ary[j]=DynamicInfo.imagebase+us.getFuid()+"/-"+ary1[j];
			}
			  String str1=StringUtils.join(ary, "|");
			 
			  dinfo.get(i).setSendimage(str1);
				   }
			   }
			   dinfo.get(i).setFname(us.getFname());
			   if(us.getFheadimage()!=null)
			     dinfo.get(i).setImagehead(new String(DynamicInfo.imagebase+us.getFuid()+"/"+us.getFheadimage()));
			   
		
		   }
		
		   return dinfo;
	}
		private List<DynamicInfo> fenzhuang(Map<String, Object> param,String s){
			 List<DynamicInfo> dinfo=null;
			if("selectallowinfo".equals(s)){
			 dinfo=idy.selectallowinfo(param);
			}else
				if("selectdybyid".equals(s)){
					dinfo=idy.selectdybyid(param);
				}
			
			   for(int i=0;i<dinfo.size();i++){
					 Map<String, Object> paramT = new HashMap<String, Object>(); 
						//??????in???????????? 
						paramT.put("pid",dinfo.get(i).getDid()); 
						paramT.put("offset",0);
						paramT.put("maxs",9);
						paramT.put("result",OracleTypes.CURSOR); 
						List <TComment> findCommentByItemId=fservice.findParentCommentByItemId(paramT);
						for(TComment comment : findCommentByItemId){ 
							List<TComment> replys = new ArrayList<TComment>(); // ????????????????????????  
					        comment.setReplyComment(replys); // ???????????????????????????  
					        String customerId = comment.getCustomerId(); // ?????????????????????Id  
					        Fuser customer = ifuser.selectbyid(customerId); // ??????????????????Id????????????????????????  
					        if(customer.getFheadimage()!=null){
					        customer.setFheadimage(DynamicInfo.imagebase+customer.getFuid()+"/"+customer.getFheadimage());
					     
					        }else
					        {
					        	customer.setFheadimage("http://localhost:8080/img/face/head_male_man_user_64px_1578_easyicon.net.png");
					        }
					        if(customer != null) customer.setFpassword(null);; // ????????????????????????????????????  
					        comment.setCustomer(customer); // ???????????????????????????  
						   buildReplyComment(comment, replys, 0, 9);
						}		
				dinfo.get(i).setTcomment(findCommentByItemId);
				   List<Zan> tem=izan.selectbyFdid(dinfo.get(i).getDid());
				   dinfo.get(i).setSendwords(dinfo.get(i).getSendwords().trim());
				   dinfo.get(i).setDinazansize(tem.size());
				   dinfo.get(i).setDianzan(tem);
				   Fuser us=ifuser.selectbyid(dinfo.get(i).getFuid());
				   if(dinfo.get(i).getSendimage()!=null){
					 if(dinfo.get(i).getSendimage().contains("city")){
						 System.out.println(dinfo.get(i).getSendimage());
					     String str="|"+dinfo.get(i).getSendimage();
					     dinfo.get(i).setSendimage(str);
				   }else
				   {
					   String[] ary1=dinfo.get(i).getSendimage().split("-");
						  Object[]ary=new String[ary1.length+1];
						for(int j=1;j<ary1.length;j++){
							ary[j]=DynamicInfo.imagebase+us.getFuid()+"/-"+ary1[j];
							
						}
						  String str1=StringUtils.join(ary, "|");
					
						  dinfo.get(i).setSendimage(str1);	
				   }
				   }
				   dinfo.get(i).setFname(us.getFname());
				   if(us.getFheadimage()!=null){
				     dinfo.get(i).setImagehead(new String(DynamicInfo.imagebase+us.getFuid()+"/"+us.getFheadimage()));
				   }else
				   {
					   dinfo.get(i).setImagehead("http://localhost:8080/img/face/head_male_man_user_64px_1578_easyicon.net.png");
				   }
			
			   }
			   return dinfo;
		}
		 private void buildReplyComment(TComment comment, List<TComment> replys, int offset, int limit){ 
				Map<String, Object> param = new HashMap<String, Object>(); 
				//??????in???????????? 
				param.put("pid",comment.getId()); 
				param.put("offset",offset);
				param.put("maxs",limit);
				param.put("result",OracleTypes.CURSOR); 
		        List<TComment> replyComments =fservice.findReplyCommentByCommentId(param); // ???????????????????????????  
		        replys.addAll(replyComments); // ????????????????????????????????????????????????????????????  
		        for(TComment c : replyComments){ // ????????????????????????  
		            String customerId = c.getCustomerId(); // ??????????????????id  
		            Fuser replyCustomer = ifuser.selectbyid(customerId); // ?????????????????????  
		            if(replyCustomer != null) replyCustomer.setFpassword(null);// ?????????????????????????????????  
		            if(replyCustomer.getFheadimage()!=null){
		            	replyCustomer.setFheadimage(DynamicInfo.imagebase+replyCustomer.getFuid()+"/"+replyCustomer.getFheadimage());
		            }else
		            {
		            	replyCustomer.setFheadimage("http://localhost:8080/img/face/head_male_man_user_64px_1578_easyicon.net.png");
		            }
		            Fuser customer =ifuser.selectbyid(comment.getCustomerId()); // ????????????????????????  
		            if(customer.getFheadimage()!=null){
				        customer.setFheadimage(DynamicInfo.imagebase+customer.getFuid()+"/"+customer.getFheadimage());
				        }else
				        {
				        	customer.setFheadimage("http://localhost:8080/img/face/head_male_man_user_64px_1578_easyicon.net.png");
				        }
		            c.setCustomer(customer); // ????????????????????????  
		            c.setReplyCustomer(replyCustomer); // ????????????????????????  
		            buildReplyComment(c, replys, offset, limit); // ????????????  
		        }  
	    }
	
}
