
const mongoose = require("mongoose");

const GroupFlatForumSchema = new mongoose.Schema(
  {
    flat: {type: mongoose.Schema.Types.ObjectId, ref: "FlatSchema"},
    group: {type: mongoose.Schema.Types.ObjectId, ref: "GroupSchema"},
    message: {type: String},
    sender: {type: mongoose.Schema.Types.ObjectId, ref: "UserSchema"},
  },
  { collection: "groupflatforums", timestamps: true }
);

const model = mongoose.model("GroupFlatForumSchema", GroupFlatForumSchema);

module.exports = {'model': model, 'schema': UserSchema};
