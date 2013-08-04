Event = require '../../models/event'
dates = require '../../helpers/dates'

# Event model's CRUD controller.
module.exports =

  # Lists all events
  index: (req, res) ->
    Event.find {}, (err, events) ->
      res.send events

  # Creates new event with data from `req.body`
  create: (req, res) ->
    event = new Event req.body

    event.dates = event.dates.map (date) ->
      dates.normalize date

    event.save (err, event) ->
      if not err
        res.send event
        res.statusCode = 201
      else
        res.send err
        res.statusCode = 500

  # Gets event by id
  get: (req, res) ->
    Event
    .findById(req.params.id)
    .populate('responses')
    .populate('invited')
    .exec (err, event) ->
      if not err
        res.send event
      else
        res.send err
        res.statusCode = 500

  # Updates event with data from `req.body`
  update: (req, res) ->
    Event.findByIdAndUpdate req.params.id, {"$set":req.body}, (err, event) ->
      if not err
        res.send event
      else
        res.send err
        res.statusCode = 500

  # Deletes event by id
  delete: (req, res) ->
    Event.findByIdAndRemove req.params.id, (err) ->
      if not err
        res.send {}
      else
        res.send err
        res.statusCode = 500


