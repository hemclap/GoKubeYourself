const mongoose = require("mongoose");

const Cluster = mongoose.model(
    "Cluster",
    new mongoose.Schema({
        serverAddress: String,
        serverLogin: String,
        rootPassword: String
    })
)

module.exports = Cluster;