# Cache Me

*A simple caching library with TTL-based expiry and configurable getter.*

```coffeescript
import * as Time from "@dashkite/joy/time"
import { Cache } from "@dashkite/cache-me"

do ->

  # contrived example to demonstrate
  # TTL-based caching...
  x = 0

  do ->
    while x++ < 3
      await Time.sleep 1000
  
  # getter normally takes a key, but
  # we ignore it here
  getter = -> x

  # create the cache with TTL of 2 seconds
  # and our contrived getter
  cache = Cache.create 2000, getter

  assert.equal 1, await cache.get "x"

  # we still get 1 back because we're reading
  # the cached value...
  await Time.sleep 1000
  assert.equal 1, await cache.get "x"

  # by now TTL has expired so now we get current value
  await Time.sleep 1000
  assert.equal 3, await cache.get "x"

```