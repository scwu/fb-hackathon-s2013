mongoose = require 'mongoose'

User = new mongoose.Schema(
  firstName: String
  lastName: String
)

module.exports = mongoose.model 'User', User
