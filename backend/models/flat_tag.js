
const mongoose = require("mongoose");

const FlatTagSchema = new mongoose.Schema(
  {
    name: { type: String, required: true, unique: true },
  },
  { collection: "flat_tags" }
);

const model = mongoose.model("FlatTagSchema", FlatTagSchema);

module.exports = model;
