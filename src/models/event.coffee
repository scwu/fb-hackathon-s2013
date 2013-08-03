mongoose = require 'mongoose'

Event = new mongoose.Schema(
	locations: [String]
	dates: [Date]
	invited: [User]
	responses: [Response]
	duration: Number
)

module.exports = mongoose.model 'Event', Event