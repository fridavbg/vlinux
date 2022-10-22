function dropdownSelected(value) {
    const options = [
        "URL",
        "IP",
        "Month",
        "Day",
        "Time",
        "Day-Time",
        "Month-Day-Time",
    ];

    for (const option of options) {
        if (option === "Day-Time") {
            console.log(value);
        }
        elif (option === "Month-Day-Time") {
            console.log(value);
        }
        console.log(value);
    }
}
