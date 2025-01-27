/*
 * Copyright (c) 2011-2018, Meituan Dianping. All Rights Reserved.
 *
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements. See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.dianping.cat.report;

import org.unidal.web.mvc.AbstractModule;
import org.unidal.web.mvc.annotation.ModuleMeta;
import org.unidal.web.mvc.annotation.ModulePagesMeta;

@ModuleMeta(name = "r", defaultInboundAction = "top", defaultTransition = "default", defaultErrorAction = "default")
@ModulePagesMeta({

	com.dianping.cat.report.page.home.Handler.class,

	com.dianping.cat.report.page.problem.Handler.class,

	com.dianping.cat.report.page.transaction.Handler.class,

	com.dianping.cat.report.page.event.Handler.class,

	com.dianping.cat.report.page.heartbeat.Handler.class,

	com.dianping.cat.report.page.logview.Handler.class,

	com.dianping.cat.report.page.model.Handler.class,

	com.dianping.cat.report.page.matrix.Handler.class,

	com.dianping.cat.report.page.dependency.Handler.class,

	com.dianping.cat.report.page.cross.Handler.class,

	com.dianping.cat.report.page.cache.Handler.class,

	com.dianping.cat.report.page.state.Handler.class,

	com.dianping.cat.report.page.statistics.Handler.class,

	com.dianping.cat.report.page.alteration.Handler.class,

	com.dianping.cat.report.page.monitor.Handler.class,

	com.dianping.cat.report.page.network.Handler.class,

	com.dianping.cat.report.page.app.Handler.class,

	com.dianping.cat.report.page.alert.Handler.class,

	com.dianping.cat.report.page.overload.Handler.class,

	com.dianping.cat.report.page.storage.Handler.class,

	com.dianping.cat.report.page.top.Handler.class,

	com.dianping.cat.report.page.browser.Handler.class,

//	com.dianping.cat.report.page.server.Handler.class,

	com.dianping.cat.report.page.business.Handler.class,

	com.dianping.cat.report.page.appstats.Handler.class,

	com.dianping.cat.report.page.crash.Handler.class,

	com.dianping.cat.report.page.applog.Handler.class,

	com.dianping.cat.report.page.tracing.Handler.class
})
public class ReportModule extends AbstractModule {

}
