document.addEventListener("DOMContentLoaded", function() {
    var alertElement = document.querySelector("#alert-success");
    if (alertElement) {
      setTimeout(function() {
        alertElement.classList.add("fade");
        alertElement.classList.remove("show");
      }, 5000);
    }
  });
  