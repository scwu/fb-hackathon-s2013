mongoose = require 'mongoose'
Schema = mongoose.Schema

User = new mongoose.Schema(
  firstName: String
  lastName: String
  email: String
  events: [{ type: Schema.Types.ObjectId, ref: 'Event' }]
)

module.exports = mongoose.model 'User', User
