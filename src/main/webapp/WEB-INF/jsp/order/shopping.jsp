<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       <%@ include file="/WEB-INF/jsp/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script src="${ctx}/js/plupload-2.1.0/js/plupload.full.min.js"
	type="text/javascript"></script>
	<script type="text/javascript" src="${ctx}/js/datagrid-detailview.js"></script>
	<script type="text/javascript">
	var datagrid;
	$(function(){
		datagrid = $('#tt').datagrid({
			url:'${ctx}/buy/listShopping.do', 
			 isField:"id",	
			title:'',
			width:1200,
			height:560,
			remoteSort:false,
			pagination:true,//显示分页
			pageSize:10,//分页大小
			pageList:[10,15,20],//每页的个数
			singleSelect:true,
			nowrap:false,
			fit:true,//自动补全
			iconCls:"icon-save",//图标
			fitColumns:true,
			
			columns:[[
                {field:'orderNum',title:'订单号',width:100,align:'center'},
				{field:'id',title:'车编号',width:100,align:'center'},
				{field:'carType',title:'车型号',width:100,align:'center'},
				{field:'mileage',title:'里程显示',width:100,align:'center'},
				{field:'price',title:'定价',width:100,align:'center'},
				{field:'color',title:'颜色',width:100,align:'center'},
				{field:'agency',title:'代理商',width:100,align:'center'},
				{field:'old',title:'买几年',width:100,align:'center',},
				{field:'color',title:'颜色',width:100,align:'center'},
				{field:'contractPrice',title:'成交价',width:100,align:'center'},
				{field:'buyer',title:'购买者',width:100,align:'center',},
				{field:'mobile',title:'联系电话',width:100,align:'center',},
				{field:'status',title:'销售状态',width:100,align:'center',
	            	  formatter:function(value,rowData,rowIndex) { 
	            		 // alert(rowData.status);
	            		  if(rowData.status==1){
	            			  return '<span style="color:red;font-weight:bold">热销中</span>';
	            		  }else if (rowData.status==2){
	            			  return '<span style="color:green;font-weight:bold">已预订</span>'
	            		  }else{
	            			  return '<span style="color:green;font-weight:bold">成功购买</span>'
	            		  }
							
	            	  }},
	            	  {field:'completeTime',title:'成交时间',width:100,align:'center',}
  	  		  /* {field:'btnId',title:'操作',width:80,align:'center',formatter: 
            	  function(value,row){
            	  var html="";
            	  html+= '<a href="${ctx}/sale/buy.do?id='+row.id+'"  style="width:80px; padding:10px;">购买</a>';
                  return html;
                  }
              } */
			]],
			
			view: detailview,
			detailFormatter: function(rowIndex, rowData){
				//alert("${ctx}");
				var s1 = "${ctx}";
				var s2 = s1.substr(0,1);
				//alert(s2);
				return '<table><tr>' +
						'<td rowspan=2 style="border:0"><img src="${s2}/uploadImage/' + rowData.imag + '.png" style="height:50px;"></td>' +
						'<td style="border:0">' +
						'<p>Attribute: ' + rowData.carType + '</p>' +
						'<p>车辆编号: ' + rowData.id + '</p>' +
						'</td>' +
						'</tr></table>';
			}
			
		});
		$("#btn_search").click(function(){
			var param = $("#searchForm").serializeJson();
			datagrid.datagrid('load', param);

		});
		
	})
	
	</script>
	
</head>
<body>
<div class="easyui-layout" style="width:100%;height:100%;" data-options="fit:true">
		<div title="车辆信息" data-options="region:'north'" style="height:100px">
		 <form id="searchForm" >
			<table cellpadding="5">
				    		<tr>
				    			<td>姓名:</td>
				    			<td><input class="easyui-textbox" type="text" id="carType"  name="carType" ></input></td>
				
				    			<td ><a href="#" id="btn_search" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px">Search</a></td>
				    		</tr>
				    		<tr>
				    		</tr>
				    	</table>
				  </form>
		</div>
		
		<div data-options="region:'center'" >
			<table id="tt" >
			</table>
		</div>
		
			
	</div>
</body>
</html>