const adminToggle = document.getElementById("admin");

adminToggle.addEventListener("click", () => {
    adminToggle.checked ? adminToggle.value = true : adminToggle.value = false;
})