CREATE SCHEMA reporting;
CREATE TABLE reporting.best_block_server (
id bigserial primary key,
server_name text not null,
server_group text,
best_block bigint not null,
version bigint not null,
created timestamptz default now() not null
);
GRANT SELECT ON reporting.outlinks_day TO redash;