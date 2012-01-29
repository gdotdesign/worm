module.exports =
  validate: (name, data, properties) ->
    for key,value of properties
      if value.key and data.key
        throw "Duplicate key in schema!"
      if key is name
        throw "Duplicate property in schema!"
      
  check: (data, properties, store) ->
    for key, value of properties
      if value.required
        unless data[key]
          unless value.default
            throw "Missing required property: "+key
          else
            def = if typeof value.default is 'function' then value.default() else value.default
            data[key] = def
      if value.key or value.unique
        if store.filter((item) -> item[key] is data[key]).length > 0
            throw "Duplicate key: "+value 
      if value.length
        throw "Wrong type for #{key} (no length)" unless data[key].hasOwnProperty('length')
        if data[key].length > value.length
          throw "Value for #{key} is longer then the specified length"
    data
