_ = require "underscore"
G = {}
G.Orm = {}
G.Orm.Mediator = {}

G.Orm.Association = class Association
  constructor: (num, name, self) ->
    @table = name
    @type = num
    @self = self
  find: (stuff) ->
    G.Orm.Mediator[table].find stuff
  update: ->
  create: ->

Resource = require('./Orm.coffee').Resource
Collection = require('./Collection.coffee')

Post = Resource ->
  @name 'Post'

  @property 'title', @text, required: true, length: 5, unique: true
  @property 'text', @text, required: true, unqiue: true
  
  #@has 'n', 'comments'
  #@has 1, comment

Comment = Resource ->
  @name 'Comment'
  
  @property 'text', @text
  
  @belongs_to 'post'

Post.create
  title: 'hello'
  text: 'yo'
Post.create
  title: 'hell2'
  text: 'yo'
###
post = Post.first('id',1)
console.log post.id
post.title = "Bello"
console.log post.dirty
post.save()
console.log post.dirty
#console.log post
###
posts = Post.all()
#posts.update(title: 'POST')
console.log posts.pop()

test = new Collection()
test.push Post.first(id:10)
#console.log test

   
