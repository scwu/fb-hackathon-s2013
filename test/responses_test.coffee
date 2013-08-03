request = require 'supertest'

Response = require process.cwd() + '/.app/models/response'
app = require process.cwd() + '/.app'


INITIAL_DATA = {
  "someField":"Some Data"
}

UPDATED_DATA = {
  "someField":"Another data"
}

cleanDB = (done) ->
  Response.remove {}, ->
    done()

describe 'Response', ->
  before cleanDB
  
  response_id = null
      
  it "should be created", (done) ->
    request(app)
      .post("/responses/create")
      .send(INITIAL_DATA)
      .expect 201, (err, res) ->
        res.body.should.include(INITIAL_DATA)
        res.body.should.have.property "_id"
        res.body["_id"].should.be.ok
        response_id = res.body["_id"]
        done()
        
  it "should be accessible by id", (done) ->
    request(app)
      .get("/responses/get/#{response_id}")
      .expect 200, (err, res) ->
        res.body.should.include(INITIAL_DATA)
        res.body.should.have.property "_id"
        res.body["_id"].should.be.eql response_id
        done()
        
  it "should be listed in list", (done) ->
    request(app)
      .get("/responses")
      .expect 200, (err, res) ->
        res.body.should.be.an.instanceof Array
        res.body.should.have.length 1
        res.body[0].should.include(INITIAL_DATA)
        done()
    
  it "should be updated", (done) ->
    request(app)
      .post("/responses/update/#{response_id}")
      .send(UPDATED_DATA)
      .expect 200, (err, res) ->
        res.body.should.include(UPDATED_DATA)
        done()
        
  it "should be persisted after update", (done) ->
    request(app)
      .get("/responses/get/#{response_id}")
      .expect 200, (err, res) ->
        res.body.should.include(UPDATED_DATA)
        res.body.should.have.property "_id"
        res.body["_id"].should.be.eql response_id
        done()
  
  it "should be removed", (done) ->
    request(app)
      .del("/responses/delete/#{response_id}")
      .expect 200, (err, res) ->
        done()
    
  it "should not be listed after remove", (done) ->
    request(app)
      .get("/responses")
      .expect 200, (err, res) ->
        res.body.should.be.an.instanceof Array
        res.body.should.have.length 0
        done()
        
  after cleanDB
      