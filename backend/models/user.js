
const mongoose = require("mongoose");

const location_priority_schema = new mongoose.Schema({
    id: { type: mongoose.Schema.Types.ObjectId, ref: "FlatTagSchema" },
});

const roommate_priority_schema = new mongoose.Schema({
    option: {type: mongoose.Schema.Types.ObjectId, ref: "RoommateTagSchema"},
    category: {type: Number}
});

const rejected_user_schema = new mongoose.Schema({
    id: {type: mongoose.Schema.Types.ObjectId, ref: "UserSchema"}
});

const listed_flat_schema = new mongoose.Schema({
    id: {type: mongoose.Schema.Types.ObjectId, ref: "FlatSchema"}
});

const UserSchema = new mongoose.Schema({
    username: { type: String, required: true, unique: true },
    picture: { type: String},
    name: { type: String, required: true },
    email: { type: String, required: true, unique: true },
    age: { type: Number, required: true },
    gender: { type: String, enum: ["Male", "Female", "Other"], required: true },
    languages: [String],
    budget: { type: Number, required: true },
    location_priorities: [location_priority_schema],
    roommate_priorities: [roommate_priority_schema],
    rejected_users: [rejected_user_schema],
    listed_flats: [listed_flat_schema]
  },
  { collection: "users" }
);

const model = mongoose.model("UserSchema", UserSchema);

module.exports = model;
