const db = require("../models");
const User = db.user;
const Cluster = db.cluster;

var jwt = require("jsonwebtoken");
var bcrypt = require("bcryptjs");
const { user } = require("../models");

exports.create = (req, res) => {
    if (!req.body) {
        return res.status(400).send({
            message: "Update body cannot be empty"
        });
    }

    const cluster = new Cluster({
        serverAddress: req.body.serverAddress,
        serverLogin: req.body.serverLogin,
        rootPassword: bcrypt.hashSync(req.body.rootPassword, 8)
    });

    cluster.save((err, cluster) => {
        if (err) {
          res.status(500).send({ message: err });
          return;
        }

        User.findOne(
            { _id: req.params.id },
            (err, user) => {
                if (err) {
                  res.status(500).send({ message: err });
                  return;
                }
                user.clusters.push(cluster);
                user.save(err => {
                    if (err) {
                      res.status(500).send({ message: err });
                      return;
                    }
        
                    res.send({ message: "Cluster was registered successfully!" });
                  })
            }
        )
    })
}

exports.findAll = (req, res) => {
    User.findOne({
        _id: req.params.id,
    }, (err, user) => {
        if (err) {
          res.status(500).send({ message: err });
          return;
        }
        Cluster.find({
            '_id' : { $in: user.clusters }
        }, function(err, clusters) {
            if (err) {
              res.status(500).send({ message: err });
              return;
            }
            res.status(200).send(clusters)
        })
    })
}
