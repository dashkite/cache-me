class Cache
  
  @expired: ( t ) -> t <= Date.now()
  
  @expires: ( ttl ) -> Date.now() + ttl
  
  @create: ( ttl, getter ) ->
    Object.assign ( new @ ), { ttl, getter, cache: {} }
  
  refresh: ( key ) ->
    data = await @getter key
    expiration = Cache.expires @ttl
    @cache[ key ] = { data, expiration }
    data

  has: ( key ) -> @cache[ key ]?

  expired: ( key ) -> 
    if @has key
      Cache.expired @cache[ key ].expiration
    else
      true

  valid: ( key ) ->
    ( @has key ) && !( @expired key )

  get: ( key ) ->
    if @valid key
      @cache[ key ].data
    else
      @refresh key

cached = ( ttl, getter ) ->
  do ({ cache } = {}) ->
    cache = Cache.create ttl, getter   
    ( key ) -> cache.get key

export { Cache, cached }