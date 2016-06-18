<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
 <c:set var="ctx" value="${pageContext.request.contextPath}" ></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
body {background-color:#fff;width: 100%;height: 100%;margin:0; padding:0;font-family:"Microsoft YaHei";}
.bodyDiv{margin:0 auto; padding: 0;}
.header{ height: 250px; }
.middle{width:100%;margin:0 auto;height:100%; display:block;}
h2.title {margin-top:20px;margin-bottom:20px; text-align:center; font-size:35px; color:#0E2D5F; line-height:30px;}
.ff{height:auto; width:500px; margin:0 auto; padding-top:55px;}
.label { color:#FFF;font-size: 20px; font-weight: 800;}
/* 首页登录框 */
 .container{ 
     width: 600px; 
     height: 250px; 
     background: rgba(255,255,255,.5); 
     border-radius: 15px;
     margin:0 auto ; 
     position: absolute;
     left: 35%; 
     top: 20%; 
 } 
  .box-shadow-2{  
      -webkit-box-shadow:inset 0 0 10px #000;  
      -moz-box-shadow:inset 0 0 10px #000; 
      box-shadow:inset 0 0 10px #000;  
  }  
  .box-shadow-1{  
  -webkit-box-shadow:0 0 10px rgba(0, 0, 0, .5);  
  -moz-box-shadow:0 0 10px rgba(0, 0, 0, .5); 
	 box-shadow:0 0 10px rgba(0, 0, 0, .5); 
} 
tr{ 
 font-size:14px;color:#333;} 

</style>
</head>
  <body>

<div class = "bodyDiv">

<div class="wrapper">
	<ul class="bg-bubbles">
		<li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
	</ul>
	
</div>
	
<!-- <div class="header"> -->
<!-- 		<div class="" style="height: 160px;"></div> -->
<!-- </div> -->
<!-- 	登陆框 -->
	<div class = "middle">
	<div style=" width:400px;margin:0 auto;">
	
	<div class="easyui-panel container box-shadow-1">
		<div style="padding:10px 60px 20px 60px">
	    <form id="ff" method="post" action ="${ctx}/login/ajaxLogin.do">
			<h2 class="title">二手车交易平台</h2>
	    	<table cellpadding="5" style="margin:0 auto;">
	    		<tr>
	    			<td>账户名:</td>
	    			<td><input class="easyui-textbox"  type="text" name="userName" data-options="required:true"/></td>
	    		</tr>
	    		<tr>
	    			<td>密码:</td>
	    			<td><input class="easyui-textbox" type="text" name="passWord" data-options="required:true,validType:'password'"/></td>
	    		</tr>
	    	</table>
	    </form>
	    <div style="text-align:center;padding:10px;margin-top:20px;">
	    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">确&nbsp;定</a>
	    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">清&nbsp;除</a>
	    </div>
	    </div>
	</div>
	</div>
	<script>

	 	$(".container").hover(function(){
	 		$(this).removeClass("box-shadow-1").addClass("box-shadow-2");
	 	},function(){
	 		$(this).removeClass("box-shadow-2").addClass("box-shadow-1");
	 	});
	</script>
	<script>
	/* 	function submitForm(){
			$('#ff').form('submit');
			window.location.href="ajaxLogin.do";
		}
		function clearForm(){
			$('#ff').form('clear');
		} */
		function submitForm(){
			$('#ff').form('submit',{
				onSubmit:function(){
					return $(this).form('enableValidation').form('validate');
				},
			    success:function(r){
			    	if(r==1){ window.location = "${ctx}/login/main.do";}
			    	else
			    		alert("账户名或者密码错误");
			    	 
			       }
			    });
		
			    };
		function clearForm(){
			$('#ff').form('clear');
		}
	</script>

</div>
</div>
    </body>

</html>