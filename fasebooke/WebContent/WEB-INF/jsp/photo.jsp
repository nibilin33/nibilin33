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

   <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script> 
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/diyUpload/css/webuploader.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/index.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/diyUpload/css/diyUpload.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/diyUpload/js/webuploader.html5only.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/diyUpload/js/diyUpload.js"></script>
           <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/main.js"></script>
                   <link href="<%=request.getContextPath()%>/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <!--[if lt IE 9]>
          <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
   <link href="<%=request.getContextPath()%>/resources/css/facebook.css" rel="stylesheet" type="text/css"/>
         <link href="http://cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.css" rel="stylesheet" type="text/css"/>
        <link rel="shortcut icon" href="<%=request.getContextPath()%>/resources/img/facebook_128px_1160395_easyicon.net.ico"/>
   <style>
   .zuobian {
    margin-top: -11px;
    margin-left: 40px;
    color: darkgray;
}
       body{font-size:14px;font-family:"????????????";background:url("http://localhost:8080/img/face/2.jpg")top no-repeat;background-attachment:fixed;z-index:0;background-size:100%;}
       a{      color: black;
         }
         #box{ margin:50px auto; width:540px; min-height:400px; background:#FF9}
.box1{width:960px;height:auto;min-height: 800px; margin:5px auto;position:relative;z-index:1;background-color:rgba(0,0,0,0.075)}
/*??????????????????*/

</style>
    </head><body>
<!--head-->
	<div id="postModal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" >
		  <div class="modal-dialog">
		
		  <div class="modal-content">
			  <div class="modal-body">
	       <div id="box" >
       	   <div id="test">
             
         </div>
     </div>
			  <div class="modal-footer">
				  <div>
				  <button class="btn btn-primary btn-sm" data-dismiss="modal" aria-hidden="true" onclick="dimiss()">??????</button>
					
				  </div>	
			  </div>
		  </div>
		  </div>
		</div>
      </div>
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
  <a href="http://localhost:8080/fasebooke/user/${current_user.fuid}.action">?????????</a></li><li><a href="http://localhost:8080/fasebooke/jian/${current_user.fuid}/firstin.action">??????</a></li><li><a href="http://localhost:8080/fasebooke/friend/${current_user.fuid}/myfreind.action">??????</a></li><li class="active"><a href="http://localhost:8080/fasebooke/picture/${current_user.fuid}/fuck.action">??????</a></li> 
   <li><a href="http://localhost:8080/fasebooke/user/${current_user.fuid}/checkin.action">??????</a></li>
   </ul>
  </div>
  </div>


<!--   container-->
 <div class="container">
     <div class="row">
         <div class="panel panel-default">
             <div class="panel-heading">
                 <i class="glyphicon glyphicon-picture" style="font-size:30px"></i><span style="font-size:30px;color:gray">??????</span>
                 <div class="btn-group" style="float:right">
              <a href="javascript:;" data-target="#postModal2" data-toggle="modal" class="btn btn-default"><i class="glyphicon glyphicon-plus"></i>????????????</a>
              <a href="javascript:;" data-target="#postModal" data-toggle="modal" class="btn btn-default"><i class="glyphicon glyphicon-pencil"></i>????????????</a>
         
            </div>
             </div>
             <div class="panel-body">
                <ul id="myTab" class="nav nav-tabs">
	<li class="active">
		<a href="#home" data-toggle="tab">
			???????????????
		</a>
	</li>
	<li><a href="#ios" data-toggle="tab">??????</a></li>
</ul>
             </div>
     
             <div id="myTabContent" class="tab-content">
    <div class="tab-pane fade in active" id="home" >
     <ul class="_mytakenpicture" id="my">
      <c:forEach items="${mygay}" var="emp" varStatus="vs">
      <c:if test="${emp.gicname=='???????????????'}">
       <c:forEach items="${emp.pictures}" var="pic" varStatus="vs">
            <li >
          <a href="javascript:;" data="${pic.pid}" onclick="deleteOnePig(this)"style="color:gray;position:relative;top:15px;text-decoration:none"><i class="glyphicon glyphicon-remove"></i></a> 
     
      <div class="pic2 fancybox img-responsive">
       <a href="${pic.picdescribe}" class="fancy" data-fancybox-group="gallery" title="${pic.ptime }">
       <img src="${pic.picdescribe}">
     </a>
      </div>
         <p style="text-align:center">${pic.picname}</p>
      </li>
      </c:forEach>
      <input type="hidden" value="${emp.gpid}">
      </c:if>
    
      </c:forEach>
      </ul>
    </div>
    <div class="tab-pane fade" id="ios">
     <div class="_mytakenpicture">
  <c:forEach items="${mygay}" var="no" varStatus="vs">
      <c:if test="${no.gicname!='???????????????'}">
        <a href="javascript:;" data="${no.gpid}" onclick="deleteG(this)" style="color:gray;position:relative;margin-left:10px;top:-126px"><i class="glyphicon glyphicon-remove"></i></a>
      <div class="pic3">
      <a href="http://localhost:8080/fasebooke/picture/${no.gpid}/ingay.action?fuid=${current_user.fuid}"><i class=" fa fa-folder-open" style="font-size:170px;" ></i><p class="pic4">${no.gicname }</p></a>
    
     <p class="gicd">${no.gicdescribe}</p> 
     </div>
   
      </c:if>
    
      </c:forEach>
         
    </div>
</div>
         </div>
     </div>
 </div>
 </div>
 </div>
</div>
 <div id="postModal2" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
		  <div class="modal-dialog">
		  <div class="modal-content">
		  <form >
			  <div class="modal-header">
       <input type="text" class="form-control" placeholder="????????????" id="biao">
			  </div>
			  <div class="modal-body">
				
					<div class="form-group center-block">
					  <textarea class="form-control input-lg" autofocus="" placeholder="????????????????????????" id="nei"></textarea>
					</div>
			  </div>
			  </form>
			  <div class="modal-footer">
				  <div>
				  <div class="dropdown" style="float:left">  
        <button class="btn btn-sm dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
<span class="glyphicon glyphicon-globe" data="0">??????</span>
<span class="caret"></span>
</button>
<ul class="dropdown-menu" aria-labelledby="dropdownMenu1" id="gallary" style="color:darkgray;text-align:center">
<li><span class="glyphicon glyphicon-globe" ><a href="javascript:;">??????</a></span></li>
<li><span class="fa fa-user" ><a href="javascript:;">??????</a></span>
</li>
<li><span class="fa  fa-unlock-alt"><a href="javascript:;">????????????</a></span></li>
</ul>
    </div> 
</div>
				  <button class="btn btn-primary btn-sm" data-dismiss="modal" aria-hidden="true" onclick="createG(this)">??????</button>
					<!-- data-dismiss="modal" -->
				  </div>	
			  </div>
		  </div>
		  </div>
		</div>
  <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/bootstrap.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/localsearch.js"></script>
         <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.fancybox.js"></script>
<script type="text/javascript">
      
        $(document).ready(function() {
        	$('.fancy').fancybox();
        window.gid=$('#my input[type=hidden]').val();
        	   $('#test').diyUpload({
               	url:'http://localhost:8080/fasebooke/picture/dotest.action?gid='+window.gid,
               	success:function( data ) {
               		console.info( data );
               		$('#my').append('<li ><a href="javascript:;" data="'+data["pid"]+'" onclick="deleteOnePig(this)"style="color:gray;position:relative;top:15px;text-decoration:none"><i class="glyphicon glyphicon-remove"></i></a> <div class="pic2"><img src="'+data["path"]+'"> </div><p p style="text-align:center">'+data["filename"]+'</p></li>');
               	},
               	error:function( err ) {
               		console.info( err );	
               	}
               });
          
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