var express = require('express');
var router = express.Router();
var Pets= require('../lib/Pets');

/* GET home page. */
router.get('/', function(req, res, next) {
  Pets.getPets(function(err, petReturn) {
    console.log(petReturn);
      res.render('index', { Pets: petReturn});
  })
  
});

module.exports = router;
