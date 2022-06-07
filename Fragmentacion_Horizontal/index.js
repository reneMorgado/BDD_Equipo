const express = require('express')
const app = express()
const cors = require('cors')
const port = process.env.PORT || 3000
const morgan = require('morgan')

const ClientsAPI = require('./src/routes/clients')

const bodyParser = require('body-parser')

app.use(bodyParser.urlencoded({extended: false}))
app.use(bodyParser.json())
app.use(cors())
app.use(morgan('dev'))

app.use('/clients', ClientsAPI)

app.listen(port, ()=>{
    console.log('App corriendo en el puerto ' + port);
})