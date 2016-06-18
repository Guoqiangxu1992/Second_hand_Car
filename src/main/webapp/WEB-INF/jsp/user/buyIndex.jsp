<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ include file="/WEB-INF/jsp/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<style type="text/css">
	.sp span.textbox{
		border-left: 0;
		border-right: 0;
		border-top: 0;  
	}
</style>
<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
	<script src="${ctx}/js/plupload-2.1.0/js/plupload.full.min.js"
	type="text/javascript"></script>
		    
  <script type="text/javascript">
	var datagrid;
	var idcardFlag = "1";
	var rowEditor=undefined;
	$(function(){
		datagrid=$("#dg").datagrid({
			url:"${ctx}/user/buy/list.do",//加载的URL
		    isField:"id",	
			pagination:true,//显示分页
			pageSize:10,//分页大小
			pageList:[10,15,20],//每页的个数
			fit:true,//自动补全
			fitColumns:true,
			singleSelect:true,
			iconCls:"icon-save",//图标
			columns:[[      //每个列具体内容
		              {field:'id', hidden:true },  
		              {field:'userId', title:'用户ID', width:100, align:'center' },
		              {field:'userName', title:'用户名', width:100,align:'center' },
		              {field:'fullName', title:'姓名', width:100,align:'center',
		            	  formatter:function(value,rowData,rowIndex) { 
								return rowData.fullName
		            	  }
		              },
		              {field:'birthday', title:'出生日期', width:100, align:'center' },
		              {field:'sex', title:'性别', width:100, align:'center',
		            	  formatter:function(value,rowData,rowIndex) { 
		            		  if(rowData.sex==1){
								return '<span>男</span>';}
		            		  else
		            			  return'<span>女</span>';
		            			  
		            	  }},
		              {field:'mobile', title:'手机号码',  width:100, align:'center',
			            	  formatter:function(value,rowData,rowIndex) { 
									return rowData.mobile
			              }}
		          	]],
			toolbar:[              //工具条
			        {text:"增加",iconCls:"icon-add",handler:function(){//回调函数
			        	 $("input",$("#idCard").next("span")).removeAttr("readonly");
			        	 $('#dd').dialog('open');
			        }},
			        {text:"删除",iconCls:"icon-remove",handler:function(){
			        	var rows=datagrid.datagrid('getSelections');
			  
			        	if(rows.length<=0)
			        	{
			        		$.messager.alert('警告','您没有选择','error');
			        	}
			        	else
			        	{
			        		$.messager.confirm('确定','您确定要删除吗',function(t){
			        			if(t)
			        			{
			        				var ids = [];
			        				var rows = datagrid.datagrid('getSelections');
			        				for(var i=0; i<rows.length; i++){
			        					ids.push(rows[i].id);
			        				}
			        				//alert(ids.join(','));
			        			
			        				$.ajax({
			        					url : '${ctx}/user/buy/deleteMore.do',
			        					data : 'ids='+ids.join(','),
			        					method: 'POST',
			        					dataType : 'text',
			        					success : function(r) {
			        						if (r==0) {
			        							$.messager.show({
			        								msg : "操作成功",
			        								title : '成功'
			        							});
			        							datagrid.datagrid('reload');
			        						} else {
			        							$.messager.alert('错误',"操作失败", 'error');
			        						}
			        					}
			        				});
			        			
			        			}
			        		})
			        	}
			        	
			        	
			        }},
			        {text:"修改",iconCls:"icon-edit",handler:function(){
			        	var rows=datagrid.datagrid('getSelections');
			    		$("input",$("#idCard").next("span")).attr("readonly", true);
			        	if(rows.length==1)
			        	{
			         		$.ajax({
			    				url : '${ctx}/user/buy/id'+rows[0].id+'.do',
			    				dataType : 'json',
			    				success : function(r) {
			    					if (r.id) {
			    						$('#dd').dialog('open');
			    						$("#userId").textbox("setValue", r.userId);
			    						$("#fullName").textbox("setValue", r.fullName);
			    						$("#sex").combobox("setValue", r.sex);
			    						$("#userName").textbox("setValue", r.userName);
			    						$("#mobile").textbox("setValue", r.mobile);
			    						$("#birthday").textbox("setValue", r.birthday);
			    						$("#id").val(r.id);
						     			initComBox({
    										comboboxId: "quaCertificate",
	   										 data: [
													{"id":'1', 
													"text":"有" 
													},{ 
													"id":'0', 
													"text":"无" 
													}],
    							      		valueField:'id',
    								 		textField:'text',
    								 		callback: function(){
    								 			if ( r.quaCertificate == null) {
    								 				$('#quaCertificate').combobox('setValue', 0);
												}else {
													$('#quaCertificate').combobox('setValue', r.quaCertificate);
												}
	        							 	}
											});
						     			initComBox({
    										comboboxId: "praCertificate",
	   										 data: [
													{"id":'1', 
													"text":"有" 
													},{ 
													"id":'0', 
													"text":"无" 
													}],
    							      		valueField:'id',
    								 		textField:'text',
    								 		callback: function(){
    								 			if (r.praCertificate == null) {
    								 				$('#praCertificate').combobox('setValue', 0);	
												}else {
													$('#praCertificate').combobox('setValue', r.praCertificate);
												}
	        							 	}
											});
			    					} else {
			    						$.messager.alert('错误', r.msg, 'error');
			    					}
			    				}
			    			});		
			        	} else {
			        		$.messager.alert('错误', "只能选择一个数据进行修改", 'error');
			        	}
			        }}
			        ]

		});
		
		 $('#dd').dialog({
             title: "My Dialog",
             closed:true,
             modal: true, //dialog继承自window，而window里面有modal属性，所以dialog也可以使用
             toolbar: [{
				text:'Ok',
				iconCls:'icon-ok',
				handler:function(){
					if (idcardFlag == "0") {
						$.messager.alert('错误', "身份证不存在");	
					}else{
					$('#ff').form('submit',{
						onSubmit:function(){
							var isValid = $(this).form('validate');
							if(isValid) {
							}
							return isValid;
						},
						success: function(r){
								//$('#ff').form('clear');
								$('#dd').dialog('close');	
							}
						}
					);
					}
				}
			},{
				text:'Cancel',
				handler:function(){
					$('#dd').dialog('close');
					$('#ff').form('clear');
				}
			}],
			onOpen: function() {
				 
			},
			onClose: function() {
				$('#ff').form('clear');
				datagrid.datagrid('unselectAll');
				datagrid.datagrid('reload');
			}
         });
		 
		 
		 

	    
		$("#btn_search").click(function(){
			var param = $("#searchForm").serializeJson();
			datagrid.datagrid('load', param);

		});
	
			});
		
	 
	
	function initCombox() {
		 $('#quaCertificate').combobox({
			 data: [
				{"id":'1', 
				"text":"有" 
				},{ 
				"id":'0', 
				"text":"无" 
				}],
			 valueField:'id', 
			 textField:'text'
		 });
		 
		 $('#praCertificate').combobox({
			 data: [
					{"id":'1', 
					"text":"有" 
					},{ 
					"id":'0', 
					"text":"无" 
					}],
			 valueField:'id', 
			 textField:'text'
		 });
	} 
	
    </script>
    <style type="text/css">
    
    </style>
</head>
<body style="padding:0 4px; margin:0;  overflow: hidden; ">
<div class="easyui-layout" style="width:100%;height:100%;" data-options="fit:true">
		<div title="买家管理" data-options="region:'north'" style="height:100px">
		 <form id="searchForm" >
			<table cellpadding="5">
				    		<tr>
				    			<td>姓名:</td>
				    			<td><input class="easyui-textbox" type="text" id="fullNameSearch"  name="fullName" ></input></td>
				
				    			<td ><a href="#" id="btn_search" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px">Search</a></td>
				    		</tr>
				    		<tr>
				    		</tr>
				    	</table>
				  </form>
		</div>
		
		<div data-options="region:'center'" >
			<table id="dg" >
			</table>
		</div>

			
	<div id="dd" title="My Dialog"  style="width:800px;height:450px; text-align: left; " data-options="closed:true"> 
				    <form id="ff" method="post"  action="${ctx}/user/buy/saveSale.do" >
				    	<input type="hidden" id="id" name="id">
						<table cellpadding="3" >
				    		<tr>
				    		    <td>姓名:</td>
				    			<td><input  class="easyui-textbox"  type="text" id="fullName" name="fullName" data-options="required:true" />
				    			</td>
				    			<td>用户ID</td>
				    			<td><input class="easyui-textbox"   type="text" id="userId"  name="userId" data-options="required:true"   /></td>
				    			<td>用户名:</td>
				    			<td><input class="easyui-textbox" type="text" id="userName"  name="userName" data-options="required:true" /></td>
				    		</tr>
				    		<tr>
				    			<td>性别:</td>
				    			<td><select style="width: 150px" class="easyui-combobox"  id="sex" name="sex"  data-options="required:true" >
				    					<option value="1">男</option>
                                        <option value="2">女</option>
                                        <option selected="selected" value=""></option>
				    			</select>
				    			</td>
				    			<td>出生日期:</td>
				    			<td><input class="easyui-datebox" type="text" id="birthday"  name="birthday" data-options="required:true" ></input></td>
				    			<td>电话:</td>
				    			<td><input class="easyui-textbox" type="text" id="mobile"  name="mobile" data-options="required:true" /></td>
				    		</tr>
				    		</table>
				  </form>
			</div>
			
		
			
	
			
			
				<div id="ddUpload" title="My Dialog" style="width: 600px; height: 400px; text-align: center;" data-options="closed:true">

				<div id="container">
					<div id="tool">
							<a id="pickfiles"  href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">选择文件</a>
						    <a id="uploadfiles" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-save'">上传文件</a>
						</div>
						<div data-options="region:'center'" >
							<table  id="uploadTable"   style=" width: 100%; border-collapse: collapse; text-align: left;" class="editTable">
							        <tr>
							            <th width="100">文件名</th>
							            <td id="fileName"></td>
							         </tr>
							        <tr>
							            <th>文件大小</th>
							            <td id="fileSize"></td>
							         </tr>
							        <tr>
							            <th>状态</th>
							            <td id="status"></td>
							         </tr>
							        <tr>
							            <th>上传进度</th>
							            <td id="progress"></td>
							         </tr>
							</table>
						</div>
				</div>
				<div id="filelist">Your browser doesn't have Flash, Silverlight
					or HTML5 support.</div>
				<br />
				<pre id="console"></pre>

		</div>

		<div id="grid-export-form" class="x-hidden">
			<form method="POST" name="GridExportForm"></form>
		</div>
			
		</div>

</body>
</html>