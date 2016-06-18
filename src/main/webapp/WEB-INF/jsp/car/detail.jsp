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
  var id = ${id};
	$(function(){
		 
		 $('#ddUpload').dialog({
             title: "上传",
             closed:true,
             modal: true, //dialog继承自window，而window里面有modal属性，所以dialog也可以使用

			onClose: function() {
			}
         });
		 
		 initUpload();
		 initCombox();
		 toolbar : [ //工具条
						
						{
							text : "返回",
							iconCls : "icon-back",
							handler : function() {//回调函数
								window.location = "${ctx}/studentLeave/myLeave.do";
							}
						}
					]
	});
	 function submitForm(){
			$('#ff').form('submit',{
				onSubmit:function(){
					var isValid = $(this).form('validate');
					if(isValid) {
						
					}
					return isValid;
				},
				success: function(data){
					if(data == "success"){
						$('#ff').form('clear');
						$.messager.show({
							msg : "操作成功",
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
     
	 function initUpload() {
		 
		 var uploader = new plupload.Uploader({
	   		runtimes : 'html5,flash,silverlight,html4',
	   		browse_button : 'pickfiles', // you can pass in id...
	   		container: document.getElementById('container'), // ... or DOM Element itself
	   		url : '${ctx}/sale/uploadCarImag.do?id='+id,
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
				UploadComplete: function(up, files) {
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
 	
 	function uploadimage(){
 		 $('#ddUpload').dialog('open');
 	}
	function back(){
		window.location = "${ctx}/sale/info.do";
	}
    </script>
    <style type="text/css">
    
    </style>
</head>
<body style="padding:0 4px; margin:0;  overflow: hidden; ">
<div class="easyui-layout" style="width:100%;height:100%;" data-options="fit:true">
		<div data-options="region:'center'" style="width:400px; padding: 50px 200px;">
		<div class="easyui-panel" title="照片上传" style="width:700px;">
			<form id="ff" method="post" action="" >
				    		<table style=" width: 100%; height:100%;border-collapse: collapse; text-align: left;"cellpadding="2" class="editTable">
				    		<tr>
				    		<td  width="100px";height="100px;" >汽车照片:</td>
				    		<td ><img id="imag" alt="" src=""  width="100px";height="100px;"></td>
				    		<td style="border: none;"><a href="#" id="upload" class="easyui-linkbutton" data-options="iconCls:'icon-save'"  onclick="uploadimage()">上传照片</a></td>
				    		<td ><a href="#" id="back" class="easyui-linkbutton" data-options="iconCls:'icon-save'"  onclick="back()">返回</a></td>
				    		</tr>
				    		</table>
				    
				    </form>
		</div>
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
							         <tr>
						            <td colspan="2">
						            	<ul>
						            		<li>1、上传的图片格式为png、分辨率为140*105；
						            		</li>
						            	</ul>
						            </td>
						         </tr>
							</table>
						</div>
				</div>
				<br />
				<pre id="console"></pre>

		</div>
</div>
</body>
</html>