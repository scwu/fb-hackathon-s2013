mongoose = require 'mongoose'
Schema = mongoose.Schema
User = require './user'
Response = require './response'

Event = new mongoose.Schema(
	locations: [String]
	dates: [Date]
	invited: [{ type: Schema.Types.ObjectId, ref: 'User' }]
	responses: [{ type: Schema.Types.ObjectId, ref: 'Response' }]
	duration: Number
  title: String
  description: String
)

module.exports = mongoose.model 'Event', Event
