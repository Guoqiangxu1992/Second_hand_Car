<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ include file="/WEB-INF/jsp/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
  <script src="${ctx}/js/plupload-2.1.0/js/plupload.full.min.js" type="text/javascript"></script>    	    
  <script type="text/javascript">
	$(function(){
 		$.ajax({
			url : '${ctx}/user/list.do',
			data:[],
			method: 'POST',
			dataType : 'json',
			success : function(r) {
				
				$("#userId").textbox("setValue",r.userId);
				$("#userName").textbox("setValue",r.userName);
				$("#sex").combobox("setValue",r.sex);
				$("#fullName").textbox("setValue",r.fullName);
				$("#passWord").textbox("setValue",r.passWord);
				$("#birthday").datebox("setValue",r.birthday);
				$("#mobile").textbox("setValue",r.mobile);
			}
 		
		});	
 		
 		initCombox();
 	 	 
		 
	});
	
	function initCombox() {
		
	 		$('#sex').combobox({
				 data: [
					{"id":'1', 
					"text":"男" 
					},{ 
					"id":'2', 
					"text":"女" 
					},{ 
					"id":'3', 
					"text":"保密" 
					}],
				 valueField:'id', 
				 textField:'text'
			 });
	 		
		
		} 
	 function submitForm(){
			$('#ff').form('submit',{
				onSubmit:function(){
					var isValid = $(this).form('validate');
					if(isValid) {
						
					}
					return isValid;
				},
				success: function(data){
					if(data == 0){
						location.href = "${ctx}/user/infoModify.do";
						$('#ff').form('clear');
						$.messager.show({
							msg : "信息修改成功",
							title : '成功'
						});
						
					} else {
						$.showAlert({
							
							text:data
						});
					}
					
					
				}
			});
     }
     function clearForm(){
         $('#ff').form('clear');
     }
     
 	function uploadimage(){
 		 $('#ddUpload').dialog('open');
 	}

    </script>
    <style type="text/css">
    
    </style>
</head>
<body style="padding:0 4px; margin:0;  overflow: hidden; ">
<div class="easyui-layout" style="width:100%;height:100%;" data-options="fit:true">
		<div data-options="region:'center'" style="width:400px; padding: 50px 200px;">
		<div class="easyui-panel" title="个人信息" style="width:700px;">
			<form id="ff" method="post" action="${ctx}/user/modify.do" >
			<input class="easyui-textbox" type="hidden" id="markImag" name="markImag"/>
			<input class="easyui-textbox" type="hidden" id="agencyId" name="agencyId"/>
				    		<table cellpadding="2" class="editTable">
				    		<tr>
				    			<td height="100px;">用户编号:</td>
				    			<td><input  class="easyui-textbox"  id="userId" name="userId"  data-options="required:true" readonly="readonly"/></td>
				    			<td>用户名:</td>
				    			<td><input  class="easyui-textbox"  id="userName" name="userName" data-options="required:true" readonly="readonly"/>
				    				<td>性别:</td>
				    			<td><input  class="easyui-combobox" type="text" id="sex"  name="sex" data-options="required:true"  />
				    		</tr>
				    		
				    		<tr>
				    			<td>姓名:</td>
				    			<td><input  class="easyui-textbox"  id="fullName" name="fullName" data-options="required:true" />
				    			<td >密码:</td>
				    		<td height="100px;"><input  class="easyui-textbox"  id="passWord" name="passWord" data-options="required:true" /></td>
				    		<td>出生日期:</td>
				    			<td><input  class="easyui-datebox" type="text" id="birthday"  name="birthday" data-options="required:true" />
				    			</td>
				    		</tr>
				    		<tr>
				    			<td height="100px;">电话号码:</td>
				    			<td><input  class="easyui-textbox"  id="mobile" name="mobile"data-options="required:true" /></td>
				    		</tr>
				    		</table>
				    
				    </form>
				     <div style="text-align:center;padding:5px">
			            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">提交</a>
			            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">清除</a>
			        </div>
		</div>
		</div>
</div>
</body>
</html>