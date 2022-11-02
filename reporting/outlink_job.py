import os
import requests
import psycopg2
import pgpasslib
from datetime import datetime, timedelta, date
from psycopg2.extras import RealDictCursor

passw = pgpasslib.getpass('localhost',
  5432,
  'emurgo_dwh',
  'dwh_jobs'
  )
conn = psycopg2.connect(
  host='localhost',
  user='dwh_jobs',
  dbname='emurgo_dwh',
  password=passw,
  port=5432,
  connect_timeout=500)
cur = conn.cursor(cursor_factory=RealDictCursor)
token_auth = '90f8af018cb3789b0c4a5be4646d0d8e'
request_date = (datetime.now() - timedelta(days=1)).date()
del_cmd = """
DELETE FROM reporting.outlinks_day WHERE outlink_date >= '%(d)s'::timestamptz;
""" % {"d": request_date}
cur.execute(del_cmd)
conn.commit()
now = datetime.now()
while request_date <= now.date():
  url = "https://xxx/";
  url += "?module=API&method=Actions.getOutlinks";
  url += "&idSite=1&period=day&date=%(d)s"% {"d": request_date};
  url += "&format=JSON&filter_limit=10";
  url += "&token_auth=%(t)s" % {"t": token_auth};
  outlink_url = "%(u)s" % {"u": url}
  outlink_res = requests.get(outlink_url)
  outlink_json = outlink_res.json()   
  for elem in outlink_json:
    print(elem)
    outlink_cmd = """
    INSERT INTO reporting.outlinks_day (label, nb_visits, 
                nb_hits, sum_time_spent, 
                idsubdatatable, outlink_date)
    SELECT '%(l)s', %(v)s, %(h)s, 
           %(s)s, %(i)s, '%(d)s';
    """ % {"l": elem['label'],
      "v": elem['nb_visits'],
      "h": elem['nb_hits'],
      "s": elem['sum_time_spent'],
      "i": elem['idsubdatatable'],
      "d": request_date}
    cur.execute(outlink_cmd)
    conn.commit()
  request_date = request_date + timedelta(days=1)
  print(request_date)
