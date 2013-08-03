mongoose = require 'mongoose'
User = require './user'
Response = require './response'

Event = new mongoose.Schema(
	locations: [String]
	dates: [Date]
	invited: [User]
	responses: [Response]
	duration: Number
)

module.exports = mongoose.model 'Event', Event
