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
router.get('/getUser', function(req, res, next) {
  const email = req.body.email;

  User.findOne({ email: email }, function(err, user) {
    if (err) {
      console.log(err);
      res.status(500).send();
    } else {
      // send user details to client side as json
      res.json(user);
    }
  });
});

router.post('/saveUser', function(req, res, next) {
  const user = new User({
    email: req.body.email,
    name: req.body.name,
    age: req.body.age,

    // add more fields here
  });

  user.save(function(err, user) {
    if (err) {
      console.log(err);
      res.status(500).send();
    } else {
      const uid = user._id;
      // send user id to client side as json
      res.json({ id: uid });
    }
  });
});

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

router.get('/mytest', function(req, res, next){
  console.log(req.body);
  var obj = new Flat();
  obj.pictures = [
                  "https://img.staticmb.com/mbphoto/property/cropped_images/2022/Dec/10/Photo_h470_w1080/64583709_3_000x480_gallery_5_470_1080.jpg",
                  "https://img.staticmb.com/mbphoto/property/cropped_images/2022/Dec/10/Photo_h470_w1080/64583709_2_000x480_gallery_6_470_1080.jpg",
                  "https://img.staticmb.com/mbphoto/property/cropped_images/2022/Dec/10/Photo_h470_w1080/64583709_1_000x480_gallery_7_470_1080.jpg",
                  "https://img.staticmb.com/mbimages/project/Photo_h470_w1080/2022/02/02/Project-Photo-36-Lodha-Kiara-Mumbai-5091452_345_1366_470_1080.jpg",
                  "https://img.staticmb.com/mbimages/project/Photo_h470_w1080/2021/10/13/Master-Plan-35-Lodha-Kiara-Mumbai-5091452_600_800_470_1080.jpg"]
  obj.location = "https://goo.gl/maps/WtdEJ21UsExguNi98";
  obj.district = "Worli";
  obj.contact = "+919876543210";
  obj.description = "2 BHK 970 Sq-ft Flat/Apartment For Rent in Lodha Kiara, Worli, Mumbai";
  obj.street_address = "Worli, Mumbai, Worli, Mumbai - South Mumbai, Maharashtra";
  obj.bhk = 2
  obj.rent = 140000
  obj.area = 970
  obj.toilets = 2
  obj.amenities_5km = ["Lower Parel Railway Station", "Inox Nakshatra Mall", "Currey Road Station"]
  obj.tags = [new mongoose.Types.ObjectId('63db7e124013484aa5ab7e85'),
              new mongoose.Types.ObjectId('63db7d9693cc4d62f4dc7a90'),
              new mongoose.Types.ObjectId('63db79cd8bf62453edd3144c')]
  obj.save(function(err){
    if(err){
      console.log(err);
      return;
    } else {
      res.redirect('/');
      console.log(obj);
    }
  });
});



// "63db79cd8bf62453edd3144c"
// "63db7d9693cc4d62f4dc7a90"
// "63db7dd74013484aa5ab7e84"
// "63db7e124013484aa5ab7e85"
// "63db7e214013484aa5ab7e86"
// "63db7e314013484aa5ab7e87"