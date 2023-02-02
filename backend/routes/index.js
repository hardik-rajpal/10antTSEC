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

// Connect to the database
mongoose.connect(uri, { useNewUrlParser: true });

async function updateTop10Flats(group_id, top10flat, rejected, all_usrs) {
  var all_flats = [];
  try {
    all_flats = Flat.find({}, '_id');
  } catch (err) {console.log(err); res.status(500).send(); return;}
  top10flat = new Set(top10flat);
  rejected = new Set(rejected);
  var all_flat_ids = all_flats.filter(x => !top10flat.has(x)).filter(x => !rejected.has(x));
  var all_flat_data = [];
  var all_usrs_data = [];
  var scores = [];
  for (let j=0; j<all_usrs.length; ++all_usrs) {
    var user = {};
    try {user = await User.findById(all_usrs[j])} catch (err) {console.log(err);}
    all_usrs_data.push(user);
  }
  for (let i=0; i<all_flat_ids.length; ++i) {
    var flat = {};
    var score = 0;
    try {flat = await Flat.findById(all_flat_ids[0])} catch (err) {console.log(err);}
    all_flat_data.push(flat);
    for (let j=0; j<all_usrs.length; j++) {
      var interaction = {};
      try {
        interaction = await UserFlatFeedback.findOne({$and: [{user_id: all_usrs[j]}, {flat_id: all_flat_ids[i]}]});
        score += interaction.score;
      } catch (err) {console.log(err);}
    }
    scores.push(score);
  }
}

router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

router.post('/registerFeedback', function(req, res, next){
  const feedback = new UserFlatFeedback({
    user_id: req.body.user_id,
    flat_id: req.body.flat_id,
    feedback: req.body.feedback,
    score: req.body.score
  })
  feedback.save(function(err, user) {
    if (err) {
      console.log(err);
      user.status(500).send();
    } else {
      Group.findById(grp_id, async function(err, group){
        if(err) {
          console.log(err);
          group.status(500).send();
          return;
        } else {
          var top10flat = group.top10flat;
          var all_usrs = group.users;
          var rejected = group.rejected;
          rejects = 0;
          for (var i=0; i<all_usrs.length; i++) {
            var flat_feedback;
            try {
              flat_feedback = await UserFlatFeedback.findOne({$and: [{user_id: all_usrs[i].id}, {flat_id: req.body.flat_id}]});
            } catch (err) {}
            if (flat_feedback.score == -1) {
              rejects += 1;
              if (rejects*2 > all_usrs.length) {
                idx = top10flat.indexOf(res.body.flat_id);
                top10flat.splice(idx, 1);
                rejected.push(res.body.flat_id);
                Group.findOneAndUpdate({'id': grp_id}, {$set: {top10flat: top10flat, rejected: rejected}}, function(err, group) {
                  if (err) {
                    console.log(err);
                    group.status(500).send();
                    return;
                  } else {
                    updateTop10Flats(grp_id, top10flat, rejected, all_usrs);
                  }
                })
                break;
              }
            }
          }
        }
      })
    }
  })
})

router.post('/deleteFeedback', function(req, res, next) {
  UserFlatFeedback.remove({$and: [{'user_id': req.body.user_id}, {'flat_id': req.body.flat_id}]}, function(err) {
    if (err) {
      console.log(err);
      res.status(500).send();
      return;
    }
  })
})

router.get('/getFlats', function(req, res, next) {
  const grp_id = req.body.grp_id;
  const usr_id = req.body.user_id;

  Group.findById(grp_id, async function(err, group){
    if(err){
      console.log(err);
      group.status(500).send();
      return;
    } else {
      const all_usrs = group.users;
      const flats = group.top10flat;
      var result = [];
      for(var i = 0; i < flats.length; i++){
        var flat = {};
        try {flat = await Flat.findById(flats[i].id);}
        catch (err) {console.log(err); res.status(500).send();}
        var flat_feedback = {};
        try {flat_feedback = await UserFlatFeedback.findOne({$and: [{user_id: usr_id}, {flat_id: flats[i].id}]});}
        catch (err) {console.log(err);}
        var my_review = flat_feedback.score;
        var feedback = flat_feedback.feedback;
        accepts = [];
        rejects = [];
        no_opinion = [];
        for (var i=0; i<all_usrs.length; i++) {
          if (all_usrs[i].id != usr_id) {
            user_data = [];
            var user = {};
            try {user = await User.findById(all_usrs[i].id);}
            catch (err) {console.log(err); res.status(500).send();}
            user_data.push({
              'picture': user.picture,
              'id': all_usrs[i].id,
              'username': user.username,
            })
            try {
              var flat_feedback = await UserFlatFeedback.findOne({$and: [{user_id: all_usrs[i].id}, {flat_id: flats[i].id}]});
              score = flat_feedback.score;
              if (score == 1) {accepts.push(user_data[id]);}
              else {rejects.push(user_data[id]);}
            }
            catch (err) {console.log(err); no_opinion.push(user_data[id]);}
          }
        }
      }
      result.push({
        'flat': flat,
        'my_review': my_review,
        'feedback': feedback,
        'accepts': accepts,
        'rejects': rejects,
        'no_opinion': no_opinion
      });
    }
    res.send(result);
  });
});

router.get('/getRoommates', function(req, res, next){
  const id = req.body.id;
});


module.exports = router;



// "63db79cd8bf62453edd3144c"
// "63db7d9693cc4d62f4dc7a90"
// "63db7dd74013484aa5ab7e84"
// "63db7e124013484aa5ab7e85"
// "63db7e214013484aa5ab7e86"
// "63db7e314013484aa5ab7e87"