create table if not exists users
(
    id       bigserial,
    username varchar(255) not null,
    email    varchar(255) not null,
    constraint pk_users primary key (id),
    constraint uk_username unique (username),
    constraint uk_email unique (email)
);

create type advisor_role as enum ('associate', 'partner', 'senior');

create table if not exists advisors
(
    user_id bigint,
    role    advisor_role not null,
    constraint pk_advisors primary key (user_id),
    constraint fk_advisors_users foreign key (user_id) references users
);

create table if not exists applicants
(
    id         bigserial,
    first_name varchar(255) not null,
    last_name  varchar(255) not null,
    ssn        integer      not null,
    constraint pk_applicants primary key (id)
);

create table if not exists addresses
(
    applicant_id bigint,
    city         varchar(255) not null,
    street       varchar(255) not null,
    number       integer      not null,
    zip          smallint     not null,
    apt          integer      not null,
    constraint pk_addresses primary key (applicant_id),
    constraint fk_addresses foreign key (applicant_id) references applicants
);

create type phone_type as enum ('home', 'work', 'mobile');

create table if not exists phone_numbers
(
    applicant_id bigint,
    type         phone_type   not null,
    number       varchar(100) not null,
    constraint pk_phone_numbers primary key (applicant_id),
    constraint fk_phone_numbers_applicants foreign key (applicant_id) references applicants
);

create type application_status as enum ('new', 'assigned', 'on_hold', 'approved', 'canceled', 'declined');

create table if not exists applications
(
    id           bigserial,
    applicant_id bigint             not null,
    advisor_id   bigint,
    amount       numeric            not null default 0,
    status       application_status not null default 'new',
    created_at   timestamp          not null default now(),
    assigned_at  timestamp          not null,
    constraint pk_applications primary key (id),
    constraint fk_applications_applicants foreign key (applicant_id) references applicants,
    constraint fk_applications_advisors foreign key (advisor_id) references advisors,
    constraint ak_applications_advisor_id check (case when status = 'assigned' then advisor_id is not null end)
);
