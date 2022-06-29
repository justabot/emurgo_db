import requests
import random
import psycopg2
import pgpasslib
from psycopg2.extras import RealDictCursor

passw = pgpasslib.getpass('localhost',
  5432,
  'fibo',
  'yy'
  )
conn = psycopg2.connect(
  host='localhost',
  user='yy',
  dbname='fibo',
  password=passw,
  port=5432,
  connect_timeout=500)
cur = conn.cursor(cursor_factory=RealDictCursor)
words_cmd = """SELECT word FROM words"""
cur.execute(words_cmd)
word_dict = cur.fetchall()
conn.commit()
WORDS = [row["word"] for row in word_dict]
# word_site = "https://www.mit.edu/~ecprice/wordlist.10000"
# response = requests.get(word_site)
# WORDS = response.content.splitlines()
counter = 1
print('loading values...')
while counter < 1000000000:
	author = random.choice(WORDS) + ' ' + random.choice(WORDS) + ' ' + random.choice(WORDS)
	author_cmd = """
	INSERT INTO user_profile (profile_id, wallet_pub_key_hex , 
	wallet_id , created_at , updated_at  )
	SELECT '%(i)s', '%(w)s', '%(d)s', 6666666, 777777;
	""" % {"i": author, "w": author, "d": author}
	cur.execute(author_cmd)
	conn.commit()
	nft = random.choice(WORDS) + ' ' + random.choice(WORDS) + ' ' + random.choice(WORDS)
	nft_cmd = """
	INSERT INTO nft(fingerprint , image_cid , policy_id , asset_name , description , 
		author , tx_hash , mime_type , created_at , updated_at, image_id , name)
	SELECT '%(f)s','%(f)s','%(f)s','%(f)s','%(f)s','%(a)s','%(f)s','%(f)s',
	       66666,77777,'%(f)s','%(f)s';
	""" % {"f": nft, "a": author}
	cur.execute(nft_cmd)
	conn.commit() 
	collection = random.choice(WORDS) + ' ' + random.choice(WORDS) + ' ' + random.choice(WORDS)
	collection_cmd = """
	INSERT INTO collection (owner , name , locking_days , created_at , updated_at) 
	SELECT '%(o)s', '%(n)s', '55', 5555, 6666;
	""" % {"o": author, "n": collection}
	cur.execute(collection_cmd)
	conn.commit() 
	counter += 1