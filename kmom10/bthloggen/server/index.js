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
            if (result.length === 0) {
                return res.send(
                    "Nothing was found in the log for ip: " + req.query.ip
                );
            }
            return res.json(result);
        }
        if (req.query.day) {
            const result = jsonLog.filter((item) =>
                item.day.includes(req.query.day)
            );
            if (result.length === 0) {
                return res.send(
                    "Nothing was found in the log for day: " + req.query.day
                );
            }
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
                        return item.time;
                    }
                    if (
                        logTimesArray[0] === hour &&
                        logTimesArray[1] === minute &&
                        seconds === undefined
                    ) {
                        return item.time;
                    } else if (
                        logTimesArray[0] === hour &&
                        minute === undefined &&
                        seconds === undefined
                    ) {
                        return item.time;
                    }
                });
                if (result.length === 0) {
                    return res.send(
                        "Nothing was found in he log for time: " +
                            req.query.time
                    );
                }
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
            if (result.length === 0) {
                return res.send(
                    "Nothing was found in he log for url: " + req.query.url
                );
            }
            return res.json(result);
        }
        return res.send(
            "Nothing was found with that property, please search for: ip, day, month, time or url"
        );
    }
    if (Object.entries(req.query).length === 2) {
        if (req.query.day && req.query.time) {
            let day = req.query.day;
            if (req.query.time.includes(":")) {
                let timeArray = req.query.time.split(":");
                const hour = timeArray[0];
                const minute = timeArray[1];
                const seconds = timeArray[2];

                const result = jsonLog.filter((item) => {
                    let logTimesArray = item.time.split(":");
                    if (
                        item.day == day &&
                        logTimesArray[0] === hour &&
                        logTimesArray[1] === minute &&
                        logTimesArray[2] === seconds
                    ) {
                        return item;
                    } else if (
                        item.day == day &&
                        logTimesArray[0] === hour &&
                        logTimesArray[1] === minute &&
                        seconds === undefined
                    ) {
                        return item;
                    } else if (
                        logTimesArray[0] === hour &&
                        minute === undefined &&
                        seconds === undefined
                    ) {
                        return item;
                    }
                });
                if (result.length === 0) {
                    return res.send(
                        "Nothing was found in he log for that time " +
                            req.query.time +
                            " and day " +
                            req.query.day
                    );
                }
                return res.json(result);
            } else {
                let hour = req.query.time;
                const result = jsonLog.filter((item) => {
                    let logTimesArray = item.time.split(":");
                    if (item.day === day && logTimesArray[0] === hour) {
                        console.log("HIT");

                        return item;
                    }
                });
                if (result.length === 0) {
                    return res.send(
                        "Nothing was found in he log for that time " +
                            req.query.time +
                            " and day " +
                            req.query.day
                    );
                }
                return res.json(result);
            }
        }
    }
    if (Object.entries(req.query).length === 3) {
        if (req.query.month && req.query.day && req.query.time) {
            let month = req.query.month;
            let day = req.query.day;
            if (req.query.time.includes(":")) {
                let timeArray = req.query.time.split(":");
                const hour = timeArray[0];
                const minute = timeArray[1];
                const seconds = timeArray[2];

                const result = jsonLog.filter((item) => {
                    let logTimesArray = item.time.split(":");
                    if (
                        item.month == month &&
                        item.day == day &&
                        logTimesArray[0] === hour &&
                        logTimesArray[1] === minute &&
                        logTimesArray[2] === seconds
                    ) {
                        return item;
                    } else if (
                        item.month === month &&
                        item.day === day &&
                        logTimesArray[0] === hour &&
                        logTimesArray[1] === minute &&
                        seconds === undefined
                    ) {
                        return item;
                    } else if (
                        item.month === month &&
                        item.day === day &&
                        logTimesArray[0] === hour &&
                        minute === undefined &&
                        seconds === undefined
                    ) {
                        return item;
                    }
                });
                if (result.length === 0) {
                    return res.send(
                        "Nothing was found in he the log for that month " +
                            req.query.month +
                            " with day " +
                            req.query.day +
                            " time " +
                            req.query.time
                    );
                }
                return res.json(result);
            } else {
                let hour = req.query.time;

                const result = jsonLog.filter((item) => {
                    let logTimesArray = item.time.split(":");
                    if (
                        item.month === month &&
                        item.day === day &&
                        logTimesArray[0] === hour
                    ) {
                        return item;
                    }
                });
                if (result.length === 0) {
                    return res.send("Nothing found from the log");
                }
                return res.json(result);
            }
        }
    }
    return res.json(jsonLog);
});

app.listen(port, () => console.log(`App listening on port ${port}!`));
