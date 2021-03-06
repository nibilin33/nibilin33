<%@ page language="java" import="java.util.*,net.sf.json.*,com.fase.po.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ page import="org.springframework.web.util.UrlPathHelper" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
      
       <base href="<%=basePath%>">
        <meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
        <meta charset="utf-8">
        <title>fasebooke</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <link href="<%=request.getContextPath()%>/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <!--[if lt IE 9]>
          <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
   <link href="<%=request.getContextPath()%>/resources/css/facebook.css" rel="stylesheet" type="text/css"/>
         <link href="http://cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.css" rel="stylesheet" type="text/css"/>
        <link rel="shortcut icon" href="<%=request.getContextPath()%>/resources/img/facebook_128px_1160395_easyicon.net.ico"/>
      <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script> 
      <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/styles.css">
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/diyUpload/css/webuploader.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/diyUpload/css/diyUpload.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/diyUpload/js/webuploader.html5only.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/diyUpload/js/diyUpload.js"></script>
           <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/main.js"></script>
           <script type="text/javascript">
           window.email=new Array();
           window.yeshu=1;
        
           window.userarray=new Array();
           </script>
   <style>
 
   #chat-messages{
	opacity:0;
	margin-top:30px;
	width:290px;
	height:320px;
	overflow-y:scroll;	
	overflow-x:hidden;
	padding-right: 20px;
 	-webkit-transition: all 200ms cubic-bezier(0.000, 0.995, 0.990, 1.000);
	   -moz-transition: all 200ms cubic-bezier(0.000, 0.995, 0.990, 1.000);
	    -ms-transition: all 200ms cubic-bezier(0.000, 0.995, 0.990, 1.000);
	     -o-transition: all 200ms cubic-bezier(0.000, 0.995, 0.990, 1.000);
	        transition: all 200ms cubic-bezier(0.000, 0.995, 0.990, 1.000); 
}
#chat-messages.animate{
	opacity:1;
	margin-top:0;
}
#chat-messages label{
	color:#aab8c2;
	font-weight:600;
	font-size:12px;
	text-align:center;
	margin:15px 0;
	width:290px;
	display:block;	
}
#chat-messages div.message{
	padding:0 0 30px 58px;
	clear:both;
	margin-bottom:45px;
}
#chat-messages div.message.right{
	  padding: 0 58px 30px 0;
	  margin-right: -19px;
	  margin-left: 19px;
}
#chat-messages .message img{
	  float: left;
	  margin-left: -38px;
	  border-radius: 50%;
	  width: 30px;
	  margin-top: 12px;
}
#chat-messages div.message.right img{
	float: right;	
    margin-left: 0;
	margin-right: -38px;	
}
.message .bubble{	
	background:#f0f4f7;
	font-size:13px;
	font-weight:600;
	padding:12px 13px;
	border-radius:5px 5px 5px 0px;
	color:#8495a3;
	position:relative;
	float:left;
}
  .floatingImg{
	width:40px;
	border-radius:50%;
	position:absolute;
	top:0;
	left:12px;
	border:3px solid #fff;
} 
#chatview{
	width:290px;
	height:484px;
	position:absolute;
	top:0;
	left:5px;	
	display:none;
	background:#fff;
}
#profile{
	height:153px;
	overflow:hidden;
	text-align:center;
	color:#fff;
}
.p1 #profile{
	background:#fff url("http://localhost:8080/img/face/timeline1.png") 0 0 no-repeat;
}
#profile .avatar{
	width:68px;
	border:3px solid #fff;
	margin:23px 0 0;
	border-radius:50%;
}
#profile  p{
	font-weight:600;
	font-size:15px;
	margin:118px 0 -1px;
	opacity:0;
	-webkit-transition: all 200ms cubic-bezier(0.000, 0.995, 0.990, 1.000);
	   -moz-transition: all 200ms cubic-bezier(0.000, 0.995, 0.990, 1.000);
	    -ms-transition: all 200ms cubic-bezier(0.000, 0.995, 0.990, 1.000);
	     -o-transition: all 200ms cubic-bezier(0.000, 0.995, 0.990, 1.000);
	        transition: all 200ms cubic-bezier(0.000, 0.995, 0.990, 1.000);	
}
#profile  p.animate{
	margin-top:97px;
	opacity:1;
	-webkit-transition: all 200ms cubic-bezier(0.000, 0.995, 0.990, 1.000);
	   -moz-transition: all 200ms cubic-bezier(0.000, 0.995, 0.990, 1.000);
	    -ms-transition: all 200ms cubic-bezier(0.000, 0.995, 0.990, 1.000);
	     -o-transition: all 200ms cubic-bezier(0.000, 0.995, 0.990, 1.000);
	        transition: all 200ms cubic-bezier(0.000, 0.995, 0.990, 1.000);	
}
#profile  span{
	font-weight:400;
	font-size:11px;
}
#close {
    position: absolute;
    top: 8px;
    opacity: 0.8;
    right: 10px;
    width: 20px;
    height: 20px;
    cursor: pointer;
}
#close:hover{
	opacity:1;
}
.cx,.cy{
	background:#fff;
	position:absolute;
	width:0px;
	top:15px;
	right:15px;
	height:3px;
	-webkit-transition: all 250ms ease-in-out;
	   -moz-transition: all 250ms ease-in-out;
		-ms-transition: all 250ms ease-in-out;
		 -o-transition: all 250ms ease-in-out;
			transition: all 250ms ease-in-out;
}
.cx.s1, .cy.s1{	
	right:0;	
	width:20px;	
	-webkit-transition: all 100ms ease-out;
	   -moz-transition: all 100ms ease-out;
		-ms-transition: all 100ms ease-out;
		 -o-transition: all 100ms ease-out;
			transition: all 100ms ease-out;
}
.cy.s2{	
	-ms-transform: rotate(50deg); 
	-webkit-transform: rotate(50deg); 
	transform: rotate(50deg);		 
	-webkit-transition: all 100ms ease-out;
	   -moz-transition: all 100ms ease-out;
		-ms-transition: all 100ms ease-out;
		 -o-transition: all 100ms ease-out;
			transition: all 100ms ease-out;
}
.zuobian {
    margin-top: -11px;
    margin-left: 40px;
    color: darkgray;
}
.cy.s3{	
	-ms-transform: rotate(45deg); 
	-webkit-transform: rotate(45deg); 
	transform: rotate(45deg);		 
	-webkit-transition: all 100ms ease-out;
	   -moz-transition: all 100ms ease-out;
		-ms-transition: all 100ms ease-out;
		 -o-transition: all 100ms ease-out;
			transition: all 100ms ease-out;
}
.cx.s1{	
	right:0;	
	width:20px;	
	-webkit-transition: all 100ms ease-out;
	   -moz-transition: all 100ms ease-out;
		-ms-transition: all 100ms ease-out;
		 -o-transition: all 100ms ease-out;
			transition: all 100ms ease-out;
}
.cx.s2{	
	-ms-transform: rotate(140deg); 
	-webkit-transform: rotate(140deg); 
	transform: rotate(140deg);		 
	-webkit-transition: all 100ms ease-out;
	   -moz-transition: all 100ms ease-out;
		-ms-transition: all 100ease-out;
		 -o-transition: all 100ms ease-out;
			transition: all 100ms ease-out;
}
.cx.s3{	
	-ms-transform: rotate(135deg); 
	-webkit-transform: rotate(135deg); 
	transform: rotate(135deg);		 
	-webkit-transition: all 100ease-out;
	   -moz-transition: all 100ms ease-out;
		-ms-transition: all 100ms ease-out;
		 -o-transition: all 100ms ease-out;
			transition: all 100ms ease-out;
}
    .wrap .panel-heading{
           background: #009688;
        color: #fff;
       }
      
.wrap {

  border-radius: 4px;
}
#demo{ margin:50px auto; width:340px; min-height:200px; background:#CF9}
    .wrap .panel-heading{
    background: #009688;
        color: #fff;
       }
       body{font-size:14px;font-family:"????????????";background:url("http://localhost:8080/img/face/2.jpg")top no-repeat;background-attachment:fixed;z-index:0;background-size:100%;}
       a{  color: black;
         }


</style>
    </head><body>
<!--head-->
   <div class="wrapper">
				<div style="width:100%" >
	<div class="navbar navbar-blue navbar-static-top" style="height:50px">  
							<div class="navbar-header">
							  <button class="navbar-toggle" type="button" data-toggle="collapse" data-target=".navbar-collapse">
								<span class="sr-only">Toggle</span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
							  </button>
							  <a href="" class="navbar-brand logo">f</a>
							</div>
							<nav class="collapse navbar-collapse" role="navigation">
							<form class="navbar-form navbar-left" method="post" action="/fasebooke/user/${current_user.fuid}/plusfd.action">
								<div class="input-group input-group-sm" style="max-width:360px;">
								  <input class="form-control" placeholder="?????????" name="srch-term" id="srch-term" type="text">
								  <ul name="EngineModel" style="height: auto;width:305px; margin-left: 20px; position: absolute; display: none;background:-webkit-gradient(linear, left top, left 25, from(#FFFFFF), color-stop(4%, #EEEEEE), to(#FFFFFF))"></ul>
								  <div class="input-group-btn">
									<button class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i></button>
								  </div>
								</div>
							</form>
							<ul class="nav navbar-nav">
                          <li>
                             <a href="http://localhost:8080/fasebooke/user/${current_user.fuid}.action">   <c:choose>
                             <c:when test="${!empty current_user.fheadimage}">
                             <img src="http://localhost:8080/img/${current_user.fuid}/${current_user.fheadimage}" style="border: 1px solid rgba(0, 0, 0, .1);width:24px;height:24px"><span>${current_user.fname}</span>
                            </c:when>
                            <c:otherwise>
                             <img src="http://localhost:8080/img/face/head_male_man_user_64px_1578_easyicon.net.png" style="border: 1px solid rgba(0, 0, 0, .1);width:24px;height:24px"><span>${current_user.fname}</span>
                            </c:otherwise>
                            </c:choose>
                             </a>
                          </li>
							  <li>
								<a href="http://localhost:8080/fasebooke/user/show.action?fuid=${current_user.fuid }">
								<i class="glyphicon glyphicon-home"></i> ??????</a>
							  </li>
							 
							  <li>
							    
								<a href="javascript:;" title="??????" onclick="opennotice(this)" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><span class="fa fa-comments"></span></a>
								<ul class="dropdown-menu" role="menu"> </ul>
							  </li>
							  <li>
							  <li>
							<a  href="javascript:;" onclick="openbroadcast(this)" title="??????" > <span class="glyphicon glyphicon-globe"></span></a>
                          <ul class="dropdown-menu" role="menu"> </ul> 
							  </li>
				
							  </li>
							</ul>
							<ul class="nav navbar-nav navbar-right">
                        		<!-- 			???????????????
							 -->
                          <li>
                            <a href="javascript:;" onclick="openL(this)"><div style="width:10px;height:100%"><img src="<%=request.getContextPath()%>/resources/img/secret.png"></div></a>
                          <ul style="width:380px ;display:none;z-index:9999;position:absolute;top:60px;left:-350px;background:#3B5999" >
<li><a href="javascript:;" style="padding:0"><div style="background-color:#3b5998;">
<span class="glyphicon glyphicon-eye-close" style="padding-left:10px;padding-right:10px;color:white"></span>
<div style="display: inline-block;margin-left:10px">
<h5 style="color:white">??????????????????</h5>
</div>
<div style="display: inline-block;margin-left:145px">
<img src="<%=request.getContextPath()%>/resources/img/secretcheck.png" style="margin-top:-90px">
</div>
</div></a></li>
<li> <a href="#demo" style="padding:0" data-toggle="collapse"><span class="glyphicon glyphicon-globe" style="padding-left:10px;padding-right:10px"></span>
<div style="display:inline-block">
<h5>????????????????????????</h5>
</div>
<div style="display: inline-block;margin-left:50%">
<span class="caret"></span>

</div>
</a>
<div id="demo" class="collapse" style="margin:0;background:transparent;min-height:0">

<ul style="padding:0;margin:0">

<li class="yinsi">
<i class="fa fa-shield"></i> 
<div class="zuobian" >
<p>?????????????????????????????????</p>
<div class="dropdown pull-left" style="margin-right:2px">
<button class="btn btn-sm dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
<span class="glyphicon glyphicon-globe">??????</span>
<span class="caret"></span>
</button>
<ul class="dropdown-menu" aria-labelledby="dropdownMenu1" id="timeline" style="color:darkgray;text-align:center">
<li><span class="glyphicon glyphicon-globe"><a href="javascript:;">??????</a></span></li>
<li><span class="fa fa-user"><a href="javascript:;">??????</a></span>
</li>
<li><span class="fa  fa-unlock-alt"><a href="javascript:;">????????????</a></span></li>
</ul>
</div>
</div>
</li>
<li class="yinsi">
<i class="fa fa-eye"></i>
<div class="zuobian">
<p>????????????????????????????????????????????????</p>
<a href="http://localhost:8080/fasebooke/user/${current_user.fuid}/${current_user.fuid}.action" style="display:block;margin:10px">????????????</a>
</div>
</li>

</ul>

</div>

</li>
<li><a href="#demo2"style="padding:0" data-toggle="collapse"><span class="fa fa-group" style="padding-left:10px;padding-right:10px"></span>
<div style="display:inline-block">
<h5>?????????????????????</h5>
</div>
<div style="display: inline-block;margin-left:50%">
<span class="caret"></span>

</div>
</a>
<div id="demo2" class="collapse">

<ul style="padding:0;margin:0">

<li class="yinsi">
<i class="fa  fa-plus"></i> 
<div class="zuobian" >
<p>???????????????????????????????????????</p>
<div class="dropdown pull-left" style="margin-right:2px">
<button class="btn btn-sm dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
<span class="glyphicon glyphicon-globe">??????</span>
<span class="caret"></span>
</button>
<ul class="dropdown-menu" aria-labelledby="dropdownMenu1" id="befriend" style="color:darkgray;text-align:center">
<li>
<span class="glyphicon glyphicon-globe"><a href="javascript:;">??????</a></span></li>
<li>
<span class="fa  fa-users"><a href="javascript:;">???????????????</a></span></li>
</ul>
</div>
</div>
</li>


</ul>

</div>
</li>

<li><a href="#demo3"style="padding:0" data-toggle="collapse"><span class="glyphicon glyphicon-minus-sign" style="padding-left:10px;padding-right:10px"></span> <div style="display:inline-block">
<h5>??????????????????????????????</h5>
</div>
<div style="display: inline-block;margin-left:43%">
<span class="caret"></span>

</div></a>
<div id="demo3" class="collapse" style="margin-bottom:10px">

<ul style="padding:0;margin:0">

<li class="yinsi">
<i class="fa  fa-minus-circle"></i> 
<div class="zuobian" >
<p>???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????</p>
<input type="text" placeholder="????????????????????????"><button type="button" onclick="lahei(this)">??????</button>
</div>
</li>


</ul>

</div>

</li>
</ul>
                          </li>
                          
             <!-- 			???????????????
							                                    -->   
                            
                            
							  <li class="dropdown">
								<a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-sort-desc"></i></a>
								<ul class="dropdown-menu">
								 
								   <li  role="separator" class="divider"></li>
								  <li><a href="/fasebooke/user/out/${current_user.fuid}.action">??????</a></li>
								
								   <li  role="separator" class="divider"></li>
								  <li><a href="http://localhost:8080/fasebooke/user/helpcenter.action?fuid=${current_user.fuid}">????????????</a></li>
								</ul>
							  </li>
							</ul>
							</nav>
						</div>

<!--  headnext-->
  
 <div class="imagrap" id="imagewrap">
  <script>
 var bk='${current_user.fbackimage}';
 if(bk!=''){
	 $('#imagewrap').removeClass("imagrap").addClass("imagrap2");
 $('#imagewrap').css("background",'url("'+bk+'") no-repeat 0px 55px');
 $('#imagewrap').css("background-size","cover");
 }
 </script>
    <a href="javascript:;" class="_30x-">
          
     <div  class="_30x">
      <span class="fa  fa-camera" style="color:white"></span>
         <span>??????????????????</span>
           <input type="file" id="imagefile2" style="position:relative;opacity:0;position:relative;opacity:0;margin-top:-20px" onchange="backimage(this)"title="????????????" name="sendimage" accept="image/*" >
     </div>
     </a>
     <img class="pic" src="http://localhost:8080/img/${current_user.fuid}/${current_user.fheadimage}">
     <span style="color:white;font-size:30px;">${current_user.fname}</span>
 </div>
  <div class="container" style="margin-left:20%;min-height:41px">

  <div class="col-md-12">
<ul class="lead nav nav-pills">
  <li >
  <a href="http://localhost:8080/fasebooke/user/${current_user.fuid}.action">?????????</a></li><li><a href="http://localhost:8080/fasebooke/jian/${current_user.fuid}/firstin.action">??????</a></li><li class="active"><a href="http://localhost:8080/fasebooke/friend/${current_user.fuid}/myfreind.action">??????</a></li><li><a href="http://localhost:8080/fasebooke/picture/${current_user.fuid}/fuck.action">??????</a></li> 
   <li><a href="http://localhost:8080/fasebooke/user/${current_user.fuid}/checkin.action">??????</a></li>
   </ul>
  </div>
  </div>


<!--   container-->

 <div class="container">
     <div class="row">
         <div class="panel panel-default">
             <div class="panel-heading">
                 <i class="glyphicon glyphicon-user" style="font-size:30px; color:gray"></i><span style="font-size:30px;color:gray">??????</span>
                 <div class="btn-group" style="float:right">
              <a href="#" class="btn btn-default"><i class="glyphicon glyphicon-pencil"></i></a>
            </div>
             </div>
             <div class="panel-body">
              <div class="col-md-4 col-sm-6">
                  <div class="panel-group wrap" id="bs-collapse">
                      <div class="panel" style="width:280px">
                          <div class="panel-heading" id="topmenu">
                              <h4 class="panel-title">
			<a data-toggle="collapse" data-parent="#" href="#four">
			<span class="friends"></span>
			</a>
			
		  </h4>
                          </div>
                          <div id="four" class="panel-collapse collapse">
            <c:forEach items="${myfreind}" var="emp" varStatus="vs">
                  <c:forEach items="${emp.flist}" var="uf">
               
               <div class="friend" data="${uf.fuid }" onclick="seeMore(this)">
			     <SCRIPT TYPE="TEXT/JAVASCRIPT">
                 var  user={"fuid":'${uf.fuid}',"fname":'${uf.fname}',"fcount":'${uf.fcount}',"ftel":'${uf.ftel}',"femail":'${uf.femail}',"fliveplace":'${uf.fhome.lprovice}',"fplace":'${uf.fhome.lurl}',"fpersonal":'${uf.fpersonal}',"fbirthday":'${uf.fbirthday}'};
                  window.userarray.push(user);
                  </SCRIPT>
			  <p>
			  
			  	<c:choose>
			<c:when test="${!empty uf.fheadimage}">
		<img src="http://localhost:8080/img/${uf.fuid}/${uf.fheadimage}"  style="border: 1px solid rgba(0, 0, 0, .1);width:24px;height:24px" >
				</c:when>
					<c:otherwise>   
 			  <img src="http://localhost:8080/img/face/head_male_man_user_64px_1578_easyicon.net.png" style="border: 1px solid rgba(0, 0, 0, .1);width:24px;height:24px" data="${uf.fuid }" >
                </c:otherwise> 
				</c:choose>  

			  
			  
			  
			  <strong>${uf.fname }</strong><span>${uf.fcount}</span></p>
			
				
			<c:choose>
			<c:when test="${uf.fstate==1}">
				<div class="status available"></div>
				</c:when>
					<c:otherwise>   
  <div class="status inactive"></div> 
  </c:otherwise> 
			</c:choose>
			<c:forEach items="${heiming}" var="hei">
			<c:if test="${hei.bfuid==uf.fuid}">
			<a href="javascript:;" style="color:gray" data="${uf.fuid}" onclick="yichuhei(this)">????????????</a>
			</c:if>
			</c:forEach>
			  </div> 
                  </c:forEach>
			
                  </c:forEach> 
                       
                                                             <div id="search">
    <input type="text" id="searchfield">
</div>
                     </div>
       <!--               ?????? -->
   <div  id="chatview" class="p1" >
   <div id="profile" >
   <div id="close">
    <div class="cy s1 s2 s3"></div>
   <div class="cx s1 s2 s3"></div> 
   </div>
<!--  
   <p class="animate">00000000</p>
   <span>8888888</span> -->
   </div>
   <div id="chat-messages" class="animate">
     <label>????????????</label>
   <div class="message">
   <img src="http://localhost:8080/img/face/facebook.net.ico">
    <a href="" style="top:20px;position:relative;display:block"></a>
   </div>
   <div class="message">
   <img src="http://localhost:8080/img/face/phone_receiver_96px_1205960_easyicon.net.png">
   <div class="bubble">
  
   </div>
   </div>
   <div class="message">
   <img src="http://localhost:8080/img/face/Email_72.730223123732px_1195279_easyicon.net.png">
   <div class="bubble">
 
   </div>
   </div>
   <div class="message">
   <img src="http://localhost:8080/img/face/smiley_pencil_72px_1113041_easyicon.net.png">
   <div class="bubble">
    ???
   </div>
   </div>
    <div class="message">
   <img src="http://localhost:8080/img/face/MSN_birthday_64px_546054_easyicon.net.png">
   <div class="bubble">
  
   </div>
   </div>
   <div class="message">
   <img src="http://localhost:8080/img/face/City_Story_48px_537166_easyicon.net.png">
   <div class="bubble">
                       ???
   </div>
   </div>
   </div>
   <img src="" class="floatingImg" style="top: 20px; width: 68px; left: 108px;">
    </div>
      <!--               ?????? -->
                      </div>
                  </div>
  
              </div>
   
              <div class="col-md-8">
                <div class="sim ">
                  <ul id="otherInfoTab">
                      <li class="active"><a href="#email" data-toggle="tab"><span class="chats "></span></a></li>
                      <li>  <a href="#email2" data-toggle="tab"><span class="history"></span></a></li>
                  </ul>
                   
                 
                </div>
                <div class="tab-content">
                 <div class="tab-pane fade in active" id="email">
                   <form role="form" class="form-horizontal">
                      <div class="form-group"> 
        
                       </div>
                      <div class="form-group"> 
        <label for="lastname" class="col-sm-2 control-label">?????????</label> 
        <div class="col-sm-10">
          <input type="text" class="form-control" id="biaoti">
         </div>
       </div>
                              <div class="form-group"> 
        <label for="lastname" class="col-sm-2 control-label">????????????</label> 
        <div class="col-sm-10">
          <input type="text" class="form-control" id="recievename" placeholder="fasebooke????????????">
         </div>
       </div>
            <div class="form-group">
                <label for="lastname" class="col-sm-2 control-label">?????????</label> 
                <div class="col-sm-10">
                    <textarea class="form-control"  rows="8"  id="neirong">
                        
                    </textarea>
     
     
       </div>
           </div> 
           <div class="form-group">
           <button type="button" class="btn btn-primary" onclick="doemail()">  ??? ???</button>
            <div class="col-sm-10">
	<div id="as" style="margin-left:180px"> 
	</div>  
            </div>
                  </div>
                   </form>
                   </div>
                   <div class="tab-pane fade" id="email2">
                    <div class="_mytakenpicture" style="columns:1;position:relative;left:-150px" >
                   
                     
                       <ul class="list-group" style="min-width:600px">
                  <c:forEach items="${myemail}" var="em">
                  <script>
                  var obj={"eid":'${em.eid}',"fname":'${em.user.fname}',"sendtime":'${em.senttime}',"estate":"${em.estate}"};
                window.email.push(obj);
              
                  </script>
                 
              </c:forEach> 
             <script>
             ini();
             </script>
            </ul>
            
                  </div>
                    <div class="container">
        <div class="row">
          <div class="col-md-12">
            <ul class="pager">
              <li>
                <a href="javascript:;" id="shang" onclick="shangyiye()">???  ?????????</a>
              </li>
              <li>
                <a href="javascript:;" id="xia" onclick="xiayiye()">?????????  ???</a>
              </li>
            </ul>
          </div>
        </div>
      </div>
                   </div>
                </div>
              </div>
             </div>
           
    </div>
  
</div>
         </div>
 
 
 <!-- endcontainer -->
 <!-- wraper -->
 </div>
</div>
  <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/bootstrap.js"></script>
         <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/localsearch.js"></script>
        <script type="text/javascript">
     
         
        /*
        * ???????????????,????????????,??????????????????????????????jquery.ajax??????;
        * ???????????????WebUploader
        */


        $('#as').diyUpload({
        	url:'http://localhost:8080/fasebooke/picture/dofile.action',
        	success:function( data ) {
        		$('#as').append('<input type="hidden" value="'+data["filepath"]+'">');
        		console.info( data );
        	},
        	error:function( err ) {
        		console.info( err );	
        	},
        	buttonText : '????????????',
        	chunked:true,
        	// ????????????
        	chunkSize:512 * 1024,
        	//???????????????????????????, ???????????????,??????????????????(????????????);
        	fileNumLimit:50,
        	fileSizeLimit:500000 * 1024,
        	fileSingleSizeLimit:50000 * 1024,
        	accept: {}
        });
                    $(function() { 
            
                $('#otherInfoTab a:last').tab('show');//?????????????????????tab  
           
                $('#otherInfoTab a').click(function(e) {  
                    console.log("dddddddddd");
                    e.preventDefault();//??????a?????????????????????  
                    $(this).tab('show');//???????????????????????????????????????content  
                })  
            })  



 
$(document).ready(function() {
	$('[data-toggle=offcanvas]').click(function() {
		$(this).toggleClass('visible-xs text-center');
		$(this).find('i').toggleClass('glyphicon-chevron-right glyphicon-chevron-left');
		$('.row-offcanvas').toggleClass('active');
		$('#lg-menu').toggleClass('hidden-xs').toggleClass('visible-xs');
		$('#xs-menu').toggleClass('visible-xs').toggleClass('hidden-xs');
		$('#btnShow').toggle();
	});
	  $(".comeon").mouseover(function(){
	        $(this).next().next().css("display","");
	    });
	  $('.collapse.in').prev('.panel-heading').addClass('active');
	  $('#accordion, #bs-collapse')
		.on('show.bs.collapse', function(a) {
		  $(a.target).prev('.panel-heading').addClass('active');
		})
		.on('hide.bs.collapse', function(a) {
		  $(a.target).prev('.panel-heading').removeClass('active');
		});
    	
	}); 
	
    </script>
</body>
</html>