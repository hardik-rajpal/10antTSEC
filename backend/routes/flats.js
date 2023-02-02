var express = require('express');
var router = express.Router();
const mongoose = require("mongoose");
const uri = "mongodb+srv://vaibhav:vaibhav@cluster0.b2eb2fv.mongodb.net/?retryWrites=true&w=majority"
const User = require("../models/user");
const FlatTag = require("../models/flat_tag");
const RoommateTag = require("../models/roommate_tag");
const Group = require("../models/group");
const Flat = require("../models/flat");

router.get('/insertFlat', function(req, res, next) {
    const data = new Flat({

    })
})

router.get('/getFlagTags', function(req, res, next) {
    FlatTag.find(function(err, flatTags) {
        if (err) {
            console.log(err);
            res.status(500).send();
        } else {
            res.send(flatTags);
        }
    })
})

module.exports = router;