function showPassword(passwordElement){
    const passwordInput = document.getElementById(passwordElement);
    if(passwordInput.getAttribute('type') === 'password'){
        passwordInput.setAttribute('type', 'text')
    }else{
        passwordInput.setAttribute('type', 'password');
    }
}

const btnShowPassword = document.querySelector('#showPassword');

btnShowPassword.addEventListener('click', ()=>{
    showPassword('password')
});