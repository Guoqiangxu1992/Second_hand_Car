<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@  page isELIgnored="false"%> 
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
 <c:set var="ctx" value="${pageContext.request.contextPath}" ></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache"> 
<meta http-equiv="cache-control" content="no-cache"> 
<meta http-equiv="expires" content="0">   
<title>二手车交易平台</title>

		<script src="${ctx}/js/easyui/jquery.min.js" type="text/javascript"></script>
		<script src="${ctx}/js/easyui/jquery.easyui.min.js" type="text/javascript"></script>
		<script src="${ctx}/js/easyui/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
		<script src="${ctx}/js/jquery.serializeJson.js" type="text/javascript"></script>
		<script src="${ctx}/js/easyui/easyui-validate-extend.js" type="text/javascript"></script>
		<script src="${ctx}/js/myfun.js" type="text/javascript"></script>
		<script src="${ctx}/js/silder.js" type="text/javascript"></script>
		<script src="${ctx}/js/jquery.cookie.js" type="text/javascript"></script>
		
		<link href="${ctx}/js/easyui/themes/default/easyui.css" rel="stylesheet" type="text/css" />
		<link href="${ctx}/js/easyui/themes/icon.css" rel="stylesheet" type="text/css" />
		<link href="${ctx}/css/main.css" rel="stylesheet" type="text/css" />
		<link href="${ctx}/css/layout.css" rel="stylesheet" type="text/css" />
		<link href="${ctx}/css/lay.css" rel="stylesheet" type="text/css" />
		

		
</head>
<body>
<input type="hidden" id="ctx" value="${ctx }">
</body>
</html>