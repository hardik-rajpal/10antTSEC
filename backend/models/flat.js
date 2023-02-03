
const mongoose = require("mongoose");

const FlatTagElement = new mongoose.Schema({
    id: {type: mongoose.Schema.Types.ObjectId, ref: 'FlatTagSchema'}
})

const FlatSchema = new mongoose.Schema(
  {
    pictures : [{ type: String}],// casted to MongoDB's BSON type: binData
    location: {type: String, required: true},
    district: {type: String, required: true},
    contact: {type: String, required: true},
    description : {type: String, required: true},
    street_address: {type: String, required: true},
    bhk: {type: Number, required: true},
    rent: {type: Number, required: true},
    area: {type: Number, required: true},
    toilets : {type: Number, required: true},
    amenities_5km: {type: [String], required: true},
    tags: [FlatTagElement],

    // furnishing: {type: String},
    // recreational: {type: String},
    // parking: {type: String},
    // security: {type: String},
    // hospital: {type: String},
    // airport: {type: String},
    // railway: {type: String},
    // bus: {type: String},
    // school: {type: String},

    owner: {type: String},
  },
  { collection: "flat" }
);

const model = mongoose.model("FlatSchema", FlatSchema);

module.exports = model;
