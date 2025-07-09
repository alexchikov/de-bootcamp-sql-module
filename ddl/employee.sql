create sequence employee_employee_id_seq
    as integer;


create table company
(
    company_id     integer not null
        primary key,
    company_name   varchar(127),
    company_rating integer
);

INSERT INTO public.company (company_id, company_name, company_rating) VALUES (1, 'Iron Electronics', 4);
INSERT INTO public.company (company_id, company_name, company_rating) VALUES (2, 'Tundra Intelligence', 2);
INSERT INTO public.company (company_id, company_name, company_rating) VALUES (3, 'Granite Co.', 5);
INSERT INTO public.company (company_id, company_name, company_rating) VALUES (4, 'Saplimited', 3);
INSERT INTO public.company (company_id, company_name, company_rating) VALUES (5, 'Squidustries', 1);
INSERT INTO public.company (company_id, company_name, company_rating) VALUES (6, 'Pearlightning', 5);
INSERT INTO public.company (company_id, company_name, company_rating) VALUES (7, 'Microlutions', 5);
INSERT INTO public.company (company_id, company_name, company_rating) VALUES (8, 'Accentwood', 4);
INSERT INTO public.company (company_id, company_name, company_rating) VALUES (9, 'Alpinestones', 4);
INSERT INTO public.company (company_id, company_name, company_rating) VALUES (10, 'Joyaid', 2);


create table city
(
    city_id      integer not null
        primary key,
    city_name    varchar(255),
    country_name varchar(255)
);


create table employee
(
    employee_id      integer not null
        primary key,
    employee_name    varchar(64),
    employee_surname varchar(64),
    city_id          integer
        constraint employee_city_city_id_fk
            references city,
    salary           integer,
    manager_id       integer,
    company_id       integer
        constraint employee_company_company_id_fk
            references company,
    created_at       timestamp,
    updated_at       timestamp,
    email            varchar(127),
    gender           boolean,
    occupation       varchar(127)
);


alter sequence employee_employee_id_seq owned by employee.employee_id;

