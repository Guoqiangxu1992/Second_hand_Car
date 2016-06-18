function initParams(params) {

	if(typeof params == 'object') {
		window.ctx = params.ctx;
		window.skin = params.skin;
		window.localAddr = params.localAddr;
		window.vodUrl = params.vodUrl;
		window.userID = params.userID;
		window.fileID = params.fileID;
		window.subfileID = params.subfileID;
		window.duration = textToSeconds(params.duration);
		window.adjustTime = params.adjustTime;
		window.heartInterval = params.heartInterval;
		window.startTimeId = params.startTimeId;
		window.isShowHSBtn = params.isShowHSBtn;
		window.sdVideoUrl = params.sdVideoUrl;
		window.hdVideoUrl = params.hdVideoUrl;
		window.sdStreamerUrl = params.sdStreamerUrl;
		window.hdStreamerUrl = params.hdStreamerUrl;
		window.sdFileUrl = params.sdFileUrl;
		window.hdFileUrl = params.hdFileUrl;
		window.strmType = params.strmType;
		window.hasOcr = params.hasOcr;
		window.hasDot = params.hasDot;
		window.hasTxtDot = params.hasTxtDot;
		window.canEditTxtIndex = params.canEditTxtIndex;
		window.hasEditFileRight = params.hasEditFileRight;
		window.hasDotAddRight = params.hasDotAddRight;
		window.hasDotLookRight = params.hasDotLookRight;
		window.hasDotEditRight = params.hasDotEditRight;
		window.id = window.localAddr + "-" +  new Date().getTime() + "-" + parseInt(Math.random() * 10000);
		window.asType = params.asType;
		window.remote = params.remote;
	}
}

function getTextDot$Xml(func) {
	// 初始化有无文字搜引
	var vodUrlStr = window.vodUrl,
	indexXmlUrl = vodUrlStr.substring(0, vodUrlStr.lastIndexOf('/')) + "/index.xml?timeStamp=" + new Date().getTime();
	$.ajax({
		url : indexXmlUrl,
		dataType: 'xml',
		success: func 
	});
}

function setCurrentPlayTime(time) {
	var parentWin = window.document.getElementById('vodIframe').contentWindow, 
		func = parentWin.setCurrentPlayTime,
		func0 = parentWin.getPlayState;
	
	if(func && func0 && func0() == 'play') {
		func(time);
	}
	
}

function getCurrentPlayTime() {
	var func = window.document.getElementById('vodIframe').contentWindow.getCurrentPlayTime;
	if(func) {
		return func();
	}
	return 0;
}

function setCurrentTimePoint(time) {
	window.currentTimePoint = time;
	window.isRefresh = true;
}

function playInvokedBySilverlight() {
	var timeId = window.startTimeId;
	if(timeId > 0 && !window.isRefresh) {
		setCurrentPlayTime(timeId);
	} else if(window.isRefresh) {
		setCurrentPlayTime(window.currentTimePoint);
		window.isRefresh = false;
	}
}

/**
 * 心跳函数
 */
function heart() {
	$.ajax({
		url : window.ctx + "/vodheart.do",
		data : "id=" + window.id,
		method: 'POST',
		dataType : 'text',
		success : function(r) {
		}
	});
}

/**
 * 时间秒和文本互转函数 
 */
function secondsToText(times) {
	if(typeof parseInt(times) == 'number') {
		var hours = Math.floor(times / 3600),
			minutes = Math.floor((times % 3600) / 60),
			seconds = (times % 3600) % 60;
		return ((hours < 10) ? ("0" + hours) : hours) + ":" + ((minutes < 10) ? ("0" + minutes) : minutes) + ":" + ((seconds < 10) ? ("0" + seconds) : seconds);
	}
	return '00:00:00';
}

function textToSeconds(timeText) {
	var timeArr = timeText.split(':');
	for ( var i = 0; i < timeArr.length; i++) {
		if(isNaN(timeArr[i])) {
			return 0;
		}
	}
	while(timeArr.length < 3 ) {
		timeArr.push(0);
	}
	return parseInt(3600 * timeArr[0]) + parseInt(60 * timeArr[1]) + parseInt(1*timeArr[2]);
}

/**
 * OCR索引字符较多时，折叠按钮事件初始化
 */
function initMoreEventsOCR() {
	$('.openMore').unbind().click(function() {
		var $this = $(this), $parent = $this.parent();
		$('.closeMore').click();
		$parent.hide();
		$parent.next().show();
	});
	$('.closeMore').unbind().click(function() {
		var $this = $(this), $parent = $this.parent();
		$parent.hide();
		$parent.prev().show();
	});
}


/**
 * DOT索引编辑、删除
 */
function initEvtsEditDelDOT() {
	$('.editdot').unbind().click(function() {
		var $this = $(this),
			formatTime = $this.siblings('.formatTime').text(),
			dotID = $this.siblings('input:hidden').val(),
			content = $this.parent().siblings('.indexcon').find('p').text();
		
		$('#btndot').hide();
		$('#dotedit').show();
		$('#editDotID').val(dotID);
		$('#edittype').val(1);
		$('#dottime').val(formatTime);
		$('.spinner').show();
		$('#dottime1').hide();
		$('#dotcontent').val(content).focus();
	});
	
	$('.deldot').unbind().click(function() {
		var confirm = window.confirm(Message.dot_surecancel);
		if(confirm) {
			var $this = $(this),
			dotID = $this.siblings('input:hidden').val();
			
			$.ajax({
				url : window.ctx + "/backstage/File.action",
				data : {'cmd' : 16031, 'dotID' : dotID},
				success : function(result) {
					if(result == 'success') {
						refreshDotIndex();
					} else {
						alert(Message.dot_cancelfail);
					}
				}
			});
		} else {
			return false;
		}
	});
}

/**
 * 文字索引编辑、删除
 */
function initEvtsEditDelTxt() {
	$('.edittxt').unbind().click(function() {
		var $this = $(this),
			formatTime = $this.siblings('.formatTime').text(),
			content = $this.parent().siblings('.indexcon').find('p').text();
		
		$('#btndot').hide();
		$('#dotedit').show();
		$('#edittype').val(2);
		$('#dottime, #dottime1').val(formatTime);
		$('.spinner').hide();
		$('#dottime1').show();
		$('#dotcontent').val(content).focus();
	});
	
	$('.deltxt').unbind().click(function() {
		var confirm = window.confirm(Message.dot_surecancel);
		if(confirm) {
			var $this = $(this),
			formatTime = $this.siblings('.formatTime').text(),
			timeId = textToSeconds(formatTime);
			$.ajax({
				url : window.ctx + "/backstage/File.action",
				data : {'cmd' : 16045, 'fileId' : window.fileID, 'subfileID' : window.subfileID, 'timeId' : timeId, 'strmType' : window.strmType},
				success : function(result) {
					if(result == 'success') {
						refreshTxtDotIndex();
					} else {
						alert(Message.dot_cancelfail);
					}
				}
			});
		} else {
			return false;
		}
	});
}

/**
 * 调整索引区高度
 */
function adjustFrameHeight() {
	var $westDiv = $('.ui-layout-west'), $tagMenu = $('.tagMenu');
    $('.frame, .scrollbar').height($westDiv.height() - $tagMenu.height() - 3);
}

/**
 * 获取打点信息，并初始化滚动条
 */
function refreshDotIndex() {
	if(!window.userID) {
		return false;
	}
	
	$.ajax({
		url : window.ctx + "/backstage/File.action",
		data : {'cmd' : 16029, 'fileID' : window.subfileID, 'asId' : window.asType},
		success : function(result) {
			var dotList = $.stringToJson(result);
			var htmlStr = '';
			if(dotList && dotList.length > 0) {
				for(var i=0; i<dotList.length; i++) {
					var item = dotList[i],
						itemStr = '<li class="index">';
						itemStr += '<div class="indextitle">' + (i+1) + '.  <label class="formatTime" onclick="setCurrentPlayTime(' + item.timeID + ');">' + secondsToText(item.timeID) + '</label>';
						if((window.hasDotEditRight || window.userID == item.userID)) {
							itemStr += '<img alt="' + Message.dot_edit + '" class="editdot" src="' + ctx + '/skins/' + skin + '/images/dotedit.png">';
							itemStr += '<img alt="' + Message.dot_delete + '" class="deldot" src="' + ctx + '/skins/' + skin + '/images/dotdelete.png">';
							itemStr += '<input type="hidden" value="' + item.id + '" />';
						}
						itemStr += '</div><div class="indexcon"><p onclick="setCurrentPlayTime(' + item.timeID +  ');">';
						itemStr += item.content + '</p></div></li>';
					htmlStr += itemStr;
				}
			}
			$('#dotIndex').html(htmlStr);
			initSlyDot();
			initEvtsEditDelDOT();
		}
	});
}

/**
 * 获取文字索引，并初始化滚动条
 */
function refreshTxtDotIndex() {
	getTextDot$Xml(function(ret) {
		var $xml = $(ret), htmlStr = '', index = 0;
		$xml.find('index').each(function() {
			index++;
			var $this = $(this), itemStr = '<li class="index">';
			itemStr += '<div class="indextitle">' + index + '.  <label class="formatTime" onclick="setCurrentPlayTime(' + $this.attr('time') + ');">' + secondsToText($this.attr('time')) + '</label>';
			if(window.hasEditFileRight && window.canEditTxtIndex == "1") {
				itemStr += '<img alt="' + Message.dot_edit + '" class="edittxt" src="' + ctx + '/skins/' + skin + '/images/dotedit.png">';
				itemStr += '<img alt="' + Message.dot_delete + '" class="deltxt" src="' + ctx + '/skins/' + skin + '/images/dotdelete.png">';
				itemStr += '<input type="hidden" value="' + $this.attr('time') + '" />';
			}
			itemStr += '</div><div class="indexcon"><p onclick="setCurrentPlayTime(' + $this.attr('time') +  ');">';
			itemStr += $this.text() + '</p></div></li>';
			htmlStr += itemStr;
		});
		$('#txtIndex').html(htmlStr);
		initSlyTxt();
		initEvtsEditDelTxt();
	});
}

function initSlyOcr() {
	if(!window.hasOcr) {
		return false;
	}
	adjustFrameHeight();
	if(window.slyObjOcr) {
		window.slyObjOcr.reload();
	} else {
		var $frame1  = $('#smart1');
		var $wrap1   = $frame1.parent();
		window.slyObjOcr = new Sly($frame1, {
			itemNav: 'basic',
			//smart: 1,
			activateOn: 'mouseenter',
			mouseDragging: 1,
			touchDragging: 1,
			releaseSwing: 1,
			scrollBar: $wrap1.find('.scrollbar'),
			scrollBy: 1,
			activatePageOn: 'click',
			speed: 300,
			elasticBounds: 1,
			easing: 'easeOutExpo',
			dragHandle: 1,
			dynamicHandle: 1,
			clickBar: 1
		}).init();
	}
}

/**
 * 初始化打点索引滚动条
 */
function initSlyDot() {
	if(!window.hasDot) {
		return false;
	}
	adjustFrameHeight();
	if(window.slyObjDot) {
		window.slyObjDot.reload();
	} else {
		var $frame2  = $('#smart2');
		var $wrap2   = $frame2.parent();
		window.slyObjDot = new Sly($frame2, {
			itemNav: 'basic',
			//smart: 1,
			activateOn: 'mouseenter',
			mouseDragging: 1,
			touchDragging: 1,
			releaseSwing: 1,
			scrollBar: $wrap2.find('.scrollbar'),
			scrollBy: 1,
			activatePageOn: 'click',
			speed: 300,
			elasticBounds: 1,
			easing: 'easeOutExpo',
			dragHandle: 1,
			dynamicHandle: 1,
			clickBar: 1
		}).init();
	}
}

/**
 * 初始化文字索引滚动条
 */
function initSlyTxt() {
	if(!window.hasTxtDot) {
		return false;
	}
	adjustFrameHeight();
	if(window.slyObjTxt) {
		window.slyObjTxt.reload();
	} else {
		var $frame3  = $('#smart3');
		var $wrap3   = $frame3.parent();
		window.slyObjTxt = new Sly($frame3, {
			itemNav: 'basic',
			//smart: 1,
			activateOn: 'mouseenter',
			mouseDragging: 1,
			touchDragging: 1,
			releaseSwing: 1,
			scrollBar: $wrap3.find('.scrollbar'),
			scrollBy: 1,
			activatePageOn: 'click',
			speed: 300,
			elasticBounds: 1,
			easing: 'easeOutExpo',
			dragHandle: 1,
			dynamicHandle: 1,
			clickBar: 1
		}).init();
	}
}

$(function() {
	$('.tagMenu').show();
	// 页面布局
	var	myLayout = $('body').layout({
		west__size: 286,
		west__spacing_open: 8,
		west__spacing_closed: 8,
		west__togglerLength_open: 44,
		west__togglerLength_closed:	44,
		west__onopen: function() {
			initSlyOcr();
			initSlyDot();
			initSlyTxt();
		},
		west__onresize_end: function() {
			initSlyOcr();
			initSlyDot();
			initSlyTxt();
		},
		center__maskContents: true
	});
	myLayout.close('west');
	
	// 初始化视频源
	var vodUrl = window.vodUrl;
	//vodUrl = "http://192.168.7.23/Rec/20130426102553cFhlhP/SD/resource/content.htm";
	var flashParams = "?sdVideoUrl=" + window.sdVideoUrl 
					+ "&hdVideoUrl=" + window.hdVideoUrl 
					+ "&sdStreamerUrl=" + window.sdStreamerUrl 
					+ "&hdStreamerUrl=" + window.hdStreamerUrl 
					+ "&sdFileUrl=" + window.sdFileUrl 
					+ "&hdFileUrl=" + window.hdFileUrl
					+ "&startPlayTime=" + window.startTimeId
					+ "&isShowHSBtn=" + window.isShowHSBtn;
	flashParams = flashParams.replace(/\//g, "!");
	vodUrl += flashParams;
	$(".vod").attr("src", vodUrl);
	//加入最近观看列表
	var fileID = window.fileID;
	var recentFileObj = $.cookies.get("recentFileObj");
	if(!recentFileObj || typeof recentFileObj !== 'object') {
		recentFileObj = {};
	}
	var tempName=window.userID;
	if(window.userID==null || window.userID==''){
		tempName = "NOTLOGIN";
	}
	recentFileObj["" + fileID] = "" + new Date().getTime() + "|" +window.asType+ "|" + tempName + "";
	$.cookies.set("recentFileObj", recentFileObj, {hoursToLive : 7*24});
	heart();
  	setInterval("heart()", window.heartInterval);

  	if(window.remote !== '0') {
  		// 说明点播的课件是通过URL推送的远程课件，不显示左侧索引面板
  		myLayout.hide('west');
  	} else {
  		// 判断是否有文字索引，如果没有一条，则文字索引界面不显示出来
  	  	getTextDot$Xml(function(ret) {
  	  		var $xml = $(ret);
  	  		window.hasTxtDot = window.hasTxtDot && ($xml.find('index').length > 0);
  			window.hasDot = window.hasDot && (window.hasDotAddRight || window.hasDotLookRight);
  			
  			if(window.hasOcr && !window.hasDot && !window.hasTxtDot) {
  				// 只有OCR索引
  				$('#menudot, #menutxt, #dotWrap, #txtWrap').remove();
  				$('#menuocr').width(286);
  			} else if(!window.hasOcr && window.hasDot && !window.hasTxtDot) {
  				// 只有打点索引
  				$('#menuocr, #menutxt, #ocrWrap, #txtWrap').remove();
  				$('#menudot').width(286);
  			} else if(!window.hasOcr && !window.hasDot && window.hasTxtDot) {
  				// 只有文字索引
  				$('#menuocr, #menudot, #ocrWrap, #dotWrap').remove();
  				$('#menutxt').width(286);
  			} else if(window.hasOcr && window.hasDot && !window.hasTxtDot) {
  				// 只有OCR索引和打点索引
  				$('#menutxt, #txtWrap').remove();
  				$('#menuocr, #menudot').width(141);
  			} else if(window.hasOcr && !window.hasDot && window.hasTxtDot) {
  				// 只有OCR索引和文字索引
  				$('#menudot, #dotWrap').remove();
  				$('#menuocr, #menutxt').width(141);
  			} else if(!window.hasOcr && window.hasDot && window.hasTxtDot) {
  				// 只有打点索引和文字索引
  				$('#menuocr, #ocrWrap').remove();
  				$('#menudot, #menutxt').width(141);
  			} else if(window.hasOcr && window.hasDot && window.hasTxtDot) {
  				// OCR索引、打点索引和文字索引都有
  				$('#menuocr, #menudot, #menutxt').width(94);
  			} else {
  				// 默认为三者都没有
  				myLayout.hide('west');
  			}
  			
  			// 没有打点添加权限
  			if(!window.hasDotAddRight) {
  				$('#btndot').remove();
  			}
  			
  			// 没有打点查看权限
  			if(!window.hasDotLookRight) {
  				$('#dotIndex').remove();
  			}
  			
  			$('#btndot').click(function() {
  				var currentTime = Math.floor(getCurrentPlayTime());
  				currentTime += parseInt(window.adjustTime);
  				
  				if(currentTime < 0) {
  					currentTime = 0;
  				} else if(window.duration && (currentTime > window.duration)) {
  					currentTime = window.duration;
  				}
  				
  				$('#btndot').hide();
  				$('#dotedit').show();
  				$('#edittype').val(0);
  				$('#dottime').val(secondsToText(currentTime));
  				$('.spinner').show();
  				$('#dottime1').hide();
  				$('#dotcontent').val('').focus();
  			});
  			
  			$('#dotsave').click(function() {
  				var timeText = $('#dottime').val(),
  					time = textToSeconds(timeText),
  					content = $('#dotcontent').val(),
  					type = $('#edittype').val(),
  					cmd = 16028, // 添加打点索引
  					dotID = $('#editDotID').val();
  				
  				if(type == 1) {
  					cmd = 16030; // 修改打点索引
  				} else if(type == 2) {
  					cmd = 16044; // 修改文字索引
  				}
  				
  				if(!timeText || !content) {
  					alert(Message.dot_cantempty);
  					return false;
  				}
  				
  				if(content.length > 128) {
  					alert(Message.dot_textwarn);
  					return false;
  				}
  				
  				if(time < 0) {
  					time = 0;
  				} else if(window.duration && (time > window.duration)) {
  					time = window.duration;
  				}
  				
  				content = content.replace(/\\/g, '');
  				$.ajax({
  					url : window.ctx + "/backstage/File.action",
  					data : {'cmd' : cmd, 'time' : time, 'content' : content, 'fileID' : window.fileID, 'subfileID' : window.subfileID, 'dotID' : dotID, 'strmType' : window.strmType},
  					success : function(result) {
  						if(result == 'success') {
  							$('#dotcancel').click();
  							if(type == 2) {
  								refreshTxtDotIndex();
  								return true;
  							}
  							refreshDotIndex();
  						} else {
  							alert(Message.dot_submitfail);
  						}
  					}
  				});
  				
  			});
  			
  			$('#dotcancel').click(function() {
  				var curr = $('.current');
  				$('#dotedit').hide();
  				if(curr.attr('id') == 'menudot' && window.hasDotAddRight) {
  					$('#btndot').show();
  				} else {
  					$('#btndot').hide();
  				}
  			});
  			
  			$('#dottime').timespinner({  
  			    showSeconds: true,
  			    highlight: 2
  			}).css({
  				width: '80px',
  				height: '21px'
  			});
  			
  			// 初始化tab标签
  			$('#menuocr').click(function() {
  				var $this = $(this);
  				if($this.hasClass('current')) {
  					return false;
  				} else {
  					$this.addClass('current').siblings().removeClass('current');
  					$('#dotWrap, #txtWrap').addClass('hideMe');
  					$('#ocrWrap').removeClass('hideMe');
  					$('#dotcancel').click();
  				}
  				initSlyOcr();
  			});
  			
  			$('#menudot').click(function() {
  				var $this = $(this);
  				if($this.hasClass('current')) {
  					return false;
  				} else {
  					$this.addClass('current').siblings().removeClass('current');
  					$('#ocrWrap, #txtWrap').addClass('hideMe');
  					$('#dotWrap').removeClass('hideMe');
  					$('#dotcancel').click();
  				}
  				refreshDotIndex();
  			});
  			
  			$('#menutxt').click(function() {
  				var $this = $(this);
  				if($this.hasClass('current')) {
  					return false;
  				} else {
  					$this.addClass('current').siblings().removeClass('current');
  					$('#ocrWrap, #dotWrap').addClass('hideMe');
  					$('#txtWrap').removeClass('hideMe');
  					$('#dotcancel').click();
  				}
  				refreshTxtDotIndex();
  			});
  			
  			if(window.hasOcr) {
  				$('#menuocr').click();
  			} else if(window.hasDot) {
  				$('#menudot').click();
  			} else {
  				$('#menutxt').click();
  			}
  			
  			initMoreEventsOCR();
  	  	});
  	}
  	
});
