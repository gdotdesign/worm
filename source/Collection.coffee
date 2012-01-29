_ = require "underscore"
# Class for creating iterable collections
#
# Extends Array so the resulting object will behave like an array.

# Class init
module.exports = class Collection extends Array
  constructor: (records) ->
    # Fill the collection with records recived
    _.each records, (record) =>
      @push record
    # Dirty property
    Object.defineProperty @, 'dirty'
      get: ->
        r = false
        for record in @
          if record.dirty
            r = true
            break
        r
  # Save all records
  save: ->
    record.save() for record in @
    @
  # Update all records
  update: (obj) ->
    record.update(obj) for record in @
    @
  push: (obj) ->
    if obj?
      add = true
      for func in ['dirty','save','update']
        add = false unless obj[func]?
      if add
        if @indexOf(obj) is -1
          @[@length] = obj
          @length++
    @
  # TODO destroy, concat
  
