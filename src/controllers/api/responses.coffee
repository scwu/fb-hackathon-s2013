Response = require '../../models/response'

# Response model's CRUD controller.
module.exports = 

  # Lists all responses
  index: (req, res) ->
    Response.find {}, (err, responses) ->
      res.send responses
      
  # Creates new response with data from `req.body`
  create: (req, res) ->
    response = new Response req.body
    response.save (err, response) ->
      if not err
        res.send response
        res.statusCode = 201
      else
        res.send err
        res.statusCode = 500
        
  # Gets response by id
  get: (req, res) ->
    Response.findById req.params.id, (err, response) ->
      if not err
        res.send response
      else
        res.send err
        res.statusCode = 500
             
  # Updates response with data from `req.body`
  update: (req, res) ->
    Response.findByIdAndUpdate req.params.id, {"$set":req.body}, (err, response) ->
      if not err
        res.send response
      else
        res.send err
        res.statusCode = 500
    
  # Deletes response by id
  delete: (req, res) ->
    Response.findByIdAndRemove req.params.id, (err) ->
      if not err
        res.send {}
      else
        res.send err
        res.statusCode = 500
      
  
