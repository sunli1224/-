#coding:utf-8
import redis
def redis_cun(code):
    pool = redis.ConnectionPool(host='127.0.0.1', port=6379)
    r = redis.Redis(connection_pool=pool)
    pipe = r.pipeline(transaction=True)
    r.set(u'验证码', code)
    r.expire(u'验证码', 60)
    pipe.execute()

def redis_link():
    pool = redis.ConnectionPool(host='127.0.0.1', port=6379)
    r = redis.Redis(connection_pool=pool)
    code_s = r.get(u'验证码')
    return code_s