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
harp = require "harp"


#==========
# Helpers
#==========

#====================
# Server Definitions
#====================
app = connect()
app.use harp.mount(__dirname + "/../public")
http.createServer(app).listen(3000, () ->
   console.log "\nMint is online."
)

mint = (request, response) ->
  response.writeHead(200)
  response.write("Hello World.")
  response.end()


# # Launch Servers
# http.createServer(mint).listen(3000, () ->
#   console.log "\nMint is online."
# )
