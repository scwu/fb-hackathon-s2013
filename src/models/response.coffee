mongoose = require 'mongoose'

# Response model
Response = new mongoose.Schema(
	dates: [Date]
	attending: Boolean
	comment: String
	locations: [String]
	name: String
)

module.exports = mongoose.model 'Response', Response