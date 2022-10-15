const express = require("express");
const app = express();

const port = process.env.DBWEBB_PORT || 1337;
const routes = require("./routes.json");
const jsonLog = require("../data/log.json");

app.get("/", (req, res) => res.json(routes));

app.get("/data", (req, res) => {
    if (Object.entries(req.query).length > 0) {
        if (req.query.ip) {
            const result = jsonLog.filter((item) =>
                item.ip.includes(req.query.ip)
            );
            return res.json(result);
        }
        if (req.query.url) {
            const result = jsonLog.filter((item) =>
                item.url.includes(req.query.url)
            );
            return res.json(result);
        }
        return res.send(
            "Nothing was found with that property, please search for a url or an ip address"
        );
    }
    return res.json(jsonLog);
});

// app.get("/data/:ip", (req, res) => {
//     let ip = req.params;
//     const result = log.filter((item) => item.ip.includes(ip.ip));

//     res.json(result);
// });

app.listen(port, () => console.log(`App listening on port ${port}!`));
