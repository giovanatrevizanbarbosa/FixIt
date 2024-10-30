create table customer (
	id bigint(20) primary key auto_increment
   ,name varchar(50) not null
   ,email varchar(50) not null
   ,password varchar(150) not null
   ,phone varchar(20) not null
   ,cpf varchar(14) not null unique
   ,active boolean default true not null
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table service_order (
	id bigint(20) primary key auto_increment
   ,description varchar(150) not null
   ,emission_date date not null
   ,completion_date date
   ,value decimal(10, 2) not null
   ,observation varchar(150)
   ,payment_method_id int not null
   ,status varchar(50) not null
);

create table payment_method (
	id int primary key auto_increment
   ,name varchar(20) not null
);

create table address (
	id bigint(20) primary key auto_increment
   ,street varchar(150) not null
   ,number varchar(10) not null
   ,complement varchar(150) not null
   ,neighborhood varchar(150) not null
   ,cep varchar(10) not null
   ,city varchar(150) not null
   ,state varchar(150) not null
);


alter table customer add address_id bigint(20), ADD CONSTRAINT FOREIGN KEY(id) REFERENCES address(id);
alter table service_order add customer_id bigint(20), ADD CONSTRAINT FOREIGN KEY(id) REFERENCES customer(id);

