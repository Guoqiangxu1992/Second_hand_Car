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
	//var rowEditor=undefined;
	//var fileName = ${fileName};
  	var fileName = "${fileName}"; 
  	//alert(fileName)
	$(function(){
		datagrid=$("#dg").datagrid({
			url:"${ctx}/sale/addList.do",//加载的URL
		    isField:"id",	
			pagination:true,//显示分页
			pageSize:10,//分页大小
			pageList:[10,15,20],//每页的个数
			fit:true,//自动补全
			fitColumns:true,
			singleSelect:true,
			iconCls:"icon-save",//图标
			columns:[[      //每个列具体内容
		              {field:'id', title:'汽车编号', width:100, align:'center'},  
		              {field:'carType', title:'汽车类型', width:100, align:'center' },
		              {field:'mileage', title:'显示里程', width:100,align:'center' },
		              {field:'price', title:'价格', width:100,align:'center'      },
		              {field:'agency', title:'经销商', width:100, align:'center' },
		              {field:'color', title:'颜色', width:100, align:'center' },
		              {field:'status', title:'签约状态', width:100, align:'center',
		            	  formatter:function(value,rowData,rowIndex) { 
		            		  if(rowData.status==1){
								return '<span style="color:red;font-weight:bold">热销中</span>';}
		            		  else if(rowData.status==2){
		            			  return'<span style="color:green;font-weight:bold">已预约</span>';
		            		  }
		            		  else return '<span style="color:green;font-weight:bold">已卖出</span>';
		            	  }},
		            	  {field:'damaged', title:'破损度', width:100, align:'center',
			            	  formatter:function(value,rowData,rowIndex) { 
			            		  if(rowData.damaged==1){
									return '<span style="color:red;font-weight:bold">小修</span>';}
			            		  else if(rowData.damaged==2){
			            			  return'<span style="color:green;font-weight:bold">大修</span>';
			            		  } else if(rowData.damaged==3){
			            			  return'<span style="color:green;font-weight:bold">有刮擦</span>';
			            		  }
			            		  
			            		  else return '<span style="color:green;font-weight:bold">无</span>';
			            	  }},
		      	  		   {field:'btnId',title:'操作',width:80,align:'center',formatter: 
		                	  function(value,row){
		                	  var html="";
		                	  html+= '<a href="${ctx}/sale/detail.do?id='+row.id+'"  style="width:80px; padding:10px;">上传照片</a>';
		                      return html;
		                      }
		                  } 
		          	]], 
			toolbar:[     
			         //工具条
			        {text:"发布",iconCls:"icon-add",handler:function(){//回调函数
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
			        					url : '${ctx}/sale/deleteMore.do',
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
			    				url : '${ctx}/sale/id'+rows[0].id+'.do',
			    				dataType : 'json',
			    				success : function(r) {
			    					if (r.id) {
			    						$('#dd').dialog('open');
			    						alert(r.carType);
			    						$("#carType").textbox("setValue", r.carType);
			    						$("#mileage").textbox("setValue", r.mileage);
			    						$("#price").textbox("setValue", r.price);
			    						$("#old").textbox("setValue", r.old);
			    						$("#agency").textbox("setValue", r.agency);
			    						$("#color").textbox("setValue", r.color);
			    						$("#damaged").textbox("setValue", r.damaged);
			    						$("#id").val(r.id);
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
		 $('#ddUpload').dialog({
             title: "上传",
             closed:true,
             modal: true, //dialog继承自window，而window里面有modal属性，所以dialog也可以使用

			onClose: function() {
			}
         });
		 
		 initUpload();
		 
		$("#btn_search").click(function(){
			var param = $("#searchForm").serializeJson();
			datagrid.datagrid('load', param);

		});
		 function initUpload() {
			 var uploader = new plupload.Uploader({
		   		runtimes : 'html5,flash,silverlight,html4',
		   		browse_button : 'pickfiles', // you can pass in id...
		   		container: document.getElementById('container'), // ... or DOM Element itself
		   		url : '${ctx}/sale/uploadCarImag.do',
		   		flash_swf_url : '${ctx}/js/plupload-2.1.2/js/Moxie.swf',
		   		silverlight_xap_url : '${ctx}/js/plupload-2.1.2/js/Moxie.xap',
		   		
		   		multi_selection: false,
		   		multiple_queues: false,
		   		filters : {
		   			max_file_size : '1mb',
		   			mime_types: [
		   				{title : "image files", extensions : "png"},
		   			]
		   		},
		   		// PreInit events, bound before the internal events
				preinit : {
					Init: function(up, info) {
						log('[Init]', 'Info:', info, 'Features:', up.features);
					},
					UploadFile: function(up, file) {
						log('[UploadFile]', file);
						// You can override settings before the file is uploaded
						// up.setOption('url', 'upload.php?id=' + file.id);
						// up.setOption('multipart_params', {param1 : 'value1', param2 : 'value2'});
					}
				},
				
		   		init: {
		   			PostInit: function() {
		   				
		   				log('[PostInit]');
		   				document.getElementById('uploadfiles').onclick = function() {
		 					if(uploader.files.length ==0){
		 						$.messager.alert('警告','请选择文件!','error');
		 						return false;
		 					}
		 					$.messager.progress({  
		 	                    title:'请稍后',  
		 	                    msg:'正在上传......',  
		 	                    interval:0  
		 	                });
		 					uploader.start();
		 					return false;
		 				};
		   			},
		   			FilesAdded: function(up, files) {
		 				if(up.files.length > 1) {
		 					log('up.files.length'+up.files.length);
		 					//return false;
		 				}
		 				log('[FilesAdded]');
		 				plupload.each(files, function(file) {
		 					log('  File:', file);
		 					$("#uploadTable #fileName").html(file.name);
		 					$("#uploadTable #fileSize").html(plupload.formatSize(file.size));
		 					$("#uploadTable #status").html(file.status);
		 					$("#uploadTable #progress").html(file.percent);
		 				});
		 			},
		 			UploadProgress: function(up, file) {
		 				log('[UploadProgress]', 'File:', file, "Total:", up.total);
		 				$("#uploadTable #progress").html(file.percent);
		 				$.messager.progress('bar').progressbar("options").text=file.name+"("+file.percent+"%)";
		 				$.messager.progress('bar').progressbar("setValue",up.total.percent);
		 			},
					UploadComplete: function(up, file) {
						
						alert(up.files.length);
						var data = up.val();
						alert(data);
						log('[UploadComplete]');
						$.messager.alert('提示', "上传完成", 'help');
						$.messager.progress('close');
						window.location.reload(true); 
						$('#ddUpload').dialog('close');
						
					},
		   		},
		   		
		   	});
				uploader.init();
		}
		 function log() {
				var str = "";

				plupload.each(arguments, function(arg) {
				var row = "";
				
				if (typeof(arg) != "string") {
					plupload.each(arg, function(value, key) {
						// Convert items in File objects to human readable form
						if (arg instanceof plupload.File) {
								// Convert status to human readable
								switch (value) {
									case plupload.QUEUED:
										value = 'QUEUED';
										break;

									case plupload.UPLOADING:
										value = 'UPLOADING';
										break;

									case plupload.FAILED:
										value = 'FAILED';
										break;
									
									case plupload.DONE:
										value = 'DONE';
										break;
								}
							}
				
						if (typeof(value) != "function") {
							row += (row ? ', ' : '') + key + '=' + value;
						}
					});
							
									str += row + " ";
					} else {
						str += arg + " ";
						}
				});
				
			var log = document.getElementById('console');
				//log.innerHTML += str + "\n";
			}	 
	
			});
	

	
    </script>
    <style type="text/css">
    
    </style>
    <script type="text/javascript">
    	function uploadimage(){
    		 $('#ddUpload').dialog('open');
    	}
    </script>
</head>
<body style="padding:0 4px; margin:0;  overflow: hidden; ">
<div class="easyui-layout" style="width:100%;height:100%;" data-options="fit:true">
		
		<div title="商家管理" data-options="region:'north'" >
		<!--  <form id="searchForm" >
			<table cellpadding="5">
				    		<tr>
				    			<td>车型:</td>
				    			<td><input class="easyui-textbox" type="text" id="carType"  name="carType" ></input></td>
				
				    			<td ><a href="#" id="btn_search" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px">Search</a></td>
				    		</tr>
				    		<tr>
				    		</tr>
				    	</table>
				  </form> -->
		</div>
		
		<div data-options="region:'center'" >
			<table id="dg" >
			</table>
		</div>

			
	<div id="dd" title="My Dialog"  style="width:800px;height:450px; text-align: left; " data-options="closed:true"> 
				    <form id="ff" method="post"  action="${ctx}/sale/saveCar.do" >
				    	<input type="hidden" id="id" name="id">
						<table cellpadding="3" >
				    		<tr>
				    		    <td>车型:</td>
				    			<td><input  class="easyui-textbox"  type="text" id="carType" name="carType" data-options="required:true" />
				    			</td>
				    			<td>车显里程:</td>
				    			<td><input class="easyui-textbox"   type="text" id="mileage"  name="mileage" data-options="required:true"   /></td>
				    			<td>价位:</td>
				    			<td><input class="easyui-textbox" type="text" id="price"  name="price" data-options="required:true" /></td>
				    		</tr>
				    		<tr>
				    			<td>购买几年:</td>
				    			<td><input class="easyui-textbox" type="text" id="old"  name="old" data-options="required:true" ></input></td>
				    			<td>经销商:</td>
				    			<td><input class="easyui-textbox" type="text" id="agency"  name="agency" data-options="required:true" /></td>
				    		    <td>颜色:</td>
				    			<td><input class="easyui-textbox" type="text" id="color"  name="color" data-options="required:true" ></input></td>
				    		</tr>
				    		<tr>
				    			  <td>破损度:</td>
				    			<td><select style="width: 150px" class="easyui-combobox"  id="damaged" name="damaged"  data-options="required:true" >
				    					<option value="1">小修</option>
                                        <option value="2">大修</option>
                                        <option value="3">有刮伤</option>
                                        <option selected="selected" value=""></option>
				    			</select>
				    			</td>
				    		</tr>
				    		</table>
				    		
				  </form>
			</div>
		</div>

</body>
</html>