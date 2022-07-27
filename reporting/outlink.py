import os
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
os.environ('MATAMO_TOKEN')
request_date = '2022-06-22'
url = "https://analytics.emurgo-rnd.com/";
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
	INSERT INTO outlinks (label, nb_visits, 
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