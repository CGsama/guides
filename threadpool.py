import threading
import time
import random

def runPool(data, func, pool_size = 10):
        def foo(vals, x, data):
                time.sleep(random.random())
                result = func(data)
                vals[x] = result
                
        pool = [None] * pool_size
        pool = list(map(lambda x : threading.Thread(), pool))
        results = [None] * len(data)
        for i in range(0, len(data)):
                flag = False
                try:
                        while True:
                                for j in range(0, len(pool)):
                                        if not pool[j].is_alive():
                                                print("adding " + str(data[i]) + " to " + str(j))
                                                pool[j] = threading.Thread(target=foo,args=(results, i, data[i]))
                                                pool[j].start()
                                                print(pool[j].is_alive())
                                                flag = True
                                                raise StopIteration
                except StopIteration: pass
        for w in pool:
                if w.is_alive():
                        w.join()
        return results
      
print(runPool(range(0,100), lambda x : x * 10))
