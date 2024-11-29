const checkboxTheme = document.querySelector('.theme-controller');

const savedTheme = JSON.parse(localStorage.getItem('isdark'));

if (savedTheme) {
    document.documentElement.setAttribute('data-theme', savedTheme ? 'dim' : 'corporate');
    checkboxTheme.checked = savedTheme; // Ajusta o checkbox com o valor armazenado
} else {
    document.documentElement.setAttribute('data-theme', 'corporate');
}

function setTheme(isDark) {
    localStorage.setItem('isdark', JSON.stringify(isDark));
    document.documentElement.setAttribute('data-theme', isDark ? 'dim' : 'corporate');
}

checkboxTheme.addEventListener('change', () => {
    const isDark = checkboxTheme.checked;
    setTheme(isDark);
});
