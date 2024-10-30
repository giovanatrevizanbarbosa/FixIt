function cpfMask(value) {
    value = value.replace(/\D/g, "");
    if (value.length > 3) {
        value = value.slice(0, 3) + "." + value.slice(3);
    }
    if (value.length > 7) {
        value = value.slice(0, 7) + "." + value.slice(7);
    }
    if (value.length > 11) {
        value = value.slice(0, 11) + "-" + value.slice(11);
    }
    return value;
}

function phoneMask(value) {
    value = value.replace(/\D/g, "");
    if (value.length > 0) {
        value = "(" + value;
    }
    if (value.length > 3) {
        value = value.slice(0, 3) + ") " + value.slice(3);
    }
    if (value.length > 10) {
        value = value.slice(0, 10) + "-" + value.slice(10, 15);
    }
    return value;
}

function cepMask(value) {
    value = value.replace(/\D/g, "");
    if (value.length > 5) {
        value = value.slice(0, 5) + "-" + value.slice(5, 8);
    }
    return value;
}

const phoneInput = document.querySelector("#phone")
const cpfInput = document.querySelector("#cpf")
const cepInput = document.querySelector("#cep")

phoneInput.addEventListener('keyup', ()=>{
    let formattedPhone = phoneMask(phoneInput.value)
    phoneInput.value = formattedPhone;
})

cpfInput.addEventListener('keyup', ()=>{
    let formattedCpf = cpfMask(cpfInput.value)
    cpfInput.value = formattedCpf;
})

cepInput.addEventListener('keyup', ()=>{
    let formattedCep = cepMask(cepInput.value)
    cepInput.value = formattedCep;
})