import assert from "@dashkite/assert"
import {test, success} from "@dashkite/amen"
import print from "@dashkite/amen-console"

import * as Time from "@dashkite/joy/time"

import { Cache } from "../src"

do ->

  print await test "Cache Me", await do ->

    x = 0

    do ->
      while x++ < 3
        await Time.sleep 1000

    getter = -> x

    cache = Cache.create 2000, getter
  
    [

      await test "get initial value", ->
        assert.equal 1, await cache.get "x"

      await test "get cached value", ->
        await Time.sleep 1000
        assert.equal 1, await cache.get "x"

      await test "get refreshed value", ->
        await Time.sleep 1000
        assert.equal 3, await cache.get "x"

    ]

  process.exit if success then 0 else 1
