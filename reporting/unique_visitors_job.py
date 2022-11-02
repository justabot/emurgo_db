import requests
import psycopg2
import pgpasslib
from datetime import datetime, timedelta
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
request_date = datetime.now()
site_id = 1
while request_date <= datetime.now():
  url = "https://xxx";
  url += "?module=API&method=VisitsSummary.getUniqueVisitors";
  url += "&idSite=%(i)s&period=day&date=%(d)s" % {"i": site_id, "d": request_date};
  url += "&format=JSON&filter_limit=10";
  url += "&token_auth=%(t)s" % {"t": token_auth};
  uq_visitors_url = "%(u)s" % {"u": url}
  uq_visitors_res = requests.get(uq_visitors_url)
  uq_visitors_json = uq_visitors_res.json()
  print(uq_visitors_json)
  uq_visitors_cmd = """
  INSERT INTO reporting.uq_visitors (
              visit_count,
              uq_visitors_date,
              site_id)
  SELECT %(l)s, '%(d)s', %(s)s;
  """ % {"l": uq_visitors_json['value'],
  	   "d": request_date,
  	   "s": site_id}
  cur.execute(uq_visitors_cmd)
  conn.commit()
  request_date = request_date + timedelta(days=1)
