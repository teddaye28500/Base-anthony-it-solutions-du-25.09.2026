
window.addEventListener('message', function(event) {
    const action = event.data.action; 
    if (action === 'openPauseMenu') {
        openPauseMenu(event.data.balance, event.data.wallet, event.data.dirtyMoney, event.data.playerName, event.data.jobName,event.data.job2Name, event.data.sex); 
    } 
});

function updatePlayerInfo(index, icon, label, value) {
    $('.contenitore_info_player .player-info-item').eq(index).html(`<i class="${icon}"></i> <strong>${label}</strong> ${value}`);
}
function openPauseMenu(balance, wallet, dirtyMoney, playerName, jobName, job2Name, sex) { 
    $('body').fadeIn();

    const genderText = sex === 'm' ? 'Homme' : sex === 'f' ? 'Femme' : 'Autre';

    updatePlayerInfo(0, 'fas fa-user', 'Nom:', playerName);
    updatePlayerInfo(1, 'fas fa-briefcase', 'Job:', jobName);
    updatePlayerInfo(2, 'fas fa-briefcase', 'Gang/Organisation:', job2Name);
    updatePlayerInfo(3, 'fas fa-venus-mars', 'Genre:', genderText); 
    updatePlayerInfo(4, 'fa-solid fa-piggy-bank', 'Banque:', `$${balance}`);
    updatePlayerInfo(5, 'fas fa-dollar-sign', 'Liquide:', `$${wallet}`);
    updatePlayerInfo(6, 'fa-solid fa-sack-dollar', 'Argent sale:', `$${dirtyMoney}`); 
}



document.onkeydown = function (event) {
    event = event || window.event;
    if (event.keyCode === 27) {
        $.post(`https://${GetParentResourceName()}/close`, JSON.stringify({}));
        closePauseMenu()
    }
};

function closePauseMenu() {
    // console.log('Close action');
    $('body').fadeOut();
}

$(document).ready(function() {

    let resourceName = "krs_pausemenu"; 
    
    $(".contenitore_mappa").click(function() {
        // console.log('Map open');
        $.post(`https://${resourceName}/map`, JSON.stringify({}), function(response) {
            $('body').fadeOut();
            console.log(response);
        });
    });
    $(".contenitore_settings").click(function() {
        // console.log('Settings open');
        $.post(`https://${resourceName}/settings`, JSON.stringify({}), function(response) {
            $('body').fadeOut();
            console.log(response);
        });
    });
    $(".contenitore_relog").click(function() {
        // console.log('Relog');
        $.post(`https://${resourceName}/relog`, JSON.stringify({}), function(response) {
            $('body').fadeOut();
            console.log(response);
        });
    });
    $(".contenitore_logout").click(function() {
        // console.log('Logout');
        $.post(`https://${resourceName}/logout`, JSON.stringify({}), function(response) {
            console.log(response);
        });
    });
});
