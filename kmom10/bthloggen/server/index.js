const express = require("express");
const app = express();

const port = process.env.DBWEBB_PORT || 1337;
const routes = require("./routes.json");
const jsonLog = require("../data/log.json");

app.get("/", (req, res) => res.json(routes));

app.get("/data", (req, res) => {
    if (Object.entries(req.query).length === 1) {
        if (req.query.ip) {
            const result = jsonLog.filter((item) =>
                item.ip.includes(req.query.ip)
            );
            return res.json(result);
        }
        if (req.query.day) {
            const result = jsonLog.filter((item) =>
                item.day.includes(req.query.day)
            );
            return res.json(result);
        }
        if (req.query.month) {
            const result = jsonLog.filter((item) =>
                item.month.includes(req.query.month)
            );
            if (result.length === 0) {
                return res.send(
                    "Nothing was found for the month of: " + req.query.month
                );
            }
            return res.json(result);
        }
        if (req.query.time) {
            if (req.query.time.includes(":")) {
                let timeArray = req.query.time.split(":");
                const hour = timeArray[0];
                const minute = timeArray[1];
                const seconds = timeArray[2];

                const result = jsonLog.filter((item) => {
                    let logTimesArray = item.time.split(":");
                    if (
                        logTimesArray[0] === hour &&
                        logTimesArray[1] === minute &&
                        logTimesArray[2] === seconds
                    ) {
                        console.log(3, item.time);

                        return item.time;
                    }
                    if (
                        logTimesArray[0] === hour &&
                        logTimesArray[1] === minute &&
                        seconds === undefined
                    ) {
                        console.log(2, item.time);

                        return item.time;
                    } else if (
                        logTimesArray[0] === hour &&
                        minute === undefined &&
                        seconds === undefined
                    ) {
                        console.log(1, item.time);

                        return item.time;
                    }
                });
                return res.json(result);
            } else {
                let hour = req.query.time;
                const result = jsonLog.filter((item) => {
                    let logTimesArray = item.time.split(":");
                    if (logTimesArray[0] === hour) {
                        return item.time;
                    }
                });
                return res.json(result);
            }
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

app.listen(port, () => console.log(`App listening on port ${port}!`));
