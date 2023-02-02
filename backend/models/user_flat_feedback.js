
const mongoose = require("mongoose");

const UserFlatFeedbackSchema = new mongoose.Schema({
    user_id: {type: String, ref: "UserSchema"},
    flat_id: {type: String, ref: "FlatSchema"},
    feedback: {type: String},
    score: {type: Number, enum: [1, -1], required: true}
  },
  { collection: "user_flat_feedbacks" }
);

const model = mongoose.model("UserFlatFeedbackSchema", UserFlatFeedbackSchema);

module.exports = model;