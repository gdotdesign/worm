# NAME PENDING
DataMapper inspired virtual Object-relational mapping, with a coffeescript DSL.

## Resources
```
Post = Resource ->
  @name 'Post'

  @property 'title', @text, required: true, length: 5, unique: true
  @property 'text', @text, required: true, unqiue: true
  
```

## Collections

```
posts = Post.all(title: 'asd')
posts.save()
posts.update( property: value)

posts.push Post.first(title: 'hello')

for post in posts
  console.log post.id
```

## TODO

* Better error handling
* Associations
* Destroying records
* Adapters for Databases
* Specs
