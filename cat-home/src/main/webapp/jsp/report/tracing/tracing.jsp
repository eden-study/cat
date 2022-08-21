<%@ page contentType="text/html; charset=utf-8" trimDirectiveWhitespaces="true" %>
<%@ page pageEncoding="UTF-8" session="false" %>
<%@ taglib prefix="a" uri="/WEB-INF/app.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="res" uri="http://www.unidal.org/webres" %>

<jsp:useBean id="ctx" type="com.dianping.cat.report.page.logview.Context" scope="request"/>
<jsp:useBean id="payload" type="com.dianping.cat.report.page.logview.Payload" scope="request"/>
<jsp:useBean id="model" type="com.dianping.cat.report.page.tracing.Model" scope="request"/>

<a:application>

    <res:useCss value="${res.css.local.logview_css}" target="head-css"/>
    <res:useJs value="${res.js.local.logview_js}" target="head-js"/>

    <script type="text/javascript">
        function queryByTraceId(anchor, id) {
            const selected = document.getElementById(id);
            $.ajax({
                type: "get",
                url: "/cat/r/m/" + $("#traceId").val() + "?header=no&waterfall=" + $("#waterfall").val() + "&map=true",
                success: function (data) {
                    selected.innerHTML = data;
                }
            });

            return false;
        }
    </script>

    <table style="width:100%;">
        <tr>
            <th class="left" colspan="13">
                <input type="text" name="traceId" id="traceId" size="40" value="${model.traceId}">
                <input class="btn btn-primary  btn-sm" value="Filter" onclick="queryByTraceId(this,'container')" type="submit" placeholder="请输入链路ID">
                <label class="label is-centered" style="margin-right:15px; ">图表展示:</label>
                <select id="waterfall">
                    <option value="true">true</option>
                    <option value="false">false</option>
                </select>
            </th>
        </tr>
    </table>
    <div id="container"></div>
</a:application>