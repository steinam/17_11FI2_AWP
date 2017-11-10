
      Create database demo;
Use demo; 



create table t1(
id integer,
a integer,
b integer
) engine = innodb;


alter table t1
	rename t2;

alter table t2
	modify a tinyint,
	change b c char(20);



alter table t2
	add column d timestamp;


alter table t2
	add index(d),
	add primary key(a);


alter table t2 
	drop c;


ALTER TABLE t2 ADD c INT UNSIGNED NOT NULL AUTO_INCREMENT,
           ADD INDEX (c);







