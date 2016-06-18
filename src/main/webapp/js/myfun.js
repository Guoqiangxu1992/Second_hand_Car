/**
 * init combox
 * @param callback
 */	
function initComBox(pConfig) {
	var defaultParam = {
			comboboxId: null,
			url: null,
			valueField: "id",
			textField: "text",
			needDefault: false,
			param: null,
			initLoadData: true,//初始化时是否加载数据
			callback: null
	};
	var config = $.extend(defaultParam, pConfig);
		var obj = $('#'+config.comboboxId);
		obj.combobox({
	        url : config.url,
	        valueField: config.valueField,
			textField: config.textField,
			onBeforeLoad: function(param){
				if(config.param != null) {
					param = $.extend(param, config.param);
				}
				if(config.initLoadData == false) {
					return false;
				}
			},
	    onLoadSuccess: function (data) {
	    	
	             if (data&&data.length>0) {
	            	 $('#'+config.comboboxId).combobox('select',data[0].id);
	               
	             } else {
	            	
	             }
				if(config.callback)config.callback();
		},
	   loadFilter: function(data){
		   if(config.needDefault){
			   var d =[];
			   var key = config.textField;
			   var value = config.valueField;
				  var defaultValue ="{"+key+":'请选择',"+value+":'-1' }";
				  d.push(eval("("+defaultValue+")"));
				  $(data).each(function(index) {
					 d.push(data[index]) 
				  });
				  return d;
		   } else {
			   return data;
		   }
			 
		   },
		   onSelect:function(node) {
				if(config.onSelect)config.onSelect(node.id);
		   }
			
	 });
}
function initCombotree(pConfig) {
	var defaultParam = {
			comboboxId: null,
			url: null,
			valueField: "id",
			textField: "text",
			callback: null
	};
	var config = $.extend(defaultParam, pConfig);
	var obj = $('#'+config.comboboxId);
	obj.combotree({
		url : config.url,
		valueField: config.valueField,
		textField: config.textField,
		onBeforeLoad: function(param){
			//param.needTip = true;//加上这个，下拉框返回"请选择"
		},
		onLoadSuccess: function (node, data) {
			if (data&&data.length>0) {
				obj.combotree('setValue',data[0].id);
				
			} else {
				
			}
			if(config.callback)config.callback();
		},
		onChange:function(newValue, oldValue){
			if(config.onChange)config.onChange(newValue, oldValue);
		},
		onSelect:function(node) {
			if(config.onSelect)config.onSelect(node.id);
	   }
	});
}

$.showConfirm = function(params) {
    var finalParams = {
        text: "float_loading",  // 信息内容
        callback:function(yes) {}    // 确认框回调函数    yes=true(确认), false(取消或者X)
    };
    if (params) $.extend(finalParams, params);
    $.messager.confirm('Confirm', Message[finalParams.text], function(r){
    	if (r){
    		finalParams.callback(true)
    	} else {
    		finalParams.callback(false);
    	}
    });
};
$.showAlert = function(params) {
	var finalParams = {
			text: "float_loading",  // 信息内容
			callback : function(){} // 关闭后回调函数
	};
	if (params) $.extend(finalParams, params);
	$.messager.alert('警告',Message[finalParams.text],'error', finalParams.callback);
	
};