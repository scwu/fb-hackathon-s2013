mongoose = require 'mongoose'
Schema = mongoose.Schema
User = require './user'

# Response model
Response = new mongoose.Schema(
	dates: [Date]
	attending: Boolean
	comment: String
	locations: [String]
	user: { type: Schema.Types.ObjectId, ref: 'User' }
)

module.exports = mongoose.model 'Response', Response
