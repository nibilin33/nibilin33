package com.fase.controller;

import java.io.File;
import java.io.IOException;
import java.io.Writer;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ModelAndView;

import util.GenImage;

import com.fase.iservice.Idynamicinfo;
import com.fase.mapper.DynamicInfoMapper;
import com.fase.po.DynamicInfo;
import com.fase.po.Fuser;
import com.sun.jmx.snmp.Timestamp;

@Controller
@RequestMapping(value="/fdynamiccontrol")
public class FDynamicControl {
	@Resource
	private Idynamicinfo dydao;
	private List<DynamicInfo> temp=new ArrayList<DynamicInfo>();
	
	@RequestMapping(value="/file2.action")
	public ModelAndView Upmessage(@RequestParam("sendwords")String sendwords,HttpServletRequest request){
		String isvisiable=request.getParameter("isvisiable");
		String fuid=request.getParameter("fuid");
		String sendimage=request.getParameter("bigimage");
		BigDecimal b=null;
		int count=0;
		for(int i=0;i<temp.size();i++){
			
			if(temp.get(i).getFuid().equals(fuid)){
				count++;
				if(count==1){
				sendimage=temp.get(i).getSendimage();
				}
				else
				{
					sendimage+=temp.get(i).getSendimage();
				}
			}
		}
		temp=null;
		temp=new ArrayList<DynamicInfo>();
		DynamicInfo one=new DynamicInfo();
	
		if(isvisiable.equals("??????")){
			b=new BigDecimal(0);
		}else if("??????".equals(isvisiable)){
			b=new BigDecimal(1);
		}else if("????????????".equals(isvisiable)){
			b=new BigDecimal(2);
		}
		one.setFuid(fuid);
		one.setSendwords(sendwords.trim());
		one.setSendtime(new Date());
		one.setSendimage(sendimage);
		one.setIsvisiable(b);
		dydao.insertIntody(one);
		return new ModelAndView("redirect:/user/show.action?fuid="+fuid);
	}
	@RequestMapping(value ="/{fuid}/city.action")
	public void city(HttpServletResponse res,@PathVariable("fuid")String fuid,HttpServletRequest re){
		String sendimage=re.getParameter("im");
		DynamicInfo one=new DynamicInfo();
		one.setFuid(fuid);
		one.setSendwords("???????????????");
		one.setSendtime(new Date());
		one.setSendimage(sendimage);
	int n=	dydao.insertIntody(one);
	if(n==1){
		try {
			res.getWriter().print("success");
		} catch (IOException e) {
			// TODO ??????????????? catch ???
			e.printStackTrace();
		}
	}else
	{
		try {
			res.getWriter().print("wrong");
		} catch (IOException e) {
			// TODO ??????????????? catch ???
			e.printStackTrace();
		}
	}
		
	}
    @RequestMapping(value="/timeline.action")
    public ModelAndView timeline(@RequestParam("sendwords")String sendwords,HttpServletRequest request){
		String isvisiable=request.getParameter("isvisiable");
		String fuid=request.getParameter("fuid");
		String sendimage=request.getParameter("bigimage");
		BigDecimal b=null;
		int count=0;
		for(int i=0;i<temp.size();i++){
			
			if(temp.get(i).getFuid().equals(fuid)){
				count++;
				if(count==1){
				sendimage=temp.get(i).getSendimage();
				}
				else
				{
					sendimage+=temp.get(i).getSendimage();
				}
			}
		}
		DynamicInfo one=new DynamicInfo();
	
		if(isvisiable.equals("??????")){
			b=new BigDecimal(0);
		}else if("??????".equals(isvisiable)){
			b=new BigDecimal(1);
		}else if("????????????".equals(isvisiable)){
			b=new BigDecimal(2);
		}
		one.setFuid(fuid);
		one.setSendwords(sendwords.trim());
		one.setSendtime(new Date());
		one.setSendimage(sendimage);
		one.setIsvisiable(b);
		dydao.insertIntody(one);
		return new ModelAndView("redirect:/user/"+fuid+".action");
    }
	@RequestMapping(value="/delete.action")
	public void deimage(HttpServletRequest request, HttpServletResponse response){
		String uid=request.getParameter("uid");
		String fid=request.getParameter("fid");
		for(int i=0;i<temp.size();i++){
			if(temp.get(i).getFuid().equals(uid)&&temp.get(i).getSendimage().equals(fid)){
				temp.remove(i);
			}
		}
		String path="E:/"+uid+"/"+fid;
		File file=new File(path);
		if (file.exists()) {// ??????????????????,??????????????????
                file.delete();
            }
		response.setCharacterEncoding("utf-8");
        response.setContentType("text/html; charset=" + "utf-8");
        Writer writer = null;
        try {
            writer = response.getWriter();
            writer.write("success");
            writer.flush();
            writer.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            IOUtils.closeQuietly(writer);
        }
	}
	
	@RequestMapping(value="/file1.action")
	public void upimage(HttpServletRequest request, HttpServletResponse response) throws IllegalStateException, IOException{
		 // ???????????????????????????????????????
	    String username=request.getParameter("uid");
	    DynamicInfo te=new DynamicInfo();
	    te.setFuid(username);
	   
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
                    System.out.println(myFileName);
                  
                    // ????????????????????????,??????????????????????????????????????????????????????
                    if (myFileName.trim() != "") {
                   
                        // ??????????????????????????????
                    	 String fileName =""+pre+"."+str;
                      
                     
                        // ??????????????????
                        String path = "E:/img/" +username;
                        System.out.println(path);
                        File localFilew = new File(path);
                        if(!localFilew.exists()&&!localFilew.isDirectory()){
                        	localFilew.mkdir();
                        }
                        File localFile=new File(path+"/"+ fileName);
                        record=fileName;
                        file.transferTo(localFile);
                    }
                }
                // ?????????????????????????????????
                int finaltime = (int) System.currentTimeMillis();
                System.out.println(finaltime - pre);
            }

        }
        System.out.println(record+"????????????");
         te.setSendimage(record);
         temp.add(te);
        responseMessage(response,record);
	}

	 private void responseMessage(HttpServletResponse response,String filename) {
	        response.setCharacterEncoding("utf-8");
	        response.setContentType("text/html; charset=" + "utf-8");
	        Writer writer = null;
	        try {
	            writer = response.getWriter();
	            writer.write("{\"code\":" + 200 + ",\"message\":\"" + filename
	                    + "\"}");
	            writer.flush();
	            writer.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            IOUtils.closeQuietly(writer);
	        }
	    }
      
	
}
