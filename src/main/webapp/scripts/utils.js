const closeAlertBtn = document.querySelector('.close-alert');
const messageDiv = document.querySelector('.alert');

if(closeAlertBtn){
    closeAlertBtn.addEventListener('click', () => {
        messageDiv.style.display = 'none';
    });

    setTimeout(()=>{
        messageDiv.style.display = 'none';
    }, 5000);
}