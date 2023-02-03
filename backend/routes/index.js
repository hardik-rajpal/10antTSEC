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
const GroupFlatForum = require("../models/group_flat_forum");

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
  Group.findOneAndUpdate({_id: group_id}, {$set: {top10flat: top10flat}}, function(err, group) {
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
    user_id: req.query.user_id,
    flat_id: req.query.flat_id,
    feedback: req.query.feedback,
    score: req.query.score
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
              flat_feedback = await UserFlatFeedback.findOne({$and: [{user_id: all_usrs[i].id}, {flat_id: req.query.flat_id}]});
            } catch (err) {}
            if (flat_feedback.score == -1) {
              rejects += 1;
              if (rejects*2 > all_usrs.length) {
                idx = top10flat.indexOf({id: res.query.flat_id});
                top10flat.splice(idx, 1);
                rejected.push({id: res.query.flat_id});
                Group.findOneAndUpdate({'id': grp_id}, {$set: {top10flat: top10flat, rejected: rejected}}, async function(err, group) {
                  if (err) {
                    console.log(err);
                    group.status(500).send();
                    return;
                  } else {
                    try {await updateTop10Flats(grp_id, top10flat, rejected, all_usrs);} catch (err) {console.log(err);}
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

router.post('/roomieFeedback', async function(req, res, next) {
  const this_id = req.body.id;
  const other_id = req.body.tid;
  const score = req.body.score;
  try {var this_user = await User.findById(this_id);} catch (err) {console.log(err); res.status(500).send(); return;}
  if (score == -1) {
    rejected_list = this_user.rejected_users;
    rejected_list.push({id: other_id});
    try {await User.findOneAndUpdate({_id: this_id}, {$set: {rejected_users: rejected_list}})} catch (err) {console.log(err);}
  } else if (score == 1) {
    accepted_list = this_user.accepted_users;
    accepted_list.push({id: other_id});
    try {await User.findOneAndUpdate({_id: this_id}, {$set: {rejected_users: rejected_list}})} catch (err) {console.log(err);}
    try {var other_user = await User.findById(other_id);} catch (err) {console.log(err);}
    other_user_accepted = new Set(other_user.accepted_users.map((obj) => obj.id));
    if (other_user_accepted.has(this_id)) {
      group_new = new Group({
        users: [{id: this_id}, {id: other_id}],
        name: this_user.username + " " + other_user.username,
        city: 'Mumbai'
      })
      group_new.save(function(err, res) {
        if (err) {console.log(err);} else {}
      })
    }
  }
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

router.get('/getFlats', async function(req, res, next) {
  const grp_id = req.query.gid;
  const usr_id = req.query.id;
  var all_tags = [];
  try {all_tags = await FlatTag.find()} catch (err) {console.log(err);}
  tag_id_name_map = []
  for (tag of all_tags) {
    tag_id_name_map[tag._id.toString()] = tag.name
  }

  var my_usr = {}
  try {my_usr = await User.findById(usr_id);} catch (err) {console.log(err); res.status(500).send(); return;}

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
        try{await updateTop10Flats(grp_id, flats.map((obj) => obj.id.toString()), rejected.map((obj) => obj.id.toString()), all_usrs.map((obj) => obj.id.toString()))} catch (err) {console.log(err);}
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
        var id_username_dict = {usr_id: my_usr.username};
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
            id_username_dict[all_usrs[j].id] = user.username;
            try {
              var flat_feedback = await UserFlatFeedback.findOne({$and: [{user_id: all_usrs[j].id}, {flat_id: flats[i].id}]});
              if (flat_feedback) {score = flat_feedback.score;} else {score = 0;}
              if (score == 1) {accepts.push(user_data[j]);}
              else if (score == -1) {rejects.push(user_data[j]);}
            }
            catch (err) {console.log(err); no_opinion.push(user_data[j]);}
          }
        }
        var group_flat_fora = []
        try {group_flat_fora = await GroupFlatForum.find({$and: [{flat: flats[i].id}, {group: req.query.gid}]})}
        catch (err) {console.log(err);}
        if (!group_flat_fora) {group_flat_fora = []}
        else {group_flat_fora = group_flat_fora.map(obj => {return {'message': obj.message, 'sender': id_username_dict[obj.sender], 'timestamp': 0}})}
        result.push({
          pictures: flat.pictures,
          location: flat.location,
          district: flat.district,
          contact: flat.contact,
          description: flat.description,
          street_address: flat.street_address,
          bhk: flat.bhk,
          rent: flat.rent,
          area: flat.area,
          toilets: flat.toilets,
          amenities_5km: flat.amenities_5km,
          tags: flat.tags.map((obj) => tag_id_name_map[obj.id]),
          my_review: my_review,
          feedback: feedback,
          accepts: accepts,
          rejects: rejects,
          no_opinion: no_opinion,
          forum: group_flat_fora,
          id: flats[i].id.toString(),
        });
      }
    }
    console.log(result);
    res.send(result);
  });
});

router.get('/getRoommateSuggestions', async function(req, res, next){
  const id = req.query.id;
  var allUserIDs = {};
  var thisUserData = {};
  try {allUserIDs = await User.find({}, '_id');} catch (err) {console.log(err);}
  console.log(allUserIDs);
  try {thisUserData = await User.findOne({_id: id});} catch (err) {console.log(err); res.status(500).send(); return;}
  console.log(thisUserData);
  accepted_users = new Set(thisUserData.accepted_users.map((obj) => obj.id));
  rejected_users = new Set(thisUserData.rejected_users.map((obj) => obj.id));
  var all_ids = allUserIDs.map((obj) => obj._id.toString()).filter((obj) => !accepted_users.has(obj)).filter((obj) => !rejected_users.has(obj)).filter((obj) => obj != id);
  console.log(all_ids);
  var scores = [];
  var userData = [];
  console.log(all_ids);
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
  res.send(result);
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
  const id = req.query.id;

  User.findById(id, function(err, user) {
    if (err) {
      console.log(err);
      res.status(500).send();
    } else {
      // send user details to client side as json
      console.log(user);
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
  console.log(req.body.location_priorities);
  console.log(req.body.roommate_priorities);
  const user = new User({
    email: req.body.email,
    name: req.body.name,
    age: req.body.age,
    username: req.body.username,
    picture: req.body.picture,
    gender: req.body.gender,
    languages: req.body.languages,
    budget: req.body.budget,
    location_priorities: req.body.location_priorities,
    roommate_priorities: req.body.roommate_priorities,
    // add more fields here
  });
  if (user.picture.length == 0) {
    user.picture = "https://fastly.picsum.photos/id/699/600/800.jpg?hmac=jFTBNa5ATcFsNWhJcKO6eghQfYYtvz7fi3wUcI0NWnc";
  }

  user.save(function(err, user) {
    if (err) {
      console.log(err);
      res.status(500).send();
    } else {
      const uid = user._id.toString();
      const groupIndividual = new Group({
        users: [{id: uid}],
        name: "Individual " + user.username,
        city: "Mumbai"
      })

      groupIndividual.save(function(err, group) {
        if (err) {console.log(err); res.status(500).send();}
        else {}
      })

      res.json({
        id: uid,
        email: user.email,
        name: user.name,
        age: user.age,
        username: user.username,
        picture: user.picture,
        gender: user.gender,
        languages: user.languages,
        budget: user.budget,
        location_priorities: user.location_priorities,
        roommate_priorities: user.roommate_priorities,
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

router.post('/addFlat', async function(req, res) {
  var flat = new Flat({
    location: req.body.location,
    district: req.body.district,
    contact: req.body.contact,
    description: req.body.description,
    street_address: req.body.street_address,
    bhk: req.body.bhk,
    rent: req.body.rent,
    area: req.body.area,
    toilets: req.body.toilets,
    amenities_5km: req.body.amenities_5km,
    tags: req.body.tags,
    owner: req.body.owner
  })

  flat.save(function(err, flat) {
    if (err) {
      console.log(err);
      res.status(500).send();
      return;
    }
    else {}
  })
})

router.post('/postMessage', async function(req, res) {
  var group_flat_msg = new GroupFlatForum({
    flat: req.body.flat,
    group: req.body.group,
    message: req.body.message,
    sender: req.body.sender
  })

  group_flat_msg.save(function (err, res) {
    if (err) {
      console.log(err);
      res.status(500).send();
    } else {}
  })
})

module.exports = router;