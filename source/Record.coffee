_ = require "underscore"

###

  Class Record
  This class represents the individual record.

###

module.exports = class Record
  constructor: (data,resource) -> 
    # Dirty property: true if changes made are not saved in the Resource     
    Object.defineProperty @, 'dirty'
      get: ->
        r = false
        for item in @parent.store
          if item.id is @id
            for key,value of item
              if value isnt @[key]
                r = true
                break
        r
    id = data.id
    # parent, and id non enumerable properties
    Object.defineProperty @, 'parent', value: resource
    Object.defineProperty @, 'id',  get: ->  id
    d = _.clone data
    delete d.id
    # Add other properties as enumberable and writable
    for key,value of d
      Object.defineProperty @, key, 
        value: value
        enumerable: true
        configurable: false
        writable: true
  # Saves the changes made to the resource
  save: ->
    if @dirty
      for item in @parent.store
        if item.id is @id
          for key,value of @
            item[key] = value
  # Updates the record and saves the changes
  update: (obj) ->
    for key,value of obj
      # check for schema
      @[key] = value
    @save()
    @
