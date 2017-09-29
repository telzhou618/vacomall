/*
SQLyog Ultimate v11.24 (32 bit)
MySQL - 5.5.54 : Database - vacomall
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `ecs_account_log` */

DROP TABLE IF EXISTS `ecs_account_log`;

CREATE TABLE `ecs_account_log` (
  `log_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
  `user_id` mediumint(8) unsigned NOT NULL COMMENT '用户登录后保存在session中的id号，跟users表中的user_id对应',
  `user_money` decimal(10,2) NOT NULL COMMENT '用户该笔记录的余额',
  `frozen_money` decimal(10,2) NOT NULL COMMENT '被冻结的资金',
  `rank_points` mediumint(9) NOT NULL COMMENT '等级积分，跟消费积分是分开的',
  `pay_points` mediumint(9) NOT NULL COMMENT '消费积分，跟等级积分是分开的',
  `change_time` int(10) unsigned NOT NULL COMMENT '该笔操作发生的时间',
  `change_desc` varchar(255) NOT NULL COMMENT '该笔操作的备注，一般是，充值或者提现。也可是是管理员后台写的任何在备注',
  `change_type` tinyint(3) unsigned NOT NULL COMMENT '操作类型，0为充值，1为提现，2为管理员调节，99为其他类型',
  PRIMARY KEY (`log_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户帐号情况记录表，包括资金和积分等';

/*Data for the table `ecs_account_log` */

/*Table structure for table `ecs_ad` */

DROP TABLE IF EXISTS `ecs_ad`;

CREATE TABLE `ecs_ad` (
  `ad_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
  `position_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '0,站外广告；从1开始代表的是该广告所处的广告位，同表ad_position中的字段position_id的值',
  `media_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '广告类型，0，图片；1，flash;2,代码；3，文字',
  `ad_name` varchar(60) NOT NULL COMMENT '该条广告记录的广告名称',
  `ad_link` varchar(255) NOT NULL COMMENT '广告链接地址',
  `ad_code` text NOT NULL COMMENT '广告链接的表现，文字广告就是文字或图片和flash就是它们的地址，代码广告就是代码内容',
  `start_time` int(11) NOT NULL DEFAULT '0' COMMENT '广告开始时间',
  `end_time` int(11) NOT NULL DEFAULT '0' COMMENT '广告结束时间',
  `link_man` varchar(60) NOT NULL COMMENT '广告联系人',
  `link_email` varchar(60) NOT NULL COMMENT '广告联系人的邮箱',
  `link_phone` varchar(60) NOT NULL COMMENT '广告联系人的电话',
  `click_count` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '该广告点击数',
  `enabled` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '该广告是否关闭，1，开启；0，关闭；关闭后广告将不再有效，直至重新开启',
  PRIMARY KEY (`ad_id`),
  KEY `position_id` (`position_id`),
  KEY `enabled` (`enabled`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='广告列表配置表，包括站内站外的图片，文字，flash，代码广告';

/*Data for the table `ecs_ad` */

/*Table structure for table `ecs_ad_position` */

DROP TABLE IF EXISTS `ecs_ad_position`;

CREATE TABLE `ecs_ad_position` (
  `position_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT '广告位自增id',
  `position_name` varchar(60) NOT NULL COMMENT '广告位名称',
  `ad_width` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '广告位宽度',
  `ad_height` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '广告位高度',
  `position_desc` varchar(255) NOT NULL COMMENT '广告位描述',
  `position_style` text NOT NULL COMMENT '广告位模板代码',
  PRIMARY KEY (`position_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='广告位置配置表';

/*Data for the table `ecs_ad_position` */

/*Table structure for table `ecs_admin_action` */

DROP TABLE IF EXISTS `ecs_admin_action`;

CREATE TABLE `ecs_admin_action` (
  `action_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
  `parent_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '该id项的父id，对应本表的action_id字段',
  `action_code` varchar(20) NOT NULL COMMENT '代表权限的英文字符串，对应汉文在语言文件中，如果该字段有某个字符串，就表示有该权限',
  PRIMARY KEY (`action_id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=104 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='管理员权限列表树';

/*Data for the table `ecs_admin_action` */

/*Table structure for table `ecs_admin_log` */

DROP TABLE IF EXISTS `ecs_admin_log`;

CREATE TABLE `ecs_admin_log` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
  `log_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '写日志时间',
  `user_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '该日志所记录的操作者id，同ecs_admin_user的user_id',
  `log_info` varchar(255) NOT NULL COMMENT '管理操作内容',
  `ip_address` varchar(15) NOT NULL COMMENT '管理者登录ip',
  PRIMARY KEY (`log_id`),
  KEY `log_time` (`log_time`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=158 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='管理员操作日志表';

/*Data for the table `ecs_admin_log` */

/*Table structure for table `ecs_admin_message` */

DROP TABLE IF EXISTS `ecs_admin_message`;

CREATE TABLE `ecs_admin_message` (
  `message_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
  `sender_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发送该留言的管理员id，同ecs_admin_user的user_id',
  `receiver_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '接收消息的管理员id，同ecs_admin_user的user_id，如果是给多个管理员发送，则同一个消息给每个管理员id发送一条',
  `sent_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '留言发送时间',
  `read_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '留言阅读时间',
  `readed` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '留言是否阅读，1，已阅读；0，未阅读',
  `deleted` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '留言是否已经是否已经被删除，1，已删除；0，未删除',
  `title` varchar(150) NOT NULL COMMENT '留言的主题',
  `message` text NOT NULL COMMENT '留言的内容',
  PRIMARY KEY (`message_id`),
  KEY `sender_id` (`sender_id`,`receiver_id`),
  KEY `receiver_id` (`receiver_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='管理员留言记录表';

/*Data for the table `ecs_admin_message` */

/*Table structure for table `ecs_admin_user` */

DROP TABLE IF EXISTS `ecs_admin_user`;

CREATE TABLE `ecs_admin_user` (
  `user_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号，管理员代号',
  `user_name` varchar(60) NOT NULL COMMENT '管理员登录名',
  `email` varchar(60) NOT NULL COMMENT '管理员邮箱',
  `password` varchar(32) NOT NULL COMMENT '管理员登录秘密加密串',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '管理员添加时间',
  `last_login` int(11) NOT NULL DEFAULT '0' COMMENT '管理员最后一次登录时间',
  `last_ip` varchar(15) NOT NULL COMMENT '管理员最后一次登录ip',
  `action_list` text NOT NULL COMMENT '管理员管理权限列表',
  `nav_list` text NOT NULL COMMENT '管理员导航栏配置项',
  `lang_type` varchar(50) NOT NULL,
  `agency_id` smallint(5) unsigned NOT NULL COMMENT '该管理员负责的办事处的id，同ecs_agency的agency_id字段。如果管理员没负责办事处，则此处为0',
  `todolist` longtext COMMENT '记事本记录的数据',
  PRIMARY KEY (`user_id`),
  KEY `user_name` (`user_name`),
  KEY `agency_id` (`agency_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='管理员资料权限列表';

/*Data for the table `ecs_admin_user` */

/*Table structure for table `ecs_adsense` */

DROP TABLE IF EXISTS `ecs_adsense`;

CREATE TABLE `ecs_adsense` (
  `from_ad` smallint(5) NOT NULL DEFAULT '0' COMMENT '广告代号，-1是站外广告，如果是站内广告则为ecs_ad的ad_id',
  `referer` varchar(255) NOT NULL COMMENT '页面来源',
  `clicks` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '点击率',
  KEY `from_ad` (`from_ad`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='广告点击率统计表';

/*Data for the table `ecs_adsense` */

/*Table structure for table `ecs_affiliate_log` */

DROP TABLE IF EXISTS `ecs_affiliate_log`;

CREATE TABLE `ecs_affiliate_log` (
  `log_id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `order_id` mediumint(8) NOT NULL,
  `time` int(10) NOT NULL,
  `user_id` mediumint(8) NOT NULL,
  `user_name` varchar(60) DEFAULT NULL,
  `money` decimal(10,2) NOT NULL DEFAULT '0.00',
  `point` int(10) NOT NULL DEFAULT '0',
  `separate_type` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`log_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='分成相关的表，还没研究透';

/*Data for the table `ecs_affiliate_log` */

/*Table structure for table `ecs_agency` */

DROP TABLE IF EXISTS `ecs_agency`;

CREATE TABLE `ecs_agency` (
  `agency_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '办事处ID',
  `agency_name` varchar(255) NOT NULL COMMENT '办事处名字',
  `agency_desc` text NOT NULL COMMENT '办事处描述',
  PRIMARY KEY (`agency_id`),
  KEY `agency_name` (`agency_name`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='办事处信息';

/*Data for the table `ecs_agency` */

/*Table structure for table `ecs_area_region` */

DROP TABLE IF EXISTS `ecs_area_region`;

CREATE TABLE `ecs_area_region` (
  `shipping_area_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '配送区域的id号，等同于ecs_shipping_area的shipping_area_id的值',
  `region_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '地区列表，等同于ecs_region的region_id',
  PRIMARY KEY (`shipping_area_id`,`region_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='记录表ecs_shipping_area中的shipping_area_name的地区名包括ecs_region中的城市';

/*Data for the table `ecs_area_region` */

/*Table structure for table `ecs_article` */

DROP TABLE IF EXISTS `ecs_article`;

CREATE TABLE `ecs_article` (
  `article_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
  `cat_id` smallint(5) NOT NULL DEFAULT '0' COMMENT '该文章的分类，同ecs_article_cat的cat_id,如果不在，将自动成为保留类型而不能删除',
  `title` varchar(150) NOT NULL COMMENT '文章题目',
  `content` longtext NOT NULL COMMENT '文章内容',
  `author` varchar(30) NOT NULL COMMENT '文章作者',
  `author_email` varchar(60) NOT NULL COMMENT '文章作者的email',
  `keywords` varchar(255) NOT NULL COMMENT '文章的关键字',
  `article_type` tinyint(1) unsigned NOT NULL DEFAULT '2' COMMENT '文章类型，0，普通；1，置顶；2和大于2的，为保留文章，保留文章不能删除',
  `is_open` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否显示。1，显示；0，不显示',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文章添加时间',
  `file_url` varchar(255) NOT NULL COMMENT '上传文件或者外部文件的url',
  `open_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0,正常；当该字段为1或者2时，会在文章最后添加一个链接“相关下载”，连接地址等于file_url的值；但程序在此处有bug',
  `link` varchar(255) NOT NULL COMMENT '该文章标题所引用的连接，如果该项有值将不能显示文章内容，即该表中content的值',
  PRIMARY KEY (`article_id`),
  KEY `cat_id` (`cat_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='文章内容表';

/*Data for the table `ecs_article` */

/*Table structure for table `ecs_article_cat` */

DROP TABLE IF EXISTS `ecs_article_cat`;

CREATE TABLE `ecs_article_cat` (
  `cat_id` smallint(5) NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
  `cat_name` varchar(255) NOT NULL COMMENT '分类名称',
  `cat_type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '分类类型；1，普通分类；2，系统分类；3，网店信息；4，帮助分类；5，网店帮助',
  `keywords` varchar(255) NOT NULL COMMENT '分类关键字',
  `cat_desc` varchar(255) NOT NULL COMMENT '分类说明文字',
  `sort_order` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '分类显示顺序',
  `show_in_nav` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否在导航栏显示；0，否；1，是',
  `parent_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '父节点id，取值于该表cat_id字段',
  PRIMARY KEY (`cat_id`),
  KEY `cat_type` (`cat_type`),
  KEY `sort_order` (`sort_order`),
  KEY `parent_id` (`parent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='文章分类信息表';

/*Data for the table `ecs_article_cat` */

/*Table structure for table `ecs_attribute` */

DROP TABLE IF EXISTS `ecs_attribute`;

CREATE TABLE `ecs_attribute` (
  `attr_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
  `cat_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '商品类型，同ecs_goods_type的cat_id',
  `attr_name` varchar(60) NOT NULL COMMENT '属性名称',
  `attr_input_type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '当添加商品时，该属性的添加类别；0，为手工输入；1，为选择输入；2，为多行文本输入',
  `attr_type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '属性是否多选；0，否；1，是；如果可以多选，则可以自定义属性，并且可以根据值的不同定不同的价',
  `attr_values` text NOT NULL COMMENT '如果attr_input_type为1，即选择输入，则attr_name对应的值的取值就是该字段的值',
  `attr_index` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '属性是否可以检索；0，不需要检索；1，关键字检索；2，范围检索；该属性应该是如果检索的话，可以通过该属性找到有该属性的商品',
  `sort_order` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '属性显示的顺序，数字越大越靠前，如果数字一样则按id顺序',
  `is_linked` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否关联；0，不关联；1，关联；如果关联，那么用户在购买该商品时，具有有该属性相同值的商品将被推荐给用户',
  `attr_group` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '属性分组，相同的为一个属性组。该值应该取自ecs_goods_type的attr_group的值的顺序',
  PRIMARY KEY (`attr_id`),
  KEY `cat_id` (`cat_id`)
) ENGINE=MyISAM AUTO_INCREMENT=175 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品类型属性表，该表记录的是每个商品类型的所有属性的配置情况，具体的商品的属性不在该表';

/*Data for the table `ecs_attribute` */

/*Table structure for table `ecs_auction_log` */

DROP TABLE IF EXISTS `ecs_auction_log`;

CREATE TABLE `ecs_auction_log` (
  `log_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
  `act_id` mediumint(8) unsigned NOT NULL COMMENT '拍卖活动的id，取值于ecs_goods_activity的act_id字段',
  `bid_user` mediumint(8) unsigned NOT NULL COMMENT '出价的用户id，取值于ecs_users的user_id',
  `bid_price` decimal(10,2) unsigned NOT NULL COMMENT '出价价格',
  `bid_time` int(10) unsigned NOT NULL COMMENT '出价时间',
  PRIMARY KEY (`log_id`),
  KEY `act_id` (`act_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='拍卖出价记录信息表';

/*Data for the table `ecs_auction_log` */

/*Table structure for table `ecs_auto_manage` */

DROP TABLE IF EXISTS `ecs_auto_manage`;

CREATE TABLE `ecs_auto_manage` (
  `item_id` mediumint(8) NOT NULL COMMENT '如果是商品就是ecs_goods的goods_id，如果是文章就是ecs_article的article_id',
  `type` varchar(10) NOT NULL COMMENT 'goods是商品，article是文章',
  `starttime` int(10) NOT NULL COMMENT '上线时间',
  `endtime` int(10) NOT NULL COMMENT '下线时间',
  PRIMARY KEY (`item_id`,`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='处理文章，商品自动上下线的计划任务列表；需要安装计划任务插件才有效';

/*Data for the table `ecs_auto_manage` */

/*Table structure for table `ecs_bonus_type` */

DROP TABLE IF EXISTS `ecs_bonus_type`;

CREATE TABLE `ecs_bonus_type` (
  `type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '红包类型流水号',
  `type_name` varchar(60) NOT NULL COMMENT '红包名称',
  `type_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '红包所值的金额',
  `send_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '红包发送类型.0,按用户如会员等级,会员名称发放;1,按商品类别发送;2,按订单金额所达到的额度发送;3,线下发送',
  `min_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '如果是按金额发送红包,该项是最小金额.即只要购买超过该金额的商品都可以领到红包',
  `max_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `send_start_date` int(11) NOT NULL DEFAULT '0' COMMENT '红包发送的开始时间',
  `send_end_date` int(11) NOT NULL DEFAULT '0' COMMENT '红包发送的结束时间',
  `use_start_date` int(11) NOT NULL DEFAULT '0' COMMENT '红包可以使用的开始时间',
  `use_end_date` int(11) NOT NULL DEFAULT '0' COMMENT '红包可以使用的结束时间',
  `min_goods_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '可以使用该红包的商品的最低价格.即只要达到该价格的商品才可以使用红包',
  PRIMARY KEY (`type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='红包类型表';

/*Data for the table `ecs_bonus_type` */

/*Table structure for table `ecs_booking_goods` */

DROP TABLE IF EXISTS `ecs_booking_goods`;

CREATE TABLE `ecs_booking_goods` (
  `rec_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
  `user_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '登记该缺货记录的用户的id，取值ecs_users的user_id',
  `email` varchar(60) NOT NULL COMMENT '页面填的用户的email，默认取值于ecs_users的email',
  `link_man` varchar(60) NOT NULL COMMENT '页面填的用户的姓名，默认取值于ecs_users的consignee ',
  `tel` varchar(60) NOT NULL COMMENT '页面填的用户的电话，默认取值于ecs_users的tel',
  `goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '缺货登记的商品id，取值于ecs_goods的 goods_id',
  `goods_desc` varchar(255) NOT NULL COMMENT '缺货登记时留的订购描述',
  `goods_number` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '订购数量',
  `booking_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '缺货登记的时间',
  `is_dispose` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否已经被处理',
  `dispose_user` varchar(30) NOT NULL COMMENT '处理该缺货登记的管理员用户名，取值于session,该session取值于ecs_admin_user的user_name',
  `dispose_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '处理的时间',
  `dispose_note` varchar(255) NOT NULL COMMENT '处理时管理员留的备注',
  PRIMARY KEY (`rec_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='缺货登记的订购和处理记录表';

/*Data for the table `ecs_booking_goods` */

/*Table structure for table `ecs_brand` */

DROP TABLE IF EXISTS `ecs_brand`;

CREATE TABLE `ecs_brand` (
  `brand_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
  `brand_name` varchar(60) NOT NULL COMMENT '品牌名称',
  `brand_logo` varchar(80) NOT NULL COMMENT '上传的该品牌公司logo图片',
  `brand_desc` text NOT NULL COMMENT '品牌描述',
  `site_url` varchar(255) NOT NULL COMMENT '品牌的网址',
  `sort_order` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '品牌在前台页面的显示顺序，数字越大越靠后',
  `is_show` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '该品牌是否显示，0，否；1，显示',
  PRIMARY KEY (`brand_id`),
  KEY `is_show` (`is_show`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品品牌信息记录表';

/*Data for the table `ecs_brand` */

insert  into `ecs_brand`(`brand_id`,`brand_name`,`brand_logo`,`brand_desc`,`site_url`,`sort_order`,`is_show`) values (21,'fdsfsdfdsfds','/upload/2017-09-09/bvq1lqdtql7laab8sgig04l4vyqhxkjl.png','wx','http://fdsfdsfds.com',10,1),(23,'fdfdsfdsf','/upload/2017-09-09/my2dth7ysb5spqyj3uxntxfx0jezwz9x.png','uu','http://xxxx.com',0,1),(22,'xxxxx','/upload/2017-09-09/q7a0cwwpudgoimseeukjq6szolqprgcz.png','xxxxx','http://dasdasdas.com',0,1),(24,'zzzzzzzzzz','/upload/2017-09-09/gmgzjyx1x5bim3svv62ieobecj7je1be.png','xa','http://zzzzzzz.com',0,0),(13,'dsadasdsa','/upload/2017-09-08/wb0ryslxt5qpxpy3xqbr9imos03akg2h.png','dasdsadasdas','http://fasdasd.com',0,1),(15,'大时代','/upload/2017-09-08/lkqytebd0rnpnpc7xjqc98akon8sohs4.png','wx','http://fasfsfds.com/fdsfds',0,1),(16,'hgfhgfhgf','/upload/2017-09-08/1amhc2lkwmkzwdp8sye50vvyoveqasib.png','dasasdas','http://dadasdas.com',11,0),(18,'gdfgdfgdf','/upload/2017-09-08/gihg9fgvltqfn8epzhvlpwxwtkrcrtwc.png','fsdfsfsdf','http://dada.com',0,1),(20,'fasfsdfdsfsd','/upload/2017-09-08/adyqzedfacnrsdvmbg8wxtxsxehw2mcm.png','tv','http://ddddddddddddadad.comggdfgdfg',0,1);

/*Table structure for table `ecs_card` */

DROP TABLE IF EXISTS `ecs_card`;

CREATE TABLE `ecs_card` (
  `card_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
  `card_name` varchar(120) NOT NULL COMMENT '贺卡名称',
  `card_img` varchar(255) NOT NULL COMMENT '贺卡图纸的名称',
  `card_fee` decimal(6,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '贺卡所需费用',
  `free_money` decimal(6,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '订单达到该字段的值后使用此贺卡免费',
  `card_desc` varchar(255) NOT NULL COMMENT '贺卡的描述',
  PRIMARY KEY (`card_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='贺卡的配置的信息';

/*Data for the table `ecs_card` */

/*Table structure for table `ecs_cart` */

DROP TABLE IF EXISTS `ecs_cart`;

CREATE TABLE `ecs_cart` (
  `rec_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
  `user_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '用户登录id，取自session，',
  `session_id` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '登录的sessionid，如果该用户退出，该sessionid对应的购物车中的所有记录都将被删除',
  `goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '商品的id，取自表goods的goods_id',
  `goods_sn` varchar(60) NOT NULL COMMENT '商品的货号，取自表goods的goods_sn',
  `goods_name` varchar(120) NOT NULL COMMENT '商品的名称，取自表goods的goods_name',
  `market_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '商品的市场价，取自表goods的market_price',
  `goods_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商品的本店价，取自表goods的shop_price',
  `goods_number` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '商品的购买数量，在购物车时，实际库存不减少',
  `goods_attr` text NOT NULL COMMENT '商品的属性，中括号里是该属性特有的价格',
  `is_real` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '取自ecs_goods的is_real',
  `extension_code` varchar(30) NOT NULL COMMENT '商品的扩展属性，取自ecs_goods的extension_code',
  `parent_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '该商品的父商品id，没有该值为0，有的话那该商品就是该id的配件',
  `rec_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '购物车商品类型，0，普通；1，团够；2，拍卖；3，夺宝奇兵',
  `is_gift` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '是否是赠品，0，否；其他，是参加优惠活动的id，取值于ecs_favourable_activity 的act_id',
  `can_handsel` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `goods_attr_id` mediumint(8) NOT NULL COMMENT '该商品的属性的id，取自goods_attr的goods_attr_id，如果有多个，只记录了最后一个，可能是个bug',
  PRIMARY KEY (`rec_id`),
  KEY `session_id` (`session_id`)
) ENGINE=MyISAM AUTO_INCREMENT=82 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='购物车购物信息记录表';

/*Data for the table `ecs_cart` */

/*Table structure for table `ecs_category` */

DROP TABLE IF EXISTS `ecs_category`;

CREATE TABLE `ecs_category` (
  `cat_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
  `cat_name` varchar(90) NOT NULL COMMENT '分类名称',
  `keywords` varchar(255) NOT NULL COMMENT '分类的关键字，可能是为了搜索',
  `cat_desc` varchar(255) NOT NULL COMMENT '分类描述',
  `parent_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '该分类的父id，取值于该表的cat_id字段',
  `sort_order` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '该分类在页面显示的顺序，数字越大顺序越靠后；同数字，id在前的先显示',
  `template_file` varchar(50) NOT NULL COMMENT '不确定字段，按名字和表设计猜，应该是该分类的单独模板文件的名字',
  `measure_unit` varchar(15) NOT NULL COMMENT '该分类的计量单位',
  `show_in_nav` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否显示在导航栏，0，不；1，显示在导航栏',
  `style` varchar(150) NOT NULL COMMENT '该分类的单独的样式表的包括文件名部分的文件路径',
  `is_show` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否在前台页面显示，1，显示；0，不显示',
  `grade` tinyint(4) NOT NULL DEFAULT '0' COMMENT '该分类的最高和最低价之间的价格分级，当大于1时，会根据最大最小价格区间分成区间，会在页面显示价格范围，如0-300,300-600,600-900这种',
  `filter_attr` smallint(6) NOT NULL DEFAULT '0' COMMENT '如果该字段有值，则该分类将还会按照该值对应在表goods_attr的goods_attr_id所对应的属性筛选，如，封面颜色下有红，黑分类筛选 ',
  PRIMARY KEY (`cat_id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品分类表，记录商品分类信息';

/*Data for the table `ecs_category` */

/*Table structure for table `ecs_collect_goods` */

DROP TABLE IF EXISTS `ecs_collect_goods`;

CREATE TABLE `ecs_collect_goods` (
  `rec_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '收藏记录的自增id',
  `user_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '该条收藏记录的会员id，取值于ecs_users的user_id',
  `goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '收藏的商品id，取值于ecs_goods的goods_id',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '收藏时间',
  `is_attention` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否关注该收藏商品，1，是；0，否',
  PRIMARY KEY (`rec_id`),
  KEY `user_id` (`user_id`),
  KEY `goods_id` (`goods_id`),
  KEY `is_attention` (`is_attention`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='会员收藏商品的记录列表，一条记录一个收藏商品';

/*Data for the table `ecs_collect_goods` */

/*Table structure for table `ecs_comment` */

DROP TABLE IF EXISTS `ecs_comment`;

CREATE TABLE `ecs_comment` (
  `comment_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户评论的自增id',
  `comment_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '用户评论的类型；0，评论的是商品；1，评论的是文章',
  `id_value` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '文章或者商品的id，文章对应的是ecs_article 的article_id；商品对应的是ecs_goods的goods_id',
  `email` varchar(60) NOT NULL COMMENT '评论时提交的email地址，默认取的ecs_users的email',
  `user_name` varchar(60) NOT NULL COMMENT '评论该文章或商品的人的名称，取值ecs_users的user_name',
  `content` text NOT NULL COMMENT '评论的内容',
  `comment_rank` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '该文章或者商品的星级；只有1到5星；由数字代替；其中5是代表5星',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论的时间',
  `ip_address` varchar(15) NOT NULL COMMENT '评论时的用户ip',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否被管理员批准显示，1，是；0，未批准显示',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论的父节点；取值该表的comment_id字段；如果该字段为0，则是一个普通评论，否则该条评论就是该字段的值所对应的评论的回复',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发表该评论的用户的用户id，取值于ecs_users的user_id',
  PRIMARY KEY (`comment_id`),
  KEY `parent_id` (`parent_id`),
  KEY `id_value` (`id_value`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户对文章和产品的评论列表';

/*Data for the table `ecs_comment` */

/*Table structure for table `ecs_crons` */

DROP TABLE IF EXISTS `ecs_crons`;

CREATE TABLE `ecs_crons` (
  `cron_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
  `cron_code` varchar(20) NOT NULL COMMENT '该插件文件在相应路径下的不包括''.php''部分的文件名，运行该插件将通过该字段的值寻找将运行的文件',
  `cron_name` varchar(120) NOT NULL COMMENT '计划任务的名称',
  `cron_desc` text COMMENT '计划人物的描述',
  `cron_order` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '应该是用了设置计划任务执行的顺序的，即当同时触发2个任务时先执行哪一个，如果一样应该是id在前的先执行暂不确定',
  `cron_config` text NOT NULL COMMENT '对每次处理的数据的数量的值，类型，名称序列化；比如删几天的日志，每次执行几个商品或文章的处理',
  `thistime` int(10) NOT NULL DEFAULT '0' COMMENT '该计划任务上次被执行的时间',
  `nextime` int(10) NOT NULL COMMENT '该计划任务下次被执行的时间',
  `day` tinyint(2) NOT NULL COMMENT '如果该字段有值，则计划任务将在每月的这一天执行该计划人物',
  `week` varchar(1) NOT NULL COMMENT '如果该字段有值，则计划任务将在每周的这一天执行该计划人物',
  `hour` varchar(2) NOT NULL COMMENT '如果该字段有值，则该计划任务将在每天的这个小时段执行该计划任务',
  `minute` varchar(255) NOT NULL COMMENT '如果该字段有值，则该计划任务将在每小时的这个分钟段执行该计划任务，该字段的值可以多个，用空格间隔',
  `enable` tinyint(1) NOT NULL DEFAULT '1' COMMENT '该计划任务是否开启；0，关闭；1，开启',
  `run_once` tinyint(1) NOT NULL DEFAULT '0' COMMENT '执行后是否关闭，这个关闭的意思还得再研究下',
  `allow_ip` varchar(100) NOT NULL COMMENT '允许运行该计划人物的服务器ip',
  `alow_files` varchar(255) NOT NULL COMMENT '运行触发该计划人物的文件列表可多个值，为空代表所有许可的文件都可以',
  PRIMARY KEY (`cron_id`),
  KEY `nextime` (`nextime`),
  KEY `enable` (`enable`),
  KEY `cron_code` (`cron_code`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='计划任务插件安装配置信息';

/*Data for the table `ecs_crons` */

/*Table structure for table `ecs_email_list` */

DROP TABLE IF EXISTS `ecs_email_list`;

CREATE TABLE `ecs_email_list` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT COMMENT '邮件订阅的自增id',
  `email` varchar(60) NOT NULL COMMENT '邮件订阅所填的邮箱地址',
  `stat` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否确认，可以用户确认也可以管理员确认；0，未确认；1，已确认',
  `hash` varchar(10) NOT NULL COMMENT '邮箱确认的验证码，系统生成后发送到用户邮箱，用户验证激活时通过该值判断是否合法；主要用来防止非法验证邮箱',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='增加电子杂志订阅表';

/*Data for the table `ecs_email_list` */

/*Table structure for table `ecs_email_sendlist` */

DROP TABLE IF EXISTS `ecs_email_sendlist`;

CREATE TABLE `ecs_email_sendlist` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT COMMENT '邮件发送队列自增id',
  `email` varchar(100) NOT NULL COMMENT '该邮件将要发送到的邮箱地址',
  `template_id` mediumint(8) NOT NULL COMMENT '该邮件的模板id，取值于ecs_mail_templates的template_id',
  `email_content` text NOT NULL COMMENT '邮件发送的内容',
  `error` tinyint(1) NOT NULL DEFAULT '0' COMMENT '错误次数，不知干什么用的，猜应该是发送邮件的失败记录',
  `pri` tinyint(10) NOT NULL COMMENT '该邮件发送的优先级；0，普通；1，高',
  `last_send` int(10) NOT NULL COMMENT '上一次发送的时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='增加发送队列表';

/*Data for the table `ecs_email_sendlist` */

/*Table structure for table `ecs_error_log` */

DROP TABLE IF EXISTS `ecs_error_log`;

CREATE TABLE `ecs_error_log` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '计划任务错误自增id',
  `info` varchar(255) NOT NULL COMMENT '错误详细信息',
  `file` varchar(100) NOT NULL COMMENT '产生错误的执行文件的绝对路径',
  `time` int(10) NOT NULL COMMENT '错误发生的时间',
  PRIMARY KEY (`id`),
  KEY `time` (`time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='该表用来记录页面触发计划任务时失败所产生的错误，从程序来看，目前主要是记录某计划任务所对应的插件文件不存在的错误';

/*Data for the table `ecs_error_log` */

/*Table structure for table `ecs_favourable_activity` */

DROP TABLE IF EXISTS `ecs_favourable_activity`;

CREATE TABLE `ecs_favourable_activity` (
  `act_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '优惠活动的自增id',
  `act_name` varchar(255) NOT NULL COMMENT '优惠活动的活动名称',
  `start_time` int(10) unsigned NOT NULL COMMENT '活动的开始时间',
  `end_time` int(10) unsigned NOT NULL COMMENT '活动的结束时间',
  `user_rank` varchar(255) NOT NULL COMMENT '可以参加活动的用户信息，取值于ecs_user_rank的rank_id；其中0是非会员，其他是相应的会员等级；多个值用逗号分隔',
  `act_range` tinyint(3) unsigned NOT NULL COMMENT '优惠范围；0，全部商品；1，按分类；2，按品牌；3，按商品',
  `act_range_ext` varchar(255) NOT NULL COMMENT '根据优惠活动范围的不同，该处意义不同；但是都是优惠范围的约束；如，如果是商品，该处是商品的id，如果是品牌，该处是品牌的id',
  `min_amount` decimal(10,2) unsigned NOT NULL COMMENT '订单达到金额下限，才参加活动',
  `max_amount` decimal(10,2) unsigned NOT NULL COMMENT '参加活动的订单金额下限，0，表示没有上限',
  `act_type` tinyint(3) unsigned NOT NULL COMMENT '参加活动的优惠方式；0，送赠品或优惠购买；1，现金减免；价格打折优惠',
  `act_type_ext` decimal(10,2) unsigned NOT NULL COMMENT '如果是送赠品，该处是允许的最大数量，0，无数量限制；现今减免，则是减免金额，单位元；打折，是折扣值，100算，8折就是80',
  `gift` text NOT NULL COMMENT '如果有特惠商品，这里是序列化后的特惠商品的id,name,price信息;取值于ecs_goods的goods_id，goods_name，价格是添加活动时填写的',
  `sort_order` tinyint(3) unsigned NOT NULL COMMENT '活动在优惠活动页面显示的先后顺序，数字越大越靠后',
  PRIMARY KEY (`act_id`),
  KEY `act_name` (`act_name`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='优惠活动的配置信息，优惠活动包括送礼，减免，打折';

/*Data for the table `ecs_favourable_activity` */

/*Table structure for table `ecs_feedback` */

DROP TABLE IF EXISTS `ecs_feedback`;

CREATE TABLE `ecs_feedback` (
  `msg_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '反馈信息自增id',
  `parent_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '父节点，取自该表msg_id；反馈该值为0；回复反馈为节点id',
  `user_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '反馈的用户的id',
  `user_name` varchar(60) NOT NULL COMMENT '反馈的用户的用户名',
  `user_email` varchar(60) NOT NULL COMMENT '反馈的用户的邮箱',
  `msg_title` varchar(200) NOT NULL COMMENT '反馈的标题，回复为reply',
  `msg_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '反馈的类型，0，留言；1，投诉；2，询问；3，售后；4，求购',
  `msg_content` text NOT NULL COMMENT '反馈的内容',
  `msg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '反馈的时间',
  `message_img` varchar(255) NOT NULL DEFAULT '0' COMMENT '用户上传的文件的地址',
  `order_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '该反馈关联的订单id，由用户提交，取值于 ecs_order_info的order_id；0，为无匹配；',
  PRIMARY KEY (`msg_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户反馈信息表，包括留言，投诉，咨询等';

/*Data for the table `ecs_feedback` */

/*Table structure for table `ecs_friend_link` */

DROP TABLE IF EXISTS `ecs_friend_link`;

CREATE TABLE `ecs_friend_link` (
  `link_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '友情链接自增id',
  `link_name` varchar(255) NOT NULL COMMENT '友情链接的名称，img的alt的内容;',
  `link_url` varchar(255) NOT NULL COMMENT '友情链接网站的链接地址',
  `link_logo` varchar(255) NOT NULL COMMENT '友情链接的logo',
  `show_order` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '在页面的显示顺序',
  PRIMARY KEY (`link_id`),
  KEY `show_order` (`show_order`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='友情链接配置信息表';

/*Data for the table `ecs_friend_link` */

/*Table structure for table `ecs_goods` */

DROP TABLE IF EXISTS `ecs_goods`;

CREATE TABLE `ecs_goods` (
  `goods_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品的自增id',
  `cat_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '商品所属商品分类id，取值ecs_category的cat_id',
  `goods_sn` varchar(60) NOT NULL COMMENT '商品的唯一货号',
  `goods_name` varchar(120) NOT NULL COMMENT '商品的名称',
  `goods_name_style` varchar(60) NOT NULL DEFAULT '+' COMMENT '商品名称显示的样式；包括颜色和字体样式；格式如#ff00ff+strong',
  `click_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品点击数',
  `brand_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '品牌id，取值于ecs_brand 的brand_id',
  `provider_name` varchar(100) NOT NULL COMMENT '供货人的名称，程序还没实现该功能',
  `goods_number` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '商品库存数量',
  `goods_weight` decimal(10,3) unsigned NOT NULL DEFAULT '0.000' COMMENT '商品的重量，以千克为单位',
  `market_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '市场售价',
  `shop_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '本店售价',
  `promote_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '促销价格',
  `promote_start_date` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '促销价格开始日期',
  `promote_end_date` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '促销价结束日期',
  `warn_number` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '商品报警数量',
  `keywords` varchar(255) NOT NULL COMMENT '商品关键字，放在商品页的关键字中，为搜索引擎收录用',
  `goods_brief` varchar(255) NOT NULL COMMENT '商品的简短描述',
  `goods_desc` text NOT NULL COMMENT '商品的详细描述',
  `goods_thumb` varchar(255) NOT NULL COMMENT '商品在前台显示的微缩图片，如在分类筛选时显示的小图片',
  `goods_img` varchar(255) NOT NULL COMMENT '商品的实际大小图片，如进入该商品页时介绍商品属性所显示的大图片',
  `original_img` varchar(255) NOT NULL COMMENT '应该是上传的商品的原始图片',
  `is_real` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否是实物，1，是；0，否；比如虚拟卡就为0，不是实物',
  `extension_code` varchar(30) NOT NULL COMMENT '商品的扩展属性，比如像虚拟卡',
  `is_on_sale` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '该商品是否开放销售，1，是；0，否',
  `is_alone_sale` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否能单独销售，1，是；0，否；如果不能单独销售，则只能作为某商品的配件或者赠品销售',
  `integral` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '购买该商品可以使用的积分数量，估计应该是用积分代替金额消费；但程序好像还没有实现该功能',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品的添加时间',
  `sort_order` smallint(4) unsigned NOT NULL DEFAULT '0' COMMENT '应该是商品的显示顺序，不过该版程序中没实现该功能',
  `is_delete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '商品是否已经删除，0，否；1，已删除',
  `is_best` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否是精品；0，否；1，是',
  `is_new` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否是新品；0，否；1，是',
  `is_hot` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否热销，0，否；1，是',
  `is_promote` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否特价促销；0，否；1，是',
  `bonus_type_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '购买该商品所能领到的红包类型',
  `last_update` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最近一次更新商品配置的时间',
  `goods_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '商品所属类型id，取值表goods_type的cat_id',
  `seller_note` varchar(255) NOT NULL COMMENT '商品的商家备注，仅商家可见',
  `give_integral` int(11) NOT NULL DEFAULT '-1' COMMENT '购买该商品时每笔成功交易赠送的积分数量。',
  PRIMARY KEY (`goods_id`),
  KEY `goods_sn` (`goods_sn`),
  KEY `cat_id` (`cat_id`),
  KEY `last_update` (`last_update`),
  KEY `brand_id` (`brand_id`),
  KEY `goods_weight` (`goods_weight`),
  KEY `promote_end_date` (`promote_end_date`),
  KEY `promote_start_date` (`promote_start_date`),
  KEY `goods_number` (`goods_number`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品表';

/*Data for the table `ecs_goods` */

/*Table structure for table `ecs_goods_activity` */

DROP TABLE IF EXISTS `ecs_goods_activity`;

CREATE TABLE `ecs_goods_activity` (
  `act_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
  `act_name` varchar(255) NOT NULL COMMENT '促销活动的名称',
  `act_desc` text NOT NULL COMMENT '促销活动的描述',
  `act_type` tinyint(3) unsigned NOT NULL,
  `goods_id` mediumint(8) unsigned NOT NULL COMMENT '参加活动的id，取值于ecs_goods的goods_id',
  `goods_name` varchar(255) NOT NULL COMMENT '商品的名称，取值于ecs_goods的goods_id',
  `start_time` int(10) unsigned NOT NULL COMMENT '活动开始时间',
  `end_time` int(10) unsigned NOT NULL COMMENT '活动结束时间',
  `is_finished` tinyint(3) unsigned NOT NULL COMMENT '活动是否结束，0，结束；1，未结束',
  `ext_info` text NOT NULL COMMENT '序列化后的促销活动的配置信息，包括最低价，最高价，出价幅度，保证金等',
  PRIMARY KEY (`act_id`),
  KEY `act_name` (`act_name`,`act_type`,`goods_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='拍卖活动和夺宝奇兵活动配置信息表';

/*Data for the table `ecs_goods_activity` */

/*Table structure for table `ecs_goods_article` */

DROP TABLE IF EXISTS `ecs_goods_article`;

CREATE TABLE `ecs_goods_article` (
  `goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '商品id，取自ecs_goods的goods_id',
  `article_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '文章id，取自 ecs_article 的article_id',
  `admin_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '猜想是管理员的id，但是程序中似乎没有提及到',
  PRIMARY KEY (`goods_id`,`article_id`,`admin_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='文章关联产品表，即文章中提到的相关产品';

/*Data for the table `ecs_goods_article` */

/*Table structure for table `ecs_goods_attr` */

DROP TABLE IF EXISTS `ecs_goods_attr`;

CREATE TABLE `ecs_goods_attr` (
  `goods_attr_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
  `goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '该具体属性属于的商品，取值于ecs_goods的goods_id',
  `attr_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '该具体属性属于的属性类型的id，取自ecs_attribute 的attr_id',
  `attr_value` text NOT NULL COMMENT '该具体属性的值',
  `attr_price` varchar(255) NOT NULL COMMENT '该属性对应在商品原价格上要加的价格',
  PRIMARY KEY (`goods_attr_id`),
  KEY `goods_id` (`goods_id`),
  KEY `attr_id` (`attr_id`)
) ENGINE=MyISAM AUTO_INCREMENT=62 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='具体商品的属性表';

/*Data for the table `ecs_goods_attr` */

/*Table structure for table `ecs_goods_cat` */

DROP TABLE IF EXISTS `ecs_goods_cat`;

CREATE TABLE `ecs_goods_cat` (
  `goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `cat_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '商品分类id',
  PRIMARY KEY (`goods_id`,`cat_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='商品的扩展分类';

/*Data for the table `ecs_goods_cat` */

/*Table structure for table `ecs_goods_gallery` */

DROP TABLE IF EXISTS `ecs_goods_gallery`;

CREATE TABLE `ecs_goods_gallery` (
  `img_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品相册自增id',
  `goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '图片属于商品的id',
  `img_url` varchar(255) NOT NULL COMMENT '实际图片url',
  `img_desc` varchar(255) NOT NULL COMMENT '图片说明信息',
  `thumb_url` varchar(255) NOT NULL COMMENT '微缩图片url',
  `img_original` varchar(255) NOT NULL COMMENT '根据名字猜，应该是上传的图片文件的最原始的文件的url',
  PRIMARY KEY (`img_id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品相册表，只出现在页面的商品相册中';

/*Data for the table `ecs_goods_gallery` */

/*Table structure for table `ecs_goods_type` */

DROP TABLE IF EXISTS `ecs_goods_type`;

CREATE TABLE `ecs_goods_type` (
  `cat_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
  `cat_name` varchar(60) NOT NULL COMMENT '商品类型名',
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '类型状态，1，为可用；0为不可用；不可用的类型，在添加商品的时候选择商品属性将不可选',
  `attr_group` varchar(255) NOT NULL COMMENT '商品属性分组，将一个商品类型的属性分成组，在显示的时候也是按组显示。该字段的值显示在属性的前一行，像标题的作用',
  PRIMARY KEY (`cat_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品类型表，该表每条记录就是一个商品类型';

/*Data for the table `ecs_goods_type` */

/*Table structure for table `ecs_group_goods` */

DROP TABLE IF EXISTS `ecs_group_goods`;

CREATE TABLE `ecs_group_goods` (
  `parent_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '父商品id',
  `goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '配件商品id',
  `goods_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '配件商品的价格',
  `admin_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '添加该配件的管理员的id',
  PRIMARY KEY (`parent_id`,`goods_id`,`admin_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='该表应该是商品配件配置表';

/*Data for the table `ecs_group_goods` */

/*Table structure for table `ecs_keywords` */

DROP TABLE IF EXISTS `ecs_keywords`;

CREATE TABLE `ecs_keywords` (
  `date` date NOT NULL DEFAULT '0000-00-00' COMMENT '搜索日期',
  `searchengine` varchar(20) NOT NULL COMMENT '搜索引擎，默认是ecshop',
  `keyword` varchar(90) NOT NULL COMMENT '搜索关键字，即用户填写的搜索内容',
  `count` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '搜索次数，按天累加',
  PRIMARY KEY (`date`,`searchengine`,`keyword`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='页面搜索关键字搜索记录';

/*Data for the table `ecs_keywords` */

/*Table structure for table `ecs_link_goods` */

DROP TABLE IF EXISTS `ecs_link_goods`;

CREATE TABLE `ecs_link_goods` (
  `goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `link_goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '被关联的商品的id',
  `is_double` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否是双向关联；0，否；1，是',
  `admin_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '添加此关联商品信息的管理员id',
  PRIMARY KEY (`goods_id`,`link_goods_id`,`admin_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='关联商品信息表，关联商品是什么意思还没研究明白';

/*Data for the table `ecs_link_goods` */

/*Table structure for table `ecs_mail_templates` */

DROP TABLE IF EXISTS `ecs_mail_templates`;

CREATE TABLE `ecs_mail_templates` (
  `template_id` tinyint(1) unsigned NOT NULL AUTO_INCREMENT COMMENT '邮件模板自增id',
  `template_code` varchar(30) NOT NULL COMMENT '模板字符串名称，主要用于插件言语包时匹配语言包文件等用途',
  `is_html` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '邮件是否是html格式；0，否；1，是',
  `template_subject` varchar(200) NOT NULL COMMENT '该邮件模板的邮件主题',
  `template_content` text NOT NULL COMMENT '邮件模板的内容',
  `last_modify` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后一次修改模板的时间',
  `last_send` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最近一次发送的时间，好像仅在杂志才记录',
  `type` varchar(10) NOT NULL COMMENT '该邮件模板的邮件类型；共2个类型；magazine，杂志订阅；template，关注订阅',
  PRIMARY KEY (`template_id`),
  UNIQUE KEY `template_code` (`template_code`),
  KEY `type` (`type`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='各种邮件的模板配置模板包括杂志模板';

/*Data for the table `ecs_mail_templates` */

/*Table structure for table `ecs_member_price` */

DROP TABLE IF EXISTS `ecs_member_price`;

CREATE TABLE `ecs_member_price` (
  `price_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '折扣价自增id',
  `goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '商品的id',
  `user_rank` tinyint(3) NOT NULL DEFAULT '0' COMMENT '会员登记id',
  `user_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '指定商品对指定会员等级的固定定价价格，单位元',
  PRIMARY KEY (`price_id`),
  KEY `goods_id` (`goods_id`,`user_rank`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='商品不按照会员的折扣定价，而是再单独为不同的会员等级定的价；';

/*Data for the table `ecs_member_price` */

/*Table structure for table `ecs_nav` */

DROP TABLE IF EXISTS `ecs_nav`;

CREATE TABLE `ecs_nav` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT COMMENT '导航配置自增id',
  `ctype` varchar(10) DEFAULT NULL,
  `cid` smallint(5) unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL COMMENT '导航显示标题',
  `ifshow` tinyint(1) NOT NULL COMMENT '是否显示',
  `vieworder` tinyint(1) NOT NULL COMMENT '页面显示顺序，数字越大越靠后',
  `opennew` tinyint(1) NOT NULL COMMENT '导航链接页面是否在新窗口打开，1，是；其他，否',
  `url` varchar(255) NOT NULL COMMENT '链接的页面地址',
  `type` varchar(10) NOT NULL COMMENT '处于导航栏的位置，top为顶部；middle为中间；bottom,为底部',
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `ifshow` (`ifshow`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='上中下3个导航栏的显示配置';

/*Data for the table `ecs_nav` */

/*Table structure for table `ecs_order_action` */

DROP TABLE IF EXISTS `ecs_order_action`;

CREATE TABLE `ecs_order_action` (
  `action_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '流水号',
  `order_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '被操作的交易号',
  `action_user` varchar(30) NOT NULL COMMENT '操作该次的人员',
  `order_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '作何操作.0，未确认；1，已确认；2，已取消；3，无效；4，退货；',
  `shipping_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '发货状态。0，未发货；1，已发货；2，已收货；3，备货中',
  `pay_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '支付状态.0,未付款;1,付款中;2,已付款;',
  `action_note` varchar(255) NOT NULL COMMENT '操作备注',
  `log_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '操作时间',
  PRIMARY KEY (`action_id`),
  KEY `order_id` (`order_id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='对订单操作日志表';

/*Data for the table `ecs_order_action` */

/*Table structure for table `ecs_order_goods` */

DROP TABLE IF EXISTS `ecs_order_goods`;

CREATE TABLE `ecs_order_goods` (
  `rec_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '订单商品信息自增id',
  `order_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '订单商品信息对应的详细信息id，取值order_info的order_id',
  `goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '商品的的id，取值表ecs_goods 的goods_id',
  `goods_name` varchar(120) NOT NULL COMMENT '商品的名称，取值表ecs_goods ',
  `goods_sn` varchar(60) NOT NULL COMMENT '商品的唯一货号，取值ecs_goods ',
  `goods_number` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT '商品的购买数量',
  `market_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商品的市场售价，取值ecs_goods ',
  `goods_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商品的本店售价，取值ecs_goods ',
  `goods_attr` text NOT NULL COMMENT '购买该商品时所选择的属性；',
  `send_number` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '当不是实物时，是否已发货，0，否；1，是',
  `is_real` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否是实物，0，否；1，是；取值ecs_goods ',
  `extension_code` varchar(30) NOT NULL COMMENT '商品的扩展属性，比如像虚拟卡。取值ecs_goods ',
  `parent_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '父商品id，取值于ecs_cart的parent_id；如果有该值则是值多代表的物品的配件',
  `is_gift` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '是否参加优惠活动，0，否；其他，取值于ecs_cart 的is_gift，跟其一样，是参加的优惠活动的id',
  PRIMARY KEY (`rec_id`),
  KEY `order_id` (`order_id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单的商品信息，注：订单的商品信息基本都是从购物车所对应的表中取来的。';

/*Data for the table `ecs_order_goods` */

/*Table structure for table `ecs_order_info` */

DROP TABLE IF EXISTS `ecs_order_info`;

CREATE TABLE `ecs_order_info` (
  `order_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '订单详细信息自增id',
  `order_sn` varchar(20) NOT NULL COMMENT '订单号，唯一',
  `user_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '用户id，同ecs_users的user_id',
  `order_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '订单状态。0，未确认；1，已确认；2，已取消；3，无效；4，退货；',
  `shipping_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '商品配送情况，0，未发货；1，已发货；2，已收货；3，备货中',
  `pay_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '支付状态；0，未付款；1，付款中；2，已付款',
  `consignee` varchar(60) NOT NULL COMMENT '收货人的姓名，用户页面填写，默认取值于表user_address',
  `country` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '收货人的国家，用户页面填写，默认取值于表user_address，其id对应的值在ecs_region',
  `province` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '收货人的省份，用户页面填写，默认取值于表user_address，其id对应的值在ecs_region',
  `city` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '收货人的城市，用户页面填写，默认取值于表user_address，其id对应的值在ecs_region',
  `district` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '收货人的地区，用户页面填写，默认取值于表user_address，其id对应的值在ecs_region',
  `address` varchar(255) NOT NULL COMMENT '收货人的详细地址，用户页面填写，默认取值于表user_address',
  `zipcode` varchar(60) NOT NULL COMMENT '收货人的邮编，用户页面填写，默认取值于表user_address',
  `tel` varchar(60) NOT NULL COMMENT '收货人的电话，用户页面填写，默认取值于表user_address',
  `mobile` varchar(60) NOT NULL COMMENT '收货人的手机，用户页面填写，默认取值于表user_address',
  `email` varchar(60) NOT NULL COMMENT '收货人的手机，用户页面填写，默认取值于表user_address',
  `best_time` varchar(120) NOT NULL COMMENT '收货人的最佳送货时间，用户页面填写，默认取值于表user_address',
  `sign_building` varchar(120) NOT NULL COMMENT '收货人的地址的标志性建筑，用户页面填写，默认取值于表user_address',
  `postscript` varchar(255) NOT NULL COMMENT '订单附言，由用户提交订单前填写',
  `shipping_id` tinyint(3) NOT NULL DEFAULT '0' COMMENT '用户选择的配送方式id，取值表ecs_shipping',
  `shipping_name` varchar(120) NOT NULL COMMENT '用户选择的配送方式的名称，取值表ecs_shipping',
  `pay_id` tinyint(3) NOT NULL DEFAULT '0' COMMENT '用户选择的支付方式的id，取值表ecs_payment',
  `pay_name` varchar(120) NOT NULL COMMENT '用户选择的支付方式的名称，取值表ecs_payment',
  `how_oos` varchar(120) NOT NULL COMMENT '缺货处理方式，等待所有商品备齐后再发； 取消订单；与店主协商',
  `how_surplus` varchar(120) NOT NULL COMMENT '根据字段猜测应该是余额处理方式，程序未作这部分实现',
  `pack_name` varchar(120) NOT NULL COMMENT '包装名称，取值表ecs_pack',
  `card_name` varchar(120) NOT NULL COMMENT '贺卡的名称，取值ecs_card ',
  `card_message` varchar(255) NOT NULL COMMENT '贺卡内容，由用户提交',
  `inv_payee` varchar(120) NOT NULL COMMENT '发票抬头，用户页面填写',
  `inv_content` varchar(120) NOT NULL COMMENT '发票内容，用户页面选择，取值ecs_shop_config的code字段的值为invoice_content的value',
  `goods_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商品总金额',
  `shipping_fee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '配送费用',
  `insure_fee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '保价费用',
  `pay_fee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '支付费用,跟支付方式的配置相关，取值表ecs_payment',
  `pack_fee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '包装费用，取值表取值表ecs_pack',
  `card_fee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '贺卡费用，取值ecs_card ',
  `money_paid` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '已付款金额',
  `surplus` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '该订单使用余额的数量，取用户设定余额，用户可用余额，订单金额中最小者',
  `integral` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '使用的积分的数量，取用户使用积分，商品可用积分，用户拥有积分中最小者',
  `integral_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '使用积分金额',
  `bonus` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '使用红包金额',
  `order_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '应付款金额',
  `from_ad` smallint(5) NOT NULL DEFAULT '0' COMMENT '订单由某广告带来的广告id，应该取值于ecs_ad',
  `referer` varchar(255) NOT NULL COMMENT '订单的来源页面',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单生成时间',
  `confirm_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单确认时间',
  `pay_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单支付时间',
  `shipping_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单配送时间',
  `pack_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '包装id，取值取值表ecs_pack',
  `card_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '贺卡id，用户在页面选择，取值取值ecs_card ',
  `bonus_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '红包的id，ecs_user_bonus的bonus_id',
  `invoice_no` varchar(50) NOT NULL COMMENT '发货单号，发货时填写，可在订单查询查看',
  `extension_code` varchar(30) NOT NULL COMMENT '通过活动购买的商品的代号；GROUP_BUY是团购；AUCTION，是拍卖；SNATCH，夺宝奇兵；正常普通产品该处为空',
  `extension_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '通过活动购买的物品的id，取值ecs_goods_activity；如果是正常普通商品，该处为0',
  `to_buyer` varchar(255) NOT NULL COMMENT '商家给客户的留言,当该字段有值时可以在订单查询看到',
  `pay_note` varchar(255) NOT NULL COMMENT '付款备注，在订单管理里编辑修改',
  `agency_id` smallint(5) unsigned NOT NULL COMMENT '该笔订单被指派给的办事处的id，根据订单内容和办事处负责范围自动决定，也可以有管理员修改，取值于表ecs_agency',
  `inv_type` varchar(60) NOT NULL COMMENT '发票类型，用户页面选择，取值ecs_shop_config的code字段的值为invoice_type的value',
  `tax` decimal(10,2) NOT NULL COMMENT '发票税额',
  `is_separate` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0，未分成或等待分成；1，已分成；2，取消分成；',
  `parent_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '能获得推荐分成的用户id，id取值于表ecs_users',
  `discount` decimal(10,2) NOT NULL COMMENT '折扣金额',
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `order_sn` (`order_sn`),
  KEY `user_id` (`user_id`),
  KEY `order_status` (`order_status`),
  KEY `shipping_status` (`shipping_status`),
  KEY `pay_status` (`pay_status`),
  KEY `shipping_id` (`shipping_id`),
  KEY `pay_id` (`pay_id`),
  KEY `extension_code` (`extension_code`,`extension_id`),
  KEY `agency_id` (`agency_id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单的配送，贺卡等详细信息';

/*Data for the table `ecs_order_info` */

/*Table structure for table `ecs_pack` */

DROP TABLE IF EXISTS `ecs_pack`;

CREATE TABLE `ecs_pack` (
  `pack_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT '包装配置的自增id',
  `pack_name` varchar(120) NOT NULL COMMENT '包装的名称',
  `pack_img` varchar(255) NOT NULL COMMENT '包装图纸',
  `pack_fee` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '包装的费用',
  `free_money` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '订单达到此金额可以免除该包装费用',
  `pack_desc` varchar(255) NOT NULL COMMENT '包装描述',
  PRIMARY KEY (`pack_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品包装信息配置表';

/*Data for the table `ecs_pack` */

/*Table structure for table `ecs_pay_log` */

DROP TABLE IF EXISTS `ecs_pay_log`;

CREATE TABLE `ecs_pay_log` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '支付记录自增id',
  `order_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '对应的交易记录的id，取值表ecs_order_info ',
  `order_amount` decimal(10,2) unsigned NOT NULL COMMENT '支付金额',
  `order_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '支付类型；0，订单支付；1，会员预付款支付',
  `is_paid` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否已支付，0，否；1，是',
  PRIMARY KEY (`log_id`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='系统支付记录';

/*Data for the table `ecs_pay_log` */

/*Table structure for table `ecs_payment` */

DROP TABLE IF EXISTS `ecs_payment`;

CREATE TABLE `ecs_payment` (
  `pay_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT '已安装的支付方式自增id',
  `pay_code` varchar(20) NOT NULL COMMENT '支付方式的英文缩写，其实就是该支付方式处理插件的不带后缀的文件名部分',
  `pay_name` varchar(120) NOT NULL COMMENT '支付方式名称',
  `pay_fee` varchar(10) NOT NULL DEFAULT '0' COMMENT '支付费用',
  `pay_desc` text NOT NULL COMMENT '支付方式描述',
  `pay_order` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '支付方式在页面的显示顺序',
  `pay_config` text NOT NULL COMMENT '支付方式的配置信息，包括商户号和密钥什么的',
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否可用，0，否；1，是',
  `is_cod` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否货到付款，0，否；1，是',
  `is_online` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否在线支付，0，否；1，是',
  PRIMARY KEY (`pay_id`),
  UNIQUE KEY `pay_code` (`pay_code`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='安装的支付方式配置信息';

/*Data for the table `ecs_payment` */

/*Table structure for table `ecs_plugins` */

DROP TABLE IF EXISTS `ecs_plugins`;

CREATE TABLE `ecs_plugins` (
  `code` varchar(30) NOT NULL DEFAULT '',
  `version` varchar(10) NOT NULL DEFAULT '',
  `library` varchar(255) NOT NULL DEFAULT '',
  `assign` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `install_date` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `ecs_plugins` */

/*Table structure for table `ecs_region` */

DROP TABLE IF EXISTS `ecs_region`;

CREATE TABLE `ecs_region` (
  `region_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '表示该地区的id',
  `parent_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '该地区的上一个节点的地区id',
  `region_name` varchar(120) NOT NULL COMMENT '地区的名字',
  `region_type` tinyint(1) NOT NULL DEFAULT '2' COMMENT '该地区的下一个节点的地区id',
  `agency_id` smallint(5) unsigned NOT NULL COMMENT '办事处的id,这里有一个bug,同一个省不能有多个办事处,该字段只记录最新的那个办事处的id',
  PRIMARY KEY (`region_id`),
  KEY `parent_id` (`parent_id`),
  KEY `region_type` (`region_type`),
  KEY `agency_id` (`agency_id`)
) ENGINE=MyISAM AUTO_INCREMENT=419 DEFAULT CHARSET=utf8 COMMENT='地区列表';

/*Data for the table `ecs_region` */

/*Table structure for table `ecs_searchengine` */

DROP TABLE IF EXISTS `ecs_searchengine`;

CREATE TABLE `ecs_searchengine` (
  `date` date NOT NULL DEFAULT '0000-00-00' COMMENT '搜索引擎访问日期',
  `searchengine` varchar(20) NOT NULL COMMENT '搜索引擎名称',
  `count` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '访问次数',
  PRIMARY KEY (`date`,`searchengine`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='搜索引擎访问记录';

/*Data for the table `ecs_searchengine` */

/*Table structure for table `ecs_sessions` */

DROP TABLE IF EXISTS `ecs_sessions`;

CREATE TABLE `ecs_sessions` (
  `sesskey` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'sessionid,',
  `expiry` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'session创建时间',
  `userid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '如果不是管理员，记录用户id',
  `adminid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '如果是管理员记录管理员id',
  `ip` char(15) NOT NULL COMMENT '客户端ip',
  `data` char(255) NOT NULL COMMENT '序列化后的session数据，如果session数据大于255则将数据存到表ecs_sessions_data，此处为空',
  PRIMARY KEY (`sesskey`),
  KEY `expiry` (`expiry`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='session记录表';

/*Data for the table `ecs_sessions` */

/*Table structure for table `ecs_sessions_data` */

DROP TABLE IF EXISTS `ecs_sessions_data`;

CREATE TABLE `ecs_sessions_data` (
  `sesskey` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'sessionid',
  `expiry` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'session创建时间',
  `data` longtext NOT NULL COMMENT 'session序列化后的数据',
  PRIMARY KEY (`sesskey`),
  KEY `expiry` (`expiry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='session数据表（超过255字节的session内容会保存在该表）';

/*Data for the table `ecs_sessions_data` */

/*Table structure for table `ecs_shipping` */

DROP TABLE IF EXISTS `ecs_shipping`;

CREATE TABLE `ecs_shipping` (
  `shipping_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
  `shipping_code` varchar(20) NOT NULL COMMENT '配送方式的字符串代号',
  `shipping_name` varchar(120) NOT NULL COMMENT '配送方式的名称',
  `shipping_desc` varchar(255) NOT NULL COMMENT '配送方式的描述',
  `insure` varchar(10) NOT NULL DEFAULT '0' COMMENT '保价费用，单位元，或者是百分数，该值直接输出为报价费用',
  `support_cod` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否支持货到付款，1，支持；0，不支持',
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '该配送方式是否被禁用，1，可用；0，禁用',
  PRIMARY KEY (`shipping_id`),
  KEY `shipping_code` (`shipping_code`,`enabled`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='配送方式配置信息表';

/*Data for the table `ecs_shipping` */

/*Table structure for table `ecs_shipping_area` */

DROP TABLE IF EXISTS `ecs_shipping_area`;

CREATE TABLE `ecs_shipping_area` (
  `shipping_area_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
  `shipping_area_name` varchar(150) NOT NULL COMMENT '配送方式中的配送区域的名字',
  `shipping_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '该配送区域所属的配送方式，同ecs_shipping的shipping_id',
  `configure` text NOT NULL COMMENT '序列化的该配送区域的费用配置信息',
  PRIMARY KEY (`shipping_area_id`),
  KEY `shipping_id` (`shipping_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='配送方式所属的配送区域和配送费用信息';

/*Data for the table `ecs_shipping_area` */

/*Table structure for table `ecs_shop_config` */

DROP TABLE IF EXISTS `ecs_shop_config`;

CREATE TABLE `ecs_shop_config` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '全站配置信息自增id',
  `parent_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '父节点id，取值于该表id字段的值',
  `code` varchar(30) NOT NULL COMMENT '跟变量名的作用差不多，其实就是语言包中的字符串索引，如$_LANG[''cfg_range''][''cart_confirm'']',
  `type` varchar(10) NOT NULL COMMENT '该配置的类型，text，文本输入框；password，密码输入框；textarea，文本区域；select，单选；options，循环生成多选；file,文件上传；manual，手动生成多选；group，是标题分组；\nhidden，不在页面显示',
  `store_range` varchar(255) NOT NULL COMMENT '当语言包中的code字段对应的是一个数组时，那该处就是该数组的索引，如$_LANG[''cfg_range''] [''cart_confirm''][1]；只有type字段为select,options时才有值',
  `store_dir` varchar(255) NOT NULL COMMENT '当type为file时才有值，文件上传后的保存目录',
  `value` text NOT NULL COMMENT '该项配置的值',
  `sort_order` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '显示顺序，数字越大越靠后',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `parent_id` (`parent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=903 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='全站配置信息表';

/*Data for the table `ecs_shop_config` */

/*Table structure for table `ecs_snatch_log` */

DROP TABLE IF EXISTS `ecs_snatch_log`;

CREATE TABLE `ecs_snatch_log` (
  `log_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
  `snatch_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '夺宝奇兵活动号，取值于ecs_goods_activity的act_id字段',
  `user_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '出价的用户id，取值于ecs_users的user_id',
  `bid_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '出价的价格',
  `bid_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '出价的时间',
  PRIMARY KEY (`log_id`),
  KEY `snatch_id` (`snatch_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='夺宝奇兵出价记录表';

/*Data for the table `ecs_snatch_log` */

/*Table structure for table `ecs_stats` */

DROP TABLE IF EXISTS `ecs_stats`;

CREATE TABLE `ecs_stats` (
  `access_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '访问时间',
  `ip_address` varchar(15) NOT NULL COMMENT '访问者ip',
  `visit_times` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT '访问次数，如果之前有过访问次数，在以前的基础上＋1',
  `browser` varchar(60) NOT NULL COMMENT '浏览器及版本',
  `system` varchar(20) NOT NULL COMMENT '操作系统',
  `language` varchar(20) NOT NULL COMMENT '语言',
  `area` varchar(30) NOT NULL COMMENT 'ip所在地区',
  `referer_domain` varchar(100) NOT NULL COMMENT '页面访问来源域名',
  `referer_path` varchar(200) NOT NULL COMMENT '页面访问来源除域名外的路径部分',
  `access_url` varchar(255) NOT NULL COMMENT '访问页面文件名',
  KEY `access_time` (`access_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='访问信息记录表';

/*Data for the table `ecs_stats` */

/*Table structure for table `ecs_tag` */

DROP TABLE IF EXISTS `ecs_tag`;

CREATE TABLE `ecs_tag` (
  `tag_id` mediumint(8) NOT NULL AUTO_INCREMENT COMMENT '商品标签自增id',
  `user_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '用户的id',
  `goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '商品的id',
  `tag_words` varchar(255) NOT NULL COMMENT '标签内容',
  PRIMARY KEY (`tag_id`),
  KEY `user_id` (`user_id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品的标记';

/*Data for the table `ecs_tag` */

/*Table structure for table `ecs_template` */

DROP TABLE IF EXISTS `ecs_template`;

CREATE TABLE `ecs_template` (
  `filename` varchar(30) NOT NULL COMMENT '该条模板配置属于哪个模板页面',
  `region` varchar(40) NOT NULL COMMENT '该条模板配置在它所属的模板文件中的位置',
  `library` varchar(40) NOT NULL COMMENT '该条模板配置在它所属的模板文件中的位置处应该引入的lib的相对目录地址',
  `sort_order` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '模板文件中这个位置的引入lib项的值的显示顺序',
  `id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '字段意义待查',
  `number` tinyint(1) unsigned NOT NULL DEFAULT '5' COMMENT '每次显示多少个值',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '属于哪个动态项，0，固定项；1，分类下的商品；2，品牌下的商品；3，文章列表；4，广告位 ',
  `theme` varchar(60) NOT NULL COMMENT '该模板配置项属于哪套模板的模板名',
  `remarks` varchar(30) NOT NULL COMMENT '备注，可能是预留字段，没有值所以没确定用途',
  KEY `filename` (`filename`,`region`),
  KEY `theme` (`theme`),
  KEY `remarks` (`remarks`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='模板设置数据表';

/*Data for the table `ecs_template` */

/*Table structure for table `ecs_topic` */

DROP TABLE IF EXISTS `ecs_topic`;

CREATE TABLE `ecs_topic` (
  `topic_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '专题自增id',
  `title` varchar(255) NOT NULL DEFAULT '''''' COMMENT '专题名称',
  `intro` text NOT NULL COMMENT '专题介绍',
  `start_time` int(11) NOT NULL DEFAULT '0' COMMENT '专题开始时间',
  `end_time` int(10) NOT NULL DEFAULT '0' COMMENT '结束时间',
  `data` text NOT NULL COMMENT '专题数据内容，包括分类，商品等',
  `template` varchar(255) NOT NULL DEFAULT '''''' COMMENT '专题模板文件',
  `css` text NOT NULL COMMENT '专题样式代码',
  KEY `topic_id` (`topic_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='专题活动配置表';

/*Data for the table `ecs_topic` */

/*Table structure for table `ecs_user_account` */

DROP TABLE IF EXISTS `ecs_user_account`;

CREATE TABLE `ecs_user_account` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID号',
  `user_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '用户登录后保存在session中的id号，跟users表中的user_id对应',
  `admin_user` varchar(255) NOT NULL COMMENT '操作该笔交易的管理员的用户名',
  `amount` decimal(10,2) NOT NULL COMMENT '资金的数目，正数为增加，负数为减少',
  `add_time` int(10) NOT NULL DEFAULT '0' COMMENT '记录插入时间',
  `paid_time` int(10) NOT NULL DEFAULT '0' COMMENT '记录更新时间',
  `admin_note` varchar(255) NOT NULL COMMENT '管理员的被准',
  `user_note` varchar(255) NOT NULL COMMENT '用户的被准',
  `process_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '操作类型，1，退款；0，预付费，其实就是充值',
  `payment` varchar(90) NOT NULL COMMENT '支付渠道的名称，取自payment的pay_name字段',
  `is_paid` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否已经付款，０，未付；１，已付',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `is_paid` (`is_paid`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户资金流动表，包括提现和充值';

/*Data for the table `ecs_user_account` */

/*Table structure for table `ecs_user_address` */

DROP TABLE IF EXISTS `ecs_user_address`;

CREATE TABLE `ecs_user_address` (
  `address_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `address_name` varchar(50) NOT NULL,
  `user_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '用户表中的流水号',
  `consignee` varchar(60) NOT NULL COMMENT '收货人的名字',
  `email` varchar(60) NOT NULL COMMENT '收货人的email',
  `country` smallint(5) NOT NULL DEFAULT '0' COMMENT '收货人的国家',
  `province` smallint(5) NOT NULL DEFAULT '0' COMMENT '收货人的省份',
  `city` smallint(5) NOT NULL DEFAULT '0' COMMENT '收货人的城市',
  `district` smallint(5) NOT NULL DEFAULT '0' COMMENT '收货人的地区',
  `address` varchar(120) NOT NULL COMMENT '收货人的详细地址',
  `zipcode` varchar(60) NOT NULL COMMENT '收货人的邮编',
  `tel` varchar(60) NOT NULL COMMENT '收货人的电话',
  `mobile` varchar(60) NOT NULL COMMENT '收货人的手机',
  `sign_building` varchar(120) NOT NULL COMMENT '收货地址的标志性建筑名',
  `best_time` varchar(120) NOT NULL COMMENT '收货人的最佳收货时间',
  PRIMARY KEY (`address_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='收货人的信息表';

/*Data for the table `ecs_user_address` */

/*Table structure for table `ecs_user_bonus` */

DROP TABLE IF EXISTS `ecs_user_bonus`;

CREATE TABLE `ecs_user_bonus` (
  `bonus_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '红包的流水号',
  `bonus_type_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '红包发送类型.0,按用户如会员等级,会员名称发放;1,按商品类别发送;2,按订单金额所达到的额度发送;3,线下发送',
  `bonus_sn` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '红包号,如果为0就是没有红包号.如果大于0,就需要输入该红包号才能使用红包',
  `user_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '该红包属于某会员的id.如果为0,就是该红包不属于某会员',
  `used_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '红包使用的时间',
  `order_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '使用了该红包的交易号',
  `emailed` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '猜的，应该是是否已经将红包发送到用户的邮箱；1，是；0，否；',
  PRIMARY KEY (`bonus_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=122 DEFAULT CHARSET=utf8 COMMENT='已经发送的红包信息列表';

/*Data for the table `ecs_user_bonus` */

/*Table structure for table `ecs_user_feed` */

DROP TABLE IF EXISTS `ecs_user_feed`;

CREATE TABLE `ecs_user_feed` (
  `feed_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `value_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `feed_type` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_feed` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`feed_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `ecs_user_feed` */

/*Table structure for table `ecs_user_rank` */

DROP TABLE IF EXISTS `ecs_user_rank`;

CREATE TABLE `ecs_user_rank` (
  `rank_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT '会员等级编号，其中0是非会员',
  `rank_name` varchar(30) NOT NULL COMMENT '会员等级名称',
  `min_points` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '该等级的最低积分',
  `max_points` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '该等级的最高积分',
  `discount` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '该会员等级的商品折扣',
  `show_price` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否在不是该等级会员购买页面显示该会员等级的折扣价格.1,显示;0,不显示',
  `special_rank` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否事特殊会员等级组.0,不是;1,是',
  PRIMARY KEY (`rank_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='会员等级配置信息';

/*Data for the table `ecs_user_rank` */

/*Table structure for table `ecs_users` */

DROP TABLE IF EXISTS `ecs_users`;

CREATE TABLE `ecs_users` (
  `user_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '会员资料自增id',
  `email` varchar(60) NOT NULL COMMENT '会员邮箱',
  `user_name` varchar(60) NOT NULL COMMENT '用户名',
  `password` varchar(32) NOT NULL COMMENT '用户密码',
  `question` varchar(255) NOT NULL COMMENT '安全问题答案',
  `answer` varchar(255) NOT NULL COMMENT '安全问题',
  `sex` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '性别，0，保密；1，男；2，女',
  `birthday` date NOT NULL DEFAULT '0000-00-00' COMMENT '生日日期',
  `user_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '用户现有资金',
  `frozen_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '用户冻结资金',
  `pay_points` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '消费积分',
  `rank_points` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员等级积分',
  `address_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '收货信息id，取值表ecs_user_address ',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `last_login` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '最后一次登录时间',
  `last_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '应该是最后一次修改信息时间，该表信息从其他表同步过来考虑',
  `last_ip` varchar(15) NOT NULL COMMENT '最后一次登录ip',
  `visit_count` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `user_rank` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '会员登记id，取值ecs_user_rank',
  `is_special` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `salt` varchar(10) NOT NULL DEFAULT '0',
  `parent_id` mediumint(9) NOT NULL DEFAULT '0' COMMENT '推荐人会员id，',
  `flag` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `alias` varchar(60) NOT NULL COMMENT '昵称',
  `msn` varchar(60) NOT NULL COMMENT 'msn',
  `qq` varchar(20) NOT NULL COMMENT 'qq号',
  `office_phone` varchar(20) NOT NULL COMMENT '办公电话',
  `home_phone` varchar(20) NOT NULL COMMENT '家庭电话',
  `mobile_phone` varchar(20) NOT NULL COMMENT '手机',
  `is_validated` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `credit_line` decimal(10,2) unsigned NOT NULL COMMENT '信用额度，目前2.6.0版好像没有作实现',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_name` (`user_name`),
  KEY `email` (`email`),
  KEY `parent_id` (`parent_id`),
  KEY `flag` (`flag`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `ecs_users` */

/*Table structure for table `ecs_virtual_card` */

DROP TABLE IF EXISTS `ecs_virtual_card`;

CREATE TABLE `ecs_virtual_card` (
  `card_id` mediumint(8) NOT NULL AUTO_INCREMENT COMMENT '虚拟卡卡号自增id',
  `goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '该虚拟卡对应的商品id，取值于表ecs_goods',
  `card_sn` varchar(60) NOT NULL COMMENT '加密后的卡号',
  `card_password` varchar(60) NOT NULL COMMENT '加密后的密码',
  `add_date` int(11) NOT NULL DEFAULT '0' COMMENT '卡号添加日期',
  `end_date` int(11) NOT NULL DEFAULT '0' COMMENT '卡号截至使用日期',
  `is_saled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否卖出，0，否；1，是',
  `order_sn` varchar(20) NOT NULL COMMENT '卖出该卡号的交易号，取值表ecs_order_info',
  `crc32` int(11) NOT NULL DEFAULT '0' COMMENT 'crc32后的key',
  PRIMARY KEY (`card_id`),
  KEY `goods_id` (`goods_id`),
  KEY `car_sn` (`card_sn`),
  KEY `is_saled` (`is_saled`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='虚拟卡卡号库';

/*Data for the table `ecs_virtual_card` */

/*Table structure for table `ecs_vote` */

DROP TABLE IF EXISTS `ecs_vote`;

CREATE TABLE `ecs_vote` (
  `vote_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '在线调查自增id',
  `vote_name` varchar(250) NOT NULL COMMENT '在线调查主题',
  `start_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '在线调查开始时间',
  `end_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '在线调查结束时间',
  `can_multi` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '能否多选，0，可以；1，不可以',
  `vote_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '投票人数也可以说投票次数',
  PRIMARY KEY (`vote_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='网站调查信息记录表';

/*Data for the table `ecs_vote` */

/*Table structure for table `ecs_vote_log` */

DROP TABLE IF EXISTS `ecs_vote_log`;

CREATE TABLE `ecs_vote_log` (
  `log_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '投票记录自增id',
  `vote_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '关联的投票主题id，取值表ecs_vote',
  `ip_address` varchar(15) NOT NULL COMMENT '投票的ip地址',
  `vote_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '投票的时间',
  PRIMARY KEY (`log_id`),
  KEY `vote_id` (`vote_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='投票记录表';

/*Data for the table `ecs_vote_log` */

/*Table structure for table `ecs_vote_option` */

DROP TABLE IF EXISTS `ecs_vote_option`;

CREATE TABLE `ecs_vote_option` (
  `option_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '投票选项自增id',
  `vote_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '关联的投票主题id，取值表ecs_vote',
  `option_name` varchar(250) NOT NULL COMMENT '投票选项的值',
  `option_count` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '该选项的票数',
  PRIMARY KEY (`option_id`),
  KEY `vote_id` (`vote_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='投票的选项内容表';

/*Data for the table `ecs_vote_option` */

/*Table structure for table `ecs_wholesale` */

DROP TABLE IF EXISTS `ecs_wholesale`;

CREATE TABLE `ecs_wholesale` (
  `act_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '批发方案自增id',
  `goods_id` mediumint(8) unsigned NOT NULL COMMENT '商品id',
  `goods_name` varchar(255) NOT NULL COMMENT '商品名称',
  `rank_ids` varchar(255) NOT NULL COMMENT '适用会员登记，多个值之间用逗号分隔，取值于ecs_user_rank',
  `prices` text NOT NULL COMMENT '序列化后的商品属性，数量，价格',
  `enabled` tinyint(3) unsigned NOT NULL COMMENT '批发方案是否可用',
  PRIMARY KEY (`act_id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='批发方案表';

/*Data for the table `ecs_wholesale` */

/*Table structure for table `sys_log` */

DROP TABLE IF EXISTS `sys_log`;

CREATE TABLE `sys_log` (
  `id` varchar(50) NOT NULL COMMENT '主键',
  `userName` varchar(50) NOT NULL COMMENT '用户',
  `logTitle` varchar(300) DEFAULT NULL COMMENT '日志标题',
  `logContent` text COMMENT '日志内容',
  `clientIp` varchar(50) DEFAULT NULL COMMENT '客户端IP',
  `requestUrl` varchar(300) DEFAULT NULL COMMENT '请求URL',
  `requestMethod` varchar(20) DEFAULT NULL COMMENT '请求方式',
  `requestParams` text COMMENT '参数',
  `logTime` datetime DEFAULT NULL COMMENT '日志时间',
  `other` varchar(300) DEFAULT NULL COMMENT '备用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日志表';

/*Data for the table `sys_log` */

insert  into `sys_log`(`id`,`userName`,`logTitle`,`logContent`,`clientIp`,`requestUrl`,`requestMethod`,`requestParams`,`logTime`,`other`) values ('1941e32d49f3442bb30d88dbac01705d','admin','','编辑用户','0:0:0:0:0:0:0:1','/user/doEdit','POST','{\"password\":[\"\"],\"userImg\":[\"/upload/2017-07-06/bw98sjevkkgi3cvzls5hqpc2dxhzo7qv.jpg\"],\"file\":[\"\"],\"userState\":[\"1\"],\"password2\":[\"\"],\"userDesc\":[\"超级管理员\"],\"id\":[\"8ec475bfc69041a4a3984c5510f7982b\"],\"userName\":[\"admin\"],\"roleIds[]\":[\"737933bffef640329a4f864c4e2746ba\"]}','2017-07-06 15:39:36',NULL),('3ccae7cd77544b929d379d238364a78b','admin','','编辑用户','0:0:0:0:0:0:0:1',NULL,'POST','{\"password\":[\"\"],\"userImg\":[\"/upload/2017-07-06/bw98sjevkkgi3cvzls5hqpc2dxhzo7qv.jpg\"],\"file\":[\"\"],\"userState\":[\"1\"],\"password2\":[\"\"],\"userDesc\":[\"超级管理员\"],\"id\":[\"8ec475bfc69041a4a3984c5510f7982b\"],\"userName\":[\"admin\"],\"roleIds[]\":[\"737933bffef640329a4f864c4e2746ba\"]}','2017-07-06 15:38:10',NULL),('5d6dd88bed3045e385870ad5db52b3a2','admin','','更新角色状态','0:0:0:0:0:0:0:1','/role/roleState','GET','{\"roleState\":[\"true\"],\"id\":[\"737933bffef640329a4f864c4e2746ba\"],\"_\":[\"1499327175984\"]}','2017-07-06 15:46:20',NULL),('8e97fe59385d430d862f73e09087934b','admin','','更新角色状态','0:0:0:0:0:0:0:1','/role/roleState','GET','{\"roleState\":[\"true\"],\"id\":[\"737933bffef640329a4f864c4e2746ba\"],\"_\":[\"1499327175982\"]}','2017-07-06 15:46:19',NULL),('be6e9a25b12c47fe92de521003f50382','admin','','编辑角色','0:0:0:0:0:0:0:1','/role/doEdit','POST','{\"roleName\":[\"超级管理员\"],\"roleDesc\":[\"超级管理员\"],\"id\":[\"737933bffef640329a4f864c4e2746ba\"]}','2017-07-06 15:46:18',NULL),('c0f7a4af5dc240a38ed73c702e129baa','admin','','更新角色状态','0:0:0:0:0:0:0:1','/role/roleState','GET','{\"roleState\":[\"false\"],\"id\":[\"737933bffef640329a4f864c4e2746ba\"],\"_\":[\"1499327175981\"]}','2017-07-06 15:46:19',NULL),('e28ca7d678fa41eb8bc712c6ad59f1af','admin','','更新角色状态','0:0:0:0:0:0:0:1','/role/roleState','GET','{\"roleState\":[\"false\"],\"id\":[\"737933bffef640329a4f864c4e2746ba\"],\"_\":[\"1499327175983\"]}','2017-07-06 15:46:19',NULL);

/*Table structure for table `sys_menu` */

DROP TABLE IF EXISTS `sys_menu`;

CREATE TABLE `sys_menu` (
  `id` varchar(50) NOT NULL COMMENT '主键',
  `text` varchar(50) NOT NULL COMMENT '菜单名称',
  `pid` varchar(50) NOT NULL COMMENT '父级菜单ID',
  `url` varchar(255) DEFAULT NULL COMMENT '连接地址',
  `icon` varchar(50) DEFAULT NULL COMMENT '图标',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `deep` int(11) DEFAULT NULL COMMENT '深度',
  `code` varchar(50) DEFAULT NULL COMMENT '编码',
  `resource` varchar(50) DEFAULT NULL COMMENT '资源名称',
  `xtype` varchar(50) DEFAULT NULL COMMENT '试图别名',
  `glyph` varchar(50) DEFAULT NULL COMMENT '字体图标',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='菜单表';

/*Data for the table `sys_menu` */

insert  into `sys_menu`(`id`,`text`,`pid`,`url`,`icon`,`sort`,`deep`,`code`,`resource`,`xtype`,`glyph`) values ('06670152165a42a09d9637deb05d13f0','商品管理','be659f4c66fb4db989f654eb408d86e1','/goods/list','',0,NULL,'0203','',NULL,NULL),('0c9b5fc8b44b41d1871a8fc8300247ec','删除菜单','4','','',4,3,'010303','menu:delete',NULL,NULL),('1','系统管理','0','#','',0,1,'01','','','0xf007'),('1db9105008404a3485b6fac30dba3c0e','查看角色列表','3','','',0,3,'010200','role:list','',''),('2','用户管理','1','/user/list','user',1,2,'0101','user','userlist','0xf007'),('3','角色管理','1','/role/list','',0,2,'0102','role','rolelist','0xf0c0'),('3b18f3d776c74266b63c2542825aa3c3','品牌管理','be659f4c66fb4db989f654eb408d86e1','/brand/list','',0,2,'0201','','',''),('3f26102ef0e04c3c9328cb97067cc5fa','创建菜单','4','','',1,3,'010301','menu:add',NULL,NULL),('4','菜单管理','1','/menu/list','icon-menu',3,2,'0103','menu','treemenu','0xf03a'),('4253190001c1480fb0d631d64d150535','编辑用户','2','','',0,3,'010102','user:edit',NULL,NULL),('42dd5ae31e3a43b3a197440e8ec19a94','监控列表','f5a20c82110b4a3ea9e30ca01a038680','','',1,3,'010701','monitor:lost',NULL,NULL),('45104a1560e34dcebb88cb8ae4bfdb1c','财务管理','0','#','&#xe65e;',0,1,'05','','','0xf157'),('488ef1eff57b4827acade7c0744278ce','查看菜单列表','4','','',0,3,'010300','menu:list',NULL,NULL),('60dda993d87647f5989c15f14f866df9','新增角色','3','','',0,3,'010201','role:add','',''),('649b484b58414d91aefa5a26143e6557','删除用户','2','','',0,3,'010103','user:delete','',''),('686630c7cb624cc786dcdc9958971a6b','编辑角色','3','','',2,3,'010202','role:edit','',''),('71a3a39a92b64aada22b57b36587b866','仓库管理','0','#','&#xe857;',0,1,'04','','','0xf0b1'),('809db56d93e848e8b43396e125803884','日志管理','1','/log/list','icon-rizhi',4,2,'0104','','loglist','0xf129'),('9c51e94cef99435780fb72bdb923a2ab','重置密码','2','','',0,3,'010104','user:restpwd','',''),('a0c6d8bb61ba42c8a11ddec068800820','商城设置','0','#','',0,NULL,'07','',NULL,NULL),('a5ebf29168234406939856bc6890c86b','角色授权','3','','',4,3,'010204','role:auth','',''),('a73802e513cc4465883530ec8074abbb','新增用户','2','','',0,3,'010101','user:add','',''),('b4e7232189b14cf3ba160cf7b0d3bf37','删除角色','3','','',3,3,'010203','role:delete','',''),('b9731c79358a4abc951900203e030ed3','采购管理','0','#','',0,1,'03','','','0xf0f3'),('be659f4c66fb4db989f654eb408d86e1','商品管理','0','#','&#xe61b;',0,1,'02','','','0xf217'),('c0c304be5c294114b5bc0d0c3acef992','日志列表','809db56d93e848e8b43396e125803884','','',1,3,'010401','log:list',NULL,NULL),('c7a50ded6fe14609a9da785e273b5af1','报表管理','0','#','&#xe62d;',0,1,'06','','','0xf1c3'),('cb9b92e1ed7b4f758e0e492681924b2f','类目管理','be659f4c66fb4db989f654eb408d86e1','/cat/list','',0,NULL,'0202','',NULL,NULL),('d2bc30feb5474a1bb7e02d48d39a3f8a','查看用户列表','2','','',0,3,'010100','user:list',NULL,NULL),('dc5f478d98ed4297a8ae638fe90df050','编辑菜单','4','','',0,3,'010302','menu:edit',NULL,NULL),('f5a20c82110b4a3ea9e30ca01a038680','系统监控','1','/monitoring','icon-jiankong',7,2,'0107','',NULL,'0xf06e');

/*Table structure for table `sys_role` */

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `id` varchar(50) NOT NULL COMMENT '主键',
  `roleName` varchar(50) NOT NULL COMMENT '角色名称',
  `roleDesc` varchar(300) DEFAULT NULL COMMENT '角色描述',
  `roleState` int(2) DEFAULT '1' COMMENT '状态,1-启用,-1禁用',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色表';

/*Data for the table `sys_role` */

insert  into `sys_role`(`id`,`roleName`,`roleDesc`,`roleState`,`createTime`) values ('1','管理员','管理员',1,'2016-12-14 10:22:34'),('2','财务部','财务部',1,'2016-12-14 10:22:34'),('2a9b728a431246b08f853c2529e6ba84','测试角色','测试fdgdfgdfgdfgfdgdf',1,'2017-02-28 15:15:41'),('3','产品部','产品部',0,'2016-12-14 10:22:34'),('420c04849fe4437c8ac54c39ca02ee2b','rgf','dsgdfgdfgdf',1,'2017-09-19 16:43:19'),('53eb8bf62c0744c9ac19d9b6e81b050f','xxx','xxx',1,'2017-09-11 15:08:20'),('5a2c4e7b3bcf4d4aa418f5d818b7d60d','xxx','xxx',1,'2017-09-19 16:43:09'),('6403131026164e8eaa5579b87d5f8f31','给个电饭锅','fdsfdsf',1,'2017-09-11 15:08:14'),('6b42c7888f9146b6ac1c42f20b6d9291','发多少f',' 发的发的发的发的',1,'2017-09-19 16:43:27'),('92f98a94217d44c59cbac9e03bcdd20e','fsdfsdfsdf','fsfsfsf',1,'2017-09-07 17:09:20'),('933249223e58406bafeb822adb98481b','wr','fdsfdsfds',1,'2017-09-19 16:43:22'),('ADMIN','超级管理员','超级管理员',1,'2016-12-14 10:22:34'),('ec611cf6564040e597337729b63ba07a','嘻嘻嘻','嘻嘻嘻',1,'2017-09-08 10:06:47');

/*Table structure for table `sys_role_menu` */

DROP TABLE IF EXISTS `sys_role_menu`;

CREATE TABLE `sys_role_menu` (
  `id` varchar(50) NOT NULL COMMENT '主键',
  `roleId` varchar(50) NOT NULL COMMENT '角色主键',
  `menuId` varchar(50) NOT NULL COMMENT '菜单主键',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色菜单关联表';

/*Data for the table `sys_role_menu` */

insert  into `sys_role_menu`(`id`,`roleId`,`menuId`) values ('075546041fcf484a86d5772e5939367b','2','4'),('08ca2023dbd94456b7300098276f5542','ADMIN','3'),('0b31769a85914f02bf361784f73d57a4','ADMIN','649b484b58414d91aefa5a26143e6557'),('0ee740c221704b7789e80b4586aebdc2','ADMIN','71a3a39a92b64aada22b57b36587b866'),('12d7fb2cd4f94f6e88b287e01aa039b4','ADMIN','b9731c79358a4abc951900203e030ed3'),('13522a67a96f4bc2973dd095c279fd67','ADMIN','45104a1560e34dcebb88cb8ae4bfdb1c'),('1b370b6562364010931820d083e1e661','ADMIN','2'),('24fb2d01d4424946930dca24ff44bec4','ADMIN','42dd5ae31e3a43b3a197440e8ec19a94'),('2a44fa497d3c4f19a1f81c8d77b232bc','2a9b728a431246b08f853c2529e6ba84','4253190001c1480fb0d631d64d150535'),('411a8222233e48e1a2d6e02bda61e3ed','2','2'),('4d5628b39e2d47eaaef73a96f1c3c6a5','53eb8bf62c0744c9ac19d9b6e81b050f','2'),('50d6821625694635a2248d660bc2ed09','ADMIN','a5ebf29168234406939856bc6890c86b'),('5624125403954a60bc217fd01688e325','ADMIN','f5a20c82110b4a3ea9e30ca01a038680'),('58647e17c4894ed480d6d533f544b643','ADMIN','9c51e94cef99435780fb72bdb923a2ab'),('60133ea31f6e4d5aa485b9b0686333f0','ADMIN','c7a50ded6fe14609a9da785e273b5af1'),('638e604af5de48f387fc116d94b6ebaf','ADMIN','686630c7cb624cc786dcdc9958971a6b'),('65ac26d144624c279d72a9e1907db46f','53eb8bf62c0744c9ac19d9b6e81b050f','d2bc30feb5474a1bb7e02d48d39a3f8a'),('6ad73954097b496cbd3c21817000a42e','1','06670152165a42a09d9637deb05d13f0'),('6bb87373c2db41deb5ebe839286084d1','ADMIN','f899f3d3baec4571b1c786717f9906fd'),('6e4c6b94b8e045ac820c21e6d682e9ff','2a9b728a431246b08f853c2529e6ba84','1'),('6e5957d640584278bca7ffbdf05a1962','2a9b728a431246b08f853c2529e6ba84','a73802e513cc4465883530ec8074abbb'),('6eb73a029089476397e955f883b335b7','ADMIN','488ef1eff57b4827acade7c0744278ce'),('71c73744ce5d41adbc33433ad600f10b','ADMIN','809db56d93e848e8b43396e125803884'),('74714029ffa34419a91c8330e3014f0a','ADMIN','d2bc30feb5474a1bb7e02d48d39a3f8a'),('74930a61f23f4fb8a31e1f19e78d39fd','ADMIN','4253190001c1480fb0d631d64d150535'),('75056910c3aa4b4583603a1630f7f7cd','ADMIN','1db9105008404a3485b6fac30dba3c0e'),('753901d889e549479ca7a77f77bb2953','2','1'),('75fa59ae5c3a448b9e09a2a70b21ff1e','ADMIN','1'),('778dbb388c784cb6bc61f30e805e72de','ADMIN','3f26102ef0e04c3c9328cb97067cc5fa'),('77abb3c2345e495f99ca1ea425cdfbe7','2','809db56d93e848e8b43396e125803884'),('78f8f0483ec54bde9e65b68a15fb30e2','2a9b728a431246b08f853c2529e6ba84','d2bc30feb5474a1bb7e02d48d39a3f8a'),('7d0b46520d1b43a6819b908e0c3a41e4','2a9b728a431246b08f853c2529e6ba84','9c51e94cef99435780fb72bdb923a2ab'),('80678bb9c0ba48c18d26666332a6c969','ADMIN','3b18f3d776c74266b63c2542825aa3c3'),('81d804176bd14131a1b5cf10b693e84f','ADMIN','b4e7232189b14cf3ba160cf7b0d3bf37'),('84a69a0d03dc435e93a99fde2f035e15','ADMIN','0c9b5fc8b44b41d1871a8fc8300247ec'),('84c92d9fced743bb8cb98b8e6b647f7e','1','3'),('9401c66a1c11441c9001df2ca388c758','ADMIN','4'),('95034001fbba4e04b99dab4dc7628e9d','2a9b728a431246b08f853c2529e6ba84','3'),('98ce388e345b419d88402e12c23d7a70','2','a0c6d8bb61ba42c8a11ddec068800820'),('9ef3f01c77ff42b3932de26babb14f10','ADMIN','dc5f478d98ed4297a8ae638fe90df050'),('a17290572e45494da1cc5c900e21a142','2a9b728a431246b08f853c2529e6ba84','1db9105008404a3485b6fac30dba3c0e'),('a5ee7587f50d4a70a20f033d683d2a5b','1','1'),('a8112735d754471d9e234d1107138d80','2a9b728a431246b08f853c2529e6ba84','4'),('a864f35b1b4143078fb94cd760340b03','ADMIN','be659f4c66fb4db989f654eb408d86e1'),('a9a6fcb3c5b64d6aaece4a121b33a6fb','ADMIN','e243bf5858d74e089650816cd6671c99'),('aaac01e73c1a468b8f176157e224fd26','2','3b18f3d776c74266b63c2542825aa3c3'),('b3a98a2779e54c0eb8512e7a94c20983','1','1db9105008404a3485b6fac30dba3c0e'),('bbedd09baeef4db09a0b35a547e943a1','ADMIN','a73802e513cc4465883530ec8074abbb'),('c6bc4e79510e42129a3302c47a558b3f','2a9b728a431246b08f853c2529e6ba84','b4e7232189b14cf3ba160cf7b0d3bf37'),('ceba32afb5ac4f129ed59db8f78198b5','2a9b728a431246b08f853c2529e6ba84','3f26102ef0e04c3c9328cb97067cc5fa'),('cf8ad3825aa84cc0a47aee76431c160f','2a9b728a431246b08f853c2529e6ba84','649b484b58414d91aefa5a26143e6557'),('d7d84bf619334657b65771a4acc2f9db','2a9b728a431246b08f853c2529e6ba84','a5ebf29168234406939856bc6890c86b'),('d878380dd855450d9178b8ab5d0721a6','2','f5a20c82110b4a3ea9e30ca01a038680'),('dd0d4cc1497744d6a5fc1f8a38ccfe4e','1','d2bc30feb5474a1bb7e02d48d39a3f8a'),('dd88a4588578486f964fce992f1585f0','ADMIN','c0c304be5c294114b5bc0d0c3acef992'),('e13818b3aa7f4018be4850c2af062cb3','ADMIN','60dda993d87647f5989c15f14f866df9'),('e21f5921be4b4beaa6100be16aab6f42','2a9b728a431246b08f853c2529e6ba84','686630c7cb624cc786dcdc9958971a6b'),('f316d53c5c1e4e77a5b70616e73efd28','2a9b728a431246b08f853c2529e6ba84','2'),('fbd8c4f041e941429c63183a7fac62f1','2a9b728a431246b08f853c2529e6ba84','60dda993d87647f5989c15f14f866df9');

/*Table structure for table `sys_user` */

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
  `id` varchar(50) NOT NULL COMMENT '主键',
  `userName` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(50) NOT NULL COMMENT '密码',
  `userState` int(2) NOT NULL DEFAULT '1' COMMENT '用户状态,1-启用,0禁用',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `userDesc` varchar(300) DEFAULT NULL COMMENT '描述',
  `userImg` varchar(300) DEFAULT NULL COMMENT '头像',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

/*Data for the table `sys_user` */

insert  into `sys_user`(`id`,`userName`,`password`,`userState`,`createTime`,`userDesc`,`userImg`) values ('01405b432a714c5791031ca090226a77','testName_441','******',1,'2017-09-06 15:48:13','测试描述_441',NULL),('0151fe5be84d4589a7415008d882091a','testName_713','******',1,'2017-09-06 15:48:15','测试描述_713',NULL),('025e3e5e35a74818bcc4b6c4dceb5d2f','testName_722','******',1,'2017-09-06 15:48:15','测试描述_722',NULL),('02d586a1457f47a4bd3e95e867ae8843','testName_228','******',1,'2017-09-06 15:48:12','测试描述_228',NULL),('02f8d7f080c44975a42c2cfe26b74377','testName_327','******',1,'2017-09-06 15:48:13','测试描述_327',NULL),('0328f8e3249b4c12b6db5a12895c603a','testName_281','******',1,'2017-09-06 15:48:12','测试描述_281',NULL),('036c622986c341e1afed5d093c630e7e','testName_177','******',1,'2017-09-06 15:48:12','测试描述_177',NULL),('03791ab7ab6b4e30b5eaf4cf4fbdaaf6','testName_184','******',1,'2017-09-06 15:48:12','测试描述_184',NULL),('0421083b994b42e2a64cacacbe61354d','testName_358','******',1,'2017-09-06 15:48:13','测试描述_358',NULL),('042d91ab31af4387b61237ad6139eb0e','edds','',0,'2017-09-06 15:48:14','xxxx',NULL),('046186c82a4e4be0b7bb5b377050bd50','testName_60','******',1,'2017-09-06 15:48:11','测试描述_60',NULL),('0531fd1e3c874c2eb2624fc54ef4e285','testName_29','******',1,'2017-09-06 15:48:11','测试描述_29',NULL),('053ee361cd314371bda635f5075a15f7','testName_62','******',1,'2017-09-06 15:48:11','测试描述_62',NULL),('054572a67b90419da8305b0fce65cc09','testName_708','******',1,'2017-09-06 15:48:15','测试描述_708',NULL),('055179fd6fe04ce9abd675cce434dc86','testName_724','******',1,'2017-09-06 15:48:15','测试描述_724',NULL),('0553df83f2044723adaa1ac88534d328','testName_444','******',1,'2017-09-06 15:48:13','测试描述_444',NULL),('06786ac054424733b07ce1ce899fff09','testName_497','******',1,'2017-09-06 15:48:14','测试描述_497',NULL),('071a09ee78c1450b9fd2857a8221d17d','testName_538','******',0,'2017-09-06 15:48:14','测试描述_538',NULL),('073fec8d363d492abbcfae586019cbd2','testName_314','******',1,'2017-09-06 15:48:13','测试描述_314',NULL),('075cdc9125214a2298caabd0168c915c','testName_188','******',1,'2017-09-06 15:48:12','测试描述_188',NULL),('08e40055889a4b60ae02083e14ce47d4','testName_710','******',1,'2017-09-06 15:48:15','测试描述_710',NULL),('090e9e96cfdb41cd875be9d0251c656b','testName_233','******',1,'2017-09-06 15:48:12','测试描述_233',NULL),('0912276050df46a1b50f8f82dc6e80f1','testName_187','******',1,'2017-09-06 15:48:12','测试描述_187',NULL),('0946521abb9e4b8e804836dbc48c7b15','testName_195','******',1,'2017-09-06 15:48:12','测试描述_195',NULL),('095cda0f3025463ba1f11b569fd0b2e6','testName_587','******',1,'2017-09-06 15:48:14','测试描述_587',NULL),('09aaf27081414ffc8ea4da8887b0b6c5','testName_682','******',1,'2017-09-06 15:48:15','测试描述_682',NULL),('0a1464d9574942dcbe8d39e1e0b34ef2','testName_139','******',1,'2017-09-06 15:48:11','测试描述_139',NULL),('0a57c4eb0c1340f9acc542f373987def','testName_391','******',1,'2017-09-06 15:48:13','测试描述_391',NULL),('0aad96ceb38841718a25d7fba45c1356','testName_524','******',1,'2017-09-06 15:48:14','测试描述_524',NULL),('0abc841b00ca48a8b34928a90680ec56','testName_114','******',1,'2017-09-06 15:48:11','测试描述_114',NULL),('0b5a66ce873e4ccf820532a6ed879297','testName_582','******',1,'2017-09-06 15:48:14','测试描述_582',NULL),('0b656ca088ee4a6da553c0db27e78397','testName_743','******',1,'2017-09-06 15:48:15','测试描述_743',NULL),('0b65ea7cf93b4a63b01ebca84a7c310a','testName_51','******',1,'2017-09-06 15:48:11','测试描述_51',NULL),('0b7a6bc2797e47c8816f3f77d90090fa','testName_594','******',1,'2017-09-06 15:48:14','测试描述_594',NULL),('0c0339d1a26a49f3ba306b6d580112a0','testName_471','******',1,'2017-09-06 15:48:14','测试描述_471',NULL),('0c83fcd7c62d42a7a82f648829630e50','testName_344','******',1,'2017-09-06 15:48:13','测试描述_344',NULL),('0c8ea981b58545528f44b32470fe3eea','testName_537','******',1,'2017-09-06 15:48:14','测试描述_537',NULL),('0cb08052cd6740819d15fcc68a8fe54e','testName_469','******',1,'2017-09-06 15:48:14','测试描述_469',NULL),('0cda683f43a4421499426344ea4393ec','testName_117','******',1,'2017-09-06 15:48:11','测试描述_117',NULL),('0e806256775f47a0bba33f9bf2d88728','testName_735','******',1,'2017-09-06 15:48:15','测试描述_735',NULL),('0ed42f3492f4448184d26c3857c22a98','testName_80','******',1,'2017-09-06 15:48:11','测试描述_80',NULL),('0f9b6e73b031421383df11715e8968d6','testName_339','******',1,'2017-09-06 15:48:13','测试描述_339',NULL),('0fa1717224a040d3bb950a97d9f0958d','testName_486','******',1,'2017-09-06 15:48:14','测试描述_486',NULL),('102ddfe8439f42dcb1e2a83f4f1704e1','testName_356','******',1,'2017-09-06 15:48:13','测试描述_356',NULL),('1078428d0c1e4e968949ec7d60fff884','testName_688','******',1,'2017-09-06 15:48:15','测试描述_688',NULL),('1105c5d769ad40dd932abd5763b22a71','testName_451','******',1,'2017-09-06 15:48:14','测试描述_451',NULL),('1109a8fdc9b147b4972206a1dc2461a0','testName_754','******',1,'2017-09-06 15:48:15','测试描述_754',NULL),('118b5afdf9224844ae0c1a0d34aeb259','testName_374','******',1,'2017-09-06 15:48:13','测试描述_374',NULL),('11b8ee74186644d5bc582cc7112ee644','testName_532','******',1,'2017-09-06 15:48:14','测试描述_532',NULL),('1219fb293e604206abefdce8574ef342','testName_407','******',1,'2017-09-06 15:48:13','测试描述_407',NULL),('13614f342aaa4f53af9a9c4e3abe256c','testName_104','******',1,'2017-09-06 15:48:11','测试描述_104',NULL),('13fa572e9edd4f6a97b58d72fece0fd6','testName_144','******',1,'2017-09-06 15:48:11','测试描述_144',NULL),('151033c8970a4da59f6f6ead69e46126','testName_687','******',1,'2017-09-06 15:48:15','测试描述_687',NULL),('15785ccbc5a14d1a833e7d0d2b8c9e71','testName_163','******',1,'2017-09-06 15:48:12','测试描述_163',NULL),('1694115f73164a3e9aac7331dd8c04ec','testName_541','******',1,'2017-09-06 15:48:14','测试描述_541',NULL),('16a988ec662143f9ae0620450710556c','testName_414','******',1,'2017-09-06 15:48:13','测试描述_414',NULL),('1743d23617a44c9aa61795dcd6a88f22','testName_234','******',1,'2017-09-06 15:48:12','测试描述_234',NULL),('177c063b9b1a4eaca12184cb512a02fb','testName_318','******',1,'2017-09-06 15:48:13','测试描述_318',NULL),('17ace3b782db4d0ebd0a44b2c1b42da4','testName_596','******',1,'2017-09-06 15:48:14','测试描述_596',NULL),('17f34b7bddca406dab3260c9f90a1b7f','testName_731','******',1,'2017-09-06 15:48:15','测试描述_731',NULL),('1846cd1e613f43b8b2963b45f2d24cc4','testName_661','******',1,'2017-09-06 15:48:15','测试描述_661',NULL),('18a32f008909467580f29e5b838a1492','testName_169','******',1,'2017-09-06 15:48:12','测试描述_169',NULL),('19143189d8084835aac1a88b8b22f247','testName_652','******',1,'2017-09-06 15:48:15','测试描述_652',NULL),('1953f0856cb4436e8d9c56912f84e857','testName_343','******',1,'2017-09-06 15:48:13','测试描述_343',NULL),('19a21e5ee74c401bb4365a32a3bcd201','testName_247','******',1,'2017-09-06 15:48:12','测试描述_247',NULL),('19aba4897014466e995272e57213361e','testName_214','******',1,'2017-09-06 15:48:12','测试描述_214',NULL),('1a0337f248dc40f19b0cf41f547f2c1d','testName_254','******',1,'2017-09-06 15:48:12','测试描述_254',NULL),('1a287874434a4a8296f2df598bab4674','testName_540','******',1,'2017-09-06 15:48:14','测试描述_540',NULL),('1a6ae3fdb3a447eeb13331318ee6866f','testName_417','******',1,'2017-09-06 15:48:13','测试描述_417',NULL),('1b38689a72d64466961141c7884517b6','testName_627','******',1,'2017-09-06 15:48:15','测试描述_627',NULL),('1bbb9922ca0a43eaa2c2de2dcc27ae5b','testName_42','******',1,'2017-09-06 15:48:11','测试描述_42',NULL),('1bf66a10710d403687229dc04bd03fe3','testName_481','******',1,'2017-09-06 15:48:14','测试描述_481',NULL),('1bf83216044642d88453d3de6dc4d3e0','testName_211','******',1,'2017-09-06 15:48:12','测试描述_211',NULL),('1c2a3c10bd52478793ac21677ff169d3','testName_272','******',1,'2017-09-06 15:48:12','测试描述_272',NULL),('1d36b19aea304bd8a5e632ec2cf91ee5','testName_141','******',1,'2017-09-06 15:48:11','测试描述_141',NULL),('1d4ed685c7db4e4a8be5c35cb3e2b896','testName_513','******',1,'2017-09-06 15:48:14','测试描述_513',NULL),('1d8df885260f42fabc1d46e23a636453','testName_30','******',1,'2017-09-06 15:48:11','测试描述_30',NULL),('1dfca5bf3fe5422886c398c9ead4a874','testName_37','******',1,'2017-09-06 15:48:11','测试描述_37',NULL),('1e0183cb5bd04270999e7e0ecaf865c8','testName_605','******',1,'2017-09-06 15:48:15','测试描述_605',NULL),('1e394a75da264d478bc658f2cf327901','testName_750','******',1,'2017-09-06 15:48:15','测试描述_750',NULL),('1e9f65a1cf7e4b148323e94bbca1851c','testName_520','******',1,'2017-09-06 15:48:14','测试描述_520',NULL),('1eedf4be0d734ec6af1164758a96e6a0','testName_654','******',1,'2017-09-06 15:48:15','测试描述_654',NULL),('1eef0b7a45334003b1cda1c29823c7a4','testName_561','******',1,'2017-09-06 15:48:14','测试描述_561',NULL),('1f0eca5f2aa34d5db9c2a3a29d0d75ae','testName_290','******',1,'2017-09-06 15:48:12','测试描述_290',NULL),('1f96a7ef33e5485fbd7bd2ea5064cdf1','testName_367','******',1,'2017-09-06 15:48:13','测试描述_367',NULL),('1f9c290414dd40998318ab595f23602c','testName_280','******',1,'2017-09-06 15:48:12','测试描述_280',NULL),('1f9d7945a9244d1ebd379936f43db824','testName_409','******',1,'2017-09-06 15:48:13','测试描述_409',NULL),('2024faeeef394e4ab07110e068e3d347','testName_9','******',1,'2017-09-06 15:48:11','测试描述_9',NULL),('203f6a04ec8f48469a492c6a8369794d','testName_625','******',1,'2017-09-06 15:48:15','测试描述_625',NULL),('205a73c16b804bd4af70cb3c3f1f370f','testName_153','******',1,'2017-09-06 15:48:12','测试描述_153',NULL),('21ade0a9dea641beb0d51f9fcf0f18bd','testName_608','******',1,'2017-09-06 15:48:15','测试描述_608',NULL),('21b155cb896b44308b8278beed2365e1','testName_484','******',1,'2017-09-06 15:48:14','测试描述_484',NULL),('224deae90e86496a86f09e21ad2f413a','testName_733','******',1,'2017-09-06 15:48:15','测试描述_733',NULL),('23874c6a6a1c4247850a9987270acc99','testName_219','******',1,'2017-09-06 15:48:12','测试描述_219',NULL),('241b186a8a0c4587b9caad997e2e1eb7','testName_252','******',1,'2017-09-06 15:48:12','测试描述_252',NULL),('2447933f3be0444593cba3d79a036a29','testName_208','******',1,'2017-09-06 15:48:12','测试描述_208',NULL),('24fc30506dc1496fbf96fb5bd65cd41b','testName_284','******',1,'2017-09-06 15:48:12','测试描述_284',NULL),('250835a152c941f3a7870e7170893f44','testName_151','******',1,'2017-09-06 15:48:12','测试描述_151',NULL),('25af221770d74b84bfddbe55fd805737','testName_203','******',1,'2017-09-06 15:48:12','测试描述_203',NULL),('25eeec6b925d42439451071ca5e35a35','testName_436','******',1,'2017-09-06 15:48:13','测试描述_436',NULL),('27535a8082af4068970c866a97b9a14a','testName_529','******',1,'2017-09-06 15:48:14','测试描述_529',NULL),('27683676634440538d2d67f5a9c4760f','testName_749','******',1,'2017-09-06 15:48:15','测试描述_749',NULL),('278abfcba39f4db1b61abb7bee57623b','testName_81','******',1,'2017-09-06 15:48:11','测试描述_81',NULL),('287a5443f76b43e0be47788954de2d24','testName_97','******',1,'2017-09-06 15:48:11','测试描述_97',NULL),('287efa644ebf4f819f13f7048df7038a','testName_350','******',1,'2017-09-06 15:48:13','测试描述_350',NULL),('289f5267e03f44a4a79af2e066986e76','testName_545','******',1,'2017-09-06 15:48:14','测试描述_545',NULL),('28e955a6f9ae4212ae2adc9db2797162','testName_334','******',1,'2017-09-06 15:48:13','测试描述_334',NULL),('291feadf445a4e04b7199aa34570b0d2','testName_706','******',1,'2017-09-06 15:48:15','测试描述_706',NULL),('29342254bce84ff385f602ccf9541113','testName_220','******',1,'2017-09-06 15:48:12','测试描述_220',NULL),('29aafaefd47f49c49a24dd6caa524bdd','testName_34','******',1,'2017-09-06 15:48:11','测试描述_34',NULL),('2a10ec7e9cd64d50a5274759bd609384','testName_161','******',1,'2017-09-06 15:48:12','测试描述_161',NULL),('2a3647bbf26f4c14975f0c3ad86c414b','testName_677','******',1,'2017-09-06 15:48:15','测试描述_677',NULL),('2a7aaf1666b14cca86e24cf626593810','testName_886','',1,'2017-09-06 15:48:16','测试描述_886',NULL),('2a8e5c8515b54cea81b6a49ca3f2d5eb','testName_24','******',1,'2017-09-06 15:48:11','测试描述_24',NULL),('2a94349b3574453cafb873a3f3481786','testName_468','******',1,'2017-09-06 15:48:14','测试描述_468',NULL),('2ac583bea0634b9db4adc517babc3f56','testName_41','******',1,'2017-09-06 15:48:11','测试描述_41',NULL),('2ae22a35c54b40919b8c184481e5ef0e','testName_799','',0,'2017-09-06 15:48:16','测试描述_799',NULL),('2b20ccb7212648d38c8cd0284c322c7d','testName_128','******',1,'2017-09-06 15:48:11','测试描述_128',NULL),('2b240f28292143199ae7ab7ba5900f66','testName_522','******',1,'2017-09-06 15:48:14','测试描述_522',NULL),('2b6d3dc1141d456fb90afd712a5b6c90','testName_644','******',1,'2017-09-06 15:48:15','测试描述_644',NULL),('2bac67c19cd84d999dad349ebbb00a02','testName_308','******',1,'2017-09-06 15:48:13','测试描述_308',NULL),('2c72d429e95842a9bf3285c9b8a88095','testName_664','******',1,'2017-09-06 15:48:15','测试描述_664',NULL),('2d0b6daecf324b5594f2b3f6d70c9ba9','testName_759','******',1,'2017-09-06 15:48:15','测试描述_759',NULL),('2d26674258ea4b278f640c98034106ba','testName_515','******',1,'2017-09-06 15:48:14','测试描述_515',NULL),('2e323d1c480e4d5895db1b7f2195013f','testName_32','******',1,'2017-09-06 15:48:11','测试描述_32',NULL),('2ef9252bf7a64331a86ca3ba26d9883f','testName_788','',0,'2017-09-06 15:48:16','测试描述_788催催催xxx',NULL),('2f927ef94363460ca6e48e63c58ed650','testName_557','******',1,'2017-09-06 15:48:14','测试描述_557',NULL),('300d2c07fd4f48b28647ddba9980483a','testName_728','******',1,'2017-09-06 15:48:15','测试描述_728',NULL),('3050f4d3fb2042bda80e5947f7aa005c','testName_189','******',1,'2017-09-06 15:48:12','测试描述_189',NULL),('307053067ae04d149dba11066b637aaf','testName_574','******',1,'2017-09-06 15:48:14','测试描述_574',NULL),('3107fe89a4d14ac28eda20fd02bdb989','testName_345','******',1,'2017-09-06 15:48:13','测试描述_345',NULL),('3122cc79602b4a7db9c0cec84a148339','testName_108','******',1,'2017-09-06 15:48:11','测试描述_108',NULL),('31b041354cba4969bf60f8f7b0bf973b','testName_717','******',1,'2017-09-06 15:48:15','测试描述_717',NULL),('320559e6ac1d429ba52349e8c9fc2cd2','testName_543','******',1,'2017-09-06 15:48:14','测试描述_543',NULL),('32174a4fe053459fbe93caad30f842e7','testName_707','******',1,'2017-09-06 15:48:15','测试描述_707',NULL),('32a43f20daa6446dbf9df8bc6950dbdd','testName_691','******',1,'2017-09-06 15:48:15','测试描述_691',NULL),('32c9a989e8c84d79aeb99e24d607a84b','testName_165','******',1,'2017-09-06 15:48:12','测试描述_165',NULL),('32f836c3653946da979936fb0648ab78','testName_581','******',1,'2017-09-06 15:48:14','测试描述_581',NULL),('331d233bbae549709859340050ae9c85','testName_398','******',1,'2017-09-06 15:48:13','测试描述_398',NULL),('335d3c739546447f89ab684ff8e64606','testName_245','******',1,'2017-09-06 15:48:12','测试描述_245',NULL),('338f1705144c421f828dc78e5d6aa0fe','testName_124','******',1,'2017-09-06 15:48:11','测试描述_124',NULL),('33cccd9059f54e94a463c4905e6f675d','testName_399','******',1,'2017-09-06 15:48:13','测试描述_399',NULL),('343833ee79c24f9d98ad418d122ceb5f','testName_889','',0,'2017-09-06 15:48:16','测试描述_889',NULL),('3467c8e1206f4a1796590d4b2c120304','testName_598','******',1,'2017-09-06 15:48:14','测试描述_598',NULL),('348191e40b224ad090dfeec8ed8751d2','testName_700','******',1,'2017-09-06 15:48:15','测试描述_700',NULL),('34cc8ea56d324eedac3a19d54440167f','testName_684','******',1,'2017-09-06 15:48:15','测试描述_684',NULL),('35091cb255b743528a7dde9770700bf7','testName_164','******',1,'2017-09-06 15:48:12','测试描述_164',NULL),('35c82d67e8924a64b9785e1e395cddd0','testName_118','******',1,'2017-09-06 15:48:11','测试描述_118',NULL),('35cae8d152c24695b3319303ac5f4dbe','testName_231','******',1,'2017-09-06 15:48:12','测试描述_231',NULL),('364f25411c6d43c4a6d12e0284eabcad','testName_588','******',1,'2017-09-06 15:48:14','测试描述_588',NULL),('36516c4ad038411f8cde674360d05023','testName_271','******',1,'2017-09-06 15:48:12','测试描述_271',NULL),('36713be40df34d70bf3e2913efa634f3','testName_19','******',1,'2017-09-06 15:48:11','测试描述_19',NULL),('36b9062b05c348bea6b44cac46db4e54','testName_424','******',1,'2017-09-06 15:48:13','测试描述_424',NULL),('37a47d88273b49d6ac9e750092a1ae32','testName_575','******',1,'2017-09-06 15:48:14','测试描述_575',NULL),('37f98135753649eaac7d836c94931f7c','testName_656','******',1,'2017-09-06 15:48:15','测试描述_656',NULL),('38d9fe1eae6245a08bd771eea10c9809','testName_49','******',1,'2017-09-06 15:48:11','测试描述_49',NULL),('38ed2f9cf8dd411b889028d9cbb08a07','testName_255','******',1,'2017-09-06 15:48:12','测试描述_255',NULL),('393accfea8b046c99db6a0fd55d22529','testName_463','******',1,'2017-09-06 15:48:14','测试描述_463',NULL),('39bf087239f84a5b844b48d6da1fd20e','testName_536','******',1,'2017-09-06 15:48:14','测试描述_536',NULL),('39ddd22511e3473aacafd79a2b1c2613','testName_443','******',1,'2017-09-06 15:48:13','测试描述_443',NULL),('39e917bfb29441b1ac5082aafd1ca500','testName_882','',0,'2017-09-06 15:48:16','测试描述_882',NULL),('3a04a179bf8c437a9e5683a69d18b2ab','testName_93','******',1,'2017-09-06 15:48:11','测试描述_93',NULL),('3a3174480f054ef188cfef0b65730004','testName_55','******',1,'2017-09-06 15:48:11','测试描述_55',NULL),('3a37cea5d1754de684cead90bb45f4e2','testName_194','******',1,'2017-09-06 15:48:12','测试描述_194',NULL),('3a407c2e5e704f689b1515ea15797fbc','testName_98','******',1,'2017-09-06 15:48:11','测试描述_98',NULL),('3af215f81e9f4194a7467ea820358c82','testName_781','',1,'2017-09-06 15:48:16','测试描述_781',NULL),('3bf5e137dca34e11971592847ce6da6b','testName_566','******',1,'2017-09-06 15:48:14','测试描述_566',NULL),('3c0b29ecf54e4f96b81168126ab42969','testName_323','******',1,'2017-09-06 15:48:13','测试描述_323',NULL),('3c1f48f8d6ae4b7288e7174505ae9d95','testName_643','******',1,'2017-09-06 15:48:15','测试描述_643',NULL),('3caab37d85874edca29120a1783439d7','testName_530','******',1,'2017-09-06 15:48:14','测试描述_530',NULL),('3cc5ef021ccb426783b37ffa876ead50','testName_628','******',1,'2017-09-06 15:48:15','测试描述_628',NULL),('3cc62658910744478714f56a03bc1087','testName_576','******',1,'2017-09-06 15:48:14','测试描述_576',NULL),('3ccbcdb2f7874de8bbdbca572356b5bd','testName_595','******',1,'2017-09-06 15:48:14','测试描述_595',NULL),('3cff275afed04860bc6b9f8946319cda','testName_732','******',1,'2017-09-06 15:48:15','测试描述_732',NULL),('3d3858601746467f93311bb45a5fc707','testName_431','******',1,'2017-09-06 15:48:13','测试描述_431',NULL),('3d4fa0155e584764ad0ba50df061f893','testName_232','******',1,'2017-09-06 15:48:12','测试描述_232',NULL),('3d5f51d6010f4865931ead11bc70316c','testName_555','******',1,'2017-09-06 15:48:14','测试描述_555',NULL),('3de20a8d8c0447d8b27bbad2fa238942','testName_570','******',1,'2017-09-06 15:48:14','测试描述_570',NULL),('3e0b4c5d53ca426cbc311a506f2a8b7a','testName_89','******',1,'2017-09-06 15:48:11','测试描述_89',NULL),('3e39c43e82d64720af26935f23da2844','testName_405','******',1,'2017-09-06 15:48:13','测试描述_405',NULL),('3e49efa6e73340d9837d2a76fb552693','testName_236','******',1,'2017-09-06 15:48:12','测试描述_236',NULL),('3ea400c2a5a4485893187ebd0174fdbe','testName_689','******',1,'2017-09-06 15:48:15','测试描述_689',NULL),('3ebefc857ec74600bc5b73a8a500d9d0','testName_364','******',1,'2017-09-06 15:48:13','测试描述_364',NULL),('3ecf2cca8ceb41c2928867e02798a880','testName_693','******',1,'2017-09-06 15:48:15','测试描述_693',NULL),('3f3eb33374a34c6dbc9134969ade71fb','testName_519','******',1,'2017-09-06 15:48:14','测试描述_519',NULL),('3f59289710ef4da8adf273d5604d5f93','testName_59','******',1,'2017-09-06 15:48:11','测试描述_59',NULL),('3fa30d35dcd3437fb9fe659b6304fc82','testName_130','******',1,'2017-09-06 15:48:11','测试描述_130',NULL),('3ff4946be4874448804d3eb535ce680a','testName_351','******',1,'2017-09-06 15:48:13','测试描述_351',NULL),('40a89100174e4314af2ef28bd2b3f65c','testName_216','******',1,'2017-09-06 15:48:12','测试描述_216',NULL),('40c3ec67e9a8451a93459cdeacb08eaa','testName_116','******',1,'2017-09-06 15:48:11','测试描述_116',NULL),('40fc0df5926041b1a9104ee4d1031e1c','testName_745','******',1,'2017-09-06 15:48:15','测试描述_745',NULL),('4106e5c406f84382bf0bac9a95994932','testName_129','******',1,'2017-09-06 15:48:11','测试描述_129',NULL),('412a3c1dd4a448d69415241c933c92a5','testName_166','******',1,'2017-09-06 15:48:12','测试描述_166',NULL),('415b4596dc6946ee8b75e74aa6f617b9','testName_551','******',1,'2017-09-06 15:48:14','测试描述_551',NULL),('4184cdca41fe440ba4da3a240b915232','testName_305','******',1,'2017-09-06 15:48:13','测试描述_305',NULL),('41e7b1d446de4eee8aacc7a8e7750545','testName_4','******',1,'2017-09-06 15:48:11','测试描述_4',NULL),('41ff607f1598463b8e6e4649f6224a4c','testName_92','******',1,'2017-09-06 15:48:11','测试描述_92',NULL),('4200a78bb9f042fca075bba8bf9b6b74','testName_84','******',1,'2017-09-06 15:48:11','测试描述_84',NULL),('42188e380443421ca8e78a43e1d1a68c','testName_492','******',1,'2017-09-06 15:48:14','测试描述_492',NULL),('422e36769adb44c59d4390d204f94043','testName_606','******',1,'2017-09-06 15:48:15','测试描述_606',NULL),('423cf09c6e4741c3a1077fc76b63ce84','testName_659','******',1,'2017-09-06 15:48:15','测试描述_659',NULL),('424cd2e35bb14685a426b06cbfed8eb6','testName_676','******',1,'2017-09-06 15:48:15','测试描述_676',NULL),('42bdc1f7853e424e9f29b1a023fbf686','testName_621','******',1,'2017-09-06 15:48:15','测试描述_621',NULL),('4312deee68194040a56cfa282110baf7','testName_389','******',1,'2017-09-06 15:48:13','测试描述_389',NULL),('4396cab0e897487bb1f6f6190e1c6119','testName_325','******',1,'2017-09-06 15:48:13','测试描述_325',NULL),('43ca68a0750043c98274e9fbb91f2e6a','testName_394','******',1,'2017-09-06 15:48:13','测试描述_394',NULL),('43dc4ea080b44ce7973fedf8246037b1','testName_658','******',1,'2017-09-06 15:48:15','测试描述_658',NULL),('43e0548790604608a8b6971b52a2cceb','testName_544','******',1,'2017-09-06 15:48:14','测试描述_544',NULL),('43f5e7a1515d44a6b0ee9625a06beb70','testName_464','******',1,'2017-09-06 15:48:14','测试描述_464',NULL),('443bc71831204b6589f675ef5f5dd367','testName_331','******',1,'2017-09-06 15:48:13','测试描述_331',NULL),('444950a2e4f345a28a3922617cb13ea2','testName_567','******',1,'2017-09-06 15:48:14','测试描述_567',NULL),('4489f4462af744e58d2e7b7f94d99e54','testName_69','******',1,'2017-09-06 15:48:11','测试描述_69',NULL),('458973d789334f8aa1bd5f7cd28e0505','testName_162','******',1,'2017-09-06 15:48:12','测试描述_162',NULL),('458c7c3298584e38aa110f984c18b7af','testName_477','******',1,'2017-09-06 15:48:14','测试描述_477',NULL),('46d540ed9135410e806323ce7c38b982','testName_741','******',1,'2017-09-06 15:48:15','测试描述_741',NULL),('4748def1e9844beaadfd39694cbd7574','testName_612','******',1,'2017-09-06 15:48:15','测试描述_612',NULL),('476dc226cd934d5bb69e58a2fc8dc330','testName_502','******',1,'2017-09-06 15:48:14','测试描述_502',NULL),('47bf6b1a713d426989fef1089e723af7','testName_25','******',1,'2017-09-06 15:48:11','测试描述_25',NULL),('48e92f2cb02948dca27bff9c1a899775','testName_528','******',1,'2017-09-06 15:48:14','测试描述_528',NULL),('48ec5ba3a9fd4450acd7d2e1b32ed355','testName_435','******',1,'2017-09-06 15:48:13','测试描述_435',NULL),('4938b86baf744173b339323f274d9c8b','testName_170','******',1,'2017-09-06 15:48:12','测试描述_170',NULL),('4960b33d14844eb1a608fa32cd0d375b','testName_193','******',1,'2017-09-06 15:48:12','测试描述_193',NULL),('49a5bad4fee6460f8925c66dfc359883','testName_753','******',1,'2017-09-06 15:48:15','测试描述_753',NULL),('4a2bb6996cfe426884920695a25688c6','testName_533','******',1,'2017-09-06 15:48:14','测试描述_533',NULL),('4ac664a6e84a41918b33e7863e28eab9','testName_357','******',1,'2017-09-06 15:48:13','测试描述_357',NULL),('4ae60dd6a71d480c808edf71de726fbe','testName_604','******',1,'2017-09-06 15:48:14','测试描述_604',NULL),('4b168f23663a43dcb5113faa8d05f698','testName_2','******',1,'2017-09-06 15:48:11','测试描述_2',NULL),('4b365055d2ae4e4888e750e247bd23fc','testName_488','******',1,'2017-09-06 15:48:14','测试描述_488',NULL),('4b753e4c648448da8a3f65ff3023e855','testName_58','******',1,'2017-09-06 15:48:11','测试描述_58',NULL),('4c3c61d1a739478b8759efc951ee84c7','testName_402','******',1,'2017-09-06 15:48:13','测试描述_402',NULL),('4c53ce73241043c18043588a58132fcc','testName_535','******',1,'2017-09-06 15:48:14','测试描述_535',NULL),('4ca1fa2f046644fd980204ab9407202e','testName_412','******',1,'2017-09-06 15:48:13','测试描述_412',NULL),('4caefaa2cb6640f3b9ff7a374dde300a','testName_28','******',1,'2017-09-06 15:48:11','测试描述_28',NULL),('4cb1dcaae60d4b67967877b3dd283e31','testName_516','******',1,'2017-09-06 15:48:14','测试描述_516',NULL),('4d1e5887211d4144b864a61d5d171bb1','testName_421','******',1,'2017-09-06 15:48:13','测试描述_421',NULL),('4d23323894f84ebabf30ba3c7f222f37','testName_258','******',1,'2017-09-06 15:48:12','测试描述_258',NULL),('4d7657280f20468ba24a0afbf14d8caa','testName_766','',1,'2017-09-06 15:48:16','测试描述_766',NULL),('4d86a5826005430ebe2e392707a9362c','testName_721','******',1,'2017-09-06 15:48:15','测试描述_721',NULL),('4d9fb70611864cef853dfe6d90b2c40c','testName_422','******',1,'2017-09-06 15:48:13','测试描述_422',NULL),('4e75a04dcc79402787f4fdaa7f57a6b4','testName_825','',1,'2017-09-06 15:48:16','测试描述_825',NULL),('4fdecda349b948e3860b8c58de83f8ca','testName_517','******',1,'2017-09-06 15:48:14','测试描述_517',NULL),('500c945006354d1ab463016318173cc5','testName_438','******',1,'2017-09-06 15:48:13','测试描述_438',NULL),('5052741acf744f86856d1e7cbf2b8f59','testName_797','',1,'2017-09-06 15:48:16','测试描述_797',NULL),('5070082bcae249cb898ba14cbd02347e','testName_149','******',1,'2017-09-06 15:48:12','测试描述_149',NULL),('507b4e33ba51418f81a5e9f267314a85','testName_734','******',1,'2017-09-06 15:48:15','测试描述_734',NULL),('510ab033c80b41e3850ed7c730f2234b','testName_96','******',1,'2017-09-06 15:48:11','测试描述_96',NULL),('52027905058a47a2a929a285cc8972e0','testName_226','******',1,'2017-09-06 15:48:12','测试描述_226',NULL),('522763cba3bb464ba65d536104acfe56','testName_630','******',1,'2017-09-06 15:48:15','测试描述_630',NULL),('522f602901ab416d85ffcf30c276e644','testName_135','******',1,'2017-09-06 15:48:11','测试描述_135',NULL),('524c144b5ee140078fd146988a791bfd','testName_243','******',1,'2017-09-06 15:48:12','测试描述_243',NULL),('52cbd3dbdd9c4b71b02a5f0aa0a6489f','testName_775','',1,'2017-09-06 15:48:16','测试描述_775',NULL),('5325356a3fbf48498a1d93281f84c06e','testName_434','******',1,'2017-09-06 15:48:13','测试描述_434',NULL),('533c700299f94bd9b7cc232f54f928f4','testName_100','******',1,'2017-09-06 15:48:11','测试描述_100',NULL),('53449bae3185414e8307717baa089bb4','testName_133','******',1,'2017-09-06 15:48:11','测试描述_133',NULL),('53675e78d004487b8dbc5d886a122f77','testName_747','******',1,'2017-09-06 15:48:15','测试描述_747',NULL),('5393417ee23a4745bcffc62a9db1b8da','testName_10','******',1,'2017-09-06 15:48:11','测试描述_10',NULL),('54332bbf041a43da8d868a5b385a978c','testName_491','******',1,'2017-09-06 15:48:14','测试描述_491',NULL),('543e4fb078424ab7a66a2f75b044f374','testName_864','',1,'2017-09-06 15:48:16','测试描述_864',NULL),('5440ba9df7484486848fbc53707e8050','testName_887','',1,'2017-09-06 15:48:16','测试描述_887',NULL),('54698bc9d3e3404896fdc6d5c1bf92f5','testName_526','******',1,'2017-09-06 15:48:14','测试描述_526',NULL),('54747ad85772458fbfa31da5d2a4baab','testName_178','******',1,'2017-09-06 15:48:12','测试描述_178',NULL),('547560214a584fa0abad1c7a41c006b3','testName_21','******',1,'2017-09-06 15:48:11','测试描述_21',NULL),('548e76ba54604bd49594d7f2a413855f','testName_629','******',1,'2017-09-06 15:48:15','测试描述_629',NULL),('549b10d2b96a4b9a89902afd5bc60620','testName_313','******',1,'2017-09-06 15:48:13','测试描述_313',NULL),('54a2e2d0c0ac4a94b9be2178aa912ca6','testName_609','******',1,'2017-09-06 15:48:15','测试描述_609',NULL),('54c3ba94513e4a6eb9acd8e00cc2c4a4','testName_498','******',1,'2017-09-06 15:48:14','测试描述_498',NULL),('54cd621f181c443fb05e21802feed1dc','testName_375','******',1,'2017-09-06 15:48:13','测试描述_375',NULL),('5537a13bbd44427a8fa3d5c52e7dd8aa','testName_210','******',1,'2017-09-06 15:48:12','测试描述_210',NULL),('55f399b3d4a74c6d8793b1006f885787','testName_241','******',1,'2017-09-06 15:48:12','测试描述_241',NULL),('563305e22b31413cb705315ab0a7c3ac','testName_757','******',1,'2017-09-06 15:48:15','测试描述_757',NULL),('5664c42518b8490c8ffdd91ac321c7e6','testName_312','******',1,'2017-09-06 15:48:13','测试描述_312',NULL),('5675a573f50a4dc39dcdb004593fa9e8','testName_466','******',1,'2017-09-06 15:48:14','测试描述_466',NULL),('56dfebc8313f45feba4774ad05b0bc19','testName_703','******',1,'2017-09-06 15:48:15','测试描述_703',NULL),('574b63cb6061438bae18ba6d3e61cc4b','testName_730','******',1,'2017-09-06 15:48:15','测试描述_730',NULL),('5787e88dc7e54882947b27b46d4e0749','testName_239','******',1,'2017-09-06 15:48:12','测试描述_239',NULL),('57d24a4d7a094f029bc2b94dde8477c0','testName_180','******',1,'2017-09-06 15:48:12','测试描述_180',NULL),('57f1c66723f84419b2d9a78731622262','testName_474','******',1,'2017-09-06 15:48:14','测试描述_474',NULL),('58195198f1204207bb8682e56e7c62c2','testName_459','******',1,'2017-09-06 15:48:14','测试描述_459',NULL),('5874321bbe6c45a994600c6cbef9a333','testName_866','******',1,'2017-09-06 15:48:16','测试描述_866',NULL),('588ed58303444191b6c8a3c30e7ab337','testName_46','******',1,'2017-09-06 15:48:11','测试描述_46',NULL),('58dc75196f734ebfb5ffea9e03356924','testName_221','******',1,'2017-09-06 15:48:12','测试描述_221',NULL),('58ed65ad29fd4694b82d75196b884c8c','testName_18','******',1,'2017-09-06 15:48:11','测试描述_18',NULL),('5982e2c0e8904acc96440d02af6388f4','testName_282','******',1,'2017-09-06 15:48:12','测试描述_282',NULL),('59ad6acfd5784ecea44c00ff98043e7b','testName_638','******',1,'2017-09-06 15:48:15','测试描述_638',NULL),('59b826ae50c041de8767ce43bd19b6b7','testName_666','******',1,'2017-09-06 15:48:15','测试描述_666',NULL),('59d5e95c6d314acb83e6c8c40396d5c0','testName_77','******',1,'2017-09-06 15:48:11','测试描述_77',NULL),('5a0c08c9242b4d1fa89738d7bccfd95c','testName_894','******',1,'2017-09-06 15:48:16','测试描述_894',NULL),('5a233f811a9444a984320214c0ccbcf4','testName_611','******',1,'2017-09-06 15:48:15','测试描述_611',NULL),('5a44a74d4c3641fdb6273f417545c77c','testName_218','******',1,'2017-09-06 15:48:12','测试描述_218',NULL),('5a64528a76b74f2ab323c85a710cabe5','testName_829','******',1,'2017-09-06 15:48:16','测试描述_829',NULL),('5a859ad448594c1d910b9ff70f4854ca','testName_580','******',1,'2017-09-06 15:48:14','测试描述_580',NULL),('5b63278a08c34cf69c35bb060d2840dc','testName_572','******',1,'2017-09-06 15:48:14','测试描述_572',NULL),('5bc7b56ad4654bb5be016bda0d41c16a','testName_479','******',1,'2017-09-06 15:48:14','测试描述_479',NULL),('5cbb801644c740969c9b63b936b17010','testName_767','******',1,'2017-09-06 15:48:16','测试描述_767',NULL),('5d2fcec8c9f14b4dbfc249df64de1359','testName_244','******',1,'2017-09-06 15:48:12','测试描述_244',NULL),('5d712013b84046268bc89ede442d3a63','testName_432','******',1,'2017-09-06 15:48:13','测试描述_432',NULL),('5d94983645f7438d84f0523217b5f371','testName_36','******',1,'2017-09-06 15:48:11','测试描述_36',NULL),('5da423f3758e465cb288c22577017231','testName_275','******',1,'2017-09-06 15:48:12','测试描述_275',NULL),('5dc2bd0b8fee4867bc2974adcd355e67','testName_16','******',1,'2017-09-06 15:48:11','测试描述_16',NULL),('5e32fdd96b4942d2b0fe630a9e0dba61','testName_199','******',1,'2017-09-06 15:48:12','测试描述_199',NULL),('5e7b033143c144a3adc92e3a993ce5bb','testName_66','******',1,'2017-09-06 15:48:11','测试描述_66',NULL),('5f02807294944e348b73da8388b6c485','testName_804','******',1,'2017-09-06 15:48:16','测试描述_804',NULL),('5f24b07d736d4404b6d87daa5de29b5e','testName_718','******',1,'2017-09-06 15:48:15','测试描述_718',NULL),('5f58ca01e6594f3bbde8075466b5a6d1','testName_636','******',1,'2017-09-06 15:48:15','测试描述_636',NULL),('5f5ff80ac0b9476a860f07070427269d','testName_85','******',1,'2017-09-06 15:48:11','测试描述_85',NULL),('5f6dbd78c04d4288b89c855569ae4ec4','testName_802','******',1,'2017-09-06 15:48:16','测试描述_802',NULL),('600c7d141f5d4e33b63c44e94eb9c8ce','testName_111','******',1,'2017-09-06 15:48:11','测试描述_111',NULL),('60c10b57d03040f685eab62804208ccf','testName_830','',1,'2017-09-06 15:48:16','测试描述_830',NULL),('60c1672a6b174fe094a46fc8750ef9be','testName_857','******',1,'2017-09-06 15:48:16','测试描述_857',NULL),('60f5558cef784f0c993d5529368d30fd','testName_185','******',1,'2017-09-06 15:48:12','测试描述_185',NULL),('60fe3a9edf264cd88acd908200a53aff','testName_831','******',1,'2017-09-06 15:48:16','测试描述_831',NULL),('610f2fbcbc354435b2c64ff13131bf6a','testName_613','******',1,'2017-09-06 15:48:15','测试描述_613',NULL),('616d25e24b994a0a969a38f1c439dc59','testName_509','******',1,'2017-09-06 15:48:14','测试描述_509',NULL),('6218b13081ce464a9394d6829c33b93e','testName_423','******',1,'2017-09-06 15:48:13','测试描述_423',NULL),('62cab8dfb96e4a199c0fc67a60c559a6','testName_274','******',1,'2017-09-06 15:48:12','测试描述_274',NULL),('62fad9c6ac17413482ddeefbcdc9bd5f','testName_554','******',1,'2017-09-06 15:48:14','测试描述_554',NULL),('6321179fbd874c2c85bb2a89057a52b1','testName_626','******',1,'2017-09-06 15:48:15','测试描述_626',NULL),('6369c5fb00b048558742d2e8b0504c2e','testName_556','******',1,'2017-09-06 15:48:14','测试描述_556',NULL),('638c0b66eaa24e1d802e0bfad6b4d4c1','testName_725','******',1,'2017-09-06 15:48:15','测试描述_725',NULL),('639cb90d1ad64b1bb3854b5f7e475a94','testName_565','******',1,'2017-09-06 15:48:14','测试描述_565',NULL),('643e78d790314270a89a3d402296e837','testName_832','******',1,'2017-09-06 15:48:16','测试描述_832',NULL),('64c66bf6588e411aabbade1d7f02d0ea','testName_426','******',1,'2017-09-06 15:48:13','测试描述_426',NULL),('64d360bda40d43c194201562a85ee925','testName_590','******',1,'2017-09-06 15:48:14','测试描述_590',NULL),('65362d80e572466ebdfc90602aef01df','testName_442','******',1,'2017-09-06 15:48:13','测试描述_442',NULL),('654315ffe7c741f99dd6e6408c1fd613','testName_458','******',1,'2017-09-06 15:48:14','测试描述_458',NULL),('654bf40dbda1494f8401dadd40ad9888','testName_338','******',1,'2017-09-06 15:48:13','测试描述_338',NULL),('6555c1ed763f493fad7f7f1379e06b12','testName_202','******',1,'2017-09-06 15:48:12','测试描述_202',NULL),('65b05c659352498b85f65fec9a8a68a3','testName_337','******',1,'2017-09-06 15:48:13','测试描述_337',NULL),('65d576d549974ec28784b522fce90fbc','testName_126','******',1,'2017-09-06 15:48:11','测试描述_126',NULL),('66130a551dc94108acc0a7faba324526','testName_450','******',1,'2017-09-06 15:48:14','测试描述_450',NULL),('6629664cebdb44e8938e0ffa0a952c1b','testName_276','******',1,'2017-09-06 15:48:12','测试描述_276',NULL),('662aa47ef2014bc68c7f259e7514c3e3','testName_856','******',1,'2017-09-06 15:48:16','测试描述_856',NULL),('666759e71338498096f38f4d40a52450','testName_311','******',1,'2017-09-06 15:48:13','测试描述_311',NULL),('669353f7b6a044469c7419a25653076f','testName_143','******',1,'2017-09-06 15:48:11','测试描述_143',NULL),('672c2dbf40c84238992342e0446876b7','testName_191','******',1,'2017-09-06 15:48:12','测试描述_191',NULL),('6742a82e4dd64d4c90cbceb68042b894','testName_505','******',1,'2017-09-06 15:48:14','测试描述_505',NULL),('674b6ac7d18645789e798f2279ad589a','testName_72','******',1,'2017-09-06 15:48:11','测试描述_72',NULL),('676646d377b04395aacac7a259ba2aaf','testName_762','******',1,'2017-09-06 15:48:15','测试描述_762',NULL),('677e38eac13642cc9ec957d98dddcc89','testName_500','******',1,'2017-09-06 15:48:14','测试描述_500',NULL),('678e518e38d14880be0dd3c8360d919a','testName_569','******',1,'2017-09-06 15:48:14','测试描述_569',NULL),('684b51fb78ea4043831b99ae36aaf631','testName_553','******',1,'2017-09-06 15:48:14','测试描述_553',NULL),('6867f537e69144229e17cd5ee14f2fd4','testName_534','******',1,'2017-09-06 15:48:14','测试描述_534',NULL),('688ba3189af941c785dd9e39238ab455','testName_685','******',1,'2017-09-06 15:48:15','测试描述_685',NULL),('6891f2e1cdc54dec9e94710f9e291987','testName_531','******',1,'2017-09-06 15:48:14','测试描述_531',NULL),('69768e4e4eff49f6ac15971ddc4ed193','testName_487','******',1,'2017-09-06 15:48:14','测试描述_487',NULL),('69b9865ea5824c0a8f40147e3f7eb78e','testName_475','******',1,'2017-09-06 15:48:14','测试描述_475',NULL),('69e680654396434d95bc683790b84182','testName_826','******',1,'2017-09-06 15:48:16','测试描述_826',NULL),('6a1f4843d0654780adf60328306bf513','testName_765','******',1,'2017-09-06 15:48:16','测试描述_765',NULL),('6bae8a228d504137b30001227d8026b8','testName_283','******',1,'2017-09-06 15:48:12','测试描述_283',NULL),('6bb76b509cde4d64992ca29e269ec59f','testName_884','******',1,'2017-09-06 15:48:16','测试描述_884',NULL),('6bd4e3f3262043ab873638ed3587413e','testName_673','******',1,'2017-09-06 15:48:15','测试描述_673',NULL),('6c385637b2a34dcf8cb950d36779882a','testName_709','******',1,'2017-09-06 15:48:15','测试描述_709',NULL),('6c6c97c3f447412fa3cfe6af7a7d966a','testName_361','******',1,'2017-09-06 15:48:13','测试描述_361',NULL),('6c8834003fd14354bfbe8d1b08d17fa2','testName_310','******',1,'2017-09-06 15:48:13','测试描述_310',NULL),('6c93f6f57de8484fa9ac96c7346d73e4','testName_105','******',1,'2017-09-06 15:48:11','测试描述_105',NULL),('6cce6df5dc59457b81ee96feb53244bc','testName_65','******',1,'2017-09-06 15:48:11','测试描述_65',NULL),('6d2f832da6824238b56a1d7a0fca48f1','testName_662','******',1,'2017-09-06 15:48:15','测试描述_662',NULL),('6d99aec879d048979a39466cc5159297','testName_379','******',1,'2017-09-06 15:48:13','测试描述_379',NULL),('6dd95aa872b34530b0a4fde0f12cd7e6','testName_253','******',1,'2017-09-06 15:48:12','测试描述_253',NULL),('6deb76eacc9342ba8f1fe3ed4dbb22fd','testName_429','******',1,'2017-09-06 15:48:13','测试描述_429',NULL),('6e0e2c3cdfc142e195dee2fcfa763a97','testName_186','******',1,'2017-09-06 15:48:12','测试描述_186',NULL),('6e30cc4c04764dfeade4da92ae8ecdc0','testName_26','******',1,'2017-09-06 15:48:11','测试描述_26',NULL),('6e77dd22c2724e8dbb0d4ad8619d5051','testName_663','******',1,'2017-09-06 15:48:15','测试描述_663',NULL),('6e79d3beb55e4ae7ab2c682dedff32df','testName_420','******',1,'2017-09-06 15:48:13','测试描述_420',NULL),('6eb0eeeaaa7948af8299322efd769b79','testName_585','******',1,'2017-09-06 15:48:14','测试描述_585',NULL),('6efc713c36d6425bb4088ee91ae8836f','testName_270','******',1,'2017-09-06 15:48:12','测试描述_270',NULL),('6f4aa6f81ccb46b891847c577753889d','testName_586','******',1,'2017-09-06 15:48:14','测试描述_586',NULL),('6f55f7da158d4afeb68759d9a6cec9cc','testName_867','******',1,'2017-09-06 15:48:16','测试描述_867',NULL),('6f79b1603a9949b896fd8a7b1447f1f2','testName_620','******',1,'2017-09-06 15:48:15','测试描述_620',NULL),('6f888209fa1641b19ef3c826e3dd1849','testName_865','',1,'2017-09-06 15:48:16','测试描述_865',NULL),('700a3861d2404835ae47b144307128da','testName_539','******',1,'2017-09-06 15:48:14','测试描述_539',NULL),('707692e9a17242b3965786530ece8e9d','testName_251','******',1,'2017-09-06 15:48:12','测试描述_251',NULL),('70a96a4420dc4831923b77d6d3d6ba74','testName_260','******',1,'2017-09-06 15:48:12','测试描述_260',NULL),('7174fad9c7a94b2e9310291972f9f278','testName_35','******',1,'2017-09-06 15:48:11','测试描述_35',NULL),('71de9d898e664fb6b20aa80796d01740','testName_854','******',1,'2017-09-06 15:48:16','测试描述_854',NULL),('7232a2869c5140afb846af4a14ec5d03','testName_376','******',1,'2017-09-06 15:48:13','测试描述_376',NULL),('723fb9da740540da984e2a24cd0dc0a4','testName_779','******',1,'2017-09-06 15:48:16','测试描述_779',NULL),('7246a45e2a3443739e17a0647aed20e1','testName_705','******',1,'2017-09-06 15:48:15','测试描述_705',NULL),('72ab7794c5ed44ca945efafa07d058af','testName_668','******',1,'2017-09-06 15:48:15','测试描述_668',NULL),('72b982dea4c44b9999d84344c3d3043b','testName_674','******',1,'2017-09-06 15:48:15','测试描述_674',NULL),('72d15cc2af08461ba841417739714dd6','testName_362','******',1,'2017-09-06 15:48:13','测试描述_362',NULL),('72e9c708fea0428799d3885883553647','testName_755','******',1,'2017-09-06 15:48:15','测试描述_755',NULL),('733887d6115a49dc92bb17698cd4a58b','testName_680','******',1,'2017-09-06 15:48:15','测试描述_680',NULL),('735e22908e014e14ad9bb354021940f5','testName_510','******',1,'2017-09-06 15:48:14','测试描述_510',NULL),('736d6b1964714225a55009996b585b0d','testName_642','******',1,'2017-09-06 15:48:15','测试描述_642',NULL),('73898b41c7b64988a02585757aa60472','testName_877','******',1,'2017-09-06 15:48:16','测试描述_877',NULL),('73967af0fb224a1aa56b6e9345e6a376','testName_645','******',1,'2017-09-06 15:48:15','测试描述_645',NULL),('73f21df7d8a74c2bade1c0323bcf1d6d','testName_521','******',1,'2017-09-06 15:48:14','测试描述_521',NULL),('73fa9428b60e41ceaffe2256a1fe3ec5','testName_263','******',1,'2017-09-06 15:48:12','测试描述_263',NULL),('747866bc8e274ff3909a0466ba0c0ef2','testName_842','******',1,'2017-09-06 15:48:16','测试描述_842',NULL),('748d186437ec4f3cac91a00cda517ca2','testName_792','******',1,'2017-09-06 15:48:16','测试描述_792',NULL),('74f71115ef4d4840805f4349f1aef89d','testName_796','******',1,'2017-09-06 15:48:16','测试描述_796',NULL),('753ac60ed72646be9ca333ad33edc66e','testName_413','******',1,'2017-09-06 15:48:13','测试描述_413',NULL),('75d7cc4e956f4ece9de99451288715c4','testName_102','******',1,'2017-09-06 15:48:11','测试描述_102',NULL),('76bebee70acd44a1bfd11987b4477d43','testName_127','******',1,'2017-09-06 15:48:11','测试描述_127',NULL),('77a7892bb1bb4c709584bef42eca4e1b','testName_31','******',1,'2017-09-06 15:48:11','测试描述_31',NULL),('78dba340c5624c378b59f22c7f660d31','testName_701','******',1,'2017-09-06 15:48:15','测试描述_701',NULL),('78df900051334e73aaa3920f74454747','testName_631','******',1,'2017-09-06 15:48:15','测试描述_631',NULL),('78f4d82497c84b7eab1da3f6155e303b','testName_695','******',1,'2017-09-06 15:48:15','测试描述_695',NULL),('78f4dca6ca33475fb9ed8bca6e4dbaf2','testName_198','******',1,'2017-09-06 15:48:12','测试描述_198',NULL),('78f87ad671cb4455ad4d5e52217ac282','testName_50','******',1,'2017-09-06 15:48:11','测试描述_50',NULL),('796843a83d52407aa39e2970a21112e5','testName_317','******',1,'2017-09-06 15:48:13','测试描述_317',NULL),('7a0937cd839d403c85c9991dd810838c','testName_440','******',1,'2017-09-06 15:48:13','测试描述_440',NULL),('7a21c3ba2c434838858a3a247eb424b1','testName_297','******',1,'2017-09-06 15:48:13','测试描述_297',NULL),('7af7d20dce2c4e17a3c43ebe7b5232c6','testName_852','******',1,'2017-09-06 15:48:16','测试描述_852',NULL),('7b1528e68f0a428da74c0ec713babee6','testName_183','******',1,'2017-09-06 15:48:12','测试描述_183',NULL),('7b304aa22d9f49a990a0f961b48af235','testName_321','******',1,'2017-09-06 15:48:13','测试描述_321',NULL),('7b48181fba04489f9d41dee8faf79b92','testName_293','******',1,'2017-09-06 15:48:12','测试描述_293',NULL),('7bb536e9e8a0448088d76d75137b22a8','testName_760','******',1,'2017-09-06 15:48:15','测试描述_760',NULL),('7c8342cd670547289d7073da8ec47ce6','testName_573','******',1,'2017-09-06 15:48:14','测试描述_573',NULL),('7cda8f22dc5c42439ddd64c6036df1cd','testName_550','******',1,'2017-09-06 15:48:14','测试描述_550',NULL),('7cf4d3508e7441d38093541aaa3e8320','testName_425','******',1,'2017-09-06 15:48:13','测试描述_425',NULL),('7d1dda539729425f9eb7e406b902bb52','testName_523','******',1,'2017-09-06 15:48:14','测试描述_523',NULL),('7d467fd4029a4daebc851ff293c30f91','testName_454','******',1,'2017-09-06 15:48:14','测试描述_454',NULL),('7d4777ae503c47ac8501cdcd64d0aa12','testName_45','******',1,'2017-09-06 15:48:11','测试描述_45',NULL),('7e225c54220a4d798f084f4bd332b5b5','testName_752','******',1,'2017-09-06 15:48:15','测试描述_752',NULL),('7e5899e5dd30410ba653596b65905e73','testName_503','******',1,'2017-09-06 15:48:14','测试描述_503',NULL),('7e8ac8f8cc574a7e8a4009a42fafc6a6','testName_881','******',1,'2017-09-06 15:48:16','测试描述_881',NULL),('7f5671addaf14c298608b4dd5ab2f467','testName_518','******',1,'2017-09-06 15:48:14','测试描述_518',NULL),('7f7af862627a43a0b52ea8f0ba168eba','testName_157','******',1,'2017-09-06 15:48:12','测试描述_157',NULL),('7fab71a49c8f4dc596cb94434d2fd6c9','testName_624','******',1,'2017-09-06 15:48:15','测试描述_624',NULL),('7fc603cf9f614057870378218a77d3d0','testName_433','******',1,'2017-09-06 15:48:13','测试描述_433',NULL),('800793aa5690433a893e9ec343efde90','testName_834','******',1,'2017-09-06 15:48:16','测试描述_834',NULL),('804e8c3051a14d4eb7d272575fd197c5','testName_637','******',1,'2017-09-06 15:48:15','测试描述_637',NULL),('8089f874f39841c0bdc4331bf4bf358f','testName_559','******',1,'2017-09-06 15:48:14','测试描述_559',NULL),('80986b0b3eb9401e90f64ebf433ae40f','testName_7','******',1,'2017-09-06 15:48:11','测试描述_7',NULL),('80cc6e68c40a47cabf40a9d97244b1bf','testName_182','******',1,'2017-09-06 15:48:12','测试描述_182',NULL),('810ed1f1a6ea4211ba5168868b170252','testName_795','******',1,'2017-09-06 15:48:16','测试描述_795',NULL),('8183eb5ffaae41989592baa0075ae542','testName_266','******',1,'2017-09-06 15:48:12','测试描述_266',NULL),('81aaf849b6a3422f8d8f58daf0923696','testName_250','******',1,'2017-09-06 15:48:12','测试描述_250',NULL),('81bdeb46b27a4ad388f55220ee10a83e','testName_303','******',1,'2017-09-06 15:48:13','测试描述_303',NULL),('81c30fdef74c415086cae5ce5da37cb3','testName_304','******',1,'2017-09-06 15:48:13','测试描述_304',NULL),('8210cacee8bb4aecb772508010db1413','testName_737','******',1,'2017-09-06 15:48:15','测试描述_737',NULL),('82476893a86e4e75a7374beb0cab78df','testName_213','******',1,'2017-09-06 15:48:12','测试描述_213',NULL),('82b734bf35b94f2c97eea288df03865c','testName_482','******',1,'2017-09-06 15:48:14','测试描述_482',NULL),('82c970d6451c423ab73ae19f4f0de736','testName_0','******',1,'2017-09-06 15:48:10','测试描述_0',NULL),('8317c7ea8e864eee8df070d2318d6df5','testName_489','******',1,'2017-09-06 15:48:14','测试描述_489',NULL),('834f97a1f2d444118d5b102973fd77d5','testName_212','******',1,'2017-09-06 15:48:12','测试描述_212',NULL),('8389a20706344932a70b0521d542e695','testName_756','******',1,'2017-09-06 15:48:15','测试描述_756',NULL),('83d203d9b08d47dd96800710fb70e115','testName_44','******',1,'2017-09-06 15:48:11','测试描述_44',NULL),('83e3c327476d4f6ca702aa7bbd8e7a3b','testName_57','******',1,'2017-09-06 15:48:11','测试描述_57',NULL),('8472860604d64ead971527a6ca7efcca','testName_300','******',1,'2017-09-06 15:48:13','测试描述_300',NULL),('84874c11e93849c0acfa1a84767c57ec','testName_83','******',1,'2017-09-06 15:48:11','测试描述_83',NULL),('84fd37558f4c46808c03e78015827c01','testName_641','******',1,'2017-09-06 15:48:15','测试描述_641',NULL),('8524ec360b6e4ccca5e79ea95e2fb031','testName_401','******',1,'2017-09-06 15:48:13','测试描述_401',NULL),('85d41641fa6144339a73cb47a0d05b5d','testName_155','******',1,'2017-09-06 15:48:12','测试描述_155',NULL),('85dbaef579de4a62be0febc204406308','testName_196','******',1,'2017-09-06 15:48:12','测试描述_196',NULL),('860155e1002e4590bd99dcc6af47d970','testName_622','******',1,'2017-09-06 15:48:15','测试描述_622',NULL),('8641a637e3bc4c6492e984863e9f7741','testName_385','******',1,'2017-09-06 15:48:13','测试描述_385',NULL),('865601f5d0ed417c8936211985d6624d','testName_369','******',1,'2017-09-06 15:48:13','测试描述_369',NULL),('868b81bdb38c4c8a90cafe4364a045d3','testName_179','******',1,'2017-09-06 15:48:12','测试描述_179',NULL),('8691f6bb757246f8b0a823148cc56a20','testName_885','******',1,'2017-09-06 15:48:16','测试描述_885',NULL),('86b84b5eea6b4083b9195b78955d1609','testName_814','******',1,'2017-09-06 15:48:16','测试描述_814',NULL),('86d3b1a228614c4a842dc9278b32d8f2','testName_340','******',1,'2017-09-06 15:48:13','测试描述_340',NULL),('870b55869ab147ebac37aad61e68a36b','testName_635','******',1,'2017-09-06 15:48:15','测试描述_635',NULL),('87af0881458c42759014ffdd7032df7a','testName_288','******',1,'2017-09-06 15:48:12','测试描述_288',NULL),('881fdf2db23b4256aec2428821fb5421','testName_6','******',1,'2017-09-06 15:48:11','测试描述_6',NULL),('88f4dad8c5d14d98ac7ffb5f0c86d292','testName_110','******',1,'2017-09-06 15:48:11','测试描述_110',NULL),('88f9e46d00bd41d4b8b7279e12ad04e1','testName_87','******',1,'2017-09-06 15:48:11','测试描述_87',NULL),('8937f2145a0548578c58f66b2f4b65a7','testName_820','******',1,'2017-09-06 15:48:16','测试描述_820',NULL),('895ac8b362044b5ba5d5fa998e173ba6','testName_439','******',1,'2017-09-06 15:48:13','测试描述_439',NULL),('899298733c2048379f4f19bf410b3384','testName_147','******',1,'2017-09-06 15:48:12','测试描述_147',NULL),('89dd3cbebb8541168b5193ffd69fabe0','testName_259','******',1,'2017-09-06 15:48:12','测试描述_259',NULL),('89e18adfdde744c1adbdf340749096e9','testName_704','******',1,'2017-09-06 15:48:15','测试描述_704',NULL),('89ec4d35ec754f7899d86bd2aaa4dc9a','testName_672','******',1,'2017-09-06 15:48:15','测试描述_672',NULL),('89f981df6de2402ea9d163045433d94b','testName_273','******',1,'2017-09-06 15:48:12','测试描述_273',NULL),('8a230fe1363a4aaf8ebe14771146b143','testName_91','******',1,'2017-09-06 15:48:11','测试描述_91',NULL),('8acc0d850f394959b93c0f7d11f7503a','testName_156','******',1,'2017-09-06 15:48:12','测试描述_156',NULL),('8b16ae598f0c4613bd0b4fd42abe47b0','testName_372','******',1,'2017-09-06 15:48:13','测试描述_372',NULL),('8b464285d8de41259e654f9cf40926fc','testName_746','******',1,'2017-09-06 15:48:15','测试描述_746',NULL),('8b8fa2d68a674b0b9509985b8810aa82','testName_836','******',1,'2017-09-06 15:48:16','测试描述_836',NULL),('8c179b12cfa942eeb8a294ece5c58b82','testName_846','******',1,'2017-09-06 15:48:16','测试描述_846',NULL),('8cb2baf5f8274f7490c18d6ac0edff0c','testName_119','******',1,'2017-09-06 15:48:11','测试描述_119',NULL),('8d888189ef9b415eaea0ebe4fd262b2e','testName_869','******',1,'2017-09-06 15:48:16','测试描述_869',NULL),('8dd94b36a4c147a6ab4392ccac231a55','testName_386','******',1,'2017-09-06 15:48:13','测试描述_386',NULL),('8de6f997810b4cfca5cc6b60b1cfd061','testName_326','******',1,'2017-09-06 15:48:13','测试描述_326',NULL),('8e20ff047128400d9c77ee494ad66f7b','testName_368','******',1,'2017-09-06 15:48:13','测试描述_368',NULL),('8ec05682e6694741a0c2cfde26e6bb75','testName_277','******',1,'2017-09-06 15:48:12','测试描述_277',NULL),('8eeb74215d104efba17f22dd22f6194b','testName_508','******',1,'2017-09-06 15:48:14','测试描述_508',NULL),('8f293d95534049efa4f0219afe976244','testName_181','******',1,'2017-09-06 15:48:12','测试描述_181',NULL),('8f81c87dec264b95981404795462be2e','testName_137','******',1,'2017-09-06 15:48:11','测试描述_137',NULL),('902ce373db2b4456acb20706085c2a83','testName_774','******',1,'2017-09-06 15:48:16','测试描述_774',NULL),('90f217f88bc94684a92e89e867b5d3c1','testName_222','******',1,'2017-09-06 15:48:12','测试描述_222',NULL),('9167f6b96516401ba600d0f93b340026','testName_390','******',1,'2017-09-06 15:48:13','测试描述_390',NULL),('9184b45a87ff43cd86b99251b030dcf9','testName_592','******',1,'2017-09-06 15:48:14','测试描述_592',NULL),('919bdea3994647a2910408b380252da7','testName_341','******',1,'2017-09-06 15:48:13','测试描述_341',NULL),('92064652bc54475ebb8b60daeeba15ad','testName_562','******',1,'2017-09-06 15:48:14','测试描述_562',NULL),('9214b85bdf734d5fad0457c64985b46f','testName_106','******',1,'2017-09-06 15:48:11','测试描述_106',NULL),('9243e086e13f4153a1e73527a21ca9d3','testName_876','******',1,'2017-09-06 15:48:16','测试描述_876',NULL),('92fe007dcc95411ba9a736741a904eab','testName_720','******',1,'2017-09-06 15:48:15','测试描述_720',NULL),('93071de2accd4994a9e45a990f669f71','testName_548','******',1,'2017-09-06 15:48:14','测试描述_548',NULL),('9328f6c3708543de837e022fbc0db466','testName_267','******',1,'2017-09-06 15:48:12','测试描述_267',NULL),('9338516d1f60455daab41fb1b8eec25e','testName_777','******',1,'2017-09-06 15:48:16','测试描述_777',NULL),('93b13bb0a88246aea3169b59053465ed','testName_176','******',1,'2017-09-06 15:48:12','测试描述_176',NULL),('9468eb2469694f709b5bf4787ba76ed2','testName_783','******',1,'2017-09-06 15:48:16','测试描述_783',NULL),('9499da073d0648b19be22f8e9e145e21','testName_583','******',1,'2017-09-06 15:48:14','测试描述_583',NULL),('9562e20e62b145738b802cdca33616ff','testName_101','******',1,'2017-09-06 15:48:11','测试描述_101',NULL),('95c3d6a2d6674e8ca6b961d290e6db7f','testName_824','******',1,'2017-09-06 15:48:16','测试描述_824',NULL),('961cf0b2f5e446128b3e3e9cf49ae900','testName_501','******',1,'2017-09-06 15:48:14','测试描述_501',NULL),('966c633b306d4c959d92b85fedb092e1','testName_698','******',1,'2017-09-06 15:48:15','测试描述_698',NULL),('96ad5da3ed0f40b1963ac2a36dd4230f','testName_22','******',1,'2017-09-06 15:48:11','测试描述_22',NULL),('96cc8b0b48ab4412b87ecfddfeaefd1c','testName_485','******',1,'2017-09-06 15:48:14','测试描述_485',NULL),('9741e2f1b99c4eadb751320cf9e9a0ea','testName_363','******',1,'2017-09-06 15:48:13','测试描述_363',NULL),('977ce78de30c45149821dc5059e83541','testName_650','******',1,'2017-09-06 15:48:15','测试描述_650',NULL),('977e472953a2421fb9dcca571c59e640','testName_669','******',1,'2017-09-06 15:48:15','测试描述_669',NULL),('978c9211b6554aa6884042aa31344159','testName_12','******',1,'2017-09-06 15:48:11','测试描述_12',NULL),('97b33886f8f34622ad314b964f85aafa','testName_235','******',1,'2017-09-06 15:48:12','测试描述_235',NULL),('98245a46a47b45b2a9d807f55be6caa1','testName_768','******',1,'2017-09-06 15:48:16','测试描述_768',NULL),('985d54789e954b7fbcde68c1a16dcf20','testName_770','******',1,'2017-09-06 15:48:16','测试描述_770',NULL),('9877eba9de9148d690034716076f06b4','testName_461','******',1,'2017-09-06 15:48:14','测试描述_461',NULL),('988afd05a79b4e14889f3b43e1f6de1b','testName_467','******',1,'2017-09-06 15:48:14','测试描述_467',NULL),('989e9d6abcd44e48a99ca4828b76f5cc','testName_616','******',1,'2017-09-06 15:48:15','测试描述_616',NULL),('98c3051d89fd439ab9eb562a6cdc3a45','testName_694','******',1,'2017-09-06 15:48:15','测试描述_694',NULL),('98f4903816ab4f3894657c80f6934fc5','testName_653','******',1,'2017-09-06 15:48:15','测试描述_653',NULL),('9927457470c54cfd97bbf5ddb3b97dae','testName_740','******',1,'2017-09-06 15:48:15','测试描述_740',NULL),('99762b448d484fa48fcdf717d1ca3d11','testName_381','******',1,'2017-09-06 15:48:13','测试描述_381',NULL),('997c6123aa8e40bf9ad988b6cf8369e9','testName_373','******',1,'2017-09-06 15:48:13','测试描述_373',NULL),('9983216b3c5d4342b56e511085636885','testName_853','',1,'2017-09-06 15:48:16','测试描述_853',NULL),('9993c740c8bf43bfbacf7de09e42cbf3','testName_758','******',1,'2017-09-06 15:48:15','测试描述_758',NULL),('99df668fb9b04efaac998394a36d45dd','testName_871','******',1,'2017-09-06 15:48:16','测试描述_871',NULL),('99e97e7d9d464ebbbbb10739d350a502','testName_862','******',1,'2017-09-06 15:48:16','测试描述_862',NULL),('9a11a5d7fe744d56ac7f0c8c2b0ab582','testName_478','******',1,'2017-09-06 15:48:14','测试描述_478',NULL),('9a211214b07c45e198d46f9ba60ddd9e','testName_542','******',1,'2017-09-06 15:48:14','测试描述_542',NULL),('9a3bbff57c64470e826727138f54e72a','testName_61','******',1,'2017-09-06 15:48:11','测试描述_61',NULL),('9ae1aea423bf4bcab7e71d17e2c7cd94','testName_88','******',1,'2017-09-06 15:48:11','测试描述_88',NULL),('9b13f49bb26a45ce8347c1a5c1c29a24','testName_665','******',1,'2017-09-06 15:48:15','测试描述_665',NULL),('9baacf4ba4dd4fdda09d5f5fbf94ff19','testName_120','******',1,'2017-09-06 15:48:11','测试描述_120',NULL),('9bc5de31b96645f6beeae41fe5d850d4','testName_56','******',1,'2017-09-06 15:48:11','测试描述_56',NULL),('9bc67d8f07bd479d9fe594216f8de825','testName_495','******',1,'2017-09-06 15:48:14','测试描述_495',NULL),('9be66c3ae6a0412aba43f87d6be90e15','testName_785','******',1,'2017-09-06 15:48:16','测试描述_785',NULL),('9c0022c48c6f495e8ce029bc46634b5e','testName_13','******',1,'2017-09-06 15:48:11','测试描述_13',NULL),('9c48ed6632ee4e788dd71d8917907841','testName_810','******',1,'2017-09-06 15:48:16','测试描述_810',NULL),('9c98008474034cf889bf88eb090bf357','testName_711','******',1,'2017-09-06 15:48:15','测试描述_711',NULL),('9d0eee2a680d4d129bcc7edcc5da49b6','testName_384','******',1,'2017-09-06 15:48:13','测试描述_384',NULL),('9d3da8ddf4894584bbfd7b06af28fe63','testName_892','******',1,'2017-09-06 15:48:16','测试描述_892',NULL),('9dc2e72767c7421c839422c16e020882','testName_602','******',1,'2017-09-06 15:48:14','测试描述_602',NULL),('9e00b814ab2b47bf8f6041911b29201e','testName_355','******',1,'2017-09-06 15:48:13','测试描述_355',NULL),('9f5c75d10f154d0893e77e2a1e7e2075','testName_388','******',1,'2017-09-06 15:48:13','测试描述_388',NULL),('9f7f8907965d4b79bad19a9e0eb5a545','testName_295','******',1,'2017-09-06 15:48:12','测试描述_295',NULL),('9fafbc6e224f46559f94e1a9cc7ea39d','testName_419','******',1,'2017-09-06 15:48:13','测试描述_419',NULL),('9fb1590ba0db4b669a2ba0f92db10106','testName_841','******',1,'2017-09-06 15:48:16','测试描述_841',NULL),('9fe0f6a266064be080f8a6ea8a17cc35','testName_815','******',1,'2017-09-06 15:48:16','测试描述_815',NULL),('a02128de05014273ad739d1291522e07','testName_209','******',1,'2017-09-06 15:48:12','测试描述_209',NULL),('a0513e7a9e894a55a5c542f75212b852','testName_366','******',1,'2017-09-06 15:48:13','测试描述_366',NULL),('a0e3e3b578a040f891373b9f915edef6','testName_686','******',1,'2017-09-06 15:48:15','测试描述_686',NULL),('a11d2bab56824b898627dc81e551a15a','testName_261','******',1,'2017-09-06 15:48:12','测试描述_261',NULL),('a15af5b6189c4e1781a55fc92072c80b','testName_726','******',1,'2017-09-06 15:48:15','测试描述_726',NULL),('a17cda87b67b41889ed88f5a3c8688c0','testName_506','******',1,'2017-09-06 15:48:14','测试描述_506',NULL),('a1958199bca34117a75517e552bf01e8','testName_159','******',1,'2017-09-06 15:48:12','测试描述_159',NULL),('a195e40d80344638a94dd5068f932825','testName_400','******',1,'2017-09-06 15:48:13','测试描述_400',NULL),('a2088021a7004025a9c0f5be79f5ab8c','testName_805','******',1,'2017-09-06 15:48:16','测试描述_805',NULL),('a2183cb6cfc04bd7a5c1b0c8a2fc6bdb','testName_472','******',1,'2017-09-06 15:48:14','测试描述_472',NULL),('a358b1ece0b5401cb37813ec0da2783a','testName_483','******',1,'2017-09-06 15:48:14','测试描述_483',NULL),('a37242556b964123b0c3e342b7c4f63f','testName_302','******',1,'2017-09-06 15:48:13','测试描述_302',NULL),('a4782df9121e4c65ac4d689ddc08d2e3','testName_564','******',1,'2017-09-06 15:48:14','测试描述_564',NULL),('a4c91ed380f947d9928e3082a46dbf07','testName_406','******',1,'2017-09-06 15:48:13','测试描述_406',NULL),('a58f273ee95442e98b438422e4a6becc','testName_285','******',1,'2017-09-06 15:48:12','测试描述_285',NULL),('a59d7c84cdd7475389e96ab44ae0730c','testName_558','******',1,'2017-09-06 15:48:14','测试描述_558',NULL),('a5d5fc19e16f4364bcd74497bec41a3d','testName_649','******',1,'2017-09-06 15:48:15','测试描述_649',NULL),('a65369bba745474283834673493f7507','testName_683','******',1,'2017-09-06 15:48:15','测试描述_683',NULL),('a65f14cc4ef14a74b64d78cde7d53c1e','testName_715','******',1,'2017-09-06 15:48:15','测试描述_715',NULL),('a6a4a7d29efa48da89c68588f6406548','testName_174','******',1,'2017-09-06 15:48:12','测试描述_174',NULL),('a709907ba8764ce5aad840c9a6f1f3a0','testName_223','******',1,'2017-09-06 15:48:12','测试描述_223',NULL),('a731b7d07304416dbd507adfc381003c','testName_122','******',1,'2017-09-06 15:48:11','测试描述_122',NULL),('a80a4b9dec3e4097bb1629053160a014','testName_309','******',1,'2017-09-06 15:48:13','测试描述_309',NULL),('a849d4ebf06c4fdfa8165abc59bd7299','testName_723','******',1,'2017-09-06 15:48:15','测试描述_723',NULL),('a86f8688e89f43b3b8ec84299adcbee1','testName_514','******',1,'2017-09-06 15:48:14','测试描述_514',NULL),('a89644bedae04974aca2bb11b8fc6cb0','testName_225','******',1,'2017-09-06 15:48:12','测试描述_225',NULL),('a8a09a64319b4a32810b2bd75bcf2c1f','testName_48','******',1,'2017-09-06 15:48:11','测试描述_48',NULL),('a93ae6962c2f47479accaf2a0087949c','testName_552','******',1,'2017-09-06 15:48:14','测试描述_552',NULL),('a962ce6731594b0597d7e77f7570eb9d','testName_257','******',1,'2017-09-06 15:48:12','测试描述_257',NULL),('a9d253c4dabe4ea0867d36c3f915ce8c','testName_716','******',1,'2017-09-06 15:48:15','测试描述_716',NULL),('a9d6c929f2694096967d1110891a3948','testName_301','******',1,'2017-09-06 15:48:13','测试描述_301',NULL),('aabd9871047d4153af385c9cb13a6609','testName_839','******',1,'2017-09-06 15:48:16','测试描述_839',NULL),('aafa105ebbaa43abad92e1e290a3aa2d','testName_17','******',1,'2017-09-06 15:48:11','测试描述_17',NULL),('ab570c7d3ffd4337859bda55b7817f9b','testName_332','******',1,'2017-09-06 15:48:13','测试描述_332',NULL),('ad9f5eaed6904016be98c8f091c02c22','testName_617','******',1,'2017-09-06 15:48:15','测试描述_617',NULL),('adb460074dc544858ceb3c866f8f8890','testName_335','******',1,'2017-09-06 15:48:13','测试描述_335',NULL),('add01bd4776b4448ab4fdeeaadd93d92','testName_316','******',1,'2017-09-06 15:48:13','测试描述_316',NULL),('ade8c967b6404b6ab720624e473bcddd','testName_499','******',1,'2017-09-06 15:48:14','测试描述_499',NULL),('ae6b086059a446f2a126d23cc3f56298','testName_63','******',1,'2017-09-06 15:48:11','测试描述_63',NULL),('ae8709e802324af98af0fa77169970e4','testName_86','******',1,'2017-09-06 15:48:11','测试描述_86',NULL),('ae87316d28b34be2af3f71b0f352ca74','testName_43','******',1,'2017-09-06 15:48:11','测试描述_43',NULL),('af8905fd8ad2453cb6f3fc006a29b65a','testName_560','******',1,'2017-09-06 15:48:14','测试描述_560',NULL),('afbcb5ad821641e28ead08860a74e4da','testName_291','******',1,'2017-09-06 15:48:12','测试描述_291',NULL),('aff0ccf4b73343ae936761aeff2cdfa0','testName_507','******',1,'2017-09-06 15:48:14','测试描述_507',NULL),('b01ee0064943488fb7769ad9b52746e1','testName_800','******',1,'2017-09-06 15:48:16','测试描述_800',NULL),('b0d1ce2e66904b8aab28a3f74c6291b8','testName_71','******',1,'2017-09-06 15:48:11','测试描述_71',NULL),('b0f27704a13141e79acf874ae636d716','testName_292','******',1,'2017-09-06 15:48:12','测试描述_292',NULL),('b1070758a81f4961a546d93f18e1c6c8','testName_679','******',1,'2017-09-06 15:48:15','测试描述_679',NULL),('b118929a93ac4d55857309d307ebce40','testName_847','******',1,'2017-09-06 15:48:16','测试描述_847',NULL),('b1e5f6f0d9a44374a6efab2207a5def4','testName_803','******',1,'2017-09-06 15:48:16','测试描述_803',NULL),('b1e65bdb9d7143aa8f2c13148e1609e0','testName_383','******',1,'2017-09-06 15:48:13','测试描述_383',NULL),('b2235400303a4dec8dc2caa2ccae3c9a','testName_455','******',1,'2017-09-06 15:48:14','测试描述_455',NULL),('b2d8178988b44b40a056af3fb1e1797b','testName_197','******',1,'2017-09-06 15:48:12','测试描述_197',NULL),('b2fd83d0792a4a36b66b89694fee645c','testName_773','******',1,'2017-09-06 15:48:16','测试描述_773',NULL),('b35a7988ac784eef9f042968ddf9b956','testName_404','******',1,'2017-09-06 15:48:13','测试描述_404',NULL),('b378eb01c22245eb8ea7a19d99cff60a','testName_563','******',1,'2017-09-06 15:48:14','测试描述_563',NULL),('b42c4e757d2e434cb3c812f8bd5b864b','testName_512','******',1,'2017-09-06 15:48:14','测试描述_512',NULL),('b461808a364f46ee82d3ee238d151d1d','testName_738','******',1,'2017-09-06 15:48:15','测试描述_738',NULL),('b4a9bde493334570ad7dcf79cb153200','testName_278','******',1,'2017-09-06 15:48:12','测试描述_278',NULL),('b570e1f559bb44298191be54602aa598','testName_115','******',1,'2017-09-06 15:48:11','测试描述_115',NULL),('b5bb071137cf4a5cac203ec2aff58c49','testName_113','******',1,'2017-09-06 15:48:11','测试描述_113',NULL),('b5dd677784784847875cf15f0a3dff17','testName_437','******',1,'2017-09-06 15:48:13','测试描述_437',NULL),('b610de97dc764ca2985008908745eb42','testName_462','******',1,'2017-09-06 15:48:14','测试描述_462',NULL),('b6128ee9c83344cba3a7bfcfdcd27935','testName_527','******',1,'2017-09-06 15:48:14','测试描述_527',NULL),('b6322c7f0c2f4ce695c0a880abc4bc5b','testName_408','******',1,'2017-09-06 15:48:13','测试描述_408',NULL),('b6737ba3240142e6b32f3039509aab2e','testName_3','******',1,'2017-09-06 15:48:11','测试描述_3',NULL),('b6ee6b21e438425bb1865688078f03a0','testName_840','',1,'2017-09-06 15:48:16','测试描述_840',NULL),('b7298d1d97854376beb3abcb46c4e634','testName_655','******',1,'2017-09-06 15:48:15','测试描述_655',NULL),('b7723a14ffe843ccbe6e62ec97139426','testName_103','******',1,'2017-09-06 15:48:11','测试描述_103',NULL),('b7944e274f3d4048ab02b649942f9afb','testName_883','******',1,'2017-09-06 15:48:16','测试描述_883',NULL),('b85ac06ce4e148b4bb8bf3dec8f412db','testName_456','******',1,'2017-09-06 15:48:14','测试描述_456',NULL),('b8821330c069429585e6d7c87fbf51c4','testName_319','******',1,'2017-09-06 15:48:13','测试描述_319',NULL),('b900d6dba4e94bad8eabe556ef6320f9','testName_158','******',1,'2017-09-06 15:48:12','测试描述_158',NULL),('b92367fdb7624395ae1d32e19f0fdba6','testName_448','******',1,'2017-09-06 15:48:14','测试描述_448',NULL),('b9500a68f949494681fee475c9b8b05d','testName_428','******',1,'2017-09-06 15:48:13','测试描述_428',NULL),('b9994dc92f034b1fbdc1c974c2eb4477','testName_365','******',1,'2017-09-06 15:48:13','测试描述_365',NULL),('ba0b8eb394264c71837b775b9812af2c','testName_848','******',1,'2017-09-06 15:48:16','测试描述_848',NULL),('ba3f583429e444a48dd031774bb5def3','testName_452','******',1,'2017-09-06 15:48:14','测试描述_452',NULL),('ba9710d52dd54fc3bfe76e966e44b3b6','testName_298','******',1,'2017-09-06 15:48:13','测试描述_298',NULL),('bba004cf5f7d4a81991075b4fe665f72','testName_134','******',1,'2017-09-06 15:48:11','测试描述_134',NULL),('bc1b317a5b40469f8fcb00ecc5902a05','testName_392','******',1,'2017-09-06 15:48:13','测试描述_392',NULL),('bca9567dd5374f6e81f45320dcbb8b5c','testName_719','******',1,'2017-09-06 15:48:15','测试描述_719',NULL),('bcdc29a261484264bf310f37e49a16a3','testName_315','******',1,'2017-09-06 15:48:13','测试描述_315',NULL),('bd1431697c9b47d0a08857167bec6457','testName_525','******',1,'2017-09-06 15:48:14','测试描述_525',NULL),('bd7c577d8ec642079af0ae5d9158c589','testName_895','******',1,'2017-09-06 15:48:16','测试描述_895',NULL),('bda493fb3e134f06bca899d2d37e42c9','testName_136','******',1,'2017-09-06 15:48:11','测试描述_136',NULL),('bde1666798854b26a200d607bcb06faa','testName_145','******',1,'2017-09-06 15:48:12','测试描述_145',NULL),('be10636589064deb8d5211ba4f67c3d7','testName_173','******',1,'2017-09-06 15:48:12','测试描述_173',NULL),('be64fb0877fb4fe5a7802d484ea130c6','testName_380','******',1,'2017-09-06 15:48:13','测试描述_380',NULL),('bea22488b8e14b41a5f932b1c1bfb33e','testName_353','******',1,'2017-09-06 15:48:13','测试描述_353',NULL),('bf2a0114228a48e582a36d30f594f620','testName_229','******',1,'2017-09-06 15:48:12','测试描述_229',NULL),('bfa6685a15264f16b89ec1b9ee9f21cd','testName_888','******',1,'2017-09-06 15:48:16','测试描述_888',NULL),('c04c5d9172a3436b84f0a22784d1e51f','testName_789','******',1,'2017-09-06 15:48:16','测试描述_789',NULL),('c0677637ca334dd998b21b6135bd354f','testName_786','******',1,'2017-09-06 15:48:16','测试描述_786',NULL),('c0e2e62568634bfe925af0e0170d63e8','testName_427','******',1,'2017-09-06 15:48:13','测试描述_427',NULL),('c13e59791bf6473b8da9ddf797bdb849','testName_761','******',1,'2017-09-06 15:48:15','测试描述_761',NULL),('c152f6467568483dbbea69a7a123e7a9','testName_415','******',1,'2017-09-06 15:48:13','测试描述_415',NULL),('c15f4d8d582f425da947e35c6454cbbe','testName_246','******',1,'2017-09-06 15:48:12','测试描述_246',NULL),('c1800d4e53824c77bda0272801a3db1b','testName_868','******',1,'2017-09-06 15:48:16','测试描述_868',NULL),('c1a746c3e9bd4758865042fb679cb111','testName_579','******',1,'2017-09-06 15:48:14','测试描述_579',NULL),('c1e440b7d8674cc390030b49fd5c31ef','testName_397','******',1,'2017-09-06 15:48:13','测试描述_397',NULL),('c1ea2d2698fa494bae7d5abd2dcf440d','testName_808','******',1,'2017-09-06 15:48:16','测试描述_808',NULL),('c24258dff7be4162a7aebad7ae040469','testName_39','******',1,'2017-09-06 15:48:11','测试描述_39',NULL),('c2b00ad10708413592e20a47eeaa822e','testName_207','******',1,'2017-09-06 15:48:12','测试描述_207',NULL),('c30b9b2228804f179cbd444debec291c','testName_377','******',1,'2017-09-06 15:48:13','测试描述_377',NULL),('c342329bea43447e80660c9814c52249','testName_132','******',1,'2017-09-06 15:48:11','测试描述_132',NULL),('c3f02c1fe1824114be24ab4fdcdab06c','testName_99','******',1,'2017-09-06 15:48:11','测试描述_99',NULL),('c3fd5422802242b6a4fc63dcc047879d','testName_878','******',1,'2017-09-06 15:48:16','测试描述_878',NULL),('c40dff72786c4d54bec7c9c6dd8a2aad','testName_5','******',1,'2017-09-06 15:48:11','测试描述_5',NULL),('c45b040cbdd24513b33010c36b2e87da','testName_568','******',1,'2017-09-06 15:48:14','测试描述_568',NULL),('c49d3bbe45d94e359add5c5e062f5eb0','testName_242','******',1,'2017-09-06 15:48:12','测试描述_242',NULL),('c54df326161b4eea912747f6754ebd7f','testName_675','******',1,'2017-09-06 15:48:15','测试描述_675',NULL),('c57de72d5872455386dfc2aee63fb718','testName_204','******',1,'2017-09-06 15:48:12','测试描述_204',NULL),('c5cd645f45e64a12b61d2f1b1fdce1dd','testName_279','******',1,'2017-09-06 15:48:12','测试描述_279',NULL),('c60d58fab4dd4b1e9d4de6d5e17e9fc9','testName_268','******',1,'2017-09-06 15:48:12','测试描述_268',NULL),('c66e2f12a2eb448db86a55c6bc5c6133','testName_418','******',1,'2017-09-06 15:48:13','测试描述_418',NULL),('c66e9474ab334e988664ce6f261a3f21','testName_15','******',1,'2017-09-06 15:48:11','测试描述_15',NULL),('c67af7c8f8ee47c68b9be8e5718996f4','testName_584','******',1,'2017-09-06 15:48:14','测试描述_584',NULL),('c69994a0d3e04cf1a6d8353868fd046f','testName_74','******',1,'2017-09-06 15:48:11','测试描述_74',NULL),('c6a3ce53edd442a397ef86b795fdca56','testName_648','******',1,'2017-09-06 15:48:15','测试描述_648',NULL),('c6ba8f63c4c44ba399e07a677d1a5c0e','testName_727','******',1,'2017-09-06 15:48:15','测试描述_727',NULL),('c6cc7dedce944844bc4c2910bf24e3af','testName_445','******',1,'2017-09-06 15:48:13','测试描述_445',NULL),('c7116492c2dc4ffc92eeaa686d2b5f58','testName_322','******',1,'2017-09-06 15:48:13','测试描述_322',NULL),('c74bc68017f843648395023356940123','testName_333','******',1,'2017-09-06 15:48:13','测试描述_333',NULL),('c7891034591c4a58a657818dd19ee781','testName_349','******',1,'2017-09-06 15:48:13','测试描述_349',NULL),('c7a19862f21649d2a7b2e2400819f9e3','testName_780','******',1,'2017-09-06 15:48:16','测试描述_780',NULL),('c7e4e30d5b7a4c8daf407ad962567e7e','testName_200','******',1,'2017-09-06 15:48:12','测试描述_200',NULL),('c85b8cfc00014804b1b05636d72bbd38','testName_215','******',1,'2017-09-06 15:48:12','测试描述_215',NULL),('c86d167dcff44943811e2f5e775fa2aa','testName_82','******',1,'2017-09-06 15:48:11','测试描述_82',NULL),('c8e4342c532940919f63baa241e6ebfe','testName_494','******',1,'2017-09-06 15:48:14','测试描述_494',NULL),('c8fdc210be784d58b805341883e53016','testName_206','******',1,'2017-09-06 15:48:12','测试描述_206',NULL),('ca635feff0474c7f9fd713bde6d7df88','testName_107','******',1,'2017-09-06 15:48:11','测试描述_107',NULL),('ca9343f507434466921f18017052e4e5','testName_633','******',1,'2017-09-06 15:48:15','测试描述_633',NULL),('cb854fca698e404c9086cd9a247d8b3f','testName_64','******',1,'2017-09-06 15:48:11','测试描述_64',NULL),('cc0bb861733548ba8f71c07303c8f288','testName_816','******',1,'2017-09-06 15:48:16','测试描述_816',NULL),('cc821eb2580e47039b8a6ee9bfb95927','testName_354','******',1,'2017-09-06 15:48:13','测试描述_354',NULL),('cc836556be0141a8b06ca87719b827eb','testName_578','******',1,'2017-09-06 15:48:14','测试描述_578',NULL),('ccef42d113e14e8c968fbd1aeafc9b09','testName_639','******',1,'2017-09-06 15:48:15','测试描述_639',NULL),('ccf066f1a5974e4bb23183509156e7f4','testName_449','******',1,'2017-09-06 15:48:14','测试描述_449',NULL),('cd0be3f752844e37ba85dbb0e975b378','testName_299','******',1,'2017-09-06 15:48:13','测试描述_299',NULL),('cdfe25b6cdd24a10b8d682bcbe86df60','testName_190','******',1,'2017-09-06 15:48:12','测试描述_190',NULL),('ce70cd8cef7e4433a9eca7ceb6ba40e2','testName_131','******',1,'2017-09-06 15:48:11','测试描述_131',NULL),('cec3e6a4f26f4c10a00aa3fe12be9481','testName_307','******',1,'2017-09-06 15:48:13','测试描述_307',NULL),('cf72e5d1da54497083b30a4c5e769a2d','testName_371','******',1,'2017-09-06 15:48:13','测试描述_371',NULL),('cfaf781e45ff4f2f80df34f267236019','testName_646','******',1,'2017-09-06 15:48:15','测试描述_646',NULL),('cfda8029be9c412493dce30c22ca208d','testName_14','******',1,'2017-09-06 15:48:11','测试描述_14',NULL),('cfe1926d560646a0b0b0ca0724affff9','testName_167','******',1,'2017-09-06 15:48:12','测试描述_167',NULL),('cfe8d952a68749989bd24f7591986cd2','testName_875','******',1,'2017-09-06 15:48:16','测试描述_875',NULL),('d0236cb156074326ab9a3bfd7e79d1e5','testName_739','******',1,'2017-09-06 15:48:15','测试描述_739',NULL),('d03492b7a96f4ffa9279a2c6a60a0ac4','testName_296','******',1,'2017-09-06 15:48:13','测试描述_296',NULL),('d0595b0cd685457a8b1a67ca5b1ac658','testName_603','******',1,'2017-09-06 15:48:14','测试描述_603',NULL),('d0715896ac354a139132c42858f9cc2d','testName_109','******',1,'2017-09-06 15:48:11','测试描述_109',NULL),('d079867c3fde44b79e69c147d937b27a','testName_742','******',1,'2017-09-06 15:48:15','测试描述_742',NULL),('d08fa03fed0d4826a878a3804ecaf522','testName_771','******',1,'2017-09-06 15:48:16','测试描述_771',NULL),('d09015d9308142fc881de8fdfa47383b','testName_690','******',1,'2017-09-06 15:48:15','测试描述_690',NULL),('d101e11775294dcda0608f3bcfc513d4','testName_123','******',1,'2017-09-06 15:48:11','测试描述_123',NULL),('d165e8da41dc4172805e0f65f3cce1b5','testName_90','******',1,'2017-09-06 15:48:11','测试描述_90',NULL),('d229115793dc489ea7e79d0a4b9b8a6a','testName_607','******',1,'2017-09-06 15:48:15','测试描述_607',NULL),('d232bd2a471f4aaca340f092d39c5369','testName_201','******',1,'2017-09-06 15:48:12','测试描述_201',NULL),('d2faae477d6d416297da94a644eac3bc','testName_470','******',1,'2017-09-06 15:48:14','测试描述_470',NULL),('d31233625a5a46168f0b2a915e128408','testName_217','******',1,'2017-09-06 15:48:12','测试描述_217',NULL),('d32ca0fb542140ce95b261cbe9289b3b','testName_671','******',1,'2017-09-06 15:48:15','测试描述_671',NULL),('d32fcfff964d4b1fafe4c4d0fc286509','testName_76','******',1,'2017-09-06 15:48:11','测试描述_76',NULL),('d37cc3f6a1df4fdc9be4d690866c848d','testName_205','******',1,'2017-09-06 15:48:12','测试描述_205',NULL),('d38f3228a382493f8acb1d38755e9d1a','testName_346','******',1,'2017-09-06 15:48:13','测试描述_346',NULL),('d3931dec8aff46f4b291efdc6b4ca353','testName_146','******',1,'2017-09-06 15:48:12','测试描述_146',NULL),('d3a432a3acd44f8f972333af3e01b603','testName_148','******',1,'2017-09-06 15:48:12','测试描述_148',NULL),('d3d0920fabc34f53986903247a788770','testName_712','******',1,'2017-09-06 15:48:15','测试描述_712',NULL),('d3e4453a35a04e91a6983a2c8f1bb21c','testName_453','******',1,'2017-09-06 15:48:14','测试描述_453',NULL),('d45eb7821e8446d2bbd03dcbab61e6a6','testName_465','******',1,'2017-09-06 15:48:14','测试描述_465',NULL),('d4603f7be0f64e26bb8838b91e57586b','testName_480','******',1,'2017-09-06 15:48:14','测试描述_480',NULL),('d46902d6d42246efa870a29de057c63a','testName_764','******',1,'2017-09-06 15:48:16','测试描述_764',NULL),('d533ecdd476d4e4faf9e8821eba39a61','testName_140','******',1,'2017-09-06 15:48:11','测试描述_140',NULL),('d5891f384d794ce5a57e50f9aa014164','testName_838','******',1,'2017-09-06 15:48:16','测试描述_838',NULL),('d5bc83ce43f143d29347497cd6c7f73a','testName_306','******',1,'2017-09-06 15:48:13','测试描述_306',NULL),('d5d43f1b866b4efa87fa646832fc4cd3','testName_230','******',1,'2017-09-06 15:48:12','测试描述_230',NULL),('d5f0c7608c934f399ece890fbf6c2d26','testName_20','******',1,'2017-09-06 15:48:11','测试描述_20',NULL),('d624ae3c950f420a8f20237918119141','testName_890','******',1,'2017-09-06 15:48:16','测试描述_890',NULL),('d635bb963be34fb3ac62b299f9dd5422','testName_378','******',1,'2017-09-06 15:48:13','测试描述_378',NULL),('d6ab2c79e48f4bf6a6069287791af323','testName_819','******',1,'2017-09-06 15:48:16','测试描述_819',NULL),('d72c0f240fe5490daf381b6730a24cc4','testName_817','******',1,'2017-09-06 15:48:16','测试描述_817',NULL),('d730d181e4354cea841ff99aeeb0bdda','testName_634','******',1,'2017-09-06 15:48:15','测试描述_634',NULL),('d73eefdc1f614780b5541fad13302809','testName_53','******',1,'2017-09-06 15:48:11','测试描述_53',NULL),('d744dc8d9a904e808c4d55fc3d3c0bab','testName_496','******',1,'2017-09-06 15:48:14','测试描述_496',NULL),('d74d7af427444b089e5e99823e991fc1','testName_330','******',1,'2017-09-06 15:48:13','测试描述_330',NULL),('d763141cbc1a41fb90c70a9e93da6bd9','testName_600','******',1,'2017-09-06 15:48:14','测试描述_600',NULL),('d7e3f8aaefdc4a76b4c3fac7fd9d7301','testName_359','******',1,'2017-09-06 15:48:13','测试描述_359',NULL),('d7ec9f92264f452bac688b7d6e2e4da6','testName_248','******',1,'2017-09-06 15:48:12','测试描述_248',NULL),('d80a937b7e5d408984b9b6f255d06f8a','testName_610','******',1,'2017-09-06 15:48:15','测试描述_610',NULL),('d884fada4bb949e29930b13c858f8f5f','testName_833','******',1,'2017-09-06 15:48:16','测试描述_833',NULL),('d8dc558ff48644138b7b05fefa4cb97d','testName_696','******',1,'2017-09-06 15:48:15','测试描述_696',NULL),('d91a9d5c0dd64a2983a799758f1246b0','testName_264','******',1,'2017-09-06 15:48:12','测试描述_264',NULL),('d934d0324ab548a1a4240dd100b58143','testName_67','******',1,'2017-09-06 15:48:11','测试描述_67',NULL),('d939d567960f4ca09ae532ada9cbd4be','testName_320','******',1,'2017-09-06 15:48:13','测试描述_320',NULL),('d96f0e4459644e6fbe4afa82f595d1ae','testName_52','******',1,'2017-09-06 15:48:11','测试描述_52',NULL),('d9ab5f86595f4280bdb90d5382703bc7','testName_395','******',1,'2017-09-06 15:48:13','测试描述_395',NULL),('d9f65081b4604f52a677713777ab5427','testName_237','******',1,'2017-09-06 15:48:12','测试描述_237',NULL),('da6aa48be8f74c9385bf9db1eed4ceda','testName_597','******',1,'2017-09-06 15:48:14','测试描述_597',NULL),('dace8a7acab0459f977dd92f8ede16e5','testName_411','******',1,'2017-09-06 15:48:13','测试描述_411',NULL),('db20053b8151450ebcc5f86ddbf57ceb','testName_75','******',1,'2017-09-06 15:48:11','测试描述_75',NULL),('db2e2926b70a432ba586804f6c60f87a','testName_172','******',1,'2017-09-06 15:48:12','测试描述_172',NULL),('dc327d552d0047dca1328b0e3b72c302','testName_860','******',1,'2017-09-06 15:48:16','测试描述_860',NULL),('dc3a42a2a8f344e5ba852079f4f7bb17','testName_175','******',1,'2017-09-06 15:48:12','测试描述_175',NULL),('dc3adce057d043ef9b6d608adc6861c4','testName_504','******',1,'2017-09-06 15:48:14','测试描述_504',NULL),('dc60ba0fcc574d989f03cd9f150d193a','testName_640','******',1,'2017-09-06 15:48:15','测试描述_640',NULL),('dc7c8c7c857946ceab3cc525bc28a7c6','testName_382','******',1,'2017-09-06 15:48:13','测试描述_382',NULL),('dd68d1b3437b4687bf34d9feb71ab480','testName_192','******',1,'2017-09-06 15:48:12','测试描述_192',NULL),('dde5f7f3423c4bb1b042227b672556f7','testName_403','******',1,'2017-09-06 15:48:13','测试描述_403',NULL),('ddef9600f5bb45ccac1b37b0674d0416','testName_460','******',1,'2017-09-06 15:48:14','测试描述_460',NULL),('de3b2110d4d849d1b5a4883af1245bf3','testName_70','******',1,'2017-09-06 15:48:11','测试描述_70',NULL),('de59de316e1b4ee8bac064e8833a045c','testName_262','******',1,'2017-09-06 15:48:12','测试描述_262',NULL),('dea3e62629ca4b878d01acb19cb603b1','testName_23','******',1,'2017-09-06 15:48:11','测试描述_23',NULL),('debfee7e295c493da087fe17ba5c1881','testName_651','******',1,'2017-09-06 15:48:15','测试描述_651',NULL),('dee91a6204524a2394a8ed96914ae492','testName_249','******',1,'2017-09-06 15:48:12','测试描述_249',NULL),('dfb14f4507f54f06a78c251edfa0b7a1','testName_702','******',1,'2017-09-06 15:48:15','测试描述_702',NULL),('dfddfe14e96f4ef9b3a5094d13ccb0ee','testName_807','******',1,'2017-09-06 15:48:16','测试描述_807',NULL),('dfec5d3219c14ad1bfaa8af9de0a4565','testName_79','******',1,'2017-09-06 15:48:11','测试描述_79',NULL),('e01212d3219941e799e9b1a964a9d05f','testName_511','******',1,'2017-09-06 15:48:14','测试描述_511',NULL),('e073497cd18f467bbc69d14c8841dce1','testName_736','******',1,'2017-09-06 15:48:15','测试描述_736',NULL),('e08be8dacf83488cbab077dccd568fee','testName_729','******',1,'2017-09-06 15:48:15','测试描述_729',NULL),('e0984e8a7da7432bb534a5fee2fab867','testName_547','******',1,'2017-09-06 15:48:14','测试描述_547',NULL),('e120bbf1e8904237b732a7a7aa91c45e','testName_269','******',1,'2017-09-06 15:48:12','测试描述_269',NULL),('e1fa908f280b43418d53dde08a8a2309','testName_787','******',1,'2017-09-06 15:48:16','测试描述_787',NULL),('e27d10944aad49f4bf69ba29ba2f39c5','testName_599','******',1,'2017-09-06 15:48:14','测试描述_599',NULL),('e2f3e35bb19441aaa85c4572cc6ddaf2','testName_416','******',1,'2017-09-06 15:48:13','测试描述_416',NULL),('e30ea9b2554a4bd79618467c38f54593','testName_125','******',1,'2017-09-06 15:48:11','测试描述_125',NULL),('e3dabfdfa38243ebb168bb5782cd7d72','testName_858','******',1,'2017-09-06 15:48:16','测试描述_858',NULL),('e49fa8363f0d4a16a01f914df043dfbf','testName_591','******',1,'2017-09-06 15:48:14','测试描述_591',NULL),('e4cf915bfd5642bc819a804cbae99f83','testName_240','******',1,'2017-09-06 15:48:12','测试描述_240',NULL),('e559d5bc28c84570ad771cde4a8013ab','testName_78','',1,'2017-09-06 15:48:11','测试描述_78',NULL),('e56a3e2b5e584543aba8e6bac9c40e9d','testName_618','******',1,'2017-09-06 15:48:15','测试描述_618',NULL),('e577be12fa1049d988a39bb1c80fbf76','testName_152','******',1,'2017-09-06 15:48:12','测试描述_152',NULL),('e59de2b1a85d4da49bbbd279e0fdd0d9','test','4292bb58be34c59d28a0dcbd11932d49',1,'2017-08-18 15:20:31','测试',NULL),('e5cae54e605643638d485edf0e6b67fc','testName_692','******',1,'2017-09-06 15:48:15','测试描述_692',NULL),('e63757f04cc54d9faa71f123c2b2ad4a','testName_8','******',1,'2017-09-06 15:48:11','测试描述_8',NULL),('e666ec16518a4144b1f53cdb8316867f','testName_667','******',1,'2017-09-06 15:48:15','测试描述_667',NULL),('e6a30f5bf2de4a67b99420c86aef0487','testName_54','******',1,'2017-09-06 15:48:11','测试描述_54',NULL),('e6a4049b5e9d4f7f8f55ca595f197842','testName_793','******',1,'2017-09-06 15:48:16','测试描述_793',NULL),('e6b2b8c4da4443918e4dbb34288772af','testName_224','******',1,'2017-09-06 15:48:12','测试描述_224',NULL),('e6f240a1bb6d404ebec3e78e61fb9191','testName_821','******',1,'2017-09-06 15:48:16','测试描述_821',NULL),('e7017df8e0e64142a87bbb4284183879','testName_38','******',1,'2017-09-06 15:48:11','测试描述_38',NULL),('e7410723228c4068a2e9ae99588ac711','testName_801','******',1,'2017-09-06 15:48:16','测试描述_801',NULL),('e80763f2203c4a63976ecc4ebf867e77','testName_828','******',1,'2017-09-06 15:48:16','测试描述_828',NULL),('e85d167446dd428b97ddd1028efa0553','testName_549','******',1,'2017-09-06 15:48:14','测试描述_549',NULL),('e89b69d7e2da4984b3cb0b218179f933','testName_670','******',1,'2017-09-06 15:48:15','测试描述_670',NULL),('e8aa9825a963496c829610b65873ef61','testName_336','******',1,'2017-09-06 15:48:13','测试描述_336',NULL),('e8aab61ef5b44df5a30095b9b6153d0b','testName_324','******',1,'2017-09-06 15:48:13','测试描述_324',NULL),('e8e0e88b94b945048c0e79c3631a539e','testName_748','******',1,'2017-09-06 15:48:15','测试描述_748',NULL),('e8f0dd7e0a704714ae00b3bef11591f0','testName_855','******',1,'2017-09-06 15:48:16','测试描述_855',NULL),('e8fa26fc64894884aee1d5eb050bd5ca','testName_287','******',1,'2017-09-06 15:48:12','测试描述_287',NULL),('e96e0a29c4034957b92d827ead04b9d5','testName_593','******',1,'2017-09-06 15:48:14','测试描述_593',NULL),('e994592e5d2443649972e697e9a40752','testName_476','******',1,'2017-09-06 15:48:14','测试描述_476',NULL),('ea2169945bf14e509260620de191bdc5','testName_238','******',1,'2017-09-06 15:48:12','测试描述_238',NULL),('ea4819873bc24c11aff9f295cfeef4f2','testName_33','******',1,'2017-09-06 15:48:11','测试描述_33',NULL),('ea62f704442b49b98c866af21caf3e8f','testName_697','******',1,'2017-09-06 15:48:15','测试描述_697',NULL),('ea95a80fbfd842639683b4cb7ae2c583','testName_68','******',1,'2017-09-06 15:48:11','测试描述_68',NULL),('eac3631dc2fc4471aff106fa479082b9','testName_396','******',1,'2017-09-06 15:48:13','测试描述_396',NULL),('eb1ab76cfc9248e7ba28d5ba6dec71b5','testName_473','******',1,'2017-09-06 15:48:14','测试描述_473',NULL),('eb5aefbe9b204f57838ea35a234e03d0','testName_352','******',1,'2017-09-06 15:48:13','测试描述_352',NULL),('eba4734ab88945bbbceb9baff1c1e872','testName_623','******',1,'2017-09-06 15:48:15','测试描述_623',NULL),('ebb9f23c57964dd3a3eb4cea0851af73','testName_601','******',1,'2017-09-06 15:48:14','测试描述_601',NULL),('ebc5a50b7aba43e8b3374975dde30fa1','testName_577','******',1,'2017-09-06 15:48:14','测试描述_577',NULL),('ec0f489b6f30402aa60906705fd98df1','testName_681','******',1,'2017-09-06 15:48:15','测试描述_681',NULL),('ec37bb507e8047348e5435c1cb781e19','testName_874','******',1,'2017-09-06 15:48:16','测试描述_874',NULL),('ec3bec5638ee48f5bddc76951be4dc91','testName_393','******',1,'2017-09-06 15:48:13','测试描述_393',NULL),('ec95b09559064926bdb7d7e618aa9b5c','testName_47','******',1,'2017-09-06 15:48:11','测试描述_47',NULL),('ed0c9a9bfdbd48e286c284e3619bdb80','testName_678','******',1,'2017-09-06 15:48:15','测试描述_678',NULL),('edd69291abf44af6b6601fadc1e6b075','testName_387','******',1,'2017-09-06 15:48:13','测试描述_387',NULL),('ef28792e2f59429ba91580766ef9bbe0','testName_138','******',1,'2017-09-06 15:48:11','测试描述_138',NULL),('efd61f458a39467eb9beb0afca69637a','testName_289','******',1,'2017-09-06 15:48:12','测试描述_289',NULL),('f025e4d0a75848119af50fda28d6c424','testName_348','******',1,'2017-09-06 15:48:13','测试描述_348',NULL),('f028c5ef2098426ba71c8cb2d8fdbf55','testName_615','******',1,'2017-09-06 15:48:15','测试描述_615',NULL),('f12bfa4f433e454b99e414ebd67061d0','testName_699','******',1,'2017-09-06 15:48:15','测试描述_699',NULL),('f202915c915f4e5db8f9e9d8732736f2','testName_227','******',1,'2017-09-06 15:48:12','测试描述_227',NULL),('f20993fef7e84ce7bfd919c93ae76b68','testName_812','******',1,'2017-09-06 15:48:16','测试描述_812',NULL),('f213fa87a7204ce689d827ddbd246a24','testName_360','******',1,'2017-09-06 15:48:13','测试描述_360',NULL),('f22abd52119b434782f54425fbce830f','testName_614','******',1,'2017-09-06 15:48:15','测试描述_614',NULL),('f22f742542b64e2e8a34433fa419613d','testName_447','******',1,'2017-09-06 15:48:13','测试描述_447',NULL),('f2583535302748b99188e927a4192c76','testName_589','******',1,'2017-09-06 15:48:14','测试描述_589',NULL),('f2dea4e58d6b4a6aa752ef321e23fd9b','testName_410','******',1,'2017-09-06 15:48:13','测试描述_410',NULL),('f3068be7ddde4d3d88c39b455a788ead','testName_168','******',1,'2017-09-06 15:48:12','测试描述_168',NULL),('f3595d18f9834d498ff344c1a9139016','testName_265','******',1,'2017-09-06 15:48:12','测试描述_265',NULL),('f41f46d09e0242d189065fe372848ded','testName_11','******',1,'2017-09-06 15:48:11','测试描述_11',NULL),('f42c9ab8f72b476fbe35ce0ec73d3d34','testName_632','******',1,'2017-09-06 15:48:15','测试描述_632',NULL),('f47fb85e6c14430bb41a66a6166a3b64','testName_744','******',1,'2017-09-06 15:48:15','测试描述_744',NULL),('f4a0343e698d4a12bfeb9b0d33770fdd','testName_342','******',1,'2017-09-06 15:48:13','测试描述_342',NULL),('f4ef5ee9794645dc9cd41a31c3f2ebfb','testName_660','******',1,'2017-09-06 15:48:15','测试描述_660',NULL),('f62abb3f9a41469190707f146aa2ade0','testName_286','******',1,'2017-09-06 15:48:12','测试描述_286',NULL),('f62b6864eea84df98e9ac40c101ca337','testName_112','******',1,'2017-09-06 15:48:11','测试描述_112',NULL),('f672291c52114e648f9566c1fe4e641d','testName_370','******',1,'2017-09-06 15:48:13','测试描述_370',NULL),('f6915d5ee93046f0b06255b395a3bb47','testName_329','******',1,'2017-09-06 15:48:13','测试描述_329',NULL),('f6c2675d98f24f15bf03cf728d3860c7','testName_150','******',1,'2017-09-06 15:48:12','测试描述_150',NULL),('f6d63a893bc3461da9c15261124f8226','testName_619','******',1,'2017-09-06 15:48:15','测试描述_619',NULL),('f7224012ed374003975919ba30aefad0','testName_95','******',1,'2017-09-06 15:48:11','测试描述_95',NULL),('f757222fbfab496d82227f44e89be937','testName_490','******',1,'2017-09-06 15:48:14','测试描述_490',NULL),('f8af8d00383e439784c12013169243f6','testName_328','******',1,'2017-09-06 15:48:13','测试描述_328',NULL),('f8d97829f7504ed398f98188d4b380b5','testName_256','******',1,'2017-09-06 15:48:12','测试描述_256',NULL),('f8f5189c8e744d7c9333f94a199746db','testName_73','******',1,'2017-09-06 15:48:11','测试描述_73',NULL),('f9638510b99745269472db4196559876','testName_893','******',1,'2017-09-06 15:48:16','测试描述_893',NULL),('f9bdc1d6c2f94fbda26ba53bc3cbdd0a','testName_347','******',1,'2017-09-06 15:48:13','测试描述_347',NULL),('f9d2080cdca84fed87dd70433bd3623c','testName_457','******',1,'2017-09-06 15:48:14','测试描述_457',NULL),('fa0c51b6d6fe494d9cdd7e61d0af51f8','testName_546','******',1,'2017-09-06 15:48:14','测试描述_546',NULL),('faeb415acf5842128308648f4e2814c0','testName_714','******',1,'2017-09-06 15:48:15','测试描述_714',NULL),('fc332ff1fe0544eb8a492cfeefc7d2ec','testName_751','******',1,'2017-09-06 15:48:15','测试描述_751',NULL),('fc7451ba78f748b48dc73d7e0937ad9f','testName_657','******',1,'2017-09-06 15:48:15','测试描述_657',NULL),('fca1a843b7a64342a413d35690e973c8','testName_430','******',1,'2017-09-06 15:48:13','测试描述_430',NULL),('fcac9a7e6ca04c2eb1d2c4ceffad614a','testName_142','******',1,'2017-09-06 15:48:11','测试描述_142',NULL),('fccd33564df9456b94639ad1969d1123','testName_154','******',1,'2017-09-06 15:48:12','测试描述_154',NULL),('fcdd6c2496244e48a93220a150873165','testName_647','******',1,'2017-09-06 15:48:15','测试描述_647',NULL),('fd06578a07c9428ba70eb79c38738093','testName_294','******',1,'2017-09-06 15:48:12','测试描述_294',NULL),('fdd9eb433790427fa8deebd0eb382610','testName_40','******',1,'2017-09-06 15:48:11','测试描述_40',NULL),('fe417ea21e5a455ab4721e00e754e506','testName_446','******',1,'2017-09-06 15:48:13','测试描述_446',NULL),('fe866727396048a185651eabe484f906','testName_571','******',1,'2017-09-06 15:48:14','测试描述_571',NULL),('ff341b869acc4055a2c8babca2025dd9','testName_870','******',1,'2017-09-06 15:48:16','测试描述_870',NULL),('ff64888a2d6f48d08af1a4f637d89536','testName_160','******',1,'2017-09-06 15:48:12','测试描述_160',NULL),('ffab345a0a1346ed8fb54646c4e44731','testName_171','******',1,'2017-09-06 15:48:12','测试描述_171',NULL);

/*Table structure for table `sys_user_role` */

DROP TABLE IF EXISTS `sys_user_role`;

CREATE TABLE `sys_user_role` (
  `Id` varchar(50) NOT NULL COMMENT '主键',
  `userId` varchar(50) NOT NULL COMMENT '用户主键',
  `roleId` varchar(50) NOT NULL COMMENT '角色主键',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色关联表';

/*Data for the table `sys_user_role` */

insert  into `sys_user_role`(`Id`,`userId`,`roleId`) values ('0261934e9bd141a3997cde8a369d17c0','d6ab2c79e48f4bf6a6069287791af323','92f98a94217d44c59cbac9e03bcdd20e'),('0d5b38ea265842f793e7b5ebb875d0a5','d6ab2c79e48f4bf6a6069287791af323','1'),('0fd8b7a240474a418e58d3854b9e59e3','4ade94dd62934d628ddc7d45b66d55c4','ADMIN'),('16d50741483e48718a697686631d1988','343833ee79c24f9d98ad418d122ceb5f','92f98a94217d44c59cbac9e03bcdd20e'),('2844b36a3b29406485db7f1254377592','2a7aaf1666b14cca86e24cf626593810','6b42c7888f9146b6ac1c42f20b6d9291'),('2f7bce66d5d54880859f5623fcf5fade','205204b075154118ba277f985aa08fb0','ADMIN'),('40e5ba03ca26461bb95cf4af0b4644a1','343833ee79c24f9d98ad418d122ceb5f','2'),('427c34ae12ab4e13a915a030e7b0cf59','e59de2b1a85d4da49bbbd279e0fdd0d9','2a9b728a431246b08f853c2529e6ba84'),('50b5cee72f2343088df41e0f7ee3f40b','343833ee79c24f9d98ad418d122ceb5f','1'),('572b0803c0bd48f4bf411edcd0a40b8e','2ae22a35c54b40919b8c184481e5ef0e','1'),('5b15a0bdf57e4b73bcdb71c3197788e7','04edd768eb284300b5b915d63ec00af3','1'),('5ecf8eb0d77a43cebbb29585bfbaac9d','d6ab2c79e48f4bf6a6069287791af323','2'),('69cc5fcbd4654edcbbf7ec3329c8792f','19c697228b0343e4a389d09716d3a058','ADMIN'),('7a6959dcfd704c33a5b067d98da52b0b','4ade94dd62934d628ddc7d45b66d55c4','1'),('7c70231e6e404247b50b1157c4a145ac','3676a68b7bf64f95b946c2af6a981e64','1'),('86b90a3fea904a949f5de507d7fb76de','2a7aaf1666b14cca86e24cf626593810','3'),('86dcf6e628234dc5aa906bbe43870893','2a7aaf1666b14cca86e24cf626593810','53eb8bf62c0744c9ac19d9b6e81b050f'),('9086edaf07c049d392d36d2d64f252a5','6f55f7da158d4afeb68759d9a6cec9cc','2'),('91bacf96aba848d091ecc602eebdd2fe','5a64528a76b74f2ab323c85a710cabe5','2'),('946ab32702c244be95a40630c0210d43','343833ee79c24f9d98ad418d122ceb5f','ec611cf6564040e597337729b63ba07a'),('99b87df65a2f46b9a7145e6fb8187f5a','343833ee79c24f9d98ad418d122ceb5f','6403131026164e8eaa5579b87d5f8f31'),('99e129f39c764d3b8ce59ed164db0548','3676a68b7bf64f95b946c2af6a981e64','2'),('b85e7031b6cd4ba894160aa0bb54c561','04edd768eb284300b5b915d63ec00af3','2'),('b960e56427cd4434bfee452c88c16ad6','5a64528a76b74f2ab323c85a710cabe5','1'),('c47b2a2853e145c2877c0db2a375c480','19c697228b0343e4a389d09716d3a058','2a9b728a431246b08f853c2529e6ba84'),('cc05c0823c7c43a4b133e5675d9c15a4','6f55f7da158d4afeb68759d9a6cec9cc','1'),('cf7007b8d92947a988551856a8a5fce7','4ade94dd62934d628ddc7d45b66d55c4','2a9b728a431246b08f853c2529e6ba84'),('d7cff2dd73174f2a9aa2753045418117','343833ee79c24f9d98ad418d122ceb5f','ADMIN'),('e72b3a78db7140bf8a6785d11e386ded','4ade94dd62934d628ddc7d45b66d55c4','2'),('f15801f646824ae096a1832f53b78020','2a7aaf1666b14cca86e24cf626593810','2'),('f39a3383e07440ea8e498b0397bc3bc7','2a7aaf1666b14cca86e24cf626593810','2a9b728a431246b08f853c2529e6ba84'),('fe40e7d25ed848d1bc0d50d0d1ae7ce5','2ae22a35c54b40919b8c184481e5ef0e','2'),('fe535c93d09849efaa9a47643cbd3afa','2a7aaf1666b14cca86e24cf626593810','1');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
