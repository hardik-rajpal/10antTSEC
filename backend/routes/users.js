var express = require('express');
var router = express.Router();
const mongoose = require("mongoose");
const uri = "mongodb+srv://vaibhav:vaibhav@cluster0.b2eb2fv.mongodb.net/?retryWrites=true&w=majority"
const User = require("../models/user");
const FlatTag = require("../models/flat_tag");
const RoommateTag = require("../models/roommate_tag");
const Group = require("../models/group");
const Flat = require("../models/flat");
const UserFlatFeedback = require("../models/user_flat_feedback");


/* GET users listing. */





router.post('/updateUser', function(req, res, next) {
  const id = req.body.id;

  User.findById(id, function(err, user) {
    if (err) {
      console.log(err);
      res.status(500).send();
    } else {
      user.email = req.body.email;
      user.password = req.body.password;
      user.name = req.body.name;
      user.age = req.body.age;

      // add more fields here

      user.save(function(err, user) {
        if (err) {
          console.log(err);
          res.status(500).send();
        } else {
          // send user id to client side as json
          res.json({ id: id });
        }
      });
    }
  });
});

router.get('/viewMyFlats', function(req, res, next){
  const id = req.body.id;
  User.findById(id, function(err, user) {
    if (err) {
      console.log(err);
      res.status(500).send();
    }
    else {
      const flats = user.listed_flats;
      var flatList = [];
      for (var i = 0; i < flats.length; i++) {
        const flatid = flats[i].id;
        Flat.findById(flatid, function(err, flat) {
          if (err) {
            console.log(err);
            res.status(500).send();
          }
          else {
            flatList.push(flat);
            if (flatList.length == flats.length) {
              res.send(flatList);
            }
          }
        });
      }
    }
  });
});

module.exports = router;


// "63db79cd8bf62453edd3144c"
// "63db7d9693cc4d62f4dc7a90"
// "63db7dd74013484aa5ab7e84"
// "63db7e124013484aa5ab7e85"
// "63db7e214013484aa5ab7e86"
// "63db7e314013484aa5ab7e87"