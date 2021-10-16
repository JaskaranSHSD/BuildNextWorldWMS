﻿CREATE DATABASE [DB_PREFIX]_bnw_console;
CREATE DATABASE [DB_PREFIX]_bnw_app;
USE [DB_PREFIX]_bnw_console;
CREATE TABLE `simple_crud_columns` (
  `id` bigint(20) NOT NULL,
  `viewid` bigint(20) DEFAULT NULL,
  `columname` longtext DEFAULT NULL,
  `columnpublicname` longtext DEFAULT NULL,
  `columnpublicid` longtext DEFAULT NULL,
  `columnlevel` tinyint(3) DEFAULT NULL,
  `flexible` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE simple_crud_columns ADD COLUMN isrequired tinyint(1);
ALTER TABLE simple_crud_columns ADD COLUMN validationtype tinyint(3);
ALTER TABLE simple_crud_columns ADD COLUMN blocksubmission tinyint(1);
ALTER TABLE simple_crud_columns ADD COLUMN defaultvalue longtext;
ALTER TABLE simple_crud_columns ADD COLUMN maxlength int;
ALTER TABLE `simple_crud_columns` ADD COLUMN iskey tinyint(1);
ALTER table `simple_crud_columns` ADD COLUMN blockread tinyint(1);
ALTER table `simple_crud_columns` ADD COLUMN blockparam tinyint(1);
ALTER table `simple_crud_columns` ADD COLUMN encrypted tinyint(1);
ALTER table `simple_crud_columns` ADD COLUMN send_encrypt tinyint(1);
ALTER TABLE simple_crud_columns ADD column send_encrypt_type tinyint(1);
alter table simple_crud_columns add column column_type varchar(150);
alter table simple_crud_columns add column column_param longtext;
alter table simple_crud_columns add column listing_column tinyint(2);

ALTER TABLE `simple_crud_columns`
  ADD PRIMARY KEY (`id`);
ALTER TABLE `simple_crud_columns`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

CREATE TABLE `simple_crud_view` (
  `id` bigint(20) NOT NULL,
  `viewname` longtext DEFAULT NULL,
  `primarydbname` longtext DEFAULT NULL,
  `primarytable` longtext DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `isdeleted` tinyint(1) DEFAULT NULL,
  `columncreated` tinyint(1) DEFAULT NULL,
  `shortcode` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER table simple_crud_view ADD COLUMN fe_create tinyint(1);
ALTER table simple_crud_view ADD COLUMN fe_list tinyint(1);
ALTER table simple_crud_view ADD COLUMN fe_delete tinyint(1);
ALTER table simple_crud_view ADD COLUMN fe_update tinyint(1);
ALTER table simple_crud_view ADD COLUMN api_create tinyint(1);
ALTER table simple_crud_view ADD COLUMN api_list tinyint(1);
ALTER table simple_crud_view ADD COLUMN api_delete tinyint(1);
ALTER table simple_crud_view ADD COLUMN api_update tinyint(1);
ALTER table simple_crud_view ADD COLUMN content_type longtext;
ALTER TABLE simple_crud_view ADD COLUMN is_table tinyint(1);	
ALTER TABLE simple_crud_view add COLUMN secure_form tinyint(1);
ALTER TABLE simple_crud_view add COLUMN secure_param int;
ALTER TABLE simple_crud_view add column enable_data_manu tinyint(1);

ALTER TABLE `simple_crud_view`
  ADD PRIMARY KEY (`id`);
ALTER TABLE `simple_crud_view`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

CREATE TABLE system_api_security
(
  id bigint PRIMARY KEY AUTO_INCREMENT,
  api_name varchar(200),
  shortcode varchar(250),
  userroleid bigint
);
ALTER TABLE system_api_security ADD CONSTRAINT UNNIQ_API_SEC UNIQUE (api_name,shortcode,userroleid); 

CREATE TABLE `user_roles` (
  `roleid` bigint(20) NOT NULL,
  `rolename` longtext DEFAULT NULL,
  `roledescription` longtext DEFAULT NULL,
  `role_constant` tinyint(3) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT NULL,
  `allow_console` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

create table system_file_manager(
	id bigint,
    token_formula longtext,
    file_name longtext,
    file_path longtext,
    expire_on datetime,
    require_logged_in tinyint(1),
    is_deleted tinyint(1)
);
ALTER TABLE system_file_manager ADD COLUMN download_counts bigint;
--
-- Dumping data for table `user_roles`
--

INSERT INTO `user_roles` (`roleid`, `rolename`, `roledescription`, `role_constant`, `is_deleted`, `allow_console`) VALUES
(1, 'ADMINISTRATOR', 'All rights given over console', 1, 0, 1),
(2, 'DEVELOPER', 'Rights given over theme, plugins and widgets area', 2, 0, 1),
(3, 'EDITOR', 'Rights given over content create, edit, delete area', 3, 0, 1),
(4, 'FRONTUSER', 'No rights over console, Front application user', 4, 0, 0),
(5, 'ANONYMOUS', 'Any one able to visit this website', 5, 0, 0);

ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`roleid`);
ALTER TABLE `user_roles`
  MODIFY `roleid` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

CREATE TABLE `system_area_master` (
  `id` bigint(20) NOT NULL,
  `areaname` longtext DEFAULT NULL,
  `areaurlpattern` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


INSERT INTO `system_area_master` (`id`, `areaname`, `areaurlpattern`) VALUES
(1, 'CONSOLE AREA', 'console-{name}'),
(2, 'FRONTEND ENGINE', 'frontendengine'),
(3, 'API ENGINE', 'apigateway'),
(4, 'STATIC PAGES', 'static'),
(5, 'SYSTEM', 'system'),
(6, 'Web Socket', 'appsockethub');

ALTER TABLE `system_area_master`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `system_area_master`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

CREATE TABLE system_schedulers_master (
	id bigint PRIMARY KEY AUTO_INCREMENT,
    schedule_name varchar(250),
    razor_path longtext,
    repeat_time_type varchar(250),
    repeat_time_value int,
    created_on datetime,
    next_run datetime,
    is_active tinyint(1)
);
CREATE TABLE system_schedulers_tasks (
	id bigint PRIMARY KEY AUTO_INCREMENT,
    sch_id bigint,
    started_on datetime,
    completed_on datetime,
    message longtext
);
ALTER TABLE system_schedulers_tasks ADD COLUMN is_completed tinyint(1);

CREATE TABLE system_events_master(
	eventid bigint PRIMARY KEY AUTO_INCREMENT,
    event_name varchar(250),
    view_id bigint,
    view_operation varchar(20),
    event_type varchar(50),
    event_template longtext,
    event_info varchar(50),
    is_post_submission tinyint(1)
);
ALTER TABLE system_events_master ADD COLUMN created datetime;
ALTER TABLE system_events_master ADD COLUMN is_aysnc tinyint(1);
ALTER TABLE system_events_master ADD COLUMN is_deleted tinyint(1);

CREATE TABLE system_events_task ( task_id bigint PRIMARY KEY AUTO_INCREMENT, task_name varchar(200), event_id bigint, created datetime, is_completed tinyint(1), message longtext );

CREATE TABLE `system_app_master` (
  `appid` bigint(20) NOT NULL,
  `appname` longtext DEFAULT NULL,
  `appurlpattern` longtext DEFAULT NULL,
  `areaid` bigint(20) DEFAULT NULL,
  `isconsoleapp` tinyint(1) DEFAULT NULL,
  `enableheadertoken` tinyint(1) DEFAULT NULL,
  `headertokenvalue` longtext DEFAULT NULL,
  `headertokenformula` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE system_traffic_master 
(
    traffic_id bigint PRIMARY KEY AUTO_INCREMENT,
    traffic_url  longtext,
    traffic_ref varchar(200),
    visit_counts bigint,
    last_update datetime
);

CREATE TABLE system_traffic_ipaddress(
    traf_id bigint PRIMARY KEY AUTO_INCREMENT,
    requested_path longtext,
    http_referrer longtext,
    created datetime,
    ip_address varchar(50),
    visit_counts bigint
);


CREATE TABLE system_short_urls
(
    url_id bigint PRIMARY KEY AUTO_INCREMENT,
    from_url varchar(250) UNIQUE,
    to_url longtext,
    is_deleted tinyint(1)  
);

CREATE TABLE system_sitemaps_url
(
    sitemap_id bigint PRIMARY KEY AUTO_INCREMENT,
    site_url longtext,
    change_feg varchar(100),
    priority varchar(50),
    created datetime,
    is_deleted tinyint(1)
);
CREATE TABLE system_pin_url
(
    pin_id bigint PRIMARY KEY AUTO_INCREMENT,
    url_name longtext,
    site_url longtext
);

INSERT INTO `system_app_master` (`appid`, `appname`, `appurlpattern`, `areaid`, `isconsoleapp`, `enableheadertoken`, `headertokenvalue`, `headertokenformula`) VALUES
(1, 'themes', 'console-{name}', 1, 1, 0, NULL, NULL),
(2, 'filemanager', 'console-{name}', 1, 1, 0, NULL, NULL),
(3, 'logicalviews', 'console-{name}', 1, 1, 0, NULL, NULL),
(4, 'settings', 'console-{name}', 1, 1, 0, NULL, NULL),
(5, 'database', 'console-{name}', 1, 1, 0, NULL, NULL),
(6, 'submit-create', 'frontendengine', 2, 0, 0, NULL, NULL),
(11, 'submit-update', 'frontendengine', 2, 0, 0, NULL, NULL),
(12, 'custom', 'frontendengine', 2, 0, 0, NULL, NULL),
(13, 'list', 'apigateway', 3, 0, 0, NULL, NULL),
(14, 'get', 'apigateway', 3, 0, 0, NULL, NULL),
(15, 'create', 'apigateway', 3, 0, 0, NULL, NULL),
(16, 'update', 'apigateway', 3, 0, 0, NULL, NULL),
(17, 'index', 'frontendengine', 2, 0, 0, NULL, NULL),
(18, 'index', 'console-{name}', 1, 1, 0, NULL, NULL),
(19, 'pages', 'console-{name}', 1, 1, 0, NULL, NULL),
(20, 'image', 'system', 5, 0, 0, NULL, NULL),
(21, 'editor', 'console-{name}', 1, 1, 0, NULL, NULL),
(22, 'api-settings', 'console-{name}', 1, 1, 0, NULL, NULL),
(23, 'schedulers', 'console-{name}', 1, 1, 0, NULL, NULL),
(24, 'addon-features', 'console-{name}', 1, 1, 0, NULL, NULL),
(25, 'events', 'console-{name}', 1, 1, 0, NULL, NULL),
(26, 'socket', 'console-{name}', 1, 1, 0, NULL, NULL),
(27, 'index', 'appsockethub', 6, 0, 0, NULL, NULL),
(28, 'negotiate', 'appsockethub', 6, 0, 0, NULL, NULL),
(29, 'download', 'system', 5, 0, 0, NULL, NULL),
(30, 'sitemap', 'system', 5, 0, 0, NULL, NULL),
(31, 'captcha', 'system', 5, 0, 0, NULL, NULL),
(32, 'execute', 'apigateway', 3, 0, 0, NULL, NULL),
(33, 'pay', 'system', 5, 0, 0, NULL, NULL);
INSERT INTO `system_app_master` (`appid`, `appname`, `appurlpattern`, `areaid`, `isconsoleapp`, `enableheadertoken`, `headertokenvalue`, `headertokenformula`) VALUES (34, 'data-manipulation', 'console-{name}', '1', '1', '0', NULL, NULL);




ALTER TABLE `system_app_master`
  ADD PRIMARY KEY (`appid`),
  ADD KEY `areaid` (`areaid`);


ALTER TABLE `system_app_master`
  MODIFY `appid` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

ALTER TABLE `system_app_master`
  ADD CONSTRAINT `system_app_master_ibfk_1` FOREIGN KEY (`areaid`) REFERENCES `system_area_master` (`id`);

CREATE TABLE `system_rerouting` (
  `routeid` bigint(20) NOT NULL,
  `isactive` tinyint(1) DEFAULT NULL,
  `appid` bigint(20) DEFAULT NULL,
  `security_info` longtext DEFAULT NULL,
  `orgpagetype` longtext DEFAULT NULL,
  `routepagetype` longtext DEFAULT NULL,
  `segmentsforinfo` int(11) DEFAULT NULL,
  `routeoperation` longtext DEFAULT NULL,
  `filename` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE `system_rerouting`
  ADD PRIMARY KEY (`routeid`),
  ADD KEY `appid` (`appid`);

ALTER TABLE `system_rerouting`
  MODIFY `routeid` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

ALTER TABLE `system_rerouting`
  ADD CONSTRAINT `system_rerouting_ibfk_1` FOREIGN KEY (`appid`) REFERENCES `system_app_master` (`appid`);

CREATE TABLE `system_app_access` (
  `id` bigint(20) NOT NULL,
  `role_id` bigint(20) DEFAULT NULL,
  `appid` bigint(20) DEFAULT NULL,
  `access_def` tinyint(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `system_app_access` (`id`, `role_id`, `appid`, `access_def`) VALUES
(1, 1, 1, 1),
(3, 1, 3, 1),
(4, 1, 4, 1),
(5, 1, 5, 1),
(6, 5, 17, 1),
(7, 4, 17, 1),
(8, 1, 18, 1),
(9, 1, 19, 1),
(10, 1, 20, 1),
(11, 2, 20, 1),
(12, 3, 20, 1),
(13, 4, 20, 1),
(14, 5, 20, 1),
(15, 1, 2, 1),
(16, 1, 21, 1),
(17, 1, 22, 1),
(18, 1, 23, 1),
(19, 1, 25, 1),
(20, 1, 24, 1),
(21, 5, 27, 1),
(22, 5, 28, 1),
(23, 5, 29, 1),
(24, 5, 30, 1),
(25, 5, 31, 1);

ALTER TABLE `system_app_access`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `system_app_access`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;


CREATE TABLE `system_properties` (
  `propid` bigint(20) NOT NULL,
  `config_key` longtext DEFAULT NULL,
  `config_value` longtext DEFAULT NULL,
  `config_value_add` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `system_properties` (`propid`, `config_key`, `config_value`, `config_value_add`) VALUES
(1, 'MASTER_PIN_CONSOLE_NAME', 'jyf5gwimBp0=', 'myconsole'),
(2, 'ACTIVE_THEME', 'Themes[SYSTEM.CHAR]Springdell_default[SYSTEM.CHAR]', 'Springdell Default theme'),
(3, 'SYSTEM_LOGIN', 'user_accounts', 'email|userpassword|true'),
(4, 'AUTH_HEADER', 'API-AUTHENTICATE', 'API-AUTHENTICATE');

ALTER TABLE `system_properties`
  ADD PRIMARY KEY (`propid`);

ALTER TABLE `system_properties`
  MODIFY `propid` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;


USE [DB_PREFIX]_bnw_app;

CREATE TABLE `user_accounts` (
  `userid` bigint(20) NOT NULL,
  `firstname` longtext DEFAULT NULL,
  `lastname` longtext DEFAULT NULL,
  `gender` longtext DEFAULT NULL,
  `email` longtext DEFAULT NULL,
  `userpassword` longtext DEFAULT NULL,
  `userroleid` bigint(20) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `freeze` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE `user_accounts`
  ADD PRIMARY KEY (`userid`),
  ADD KEY `userroleid` (`userroleid`);

ALTER TABLE `user_accounts`
  MODIFY `userid` bigint(20) NOT NULL AUTO_INCREMENT;

ALTER TABLE `user_accounts`
  ADD CONSTRAINT `user_accounts_ibfk_1` FOREIGN KEY (`userroleid`) REFERENCES `[DB_PREFIX]_bnw_console`.`user_roles` (`roleid`);

ALTER TABLE user_accounts ADD COLUMN freeze_point tinyint(3);

CREATE TABLE `login_module` (
  `id` bigint(20) NOT NULL,
  `token` varchar(150) DEFAULT NULL,
  `accountid` bigint(20) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `expire` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE `login_module`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `login_module`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

create table payment_transactions(
	id bigint PRIMARY KEY AUTO_INCREMENT,
    paypal_transaction_id varchar(250),
    local_product_id varchar(250),
    amount float,
    currency varchar(3),
    status longtext,
    created datetime,
    last_update datetime
);
ALTER TABLE payment_transactions add COLUMN user_id bigint;
