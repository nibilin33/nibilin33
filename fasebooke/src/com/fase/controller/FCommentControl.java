package com.fase.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;
import oracle.jdbc.driver.OracleTypes;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fase.iservice.Icommentservice;
import com.fase.iservice.Ileave;
import com.fase.mapper.FuserMapper;
import com.fase.po.Askpermission;
import com.fase.po.DynamicInfo;
import com.fase.po.Fuser;
import com.fase.po.Helpcenter;
import com.fase.po.Leavenote;
import com.fase.po.TComment;
import com.fase.service.imp.Fcomment;

@Controller
@RequestMapping(value="/comment")
public class FCommentControl {

	@Resource
	private Icommentservice fservice;
	@Resource
	private FuserMapper fuservice;
	@Resource
	private Ileave ileveservice;
	@RequestMapping (value="/{fuid}/seenote.action")
	public ModelAndView seenote(@PathVariable("fuid")String fuid,HttpServletRequest re){
		ModelAndView mv=new ModelAndView();
		HttpSession s=re.getSession();
		Fuser us=(Fuser) s.getAttribute("current_user");
		if(us==null){
		  us=fuservice.selectByPrimaryKey(fuid);
	      s.setAttribute("current_user", us);
		}
		List<Leavenote> note=ileveservice.selectbyfuid(fuid);
		for(int i=0;i<note.size();i++){
			note.get(i).setFcount( fuservice.selectByPrimaryKey(note.get(i).getLfuid()).getFcount());
		}
		System.out.println(note.size()+"iiiiiiiiii");
		mv.addObject("note", note);
		mv.setViewName("leavenote");
		return mv;
	}
	@RequestMapping (value="/{visitfuid}/{fuid}/toseenote.action")
	public ModelAndView toseenote(@PathVariable("fuid")String fuid,@PathVariable("visitfuid")String visitfuid,HttpServletRequest re){
		ModelAndView mv=new ModelAndView();
		HttpSession s=re.getSession();
		Fuser us=(Fuser) s.getAttribute("current_user");
		if(us==null){
		  us=fuservice.selectByPrimaryKey(fuid);
	      s.setAttribute("current_user", us);
		}
		Fuser vi=fuservice.selectByPrimaryKey(visitfuid);
		s.setAttribute("visit", vi);
		List<Leavenote> note=ileveservice.selectbyfuid(visitfuid);
		for(int i=0;i<note.size();i++){
			note.get(i).setFcount( fuservice.selectByPrimaryKey(note.get(i).getLfuid()).getFcount());
		}
	   
		mv.addObject("note", note);
		mv.setViewName("leavenotetosee");
		return mv;
	}
	@RequestMapping (value="/addnote.action")
	public void addnote(@RequestBody Leavenote le,HttpServletResponse response){
	
	    int n=   ileveservice.insertIleve(le);
	  
	       if(n==1){
	    	   try {
				response.getWriter().print("sucuss");
			} catch (IOException e) {
				// TODO ??????????????? catch ???
				e.printStackTrace();
			}
	       }else
	       {
	    	   try {
				response.getWriter().print("wrong")  ;
			} catch (IOException e) {
				// TODO ??????????????? catch ???
				e.printStackTrace();
			}
	       }
	}
	@RequestMapping(value="/dycomment.action")
public ModelAndView findCommentByItemId(HttpServletRequest request, HttpServletResponse response){
   String parentid=request.getParameter("contentid");
   String fuid=request.getParameter("fuid");
   Map<String, Object> param = new HashMap<String, Object>(); 
	//??????in???????????? 
	param.put("pid",parentid); 
	param.put("offset",0);
	param.put("maxs",9);
	param.put("result",OracleTypes.CURSOR); 
	List <TComment> findCommentByItemId=fservice.findParentCommentByItemId(param);
	for(TComment comment : findCommentByItemId){ 
		List<TComment> replys = new ArrayList<TComment>(); // ????????????????????????  
        comment.setReplyComment(replys); // ???????????????????????????  
        String customerId = comment.getCustomerId(); // ?????????????????????Id  
        Fuser customer = fuservice.selectByPrimaryKey(customerId); // ??????????????????Id????????????????????????  
        if(customer != null) customer.setFpassword(null);; // ????????????????????????????????????  
        comment.setCustomer(customer); // ???????????????????????????  
	     buildReplyComment(comment, replys, 0, 9);
	}
	HttpSession s=request.getSession();
	s.setAttribute("itemComments", findCommentByItemId);
/*	JSONObject json=new JSONObject();
	json.put("itemComments", findCommentByItemId);
	 try {
  	   response.setContentType("application/json");
         response.setHeader("Pragma", "No-cache");
         response.setHeader("Cache-Control", "no-cache");
         response.setCharacterEncoding("UTF-8");
		  response.getWriter().print(json);
	} catch (IOException e) {
		// TODO ??????????????? catch ???
		e.printStackTrace();
	} */
	return  new ModelAndView("redirect:/user/show.action?fuid="+fuid);
	}
	@RequestMapping(value="/reply.action")
	public void reply(@RequestBody TComment ask,HttpServletResponse response){
	Integer s=	fservice.InsertComment(ask);
	       try {
	           response.setHeader("Pragma", "No-cache");
	           response.setHeader("Cache-Control", "no-cache");
	           response.setCharacterEncoding("UTF-8");
			  response.getWriter().print(ask.getId());
		} catch (IOException e) {
			// TODO ??????????????? catch ???
			e.printStackTrace();
		} 
	     
	}
	 private void buildReplyComment(TComment comment, List<TComment> replys, int offset, int limit){ 
			Map<String, Object> param = new HashMap<String, Object>(); 
			//??????in???????????? 
			param.put("pid",comment.getId()); 
			param.put("offset",0);
			param.put("maxs",9);
			param.put("result",OracleTypes.CURSOR); 
	        List<TComment> replyComments =fservice.findReplyCommentByCommentId(param); // ???????????????????????????  
	        replys.addAll(replyComments); // ????????????????????????????????????????????????????????????  
	        for(TComment c : replyComments){ // ????????????????????????  
	            String customerId = c.getCustomerId(); // ??????????????????id  
	            Fuser replyCustomer = fuservice.selectByPrimaryKey(customerId); // ?????????????????????  
	            if(replyCustomer != null) replyCustomer.setFpassword(null);// ?????????????????????????????????  
	            if(replyCustomer.getFheadimage()!=null){
	            	replyCustomer.setFheadimage(DynamicInfo.imagebase+replyCustomer.getFuid()+"/"+replyCustomer.getFheadimage());
	            }else
	            {
	            	replyCustomer.setFheadimage("http://localhost:8080/img/face/head_male_man_user_64px_1578_easyicon.net.png");
	            }
	            Fuser customer =fuservice.selectByPrimaryKey(comment.getCustomerId()); // ????????????????????????  
	            c.setCustomer(customer); // ????????????????????????  
	            c.setReplyCustomer(replyCustomer); // ????????????????????????  
	            buildReplyComment(c, replys, offset, limit); // ????????????  
	        }  
    }
}