User = require '../../models/user'
Event = require '../../models/event'

# User model's CRUD controller.
module.exports = 

  # Lists all users
  index: (req, res) ->
    User.find {}, (err, users) ->
      res.send users
      
  # Creates new user with data from `req.body`
  create: (req, res) ->
    user = new User req.body
    user.save (err, user) ->
      if not err
        res.send user
        res.statusCode = 201
      else
        res.send err
        res.statusCode = 500

  createEvent: (req, res) ->
    event = new Event req.body

    event.save (err, savedEvent) ->
      User.findById(req.params.id).populate('events').exec (err, user) ->

        user.events.push savedEvent

        user.save (err, updated) ->
          if not err
            res.send updated.events[updated.events.length - 1]
          else
            res.send 500, err

        
  # Gets user by id
  get: (req, res) ->
    User.findById req.params.id, (err, user) ->
      if not err
        res.send user
      else
        res.send err
        res.statusCode = 500

  getEvents: (req, res) ->
    User.findById(req.params.id).populate('events').exec (err, user) ->
      if not err
        res.send user.events
      else
        res.send 500, err

  getEmail: (req, res) ->
      User.findById(req.params.id)
        .populate('email')
        .exec (err, user) ->
          if not err
            res.send user.email
          else
            res.send 500, err
             
  # Updates user with data from `req.body`
  update: (req, res) ->
    User.findByIdAndUpdate req.params.id, {"$set":req.body}, (err, user) ->
      if not err
        res.send user
      else
        res.send err
        res.statusCode = 500
    
  # Deletes user by id
  delete: (req, res) ->
    User.findByIdAndRemove req.params.id, (err) ->
      if not err
        res.send {}
      else
        res.send err
        res.statusCode = 500
      
  
