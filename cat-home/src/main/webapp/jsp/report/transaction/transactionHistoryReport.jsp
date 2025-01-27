<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="a" uri="/WEB-INF/app.tld"%>
<%@ taglib prefix="w" uri="http://www.unidal.org/web/core"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="res" uri="http://www.unidal.org/webres"%>
<jsp:useBean id="ctx"	type="com.dianping.cat.report.page.transaction.Context" scope="request" />
<jsp:useBean id="payload"	type="com.dianping.cat.report.page.transaction.Payload" scope="request" />
<jsp:useBean id="model"	type="com.dianping.cat.report.page.transaction.Model" scope="request" />
<style type="text/css">
.data th{
	word-break: normal;
}
.data td{
	word-break: normal;
}
</style>
<a:historyReport title="History Report" navUrlPrefix="type=${payload.encodedType}&queryname=${model.queryName}">
	<jsp:attribute name="subtitle">${w:format(payload.historyStartDate,'yyyy-MM-dd HH:mm:ss')} to ${w:format(payload.historyDisplayEndDate,'yyyy-MM-dd HH:mm:ss')}</jsp:attribute>
	<jsp:body>
<table class="machines">
	<tr style="text-align: left">
		<th>
		<c:forEach items="${model.ips}" var="value">
    		<c:if test="${value == 'All'}">
        	<c:set var="found" value="true" scope="request" />
    		</c:if>
		</c:forEach>
		<c:if test="${found != true}">
		&nbsp;[&nbsp;
			<c:choose>
				<c:when test="${model.ipAddress eq 'All'}">
					<a href="?op=history&domain=${model.domain}&date=${model.date}&type=${payload.encodedType}&queryname=${model.queryName}&reportType=${payload.reportType}${model.customDate}"
						class="current">All</a>
				</c:when>
				<c:otherwise>
					<a href="?op=history&domain=${model.domain}&date=${model.date}&type=${payload.encodedType}&queryname=${model.queryName}&reportType=${payload.reportType}${model.customDate}">All</a>
				</c:otherwise>
			</c:choose> &nbsp;]&nbsp;
		</c:if>
   	  		 <c:forEach var="ip" items="${model.ips}">&nbsp;[&nbsp;
   	  		    <c:choose>
					<c:when test="${model.ipAddress eq ip}">
						<a	href="?op=history&domain=${model.domain}&date=${model.date}&ip=${ip}&type=${payload.encodedType}&queryname=${model.queryName}&reportType=${payload.reportType}${model.customDate}"
									class="current">${ip}</a>
					</c:when>
					<c:otherwise>
						<a	href="?op=history&domain=${model.domain}&date=${model.date}&ip=${ip}&type=${payload.encodedType}&queryname=${model.queryName}&reportType=${payload.reportType}${model.customDate}">${ip}</a>
					</c:otherwise>
				</c:choose>
   	 		&nbsp;]&nbsp;
			 </c:forEach>
		</th>
	</tr>
</table>
<script type="text/javascript" src="/cat/js/appendHostname.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		appendHostname(${model.ipToHostnameStr});
	});
</script>
<table class="groups">
	<tr class="left">
		<th>
			<c:forEach var="group" items="${model.groups}">
	   	  		&nbsp;[&nbsp;
	   	  			<a href="?op=historyGroupReport&domain=${model.domain}&date=${model.date}&group=${group}&reportType=${payload.reportType}&type=${payload.encodedType}">${group}</a>
	   	 		&nbsp;]&nbsp;
			 </c:forEach>
		</th>
	</tr>
</table>

<table class='table table-hover table-striped table-condensed ' style="width:100%;">
	<c:choose>
		<c:when test="${empty payload.type}">
		<tr>
			<th  style="text-align: left;"><a	href="?op=history&domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&reportType=${payload.reportType}&sort=type${model.customDate}">Type</a></th>
			<th class="right"><a	href="?op=history&domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&reportType=${payload.reportType}&sort=total${model.customDate}">总量</a></th>
			<th class="right"><a	href="?op=history&domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&reportType=${payload.reportType}&sort=failure${model.customDate}">失败次数</a></th>
			<th class="right"><a	href="?op=history&domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&reportType=${payload.reportType}&sort=failurePercent${model.customDate}">错误率</a></th>
			<th class="right">样本链接</th>
			<th class="right"><a	href="?op=history&domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&reportType=${payload.reportType}&sort=min${model.customDate}">最小耗时</a>(ms)</th>
			<th class="right"><a	href="?op=history&domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&reportType=${payload.reportType}&sort=max${model.customDate}">最大耗时</a>(ms)</th>
			<th class="right"><a	href="?op=history&domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&reportType=${payload.reportType}&sort=avg${model.customDate}">平均耗时</a>(ms)</th>
			<th class="right"><a	href="?op=history&domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&reportType=${payload.reportType}&sort=95line${model.customDate}">P95</a>(ms)</th>
			<th class="right"><a	href="?op=history&domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&reportType=${payload.reportType}&sort=99line${model.customDate}">P99</a>(ms)</th>
			<th class="right"><a	href="?op=history&domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&reportType=${payload.reportType}&sort=std${model.customDate}">标准差</a>(ms)</th>
			<th class="right"><a	href="?op=history&domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&reportType=${payload.reportType}&sort=total${model.customDate}">QPS</a></th>
					</tr>
			<c:forEach var="item" items="${model.displayTypeReport.results}"
						varStatus="status">
				<c:set var="e" value="${item.detail}" />
				<c:set var="lastIndex" value="${status.index}" />
				<tr class=" right">
					<td style="text-align: left">
							<a href="?op=historyGraph&domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&reportType=${payload.reportType}&type=${item.type}${model.customDate}" class="history_graph_link" data-status="${status.index}">[:: show ::]</a>
							&nbsp;&nbsp;&nbsp;<a href="?op=history&domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&reportType=${payload.reportType}&type=${item.type}${model.customDate}">${item.detail.id}</a></td>
					<td>${w:format(e.totalCount,'#,###,###,###,##0')}</td>
					<td>${e.failCount}</td>
					<td>${w:format(e.failPercent/100,'0.0000%')}</td>
					<td><a	href="/cat/r/m/${empty e.failMessageUrl ? e.successMessageUrl : e.failMessageUrl}?domain=${model.domain}">样本链接</a></td>
					<td>${w:format(e.min,'0.#')}</td>
					<td>${w:format(e.max,'0.#')}</td>
					<td>${w:format(e.avg,'0.0')}</td>
					<td>${w:format(e.line95Value,'0.0')}</td>
					<td>${w:format(e.line99Value,'0.0')}</td>
					<td>${w:format(e.std,'0.0')}</td>
					<td>${w:format(e.tps,'0.0')}</td>
				</tr>
				<tr class="graphs"><td colspan="13"  style="display:none"><div id="${status.index}" style="display:none"></div></td></tr>
				<tr></tr>
			</c:forEach>
		</c:when>
		<c:otherwise>
		<tr><th  style="text-align:left;" colspan='13'>
			<input type="text" id="queryname" size="40" style="height:35px" value="${model.queryName}">
		    <input  class="btn btn-primary btn-sm" style="margin-left:-4px;margin-top:-2px" value="Filter" onclick="filterByName('${model.date}',
				'${model.domain}','${model.ipAddress}','${payload.type}')" type="submit">
		    &nbsp;支持多个字符串查询，例如 SQL|URL，查询结果为包含任一SQL、URL的列
		</th></tr><script>
			function filterByName(date,domain,ip,type){
				var customDate ='${model.customDate}';
				var reportType = '${payload.reportType}';
				var type = '${payload.type}';
				var queryname=$("#queryname").val();
				window.location.href="?op=history&domain="+domain+"&ip="+ip+"&date="+date+'&type='+type+'&reportType='+reportType+"&queryname="+queryname+customDate;
			}
		</script>
			<tr>
			<th style="text-align: left;">
			<a	href="?op=history&domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&reportType=${payload.reportType}&type=${payload.encodedType}&sort=type${model.customDate}&queryname=${model.queryName}">Name</a>
						</th>
			<th class="right"><a	href="?op=history&domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&reportType=${payload.reportType}&type=${payload.encodedType}&sort=total${model.customDate}&queryname=${model.queryName}">总量</a></th>
			<th class="right"><a	href="?op=history&domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&reportType=${payload.reportType}&type=${payload.encodedType}&sort=failure${model.customDate}&queryname=${model.queryName}">失败次数</a></th>
			<th class="right"><a	href="?op=history&domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&reportType=${payload.reportType}&type=${payload.encodedType}&sort=failurePercent${model.customDate}&queryname=${model.queryName}">错误率</a></th>
			<th class="right">样本链接</th>
			<th class="right"><a	href="?op=history&domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&reportType=${payload.reportType}&type=${payload.encodedType}&sort=min${model.customDate}&queryname=${model.queryName}">最小耗时</a>(ms)</th>
			<th class="right"><a	href="?op=history&domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&reportType=${payload.reportType}&type=${payload.encodedType}&sort=max${model.customDate}&queryname=${model.queryName}">最大耗时</a>(ms)</th>
			<th class="right"><a	href="?op=history&domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&reportType=${payload.reportType}&type=${payload.encodedType}&sort=avg${model.customDate}&queryname=${model.queryName}">平均耗时</a>(ms)</th>
			<th class="right"><a	href="?op=history&domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&reportType=${payload.reportType}&type=${payload.encodedType}&sort=95line${model.customDate}&queryname=${model.queryName}">P95</a>(ms)</th>
			<th class="right"><a	href="?op=history&domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&reportType=${payload.reportType}&type=${payload.encodedType}&sort=99line${model.customDate}&queryname=${model.queryName}">P99</a>(ms)</th>
			<th class="right"><a	href="?op=history&domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&reportType=${payload.reportType}&type=${payload.encodedType}&sort=std${model.customDate}&queryname=${model.queryName}">标准差</a>(ms)</th>
			<th class="right"><a	href="?op=history&domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&reportType=${payload.reportType}&type=${payload.encodedType}&sort=total${model.customDate}&queryname=${model.queryName}">QPS</a></th>
			<th class="right"><a	href="?op=history&domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&reportType=${payload.reportType}&type=${payload.encodedType}&sort=total${model.customDate}&queryname=${model.queryName}">百分比%</a></th>
					</tr>
			<c:forEach var="item" items="${model.displayNameReport.results}"
						varStatus="status">
				<c:set var="e" value="${item.detail}" />
				<c:set var="lastIndex" value="${status.index}" />
				<tr class=" right">
					<td class="longText" style="text-align:left;white-space:normal">
					<c:choose>
					<c:when test="${status.index > 0}">
					<a href="?op=historyGraph&domain=${model.domain}&date=${model.date}&ip=${model.ipAddress}&reportType=${payload.reportType}&type=${payload.encodedType}&name=${item.name}${model.customDate}" class="history_graph_link" data-status="${status.index}">[:: show ::]</a>
					</c:when>
					<c:otherwise></c:otherwise></c:choose>
					&nbsp;&nbsp;&nbsp;${w:shorten(e.id, 120)}</td>
					<td>${w:format(e.totalCount,'#,###,###,###,##0')}</td>
					<td>${e.failCount}</td>
					<td>${w:format(e.failPercent/100,'0.0000%')}</td>
					<td><a	href="/cat/r/m/${empty e.failMessageUrl ? e.successMessageUrl : e.failMessageUrl}?domain=${model.domain}">样本链接</a></td>
					<td>${w:format(e.min,'0.#')}</td>
					<td>${w:format(e.max,'0.#')}</td>
					<td>${w:format(e.avg,'0.0')}</td>
					<td>${w:format(e.line95Value,'0.0')}</td>
					<td>${w:format(e.line99Value,'0.0')}</td>
					<td>${w:format(e.std,'0.0')}</td>
					<td>${w:format(e.tps,'0.0')}</td>
					<td>${w:format(e.totalPercent,'0.00%')}</td>
				</tr>
				<tr class="graphs"><td colspan="13"  style="display:none"><div id="${status.index}" style="display:none"></div></td></tr>
				<tr></tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>

<font color="white">${lastIndex+1}</font>
<res:useJs value="${res.js.local.transaction_js}" target="bottom-js" />
<c:choose>
	<c:when test="${not empty payload.type}">
		<table>
			<tr>
				<td><div id="transactionGraph" class="pieChart"></div>
				</td>
			</tr>
		</table>
		<script type="text/javascript">
			var data = ${model.pieChart};
			graphPieChart(document.getElementById('transactionGraph'), data);
		</script>
	</c:when>
</c:choose>
</br>
</jsp:body>

</a:historyReport>
