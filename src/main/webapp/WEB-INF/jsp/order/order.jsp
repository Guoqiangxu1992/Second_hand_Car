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
 		$.ajax({
			url : '${ctx}/buy/orderView.do?id='+id,
			data:[],
			method: 'POST',
			dataType : 'json',
			success : function(r) {
				/* var s = r.id;
				alert(s);
				alert(typeof s );
				id = s.toString();
				alert(typeof id);
				alert(typeof r.old); */
				var a = r.imag;
				$("#carType").textbox("setValue",r.carType);
				$("#price").textbox("setValue",r.price);
				$("#mileage").textbox("setValue",r.mileage);
				$("#agency").textbox("setValue",r.agency);
				$("#color").textbox("setValue",r.color);
				$("#agencyId").textbox("setValue",r.agencyId);
				//alert(r.agencyId);
	    		$("#markImag").textbox("setValue",a);
				if(r.imag != 'undefined'){
					var s1 = "${ctx}";
					var s2 = s1.substr(0,1);
					document.getElementById('imag').setAttribute("src","${s2}/uploadImage/"+r.imag+'.png');
				}
				$("#old").textbox("setValue",r.old);
				
					$("#id").textbox("setValue",id);
			}
		});		
		 
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
					if(data == 0){
						location.href = "${ctx}/buy/info.do";
						$('#ff').form('clear');
						$.messager.show({
							msg : "订单预定成功！",
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
 	function initCombox() {
 		$('#status').combobox({
			 data: [
				{"id":'1', 
				"text":"热销中" 
				},{ 
				"id":'2', 
				"text":"已预约" 
				},{ 
				"id":'3', 
				"text":"已订购" 
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
		<div data-options="region:'center'" style="width:400px; padding: 50px 200px;">
		<div class="easyui-panel" title="订单信息" style="width:700px;">
			<form id="ff" method="post" action="${ctx}/buy/orderList.do" >
			<input class="easyui-textbox" type="hidden" id="markImag" name="markImag"/>
			<input class="easyui-textbox" type="hidden" id="agencyId" name="agencyId"/>
				    		<table cellpadding="2" class="editTable">
				    	
				    		<tr>
				    			<td rowspan="3">汽车照片:</td>
				    			<td rowspan="3"><img id="imag" alt="" src="" height="100px;"></td>
				    		</tr>
				    		<tr>
				    			<td>汽车编号</td>
				    			<td><input  class="easyui-textbox"  id="id" name="id"  /></td>
				    			<td>车型号:</td>
				    			<td><input  class="easyui-textbox"  id="carType" name="carType"  />
				    		</tr>
				    		
				    		<tr>
				    			<td>定价:</td>
				    			<td><input  class="easyui-textbox"  id="price" name="price"  />
				    			<td height="100px;">里程显示:</td>
				    		<td height="100px;"><input  class="easyui-textbox"  id="mileage" name="mileage"  readonly="readonly"/></td>
				    		</tr>
				    		<tr>
				    			<td>颜色:</td>
				    			<td><input  class="easyui-textbox" type="text" id="color"  name="color" data-options="required:true"  />
				    			<td>代理商:</td>
				    			<td><input  class="easyui-textbox" type="text" id="agency"  name="agency"  readonly="readonly" />
				    			</td>
				    			<td>买几年:</td>
				    			<td><input  class="easyui-textbox"  id="old" name="old" /></td>
				    		</tr>
				    		<tr>
				    			<td align="center">一口价:</td>
				    			<td align="center"><input  class="easyui-textbox"  id="contractPrice" name="contractPrice" /></td>
				    		</tr>
				    	<tr>	</tr>
				    		</table>
				    
				    </form>
				     <div style="text-align:center;padding:5px">
			            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">Submit</a>
			            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">Clear</a>
			        </div>
		</div>
		</div>
</div>
</body>
</html>