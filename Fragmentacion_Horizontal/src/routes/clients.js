const Router = require('express').Router()
const { getClients } = require('../controllers/clients')

Router.get("/clients", getClients);


module.exports = Router