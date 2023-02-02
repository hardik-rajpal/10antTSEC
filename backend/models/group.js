
const mongoose = require("mongoose");

const user_schema = new mongoose.Schema({
  id: {type: mongoose.Schema.Types.ObjectId, ref: "UserSchema"}
})

const flats_schema = new mongoose.Schema({
  id: {type: mongoose.Schema.Types.ObjectId, ref: "FlatSchema"}
})

const GroupSchema = new mongoose.Schema(
    {
        users: [user_schema],
        name: { type: String, required: true },
        city: { type: String, required: true },
        top10flat: [flats_schema],
        rejected: [flats_schema],
    },
  { collection: "group" }
);

const model = mongoose.model("GroupSchema", GroupSchema);

module.exports = model;
