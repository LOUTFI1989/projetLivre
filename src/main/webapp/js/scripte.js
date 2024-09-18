document.addEventListener("DOMContentLoaded", function() {
    const form = document.forms["bookForm"];
    if (form) {
        form.addEventListener("submit", function(event) {
            const title = form["title"].value;
            const author = form["author"].value;
            const genre = form["genre"].value;
            const price = form["price"].value;
            let valid = true;
            let errorMessage = "";

            if (!title || !author || !genre || !price) {
                errorMessage = "All fields must be filled out";
                valid = false;
            } else if (isNaN(price) || parseFloat(price) <= 0) {
                errorMessage = "Price must be a positive number";
                valid = false;
            }

            if (!valid) {
                event.preventDefault();
                alert(errorMessage);
            }
        });
    }
});
