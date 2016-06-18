<%@ page contentType="text/html; charset=UTF-8"%>
 <%@ include file="/WEB-INF/jsp/common.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<title>二手车交易平台</title>
		  
	   
<script type="text/javascript">
var lastTabs = new Array(); 
var currentTabTitle = "Home";
$(document).ready(function () {
	 $(".easyui-accordion li").mouseover(function(){
		 if($(this).hasClass("clicked")) {
			 return;
		 } else {
			 $(this).addClass("menuHover");
		 }
	 });
	 $(".easyui-accordion li").mouseout(function(){
		 if($(this).hasClass("clicked")) {
			 return;
		 } else {
			 $(this).removeClass("menuHover");
		 }
	 });
	 $(".easyui-accordion li").click(function(){
		 //退出登录
		 if($(this).attr("href").indexOf("/ajaxLogout.do")>0){
			 $.ajax({
					url : $(this).attr("href"),
					data : null,
					method: 'POST',
					dataType : 'text',
					success : function(r) {
						window.location="${ctx}/login/tologin.do";
					}
				});
		 } else
		 if($(this).hasClass("clicked")) {
			 refreshTab({tabTitle:$(this).attr("title"),url:$(this).attr("href")});
		 } else {
			 $(".easyui-accordion .clicked").removeClass("clicked");
			 $(this).removeClass("menuHover");
			 $(this).addClass("clicked");
			 addTab($(this).attr("title"),$(this).attr("href"),null);
	
		 }
	 });
	 
	 $("#forword").click(function(){
		 //退出登录
		 if($(this).attr("href").indexOf("/ajaxLogout.do")>0){
			 $.ajax({
					url : $(this).attr("href"),
					data : null,
					method: 'POST',
					dataType : 'text',
					success : function(r) {
						window.location="${ctx}/login/tologin.do";
					}
				});
		 } else
		 if($(this).hasClass("clicked")) {
			 refreshTab({tabTitle:$(this).attr("title"),url:$(this).attr("href")});
		 } else {
			 $(".easyui-accordion .clicked").removeClass("clicked");
			 $(this).removeClass("menuHover");
			 $(this).addClass("clicked");
			 addTab($(this).attr("title"),$(this).attr("href"),null);
	
		 }
	 });
	 
	 $('.easyui-tabs').tabs({
		 onSelect: function(title) { 
			//移除 tt 
			lastTabs = $.grep(lastTabs, function(n, i) { return n != title; }); 
			//重新压入，保证 最新的在最上面 
			lastTabs.push(title); 
			//更新当前 
			currentTabTitle = title; 
			var clickedMenu =  $(".easyui-accordion .clicked");
			 if(clickedMenu) {
				 clickedMenu.removeClass("clicked");
				 $(".easyui-accordion li[title='"+title+"']").addClass("clicked");
				 
				 //展开tab所属的一级菜单
				var menuGroupTitle = $(".easyui-accordion li[title='"+title+"']").parent().parent().attr("atitle");
				  if(clickedMenu.parent().parent().attr("atitle") !=menuGroupTitle  ) {
					  $("#aa").accordion('select', menuGroupTitle);
				 }
				 
			 }
			 
			 
			}, 
		 onClose:function(title){   
			 var tt = $('.easyui-tabs');
			//移除 tt 
			 lastTabs = $.grep(lastTabs, function(n, i) { return n != title; }); 
			 //重新选择 
			 tt.tabs('select', lastTabs[lastTabs.length - 1]); 
			 
			 
			 var clickedMenu =  $(".easyui-accordion .clicked");
			 if(clickedMenu) {
				 if(clickedMenu.attr("title") == title) {
					 clickedMenu.removeClass("clicked");
				 }
			 }
	      }   
	  });
});

function removePanel(){
	 var tt = $('.easyui-tabs');
    var tab = tt.tabs('getSelected');
    if(tab){
        var index = tt.tabs('getTabIndex',tab);
        alert(index);
        tt.tabs('close',index);
    }
}

function addTab(title, href,icon){
	var tt = $('.easyui-tabs');
	if (tt.tabs('exists', title)){//如果tab已经存在,则选中并刷新该tab    	
        tt.tabs('select', title);
        refreshTab({tabTitle:title,url:href});
	} else {
		var content = '未实现';
    	if (href){
	    	 content = '<iframe scrolling="no" frameborder="0"  src="'+href+'" style="width:100%;height:100%;"></iframe>';
    	} else {
    	}
    	tt.tabs('add',{
	    	title:title,
	    	closable:true,
	    	content:content,
	    	iconCls:icon||'icon-default'
    	});
	}
}
/**    
 * 刷新tab
 * @cfg 
 *example: {tabTitle:'tabTitle',url:'refreshUrl'}
 *如果tabTitle为空，则默认刷新当前选中的tab
 *如果url为空，则默认以原来的url进行reload
 */
function refreshTab(cfg){
	var refresh_tab = cfg.tabTitle?$('.easyui-tabs').tabs('getTab',cfg.tabTitle):$('.easyui-tabs').tabs('getSelected');
	if(refresh_tab && refresh_tab.find('iframe').length > 0){
	var _refresh_ifram = refresh_tab.find('iframe')[0];
	var refresh_url = cfg.url?cfg.url:_refresh_ifram.src;
	//_refresh_ifram.src = refresh_url;
	_refresh_ifram.contentWindow.location.href=refresh_url;
	}
}


</script> 
<style type="text/css"> 
.easyui-accordion li {
	width: 100%; height: 30px;
	line-height: 30px;
	cursor:pointer;
}
.clicked{
 background: #99cdff;
}
.menuHover{
 background: #eaeac4;
}
.footer {
        width: 100%;
        text-align: center;
        line-height: 35px;
    }

.top-bg {
    background-color: #d8e4fe;
    height: 80px;
}
.panel-title {
  font-size: 12px;
  font-weight: bold;
  color: #0E2D5F;
  height: 16px;
  padding: 0 10px 5px 20px;
}
.tb_title{font-size:26px;color:#0E2D5F;float:left;line-height:80px;padding-left:20px;}
.user_name{font-size:20px;color:#fa3438;padding:0 10px;}
.main_r_title{font-size:16px;font-weight:bold;color:#333;line-height:30px;width:100%;display:inline-block;text-align:left;}
.main_rule{font-size:12px;color:#333;line-height:24px;width:100%;margin:10px 0;text-align:left;}
.main_detail{text-align:left;margin:10px 0;}
 </style>
</head>
<body class="easyui-layout" data-options="fit:true">
    <div region="north" border="true" split="true" style="overflow: hidden; height: 80px;">
        <div class="top-bg">
        	<p class="tb_title">二手车交易平台</p>
        	<div style=" height:35px; float: right; margin-top:40px; font-size: 18px; padding-right: 20px;">
        		<p>
        		<span class="user_name">${SESSION_LOGIN_USER.fullName }</span>
        		<span style="font-size:14px;color:#333;">欢迎您！</span>
        		<span style="color:#999;font-size:12px;">登录时间：${currentDate }</span>
        		</p>
        	</div>
        </div>
    </div>
    <div region="south" border="true" split="true" style="overflow: hidden; height: 40px;">
        <div class="footer">版权所有：<a href="#"></a></div>
    </div>
    <div region="west" split="true" title="导航菜单" style="width: 200px;">
    	<div id="aa" class="easyui-accordion" >
            <c:forEach items="${treeList}" var="m">
            	<div title="${m.menuName }"  iconcls="" style="overflow: auto; padding: 4px 0px;">
    			<ul style="list-style: none; margin: 0; width: 100%; padding: 0; text-align: center; vertical-align: middle;">
    				<c:forEach items="${m.children}" var="child">
    					<li href="${ctx }${child.menuAction }"  title="${child.menuName }">${child.menuName }
    				</c:forEach>
    			</ul>
    			</div>
            </c:forEach>
    	</div>
    </div>
    <div id="mainPanle" region="center" style="overflow: hidden;">
    	<div class="easyui-tabs" data-options="tabWidth:112,tools:'#tab-tools', fit:true" style="width:100%;height:100%;">
			<div title="主界面" style="padding:10px" style="width:100%; height:100%;">
				<div id="p"  style="width:90%;height:90%;padding:10px; text-align: center; margin:0 auto;">
					<p style="font-size: 20px;">请务必先阅读主界面上关于本交易平台的<span style="font-weight:bold;">交易流程</span>和<span style="font-weight:bold;">注意事项</span>，避免您在交易过程中遇到困扰！谢谢您的合作！<p>
				   	<div class="main_rule">
					<p class="main_r_title">交易流程：</p>
					<p class="main_r_detail">1、买家和商家都需直接联系管理员才能进行本平台上的账号注册，</p>
					<p class="main_r_detail">2、商家登录后可自行录入车辆信息，并及时发布。</p>
					<p class="main_r_detail">3、商家的车辆信息发布后，买家可登陆自己的账号进行有意向的车辆信息查询。</p>
					<p class="main_r_detail">4、买家确定欲购买的车辆后，可在“二手车信息”中点击购买，进行提前预定。商家在看到车辆预定后，请务必及时处理订单，</p>
					<p class="main_r_detail">5、双方联系后，可自行选择是否继续本次交易。</p>
					</div>
				    <div class="main_rule">
					  	<p class="main_r_title">注意事项:</p>
						<p class="main_r_detail">0、二手车交易网是专为二手车买卖在网上搭建的第三方交易平台，为汽车消费者提供丰富的购车信息，是用户购车前参考选购车辆，购车后获得服务、维修和养护资料的综合性汽车资讯网站。</p>
						<p class="main_r_detail">1、二手车手续费者对要买的二手车的手续有一个详细的了解，有些买车人因为图便宜选择购买一些手续不完，不能过户的二手车，这样不仅买家会有麻烦，卖家也会存在相同的麻烦。</p>
						<p class="main_r_detail">2、二手车交易需要的手续有车辆登记证、行驶证、购车发票、保险单以及交易双方的身份证。</p>
						<p class="main_r_detail">3、二手车里程表作假汽车里程表主要分为两种，即机械式和电子式。机械式里程表利用的是齿轮转动的工作原理，只要拨动里程表计数器的齿轮，就能随意调整读数。而后者的回调难度要大一些，</p>
						<p class="main_r_detail">4、但也不是不可能。很多人都习惯通过了解车辆的使用年限及公里数可以判断原车主的用车情况，这个想法是没有问题的，但判断车况不能单凭里程表，因为这个是可以改动的，建议消费者提高警惕。</p>
						<p class="main_r_detail">5、车况是否隐瞒问题一要进行目测检查，这其中包括检查车辆发动机型号和出厂编号、底盘型号是否与行车执照上的记载吻合。二是车辆的技术状况检查，包括检查车辆是否发生碰撞受损、车门是否平衡、油漆脱落情况和车辆的金属锈蚀程度等。</p>
						<p class="main_r_detail">6、三是车厢内部、附属装置、车辆底部检查，要看座位的新旧程度、座椅是否下凹，以及行李箱的随车工具是否完整，车窗玻璃升降是否灵活、仪表是否原装、踏板是否有弹性等。</p>
						<p class="main_r_detail">7、四是发动机检查，包括观察发动机的外部状况，看汽缸外有无油迹露出；检查发动机油量，拿出机油量度尺看机油是否混浊不堪或起水泡；揭开水箱盖看风扇皮带是否松紧合适等。</p>
					</div>

				</div>
			</div>
		</div>
    </div>
</body>
</html>
