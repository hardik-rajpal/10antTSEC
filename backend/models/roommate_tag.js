
const mongoose = require("mongoose");

const RoommateTagSchema = new mongoose.Schema(
  {
    name: { type: String, required: true, unique: true},
    options: [String],
  },
  { collection: "roommate_tags" }
);

const model = mongoose.model("RoommateTagSchema", RoommateTagSchema);

module.exports = model;
