User = require '../../models/user'

module.exports =

  index: (req, res) ->
    User.find {}, (err, users) ->
      res.send users

  create: (req, res) ->
    user = new User req.body
    user.save (err, user) ->
      if not err
        res.send 201, user
      else
        res.send 500, err
