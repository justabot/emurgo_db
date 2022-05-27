import os
import sys
import psycopg2
import pgpasslib
from datetime import datetime, timedelta, timezone, date
from psycopg2.extras import RealDictCursor
from tendo import singleton

me = singleton.SingleInstance()
passw = pgpasslib.getpass('lim-01.emurgo-rnd.com',
  30043,
  'yoroi_db',
  'yoroi_usr'
  )
conn = psycopg2.connect(
  host='lim-01.emurgo-rnd.com',
  user='yoroi_usr',
  dbname='yoroi_db',
  password=passw,
  port=30043,
  connect_timeout=500)
server_passw = pgpasslib.getpass('vin-03.emurgo-rnd.com',
  30000,
  'cardano_db',
  'cardano_usr'
  )
cur = conn.cursor(cursor_factory=RealDictCursor)
servers = [
# 'waw-01.emurgo-rnd.com',
'waw-02.emurgo-rnd.com',
'waw-03.emurgo-rnd.com',
'waw-04.emurgo-rnd.com',
'rbx-01.emurgo-rnd.com',
'rbx-02.emurgo-rnd.com',
'lim-01.emurgo-rnd.com',
'lim-02.emurgo-rnd.com',
'lim-03.emurgo-rnd.com',
'lim-04.emurgo-rnd.com',
'lim-05.emurgo-rnd.com',
'lim-06.emurgo-rnd.com',
'lon-01.emurgo-rnd.com',
'lon-02.emurgo-rnd.com',
'lon-03.emurgo-rnd.com',
'lon-04.emurgo-rnd.com',
'lon-05.emurgo-rnd.com',
'lon-06.emurgo-rnd.com',
'lon-07.emurgo-rnd.com',
'gra-01.emurgo-rnd.com',
'gra-02.emurgo-rnd.com',
'sgp-01.emurgo-rnd.com',
'sgp-02.emurgo-rnd.com',
'sgp-03.emurgo-rnd.com',
'sgp-04.emurgo-rnd.com',
'sgp-05.emurgo-rnd.com',
'sgp-06.emurgo-rnd.com',
'sgp-07.emurgo-rnd.com',
'sgp-08.emurgo-rnd.com',
'sgp-09.emurgo-rnd.com',
'sgp-10.emurgo-rnd.com',
'vin-01.emurgo-rnd.com',
'vin-02.emurgo-rnd.com',
'vin-03.emurgo-rnd.com',
'vin-04.emurgo-rnd.com',
'hil-01.emurgo-rnd.com',
'hil-02.emurgo-rnd.com',
'hil-03.emurgo-rnd.com',
'hil-04.emurgo-rnd.com',
'bhs-01.emurgo-rnd.com',
'bhs-02.emurgo-rnd.com',
'bhs-03.emurgo-rnd.com',
'bhs-04.emurgo-rnd.com',
'bhs-05.emurgo-rnd.com',
'bhs-06.emurgo-rnd.com',
'stl-01.emurgo-rnd.com',
'stl-02.emurgo-rnd.com',
'stl-03.emurgo-rnd.com',
'stl-04.emurgo-rnd.com',
'stl-05.emurgo-rnd.com',
'stl-06.emurgo-rnd.com']
version_cmd = """
SELECT max(version) current_version
  FROM reporting.best_block_server"""
cur.execute(version_cmd)
version = cur.fetchone()
conn.commit()
version_int = 1
if version['current_version'] is not None:
  version_int = version['current_version']
best_insert = """
  INSERT INTO reporting.best_block_server (server_name, server_group, best_block, version) VALUES """
values = ""
for server in servers:
  server_conn = psycopg2.connect(
    host=server,
    user='cardano_usr',
    dbname='cardano_db',
    password=server_passw,
    port=30000,
    connect_timeout=500)
  server_cur = server_conn.cursor(cursor_factory=RealDictCursor)
  best_block_cmd = """
  SELECT max(block_no) block_no
    FROM block;
  """
  server_cur.execute(best_block_cmd)
  best_block = server_cur.fetchone()
  server_conn.commit()
  # print(best_block)
  values += """ ('%(j)s', '%(t)s', %(o)s, %(c)s),""" % \
    {"j": server, "t": server.split("-")[0], "o": best_block['block_no'], "c": version_int+1}
cur.execute("""%(m)s%(v)s""" % {"m": best_insert, "v": values[:-1]})        
conn.commit()

