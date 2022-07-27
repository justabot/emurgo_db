import requests
import psycopg2
import pgpasslib
from psycopg2.extras import RealDictCursor

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
cur = conn.cursor(cursor_factory=RealDictCursor)
os.environ('MATOMO_TOKEN')
request_date = '2022-06-22'
url = "https://analytics.emurgo-rnd.com/";
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