建表语句

/*==============================================================*/
/* Table: " tb_user"   1.用户信息表                             */
/*==============================================================*/
create table tb_user 
(
   userId               number(10)                       primary key, 
   userType				number(10)						  null,
   nickname             varchar2(255)                     null,
   password             varchar2(255)                     null,
   email                varchar2(255)                     null,
   departId             number(10)                        not null,
   photoUrl             varchar2(255)                     null,  
   qq                   varchar2(255)                     null,
   integral             number(10)                        null,
   phone                varchar2(255)                     null,
   accountBalance       number(6,2)    DEFAULT 0          null,
   payPassword          varchar2(255)  DEFAULT '000000'   null
);
/*==========约束==（注意要先创建城市信息表）========*/
alter table tb_user
   add constraint FK_user_depart foreign key (departId)
      references tb_departmentInfo (departId);
/*=========创建序列语句=========*/
drop sequence seq_user_userId;
create sequence seq_user_userId INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE;
/*=========插入语句=========*/
insert into tb_user values
(seq_user_userId.nextval,1,'超级管理员','admin','admin',1,'','442454568',0,'15110415932',default,default);
select * from tb_user ;
drop table tb_user; 
update  tb_user set userType=2 where userId=2;
delete from tb_user ;

/*==============================================================*/
/* Table: "tb_cityInfo"  2.城市信息表                           */
/*==============================================================*/
create table tb_cityInfo 
(
   cityId               number(10)                      primary key,
   cityName             varchar2(255)                   null	  
);
/*=========创建序列语句=========*/
drop sequence seq_cityInfo_cityId;
create sequence seq_cityInfo_cityId INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE;
select * from tb_cityInfo;
drop table tb_cityInfo;
insert into tb_cityInfo values(seq_cityInfo_cityId.nextval,'全国');
insert into tb_cityInfo values(seq_cityInfo_cityId.nextval,'太原');
insert into tb_cityInfo values(seq_cityInfo_cityId.nextval,'北京');


/*==============================================================*/
/* Table: "tb_schoolInfo"  3.学校信息表                         */
/*==============================================================*/
create table tb_schoolInfo 
(
   schoolId              number(10)                       primary key,
   schoolName            varchar2(255)                    null,
   cityId		 number(10)	                  null
);
/*==========约束==（注意要先创建城市信息表）========*/
alter table tb_schoolInfo
   add constraint FK_school_city foreign key (cityId)
      references tb_cityInfo (cityId);
/*=========创建序列语句=========*/
drop sequence seq_schoolInfo_schoolId;
create sequence seq_schoolInfo_schoolId INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE;
select * from tb_schoolInfo;
drop table tb_schoolInfo;
delete from tb_schoolInfo;
insert into tb_schoolInfo values(seq_schoolInfo_schoolId.nextval,'全省',1);
insert into tb_schoolInfo values(seq_schoolInfo_schoolId.nextval,'中北大学',2);
insert into tb_schoolInfo values(seq_schoolInfo_schoolId.nextval,'山西大学',2);
insert into tb_schoolInfo values(seq_schoolInfo_schoolId.nextval,'太原理工',2);
insert into tb_schoolInfo values(seq_schoolInfo_schoolId.nextval,'北京大学',3);
insert into tb_schoolInfo values(seq_schoolInfo_schoolId.nextval,'清华大学',3);
insert into tb_schoolInfo values(seq_schoolInfo_schoolId.nextval,'北京理工大学',3);




/*==============================================================*/
/* Table: "tb_departmentInfo"  4.院系信息表                     */
/*==============================================================*/
create table tb_departmentInfo 
(
   departId                 number(10)                primary key,
   facultyName              varchar2(255)             null,
   schoolId                 number(10)                null
);
/*==========约束==（注意要先创建学校信息表）========*/
alter table tb_departmentInfo
   add constraint FK_depart_school foreign key (schoolId)
      references tb_schoolInfo (schoolId);
/*=========创建序列语句=========*/
drop  sequence seq_departInfo_departId;     
create sequence seq_departInfo_departId INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE;
select * from tb_departmentInfo;
drop table tb_departmentInfo;
insert into tb_departmentInfo values(seq_departInfo_departId.nextval,'全校',1);
insert into tb_departmentInfo values(seq_departInfo_departId.nextval,'软件学院',2);
insert into tb_departmentInfo values(seq_departInfo_departId.nextval,'机电工程学院',2);
insert into tb_departmentInfo values(seq_departInfo_departId.nextval,'计算机学院',3);
insert into tb_departmentInfo values(seq_departInfo_departId.nextval,'艺术学院',3);
insert into tb_departmentInfo values(seq_departInfo_departId.nextval,'经济管理学院',4);
insert into tb_departmentInfo values(seq_departInfo_departId.nextval,'体育学院',5);
insert into tb_departmentInfo values(seq_departInfo_departId.nextval,'机械自动化学院',6);
insert into tb_departmentInfo values(seq_departInfo_departId.nextval,'理学院',7);


/*==============================================================*/
/* Table: "tb_goodsClass"  5.商品分类表                   */
/*==============================================================*/
create table tb_goodsClass 
(
   classId              number(10)                       primary key,
   className            varchar2(255)                    null
);
/*=========创建序列语句=========*/
drop sequence seq_goodsClass_classId;
create sequence seq_goodsClass_classId INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE;
/*=========插入语句=========*/
delete from tb_goodsClass where className='校园代步';
select * from tb_goodsClass;
drop table tb_goodsClass;

insert into tb_goodsClass values(seq_goodsClass_classId.nextval,'校园代步'); 
insert into tb_goodsClass values(seq_goodsClass_classId.nextval,'生活用品'); 
insert into tb_goodsClass values(seq_goodsClass_classId.nextval,'手机'); 
insert into tb_goodsClass values(seq_goodsClass_classId.nextval,'电脑|硬件|软件'); 
insert into tb_goodsClass values(seq_goodsClass_classId.nextval,'数码产品'); 
insert into tb_goodsClass values(seq_goodsClass_classId.nextval,'运动健身|文体用品'); 
insert into tb_goodsClass values(seq_goodsClass_classId.nextval,'门票|卡券'); 
insert into tb_goodsClass values(seq_goodsClass_classId.nextval,'衣物伞帽'); 
insert into tb_goodsClass values(seq_goodsClass_classId.nextval,'图书教材'); 
insert into tb_goodsClass values(seq_goodsClass_classId.nextval,'租赁'); 
insert into tb_goodsClass values(seq_goodsClass_classId.nextval,'其他'); 


/*==============================================================*/
/* Table: "tb_suggestion"  6.网站建议及意见表                   */
/*==============================================================*/
create table tb_suggestion 
(
   suggId                number(10)                           primary key,
   content               varchar2(255)                        null,
   pubDate               varchar2(255)                        null
);
/*=========创建序列语句=========*/
drop sequence seq_sugg_suggId;
create sequence seq_sugg_suggId INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE;
select * from tb_suggestion;
drop table tb_suggestion;



/*==============================================================*/
/* Table: "tb_goodsZr"  7.商品转让信息表                     */
/*==============================================================*/
//仅限同校0，仅限同校或同城1，可以邮寄2。
create table tb_goodsZr 
(
   goodsZrId             number(10)                 primary key,
   goodsName             varchar2(255)                null,
   goodsPic              varchar2(2000)               null,
   goodsMsg              varchar2(255)                null,
   newAndOld             varchar2(255)                null,
   tradeType			 number(10)					  null,
   address               varchar2(255)                null,
   price                 number(6,2)                  null,
   talkPrice             varchar2(255)                null,
   phone                 varchar2(255)                null,
   qq                    varchar2(255)                null,
   pubDate               varchar2(255)                null,
   statu                 varchar2(255)		          null,
   userId                number(10)                   null,
   classId		 		number(10)                    null,
   goodsPicOne          VARCHAR2(255) 		          null ,
   praise				number(10)                   null
)
/*==========约束==（注意要先创建用户信息表）========*/
alter table tb_goodsZr
   add constraint FK_goodsZr_user foreign key (userId)
      references tb_user (userId);
/*==========约束==（注意要先创建商品类型表）========*/
alter table tb_goodsZr
   add constraint FK_goodsZr_class foreign key (classId)
      references tb_goodsClass (classId);
/*=========创建序列语句=========*/
drop sequence seq_gZr_goodsZrId;
create sequence seq_gZr_goodsZrId INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE;
select * from tb_goodsZr;
select count(*) from tb_goodsZr where userId =4;
drop table tb_goodsZr;
delete from tb_goodsZr ;


/*==============================================================*/
/* Table: "tb_goodsQg"  8.求购信息表                          */
/*==============================================================*/
create table tb_goodsQg 
(
   goodsQgId             number(10)               primary key,
   goodsName             varchar2(255)            null,
   goodsMsg		 varchar2(255)            null,  /*新增*/
   address               varchar2(255)            null,
   price                 number(6,2)              null,
   phone                 varchar2(255)            null,
   qq                    varchar2(255)            null,
   pubDate               varchar2(255)            null,
   statu                 varchar2(255)            null,
   classId		 number(10)               null,  
   userId                number(10)               null
);
/*==========约束==（注意要先创建用户信息表）========*/
alter table tb_goodsQg
   add constraint FK_goodsQg_user foreign key (userId)
      references tb_user (userId);
/*==========约束==（注意要先创建商品类型表）========*/
alter table tb_goodsQg
   add constraint FK_goodsQg_class foreign key (classId)
      references tb_goodsClass (classId);
/*=========创建序列语句=========*/
drop sequence seq_gQg_goodsQgId;
create sequence seq_gQg_goodsQgId INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE;
select * from tb_goodsQg;
drop table tb_goodsQg;
delete from tb_goodsQg;


/*==============================================================*/
/* Table: "tb_comments"  9.留言信息表                      */
/*==============================================================*/
create table tb_comments 
(
   comId                 number(10)                      primary key,
   content               varchar2(500)                   null,
   cdate                 varchar2(20)                    null,
   userId                number(10)                      null,
   toUserId				number(10)                       null,
   goodsZrId		    number(10)						 null,
   ctype				number(10)						 null,
   revertSta			number(10)						 null,
   autoType				number(10)						 null,
   oldComId				number(10)						 null
);
/*==========约束==（注意要先创建用户信息表）========*/
alter table tb_comments
   add constraint FK_comments_user foreign key (userId)
      references tb_user (userId);
alter table tb_comments
   add constraint FK_comments_userTo foreign key (toUserId)
      references tb_user (userId);
/*==========约束==（注意要先创建转让信息表）========*/
alter table tb_comments
   add constraint FK_comments_goosZr foreign key (goodsZrId)
      references tb_goodsZr (goodsZrId);
/*=========创建序列语句=========*/
drop sequence seq_com_comId;
create sequence seq_com_comId INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE;
select * from tb_comments;
drop table tb_comments;
delete from tb_comments;




/*==============================================================*/
/* Table: "tb_cart"  10.购物车信息表                              */
/*==============================================================*/
create table tb_cart 
(
   cartId                number(10)                  primary key,
   goodsZrId             number(10)                  null,
   userId                number(10)                  null,
   goodsPicOne          VARCHAR2(255) 		     null 
   
)
/*==========约束==（注意要先创建用户信息表）========*/
alter table tb_cart
   add constraint FK_cart_user foreign key (userId)
      references tb_user (userId);
/*==========约束==（注意要先创建转让信息表）========*/
alter table tb_cart
   add constraint FK_cart_goosZr foreign key (goodsZrId)
      references tb_goodsZr (goodsZrId);
/*=========创建序列语句=========*/
drop sequence seq_cart_cartId;
create sequence seq_cart_cartId INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE;
delete from   tb_cart;
select * from tb_cart;
drop table tb_cart;



/*==============================================================*/
/* Table: "tb_orderInfo"  11.订单信息表                         */
/*==============================================================*/
create table tb_orderInfo 
(
   orderId               number(10)                       primary key,
   goodsZrId             number(10)                       null,
   statu                 varchar2(255)                    null,
   pubDate		 varchar2(255) 			            null,
   evaluate	     varchar2(255)					    null,
   userId		 number(10)                         null,
   goodsPicOne		 VARCHAR2(500)                  null,
   buyStatu			number(10)						null,
   saleStatu		number(10)						null
);
/*==========约束==（注意要先创建用户信息表）========*/
alter table tb_orderInfo
   add constraint FK_order_user foreign key (userId)
      references tb_user (userId);
/*==========约束==（注意要先创建转让信息表）========*/
alter table tb_orderInfo
   add constraint FK_order_goosZr foreign key (goodsZrId)
      references tb_goodsZr (goodsZrId);
/*=========创建序列语句=========*/
drop sequence seq_orInfo_orderId;
create sequence seq_orInfo_orderId INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE;
update tb_orderInfo set saleStatu=0 where orderId=2;
select * from tb_orderInfo where buyStatu=0 and statu='0' and userId = 5;
select * from tb_orderInfo where buyStatu=0 and statu='0';
drop table tb_orderInfo;
delete from tb_orderInfo;


/*==============================================================*/
/* Table: "tb_rule"  12.积分规则表                         */
/*==============================================================*/
create table tb_rule 
(
   ruleId                  number(10)                      primary key,
   ruleName			       varchar2(255)             	   null,
   ruleValue               varchar2(255)             	   null,
   validTime		       varchar2(255) 			       null
);
/*=========创建序列语句=========*/
drop sequence seq_rule_ruleId;
create sequence seq_rule_ruleId INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE;
select * from tb_rule;
drop table tb_rule;
insert into tb_rule values(seq_rule_ruleId.nextval,'用户注册','+20','第一次有效');
insert into tb_rule values(seq_rule_ruleId.nextval,'发布转让商品','+20','每次生效');
insert into tb_rule values(seq_rule_ruleId.nextval,'发布求购商品','+10','每次生效');
insert into tb_rule values(seq_rule_ruleId.nextval,'购买商品','+10','每次生效');
insert into tb_rule values(seq_rule_ruleId.nextval,'售出商品','+10','每次生效');
insert into tb_rule values(seq_rule_ruleId.nextval,'评价商品','+5','每次生效');
insert into tb_rule values(seq_rule_ruleId.nextval,'加购物车','+2','每次生效');
insert into tb_rule values(seq_rule_ruleId.nextval,'删除发布的转让商品','-5','每次生效');
insert into tb_rule values(seq_rule_ruleId.nextval,'删除发布的求购商品','-3','每次生效');
insert into tb_rule values(seq_rule_ruleId.nextval,'删除购物车商品','-2','每次生效');
insert into tb_rule values(seq_rule_ruleId.nextval,'留言及回复','+2','每次生效');
insert into tb_rule values(seq_rule_ruleId.nextval,'删除留言及回复','-2','每次生效');

/*==============================================================*/
/* Table: "tb_integration"  13.积分明细表                         */
/*==============================================================*/
create table tb_integration 
(
   integraId               number(10)                      primary key,
   integraDate		       varchar2(255) 			       null,
   ruleId				   number(10)                      null,
   userId		           number(10)                      null
);
/*==========约束==（注意要先创建用户信息表）========*/
alter table tb_integration
   add constraint FK_integration_user foreign key (userId)
      references tb_user (userId);
/*==========约束==（注意要先创建积分规则表）========*/
alter table tb_integration
   add constraint FK_integration_rule foreign key (ruleId)
      references tb_rule(ruleId);
/*=========创建序列语句=========*/
drop sequence seq_integration_integraId;
create sequence seq_integration_integraId INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE;
select * from tb_integration;
drop table tb_integration;
delete from tb_integration;
insert into tb_integration values(seq_integration_integraId.nextval,'2016-5-26',1,2);
---------------------------------------------------------------------------------------------------------------
