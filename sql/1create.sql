-- create database okr;
-- use okr;
-- create user 'gordon'@'localhost' identified by 'gordon';
-- grant all privileges on modus.* to gordon@localhost;
-- grant super on *.* to gordon@localhost;
-- grant file on *.* to gordon@localhost;
-- flush privileges;

drop table quarter;

create table quarter (
  id          integer not null auto_increment,
  year        smallint not null,
  quarter     smallint not null,
  archived    boolean,
  primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

drop table team;

create table team (
  id               integer not null auto_increment,
  name             varchar(100) not null,
  shortCode        varchar(10)  not null,
  techLead         varchar(100),
  organisation     integer,
  archived         boolean,
  primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

drop table objective;

create table objective (
  id               integer not null auto_increment,
  name             varchar(500) not null,
  description      varchar(500),
  programmeManager varchar(100),
  engResp          varchar(100),
  productResp      varchar(100),
  uxDesResp        varchar(100),
  uxResResp        varchar(100),
  biResp           varchar(100),
  objectiveType    varchar(100),
  engineers        varchar(2000),
  organisation     integer,
  docLink          varchar(200),
  archived         boolean,
  primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

drop table keyResult;

create table keyResult (
  id              integer not null auto_increment,
  quarter         integer      not null,
  objective       integer      not null, 
  name            varchar(500) not null,
  krType          varchar(100),
  companyGoal     varchar(100),
  committed       boolean default true,  
  jiraKR          varchar(500),
  risks           varchar(2000),
  docLink         varchar(200),
  archived        boolean,
  primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- need to add FKs to quarter and objective

drop table keyResultUpdate;

create table keyResultUpdate (
  id                integer not null auto_increment,
  keyResult         integer not null,
  updateDate        date not null,
  rag               varchar(100),
  completionHorizon integer,
  status            varchar(100),
  commentary        varchar(2000),
  archived          boolean,
  primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

alter table keyResultUpdate
add index kru_kr_idx (keyResult);

drop table deliverable;

create table deliverable (
  id               integer      not null auto_increment,
  keyResult        integer      not null,
  name             varchar(500) not null,
  description      varchar(2000),
  jiraRoadmapItem  varchar(200),
  team             integer,
  priority         integer,
  archived         boolean,
  statusChangeDate date,
  primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

alter table deliverable
add index d_kr_idx (keyResult);

alter table deliverable
add index d_t_idx (team);

drop table deliverableUpdate;

create table deliverableUpdate (
  id                integer not null auto_increment,
  deliverable       integer not null,
  updateDate        date    not null,
  status            varchar(100),
  commentary        varchar(750),
  archived          boolean,
  countryFlag       boolean,
  teamFlag          boolean,
  deliveryDate      date,
  primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- need to add FK to deliverable

alter table deliverableUpdate
add index du_del_idx (deliverable);

drop table organisation;

create table organisation (
  id   integer not null auto_increment,
  name varchar(100),
  primary key (id),
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

drop table role;

create table role (
  id   integer not null auto_increment,
  name varchar(100),
  primary key (id),
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

drop table user;

create table user (
  id                integer not null auto_increment,
  name              varchar(100) not null,
  givenName         varchar(100) not null,
  surname           varchar(100) not null,
  email             varchar(100) not null,
  organisation      integer,
  team              integer,
  role              integer,
  token             varchar(200),
  tokenExp          date,
  lastVersionUpdate integer,
  staffNumber       varchar(100),
  primary key (id),
  unique (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table versionUpdate (
  id          integer       not null,
  name        varchar(200)  not null,
  description varchar(5000) not null,
  releaseDate date,
  primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table userWeekKeyResult (
  id             integer,
  weekCommencing date,
  quarter        integer,
  user           integer,
  team           integer,
  keyResult      integer,
  primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table jira (
  id             varchar(100),
  project        varchar(100),
  keyResult      varchar(100),
  assignee       varchar(100),
  implementedBy  varchar(100),
  resolutionDate date,
  status         varchar(100),
  primary        key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;