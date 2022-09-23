const express = require("express");
const app = express();

const port = process.env.DBWEBB_PORT || 1337;

app.get("/", (req, res) => res.send("Hello from inside Docker!"));

app.get("/all", (req, res) => {
    const items = require("./data/items.json");

    res.json(items);
});

app.get("/names", (req, res) => {
    const items = require("./data/items.json");
    const result = items.items.map((item) => item.name);

    res.json(result);
});

function capitalizeFirstLetter(str) {
    return str[0].toUpperCase() + str.slice(1);
}

app.get("/color/:color", (req, res) => {
    const items = require("./data/items.json");
    let color = capitalizeFirstLetter(Object.values(req.params).toString());

    const result = items.items.filter((item) => item.color.includes(color));

    res.json(result);
});

app.listen(port, () => console.log(`Example app listening on port ${port}!`));
