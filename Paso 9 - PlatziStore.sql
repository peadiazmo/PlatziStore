/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     06/03/2017 04:27:09 p.m.                     */
/*==============================================================*/


drop table if exists CARRITO;

drop table if exists CARRITO_ITEM;

drop table if exists CLIENTE;

drop table if exists ITEM;

drop table if exists ITEM_PROVEEDOR;

drop table if exists MCOMPRA;

drop table if exists MPAGO;

drop table if exists PROVEEDOR;

/*==============================================================*/
/* Table: CARRITO                                               */
/*==============================================================*/
create table CARRITO
(
   CARRITO_ID           int not null auto_increment,
   CLLIENTE_ID          int not null,
   CLIENTE_CUENTAPLATZI varchar(60) not null,
   MPAGO_ID             int not null,
   MCOMPRA_ID           int not null,
   MCOMPRA_COD          numeric(15,0) not null,
   CARRITO_NUMITEM      numeric(3,0) not null,
   CARRITO_DIR          varchar(120),
   CARRITO_COMENT       varchar(300),
   CARRITO_TAG          varchar(100),
   primary key (CARRITO_ID)
);

/*==============================================================*/
/* Table: CARRITO_ITEM                                          */
/*==============================================================*/
create table CARRITO_ITEM
(
   ITEM_ID              int not null,
   CARRITO_ID           int not null,
   CANTIDAD             numeric(3,0) not null,
   primary key (ITEM_ID, CARRITO_ID)
);

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE
(
   CLLIENTE_ID          int(10) not null auto_increment,
   CLIENTE_CUENTAPLATZI varchar(60) not null,
   CLIENTE_NOMBRE       varchar(80) not null,
   CLIENTE_FECHAINI     timestamp not null,
   CLIENTE_CORREO       varchar(60),
   CLIENTE_FECHANAC     timestamp,
   CLIENTE_PREFERENCIAS varchar(300),
   primary key (CLLIENTE_ID, CLIENTE_CUENTAPLATZI)
);

/*==============================================================*/
/* Table: ITEM                                                  */
/*==============================================================*/
create table ITEM
(
   ITEM_ID              int not null auto_increment,
   ITEM_NOMBRE          varchar(60) not null,
   ITEM_DESC            varchar(300) not null,
   ITEM_MEDIDAS         varchar(60) not null,
   ITEM_PESO            varchar(15) not null,
   ITEM_FOTO            longblob,
   primary key (ITEM_ID)
);

/*==============================================================*/
/* Table: ITEM_PROVEEDOR                                        */
/*==============================================================*/
create table ITEM_PROVEEDOR
(
   PROV_ID              numeric(5,0) not null,
   PROV_CODCC           varchar(15) not null comment 'Codigo Camara de Comercio',
   ITEM_ID              int not null,
   LOTE                 varchar(10) not null,
   primary key (PROV_ID, PROV_CODCC, ITEM_ID)
);

/*==============================================================*/
/* Table: MCOMPRA                                               */
/*==============================================================*/
create table MCOMPRA
(
   MCOMPRA_ID           int not null auto_increment,
   MCOMPRA_COD          numeric(15,0) not null,
   MCOMPRA_METODO       varchar(250) not null,
   MCOMPRA_FECHAINI     timestamp not null,
   MCOMPRA_DIR          varchar(120),
   primary key (MCOMPRA_ID, MCOMPRA_COD)
);

/*==============================================================*/
/* Table: MPAGO                                                 */
/*==============================================================*/
create table MPAGO
(
   MPAGO_ID             int not null auto_increment,
   MPAGO_TIPO           varchar(250) not null,
   MPAGO_CODPASARELA    varchar(15) not null,
   MPAGO_STATUS         varchar(10) not null,
   MPAGO_FECHAEXPIRA    timestamp not null,
   primary key (MPAGO_ID)
);

/*==============================================================*/
/* Table: PROVEEDOR                                             */
/*==============================================================*/
create table PROVEEDOR
(
   PROV_ID              numeric(5,0) not null,
   PROV_CODCC           varchar(15) not null comment 'Codigo Camara de Comercio',
   PROV_NOMBRE          varchar(90) not null,
   PROV_DESC            varchar(300) not null,
   PROV_FECHAINI        timestamp not null,
   PROV_FECHAUCOMPRA    timestamp,
   PROV_MONTOUCOMPRA    numeric(7,0),
   PROV_MONEDA          varchar(5),
   primary key (PROV_ID, PROV_CODCC)
);

alter table CARRITO add constraint FK_CARRITO_CLIENTE foreign key (CLLIENTE_ID, CLIENTE_CUENTAPLATZI)
      references CLIENTE (CLLIENTE_ID, CLIENTE_CUENTAPLATZI) on delete restrict on update restrict;

alter table CARRITO add constraint FK_CARRITO_MCOMPRA foreign key (MCOMPRA_ID, MCOMPRA_COD)
      references MCOMPRA (MCOMPRA_ID, MCOMPRA_COD) on delete restrict on update restrict;

alter table CARRITO add constraint FK_MPAGO_CARRITO foreign key (MPAGO_ID)
      references MPAGO (MPAGO_ID) on delete restrict on update restrict;

alter table CARRITO_ITEM add constraint FK_CARRITO_ITEM foreign key (ITEM_ID)
      references ITEM (ITEM_ID) on delete restrict on update restrict;

alter table CARRITO_ITEM add constraint FK_CARRITO_ITEM2 foreign key (CARRITO_ID)
      references CARRITO (CARRITO_ID) on delete restrict on update restrict;

alter table ITEM_PROVEEDOR add constraint FK_ITEM_PROVEEDOR foreign key (PROV_ID, PROV_CODCC)
      references PROVEEDOR (PROV_ID, PROV_CODCC) on delete restrict on update restrict;

alter table ITEM_PROVEEDOR add constraint FK_ITEM_PROVEEDOR2 foreign key (ITEM_ID)
      references ITEM (ITEM_ID) on delete restrict on update restrict;

