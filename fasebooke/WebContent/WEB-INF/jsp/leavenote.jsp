<%@ page language="java" import="java.util.*,net.sf.json.*,com.fase.po.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ page import="org.springframework.web.util.UrlPathHelper" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
	<head>
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
    <link href="<%=request.getContextPath()%>/resources/css/note.css" rel="stylesheet" type="text/css"/>
         <link href="http://cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.css" rel="stylesheet" type="text/css"/>
        <link rel="shortcut icon" href="<%=request.getContextPath()%>/resources/img/facebook_128px_1160395_easyicon.net.ico"/>
      <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script> 
         
      <script language="javascript" type="text/javascript" src="http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js
"></script>
 <script language="javascript" type="text/javascript">
 <% Fuser us =(Fuser)request.getSession().getAttribute("current_user") ;  %>
 var cuserid='<%=us.getFuid()%>';
 var curername='<%=us.getFname()%>';
 var curhead='${current_user.fheadimage}'; 
  if(curhead==''){
	 curhead="http://localhost:8080/img/face/head_male_man_user_64px_1578_easyicon.net.png"; 
 }else
	 {
	 var s="http://localhost:8080/img/"+cuserid+"/"+curhead;
  console.log(s); 
	 curhead=s; 
	 }  
 
  localStorage.setItem("current_id",cuserid); 
  localStorage.setItem("current_name",curername); 
  localStorage.setItem("current_head",curhead);
 window.onload=function(){
	 window.p=remote_ip_info.province+remote_ip_info.city;
 }
 
 </script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/main.js"></script> 
    </head>
    <body>
        
        <div class="wrapper">
			<div class="box">
				<div class="row row-offcanvas row-offcanvas-left">
					
					<!-- sidebar -->
					<div class="column col-sm-2 col-xs-1 sidebar-offcanvas" id="sidebar">
					  
						<ul class="nav">
							<li><a href="javascript:;" data-toggle="offcanvas" class="visible-xs text-center"><i class="glyphicon glyphicon-chevron-right"></i></a></li>
						</ul>
					   
						<ul class="nav hidden-xs" id="lg-menu">
							<li class="active"><a href="javascript:;"><i class="fa fa-facebook-square"></i> ????????????fasebooke</a></li>
							<li><a href="javascript:;" onclick="openChatService()"><i class="glyphicon glyphicon-list"></i> fasebooke?????????</a></li>
							<li><a href="http://localhost:8080/fasebooke/picture/${current_user.fuid}/onthisday.action"><i class="glyphicon glyphicon-picture"></i> ?????????</a></li>
							<li>
							    <a href="http://localhost:8080/fasebooke/comment/${current_user.fuid}/seenote.action"><i class="fa  fa-history" ></i>?????????</a>
							</li>
						</ul>
						<ul class="list-unstyled hidden-xs" id="sidebar-footer">
							
						</ul>
					  
						<!-- tiny only nav-->
					  <ul class="nav visible-xs" id="xs-menu">
							<li><a href="#featured" class="text-center"><i class="glyphicon glyphicon-list-alt"></i></a></li>
							<li><a href="#stories" class="text-center"><i class="glyphicon glyphicon-list"></i></a></li>
							<li><a href="#" class="text-center"><i class="glyphicon glyphicon-paperclip"></i></a></li>
							<li><a href="#" class="text-center"><i class="glyphicon glyphicon-refresh"></i></a></li>
						</ul>
					  
					</div>
					<!-- /sidebar -->
				  
					<!-- main right col -->
					<div class="column col-sm-10 col-xs-11" id="main">
						
						<!-- top nav -->
						<div class="navbar navbar-blue navbar-static-top">  
							<div class="navbar-header">
							  <button class="navbar-toggle" type="button" data-toggle="collapse" data-target=".navbar-collapse">
								<span class="sr-only">Toggle</span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
							  </button>
							  <a href="javascript:;" class="navbar-brand logo">f</a>
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
                             <a href="http://localhost:8080/fasebooke/user/${current_user.fuid}.action"> 
                             
                             <c:choose>
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
							    
								<a href="javascript:;" title="??????" onclick="opennoticeSou(this)"><span class="fa fa-comments"></span></a>
								<ul class="dropdown-menu" role="menu" ></ul>
							  </li>
							  <li>
							  <li>
							<a  href="javascript:;" onclick="openbroadcast(this)" title="??????" > <span class="glyphicon glyphicon-globe"></span></a>
                          <ul class="dropdown-menu" role="menu"></ul> 
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
<div id="demo" class="collapse">

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
						<!-- /top nav -->
					  <div class="full col-sm-12">
					  <div class="onthisday">
                     <div class="clearfix">
                      <div style="postion:relative;margin-left:-700px;margin-top:20px">
					      <div style="color: #000; -webkit-font-smoothing: antialiased; text-align: center;" id="m">
					           
					                                             
					      </div>
					      <div style="color: #ec4c60;font-size: 33px;text-align: center;" id="r">
                                                      
                                                              </div>
                                                               <script type="text/javascript">
					            var time = new Date( ); //??????????????????
					            var month = time.getMonth( )+1;
					            var day = time.getDate( ); 
					            $('#m').text(month+"???");
					            $('#r').text(day+"???");
					            console.log(month);
					            </script>
                                                              </div>
                                                              </div>
					  </div>
					  	 <div class="col-sm-12">
			<div class="wrapper2 clearfix">
			<c:forEach items="${ note}" var="emp" varStatus="state">
			<c:if test="${ state.count%4==1}">
		<aside class="note-wrap note-yellow">
			<p>${emp.leavenote}  </p>
			<p>${emp.leavedate }</p>
			<a href="http://localhost:8080/fasebooke/user/${emp.lfuid}/${current_user.fuid}.action">${emp.fcount}??????</a>
		</aside>
		</c:if>
		<c:if test="${ state.count%4==2}">
		<aside class="note-wrap note-blue">
			<p>${emp.leavenote}  </p>
			<p>${emp.leavedate }</p>
			<a href="http://localhost:8080/fasebooke/user/${emp.lfuid}/${current_user.fuid}.action">${emp.fcount}??????</a>
		</aside>
		</c:if>
		<c:if test="${ state.count%4==3}">
		<aside class="note-wrap note-pink">
			<p>${emp.leavenote}  </p>
			<p>${emp.leavedate }</p>
			<a href="http://localhost:8080/fasebooke/user/${emp.lfuid}/${current_user.fuid}.action">${emp.fcount}??????</a>
		</aside>
		</c:if>
		<c:if test="${ state.count%4==0}">
		<aside class="note-wrap note-green">
			<p>${emp.leavenote}  </p>
			<p>${emp.leavedate }</p>
			<a href="http://localhost:8080/fasebooke/user/${emp.lfuid}/${current_user.fuid}.action">${emp.fcount}??????</a>
		</aside>
		</c:if>
		</c:forEach>
	</div>
					</div>
				</div>
		
					<!-- /main -->
				  
				</div>
			</div>
		</div>


		<!--post modal-->
		
        

        <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/bootstrap.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/localsearch.js"></script> 
      <!--     <script src='http://codepen.io/assets/libs/fullpage/none.js'></script>  -->
    <script type="text/javascript">
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
			        $(this).next().next().css("display",""); });});
        function commenthide(e){
            var parent=e.parentNode.parentNode.parentNode;
            parent.style="display:none";
                }
    

      </script>  
</body></html>