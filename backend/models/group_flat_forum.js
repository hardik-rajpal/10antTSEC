
const mongoose = require("mongoose");

const GroupFlatForumSchema = new mongoose.Schema(
  {
    flat: {type: String},
    group: {type: String},
    message: {type: String},
    sender: {type: String},
  },
  { collection: "groupflatforums", timestamps: true }
);

const model = mongoose.model("GroupFlatForumSchema", GroupFlatForumSchema);

module.exports = model;