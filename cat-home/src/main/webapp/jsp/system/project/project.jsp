<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="a" uri="/WEB-INF/app.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="res" uri="http://www.unidal.org/webres"%>
<%@ taglib prefix="w" uri="http://www.unidal.org/web/core"%>

<jsp:useBean id="ctx" type="com.dianping.cat.system.page.config.Context" scope="request"/>
<jsp:useBean id="payload" type="com.dianping.cat.system.page.config.Payload" scope="request"/>
<jsp:useBean id="model" type="com.dianping.cat.system.page.config.Model" scope="request"/>

<a:config>
	<res:useJs value="${res.js.local['alarm_js']}" target="head-js" />
	<script type="text/javascript">
		$(document).ready(function() {
			$('#domain-config').addClass('active open');
			$('#projects').addClass('active');

			if("${payload.action.name}" != 'projects') {
				var state = '${model.opState}';
				if(state=='Success'){
					$('#state').html('操作成功');
				}else{
					$('#state').html('操作失败');
				}
				setInterval(function(){
					$('#state').html('&nbsp;');
				},3000);
			}

			$.widget( "custom.catcomplete", $.ui.autocomplete, {
				_renderMenu: function( ul, items ) {
					var that = this,
					currentCategory = "";
					$.each( items, function( index, item ) {
						if ( item.category != currentCategory ) {
							ul.append( "<li class='ui-autocomplete-category'>" + item.category + "</li>" );
							currentCategory = item.category;
						}
						that._renderItemData( ul, item );
					});
				}
			});

			var data = [];
			<c:forEach var="project" items="${model.projects}">
						var item = {};
						item['label'] = '${project.domain}';
						item['category'] ='${project.bu} - ${project.cmdbProductline}';

						data.push(item);
			</c:forEach>

			$( "#search" ).catcomplete({
				delay: 0,
				source: data
			});

			$("#search_go").bind("click",function(e){
				var newUrl = '/cat/s/config?op=projects&domain='+$( "#search" ).val() +'&date=${model.date}';
				window.location.href = newUrl;
			});
			$('#wrap_search').submit(
				function(){
					var newUrl = '/cat/s/config?op=projects&domain='+$( "#search" ).val() +'&date=${model.date}';
					window.location.href = newUrl;
					return false;
				}
			);
		});
	</script>
	<div class="navbar-header pull-left position" style="width:350px;MARGIN-LEFT:10px;MARGIN-TOP:5px;padding:3px;">
		<form id="wrap_search" style="margin-bottom:0px;">
		<div class="input-group">
			<c:if test="${not empty payload.project.domain}">
				<c:set var="domain" value="${payload.project.domain}"/>
			</c:if>
			<c:if test="${not empty payload.domain}">
				<c:set var="domain" value="${payload.domain}"/>
			</c:if>
			<c:if test="${empty domain}">
				<c:set var="domain" value="cat"/>
			</c:if>
			<span class="input-icon" style="width:300px;">
				<input type="text" placeholder="input domain for search" value="${domain}" class="search-input search-input form-control ui-autocomplete-input" id="search" autocomplete="off" />
				<i class="ace-icon fa fa-search nav-search-icon"></i>
				</span>
				<span class="input-group-btn" style="width:50px">
				<button class="btn btn-sm btn-primary" type="button" id="search_go" style="height: 34px;vertical-align: middle;">
				Go
				</button>
 				</span>
 				 <span class="input-group-addon">请输入你的项目，默认是cat。找不到你的项目？请点<a href="/cat/s/config?op=projectAdd"><strong>添加</strong></a></span>
			</div>
		</form>
	</div>
	<br/>F
	<br/>
	<br/>
	<div style="padding:5px;">
	<form name="projectUpdate" id="form" method="get" action="${model.pageUri}?op=updateSubmit">
	<table class="table table-striped table-condensed " style="margin-top: -12px;">
		<input type="hidden" name="project.id" value="${model.project.id}" />
		<input type="hidden" name="project.domain" value="${model.project.domain}" />
		<input type="hidden" name="op" value="updateSubmit" />
		<tr>
			<td style="width:170px;">应用名称</td>
			<td style="width:333px;">${model.project.domain}</td>
			<td style="color:red">注意：建议使用半角英文和半角符号(. -)。</td>
		</tr>
		<tr style="display: none">
			<td style="width:170px;">CMDB应用名称</td>
			<td style="width:333px;"><input class="form-control" name="project.cmdbDomain" value="${model.project.cmdbDomain}" /></td>
			<td>CMDB中项目统一名称<span style="color:red">【CMDB中没有的话，与CAT上的应用名称保持一致即可】</span></td>
		</tr>
        <tr style="display: none">
			<td style="width:170px;">CMDB项目级别</td>
			<td style="width:333px;"><input class="form-control" name="project.level" value="${model.project.level}" /></td>
			<td>CMDB中项目统一级别<span  style="color:red">【此字段会和CMDB信息同步】</span></td>
		</tr>
		<tr>
			<td style="width:170px;">事业部</td>
			<td style="width:333px;"><input class="form-control" name="project.bu" value="${model.project.bu}" /></td>
            <td>所属部门名称</td>
		</tr>
		<tr>
			<td style="width:170px;">产品线</td>
			<td style="width:333px;"><input class="form-control" name="project.cmdbProductline" value="${model.project.cmdbProductline}" /></td>
            <td>所属产品线名称</td>
		</tr>
		<tr>
			<td style="width:170px;">负责人</td>
			<td style="width:333px;"><input class="form-control" name="project.owner" value="${model.project.owner}"/></td>
			<td>项目负责人</td>
		</tr>
		<tr>
			<td style="width:170px;">项目组邮件</td>
			<td style="width:333px;"><input name="project.email" class="form-control" value="${model.project.email}"/></td>
			<td>字段(多个，逗号分割)</td>
		</tr>
		<tr>
			<td style="width:170px;">项目组号码</td>
			<td style="width:333px;"><input name="project.phone" class="form-control" value="${model.project.phone}"/></td>
			<td>字段(多个，逗号分割)</td>
		</tr>
		<tr>
			<td style="width:15%;">项目键</td>
			<td><input name="project.key" class="form-control" value="${model.project.key}"/></td>
			<td>系统代码</td>
		</tr>
		<tr>
			<td style="width:15%;">项目经办人</td>
			<td><input name="project.assigner" class="form-control" value="${model.project.assigner}"/></td>
			<td>系统默认分配账号</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input class='btn btn-primary btn-sm' type="submit" name="submit" value="更新" />&nbsp;
			<a href="?op=projectDelete&projectId=${model.project.id}" class="btn btn-danger btn-sm delete" >删除</a>
						<h4 class="text-center text-danger" id="state">&nbsp;</h4></td>
		</tr>
	</table>
</form>

</div>
</a:config>
<style>
.input-icon>.ace-icon {
	z-index: 0;
}
</style>
