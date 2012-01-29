_ = require "underscore"

Schema = require './Schema.coffee'
Collection = require './Collection.coffee'
Record = require './Record.coffee'

class Resource
  constructor: ->
    @uid = 1
    @store = []
    @schema = {}
    @schema.id =
      key: true
      unique: true
      required: true
      default: =>
        @uid++
  update: ->
  find: ->
  all: (obj) ->
    c = new Collection()
    for data in @store
      a = new Record(data, @) 
      c.push a
    c
  first: (obj) ->
    data = @store.filter((item) ->
      r = true
      for k, v of obj
        if item[k] isnt v
          r = false
          break
      r
    )[0]
    if data isnt undefined
      b = new Record data, @
    else
      null
  create: (data) -> 
    try
      d = Schema.check data, @schema, @store
      @store.push d
      d.id
    catch e
      console.error e
      
# DSL wrapper for create resources
module.exports = (f) ->
  try
    a = f.call
      self: new Resource
      schema: {}
      text: {}
      property: (name, type, descriptor = {}) ->
        d = _.defaults descriptor, type
        if Schema.validate(name,d,@self.schema)
          @self.schema[name] = d
        @
      name: (name) ->
        @name = name
        @
      has: (num, resource) ->
        #@self.schema[resource] = new G.Orm.Association num, resource, @self
        @
      belongs_to: (table) ->
        @self.schema[table+"_id"] = ''
        @
    r = a.self
    #G.Orm.Mediator[a.name] = r
    r
  catch e
    console.error e
  r

