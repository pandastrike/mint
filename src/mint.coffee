#===============================================================================
# Mint Example - Node Server
#===============================================================================
# The mint example provides a simple GUI to allow users to input data into
# this an Elasticsearch cluster.  That data should then become visible in Kibana
# alomost immediately.

# This server has two responsibilities.
# (1) Statically serve the mint GUI
# (2) Accept data from the GUI and store it in Elasticsearch

#==============
# Modules
#==============
http = require "http"

connect = require "connect"
bodyParser = require "body-parser"
harp = require "harp"
ElasticSearch = require "elasticsearch"

#==========
# Helpers
#==========

# Creates a middleware that accepts POST requests only and adds
# the posted data as a new document to the specified index
addToIndex = (name) ->
  client = new ElasticSearch.Client(host: 'mint-es.flavor.cluster:2020')

  (request, response, next) ->
    if request.method == "POST"
      console.log request.body

      if request.body? and Object.keys(request.body).length > 0
        # add a timestamp
        request.body['timestamp'] = Date.now()
        # save to index
        client.create
          index: name
          type: 'document'
          body: request.body

        response.writeHead 201
        response.write "Created"
        response.end()
      else
        response.writeHead 400
        response.write "No data"
        response.end()
    else
      next()

#====================
# Server Definitions
#====================
app = connect()

app.use bodyParser.urlencoded()
app.use addToIndex('demo')

app.use harp.mount(__dirname + "/../public")

http.createServer(app).listen 8080, ->
   console.log "\nMint is online."

