# NAME PENDING

## Properties
```
Post = Resource ->
  @name 'Post'

  @property 'title', @text, required: true, length: 5, unique: true
  @property 'text', @text, required: true, unqiue: true
```
