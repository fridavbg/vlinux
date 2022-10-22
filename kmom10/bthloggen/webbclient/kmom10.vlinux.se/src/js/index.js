const el = document.getElementById("search-options");


// fetch("http://localhost:1337")
//     .then((response) => {
//         if (response.ok) {
//             return response.json();
//         } else {
//             throw new Error("NETWORK RESPONSE ERROR");
//         }
//     })
//     .then((data) => {
//         console.log(data);
//     })
//     .catch((error) => console.error("FETCH ERROR:", error));


el.addEventListener("change", function handleChange(event) {
    let searchForm = document.createElement("form");
    let value = event.target.value;

    if (value === "Day-Time") {
        searchForm.innerHTML =
            "<label>Day: </label>" +
            "<input name='day' value='day'/>" +
            "<label>Time: </label>" +
            "<input name='time' value='time'/>";
    } else if (value === "Month-Day-Time") {
        searchForm.innerHTML =
            "<label>Month: </label>" +
            "<input name='Month' value='Month'/>" +
            "<label>Day: </label>" +
            "<input name='day' value='day'/>" +
            "<label>Time: </label>" +
            "<input name='time' value='time'/>";
    } else {
        searchForm.innerHTML = `
        <label>${value}: </label>
        <input
        name='${value}' 
        value='${value}'
        />
        `;
    }
    console.log(searchForm);
});
