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
  console.log(group_id, top10flat, rejected, all_usrs);
  var all_flats = [];
  try {
    all_flats = await Flat.find({});
  } catch (err) {console.log(err); res.status(500).send(); return;}
  all_flats = all_flats.map((val) => val._id.toString());
  top10flat = new Set(top10flat.map((val) => val.id));
  if (top10flat.length == 10) {
    return;
  }
  rejected = new Set(rejected.map((val) => val.id));
  var all_flat_ids = all_flats.filter(x => !top10flat.has(x)).filter(x => !rejected.has(x));
  var all_usrs_data = [];
  var scores = [];
  for (let j=0; j<all_usrs.length; ++j) {
    var user = {};
    try {user = await User.findById(all_usrs[j])} catch (err) {console.log(err);}
    all_usrs_data.push(user);
  }
  console.log(all_usrs_data);
  for (let i=0; i<all_flat_ids.length; ++i) {
    var flat = {};
    var score = 0;
    try {flat = await Flat.findById(all_flat_ids[i])} catch (err) {console.log(err);}
    for (let j=0; j<all_usrs.length; j++) {
      var interaction = {};
      try {
        interaction = await UserFlatFeedback.findOne({$and: [{user_id: all_usrs[j]}, {flat_id: all_flat_ids[i]}]});
        if (interaction !== null) {score += interaction.score;}
      } catch (err) {console.log(err);}
      for (const flat_tag of flat.tags) {
        for (const user_loc_tag of all_usrs_data[j].location_priorities) {
          if (user_loc_tag.id.toString() == flat_tag.id.toString()) {score += 1;}
        }
      }
    }
    scores.push(score);
  }
  top10flat = Array.from(top10flat);
  numReqd = 10 - top10flat.length;
  var argsorted = [...Array(scores.length).keys()];
  argsorted.sort((b, a) => scores[a] - scores[b]);
  for (let i=0; i<Math.min(argsorted.length, numReqd); ++i) {
    top10flat.push({id: all_flat_ids[argsorted[i]]});
  }
  console.log(top10flat);
  console.log(scores);
  Group.findOneAndUpdate({'id': group_id}, {$set: {top10flat: top10flat}}, function(err, group) {
    if (err) {
      console.log(err);
      group.status(500).send();
      return;
    } else {}
  })
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
                idx = top10flat.indexOf({id: res.body.flat_id});
                top10flat.splice(idx, 1);
                rejected.push({id: res.body.flat_id});
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
  const grp_id = req.query.gid;
  const usr_id = req.query.id;

  Group.findById(grp_id, async function(err, group){
    if(err){
      console.log(err);
      group.status(500).send();
      return;
    } else {
      var all_usrs = group.users;
      var flats = group.top10flat;
      var rejected = group.rejected;
      if (flats.length < 10) {
        updateTop10Flats(grp_id, flats.map((obj) => obj.id.toString()), rejected.map((obj) => obj.id.toString()), all_usrs.map((obj) => obj.id.toString()))
        try {group = await Group.findById(grp_id);}
        catch (err) {console.log(err);}
        flats = group.top10flat;
        all_usrs = group.users;
        rejected = group.rejected;
      }
      var result = [];
      for(var i = 0; i < flats.length; i++){
        var flat = {};
        try {flat = await Flat.findById(flats[i].id);}
        catch (err) {console.log(err); res.status(500).send();}
        var flat_feedback = {};
        var my_review = 0;
        var accepts = [];
        var rejects = [];
        var no_opinion = [];
        var feedback = "";
        try {
          flat_feedback = await UserFlatFeedback.findOne({$and: [{user_id: usr_id}, {flat_id: flats[i].id}]});
          if (flat_feedback) {my_review = flat_feedback.score; feedback = flat_feedback.feedback;}
        }
        catch (err) {console.log(err);}
        for (var j=0; j<all_usrs.length; j++) {
          if (all_usrs[j].id != usr_id) {
            user_data = [];
            var user = {};
            try {user = await User.findById(all_usrs[j].id);}
            catch (err) {console.log(err); res.status(500).send();}
            user_data.push({
              'picture': user.picture,
              'id': all_usrs[j].id,
              'username': user.username,
            })
            try {
              var flat_feedback = await UserFlatFeedback.findOne({$and: [{user_id: all_usrs[j].id}, {flat_id: flats[i].id}]});
              if (flat_feedback) {score = flat_feedback.score;} else {score = 0;}
              if (score == 1) {accepts.push(user_data[j]);}
              else if (score == -1) {rejects.push(user_data[j]);}
            }
            catch (err) {console.log(err); no_opinion.push(user_data[j]);}
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
    }
    console.log(result);
    res.send(result);
  });
});

router.get('/getRoommateSuggestions', async function(req, res, next){
  const id = req.query.id;
  var allUserIDs = User.find({}, '_id');
  var thisUserData = User.findById(req.query.id);
  accepted_users = new Set(thisUserData.accepted_users.map((obj) => obj.id));
  rejected_users = new Set(thisUserData.rejected_users.map((obj) => obj.id));
  var all_ids = allUserData.map((obj) => obj._id.toString()).filter((obj) => !accepted_users.has(obj)).filter((obj) => !rejected_users.has(obj)).filter((obj) => obj != id);
  var scores = [];
  var userData = [];
  for (let i=0; i<all_ids.length; ++i) {
    var query_user = {};
    try {query_user = await User.findById(all_ids[i])} catch (err) {console.log(err);}
    query_user.id = query_user._id.toString();
    userData.push(query_user);
    var score = 0;
    for (roommate_priority of thisUserData.roommate_priorities) {
      for (option_priority of query_user.roommate_priorities) {
        if (roommate_priority.option.toString() == option_priority.option.toString()) {
          score += 10 - Math.abs(roommate_priority.category - option_priority.category);
        }
      }
    }
    scores.push(score);
  }
  var argsorted = [...Array(userData.length).keys()];
  argsorted.sort((b, a) => scores[a] - scores[b]);
  result = argsorted.map((id) => userData[id]);
  res.send(result);
});

router.get('/resultRoommate', function(req, res, next) {
  
})

router.get('/checkupdate', function(req, res, next) {
  updateTop10Flats("63dbce55e8ad910ae826623c", [], [], [{id: "63dbcb16676ff9c4bda0c987"}, {id: "63dbcb5e07d46ecc14d7883f"}])
})

router.get('/checkroommatesugg', async function(req, res, next) {
  id = "63dbcb16676ff9c4bda0c987"
  var allUserIDs = {};
  var thisUserData = {};
  try {allUserIDs = await User.find({}, '_id');} catch (err) {console.log(err);}
  try {thisUserData = await User.findById(id);} catch (err) {console.log(err);}
  accepted_users = new Set(thisUserData.accepted_users.map((obj) => obj.id));
  rejected_users = new Set(thisUserData.rejected_users.map((obj) => obj.id));
  var all_ids = allUserIDs.map((obj) => obj._id.toString()).filter((obj) => !accepted_users.has(obj)).filter((obj) => !rejected_users.has(obj)).filter((obj) => obj != id);
  console.log(all_ids);
  var scores = [];
  var userData = [];
  for (let i=0; i<all_ids.length; ++i) {
    var query_user = {};
    try {query_user = await User.findById(all_ids[i])} catch (err) {console.log(err);}
    query_user.id = query_user._id.toString();
    userData.push(query_user);
    score = 0;
    for (roommate_priority of thisUserData.roommate_priorities) {
      for (option_priority of query_user.roommate_priorities) {
        if (roommate_priority.option.toString() == option_priority.option.toString()) {
          score += 10 - Math.abs(roommate_priority.category - option_priority.category);
        }
      }
    }
    scores.push(score);
  }
  var argsorted = [...Array(userData.length).keys()];
  argsorted.sort((b, a) => scores[a] - scores[b]);
  result = argsorted.map((id) => userData[id]);
  console.log(result, scores);
})

router.get('/getGroupsForUsers', async function(req, res, next) {
  const id = req.query.id;
  var all_groups = {};
  try {all_groups = await Group.find()} catch (err) {console.log(err);}
  group_data = [];
  for (let group of all_groups) {
    var id_set = new Set(group.users.map((obj) => obj.id.toString()));
    if (id_set.has(id)) {
      group_data.push({
        'name': group.name,
        'city': group.city,
        'id': group._id.toString(),
        'users': group.users.map((obj) => obj.id.toString())
      })
    }
  }
  console.log(group_data)
  res.send(group_data);
})

router.get('/getUser', function(req, res, next) {
  const id = req.query.userid;

  User.findById(id, function(err, user) {
    if (err) {
      console.log(err);
      res.status(500).send();
    } else {
      // send user details to client side as json
      res.json(user);
    }
  });
});

router.get('/getUserId', function(req, res) {
  const email = req.query.email;
  User.findOne({ email: email }, function(err, user) {
    if (err) {
      console.log(err);
      res.status(500).send();
    } else {
      res.json({id: user._id});
    }
  })
})

router.get('/getFlatsListed', async function(req, res, next) {
  var id = req.query.id;
  var flat_ids = {};
  try {flat_ids = await User.findById(id);} catch (err) {console.log(err); res.status(500).send(); return;}
  var all_flat_details = []
  for (idx of flat_ids.listed_flats.map((obj) => obj.id.toString())) {
    var flat_details = {}
    try {flat_details = await Flat.findById(idx);} catch (err) {console.log(err);}
    try {like = await UserFlatFeedback.find({$and: [{flat_id: idx}, {score: 1}]})} catch (err) {console.log(err);}
    try {dislike = await UserFlatFeedback.find({$and: [{flat_id: idx}, {score: -1}]})} catch (err) {console.log(err);}
    all_flat_details.push({
      pictures: flat_details.pictures,
      location: flat_details.location,
      district: flat_details.district,
      contact: flat_details.contact,
      description: flat_details.description,
      street_address: flat_details.street_address,
      bhk: flat_details.bhk,
      rent: flat_details.rent,
      area: flat_details.area,
      toilets: flat_details.toilets,
      amenities_5km: flat_details.amenities_5km,
      tags: flat_details.tags.map((obj) => obj.id.toString()),
      owner: flat_details.owner,
      id: flat_details._id.toString(),
      likes: like.map((obj) => obj.feedback),
      dislikes: dislike.map((obj) => obj.feedback),
    });
  }
  res.send(all_flat_details);
})

router.post('/saveUser', function(req, res, next) {
  const user = new User({
    email: req.query.email,
    name: req.query.name,
    age: req.query.age,
    username: req.query.username,
    picture: req.query.picture,
    gender: req.query.gender,
    languages: req.query.languages,
    budget: req.query.budget,
    location_priorities: [],
    roommate_priorities: [],
    // add more fields here
  });

  user.save(function(err, user) {
    if (err) {
      console.log(err);
      res.status(500).send();
    } else {
      const uid = user._id.toString();
      // send user id to client side as json
      res.json({
        id: uid,
        email: req.query.email,
        name: req.query.name,
        age: req.query.age,
        username: req.query.username,
        picture: req.query.picture,
        gender: req.query.gender,
        languages: req.query.languages,
        budget: req.query.budget,
        location_priorities: [],
        roommate_priorities: [],
      });
    }
  });
});

router.get('/locationPriorities', async function(req, res) {
  try {all_tags = await FlatTag.find()} catch (err) {console.log(err);}
  result = []
  for (tag of all_tags) {
    result.push({
      id: tag._id.toString(),
      name: tag.name,
    })
  }
  res.send(result);
})

router.get('/roommatePriorities', async function(req, res) {
  try {all_tags = await RoommateTag.find()} catch (err) {console.log(err);}
  result = []
  for (tag of all_tags) {
    result.push({
      id: tag._id.toString(),
      name: tag.name,
      options: tag.options
    })
  }
  res.send(result);
})

module.exports = router;