const { authJwt } = require("../middlewares");
const controller = require("../controllers/cluster.controller");

module.exports = function(app) {
    app.use(function(req, res, next) {
        res.header(
            "Access-Control-Allow-Headers",
            "x-access-token, Origin, Content-Type, Accept"
        );
        next();
    });

    app.post("/api/test/cluster/:id", controller.create);

    app.get("/api/test/cluster/:id", controller.findAll);
}
