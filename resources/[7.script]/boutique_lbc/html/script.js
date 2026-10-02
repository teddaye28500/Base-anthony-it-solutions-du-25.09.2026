let showMyAds = false;
let playerIdentifier = null; // On le récupérera au 1er fetchAnnonces

// ====================== NUI UTILS ===========================
function fetchNui(event, data = {}) {
    return new Promise((resolve) => {
        fetch(`https://${GetParentResourceName()}/${event}`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json; charset=UTF-8' },
            body: JSON.stringify(data)
        })
        .then(res => res.json())
        .then(resolve)
        .catch(() => resolve(null));
    });
}




// ================= SPA NAVIGATION ===========================
function hideAllPages() {
    document.querySelectorAll('.page').forEach(p => p.style.display = 'none');
    document.getElementById('popup-bg').style.display = 'none';
    
    document.querySelectorAll('.header-btns button').forEach(btn => {
        btn.addEventListener('click', function() {
            btn.classList.remove('clicked');
            void btn.offsetWidth; // reset anim
            btn.classList.add('clicked');
        });
    });

}
function gotoHome() {
    hideAllPages();
    document.getElementById('home-section').style.display = 'block';
    fetchAnnonces();
}
function openVendre() {
    hideAllPages();
    document.getElementById('vendre-section').style.display = 'block';
}



//function openHistorique() {
//    hideAllPages();
//    document.getElementById('historique-section').style.display = 'block';
//    fetchHistorique();
//    fetchActiveAnnonces();
//}

function openHistorique() {
    hideAllPages();
    document.getElementById('historique-section').style.display = 'block';
    fetchHistorique();
    fetchActiveAnnonces();
}


function showNotify(msg, type='info') {
    let notif = document.createElement('div');
    notif.className = `notify ${type}`;
    notif.innerText = msg;
    document.getElementById('notify').appendChild(notif);
    setTimeout(() => notif.remove(), 3500);
}

// ================= ANNONCES MARKET ==========================
// PAS de fetchNui ici, on appelle juste la NUI callback !
function fetchAnnonces() {
    fetch(`https://${GetParentResourceName()}/getAnnonces`, { method: 'POST' })
    .then(res => res.json())
    .then(list => {
        // Récupère l'identifiant du joueur (met dans playerIdentifier si pas déjà fait)
        if (!playerIdentifier && list[0] && list[0].player_identifier) {
            playerIdentifier = list[0].player_identifier;
        }
        let filtered = showMyAds && playerIdentifier
            ? list.filter(a => a.seller_identifier === playerIdentifier)
            : list;

        let html = '';
        if (!filtered || filtered.length === 0) {
            html = `<div class="no-annonce">${showMyAds ? "Aucune annonce active pour vous." : "Aucune annonce disponible."}</div>`;
        } else {
            for (let a of filtered) {
                html += `
                <div class="annonce-card" onclick="openPopupAnnonce(${a.id})">
                    <img src="${a.image_url || 'assets/default.png'}" class="annonce-img">
                    <div class="annonce-title">${a.item_label}</div>
                    <div class="annonce-price">${a.price} $</div>
                    <div class="annonce-qty">x${a.amount}</div>
                    ${(showMyAds ? '<div class="delete-ads-btn" onclick="event.stopPropagation();confirmDeleteAnnonce(' + a.id + ')">🗑️</div>' : '')}
                </div>`;
            }
        }
        document.getElementById('annonces-list').innerHTML = html;
    });
}

document.getElementById('btn-all-ads').onclick = () => {
    showMyAds = false;
    document.getElementById('btn-all-ads').classList.add('selected');
    document.getElementById('btn-my-ads').classList.remove('selected');
    fetchAnnonces();
};
document.getElementById('btn-my-ads').onclick = () => {
    showMyAds = true;
    document.getElementById('btn-all-ads').classList.remove('selected');
    document.getElementById('btn-my-ads').classList.add('selected');
    fetchAnnonces();
};

window.confirmDeleteAnnonce = function(id) {
    const html = `
    <div class="confirm-delete-popup">
        <div class="popup-content">
            <div class="confirm-title">⚠️ Suppression d'annonce</div>
            <div class="confirm-msg">
                <b>Êtes-vous sûr de vouloir supprimer cette annonce ?<br>
                <span style="color:#ffb700;">Les 1000$ ne seront pas remboursés.</span></b>
            </div>
            <div class="confirm-btns">
                <button class="btn-delete" onclick="deleteAnnonce(${id})">Supprimer</button>
                <button onclick="closeConfirmDelete()">Annuler</button>
            </div>
        </div>
    </div>`;
    document.body.insertAdjacentHTML('beforeend', html);
    setTimeout(() => document.querySelector('.confirm-delete-popup').classList.add('active'), 20);
};
window.closeConfirmDelete = function() {
    const pop = document.querySelector('.confirm-delete-popup');
    if (pop) pop.remove();
};
window.deleteAnnonce = function(id) {
    // Appel NUI pour supprimer côté serveur
    fetch(`https://${GetParentResourceName()}/deleteAnnonce`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ annonce_id: id })
    }).then(() => {
        closeConfirmDelete();
        fetchAnnonces();
        // (optionnel) Notif animée :
        showNotify("Annonce supprimée avec succès. Objet retourné dans votre inventaire !");
    });
};
function showNotify(msg) {
    // Simple notif stylée
    let n = document.createElement('div');
    n.className = "notify success";
    n.innerText = msg;
    document.body.appendChild(n);
    setTimeout(() => n.remove(), 3200);
}


window.openPopupAnnonce = function(id) {
    fetch(`https://${GetParentResourceName()}/getAnnonces`, { method: 'POST' })
    .then(res => res.json())
    .then(list => {
        let a = list.find(an => an.id == id);
        if (!a) return;
        fetch(`https://${GetParentResourceName()}/getBadgesForIdentifier`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json; charset=UTF-8' },
            body: JSON.stringify({ identifier: a.seller_identifier })
        })
        .then(res => res.json())
        .then(badges => {
            let badgeHTML = (badges && badges.length > 0) ? 
                badges.map(b => `<img src="${b.image_url}" class="badge-small" title="${b.name}">`).join('') : '';
            let html = `
                <div class="popup-content">
                    <img src="${a.image_url || 'assets/default.png'}" class="popup-img">
                    <h3>${a.item_label}</h3>
                    <div class="popup-row"><span>Prix :</span> <b>${a.price} $</b></div>
                    <div class="popup-row"><span>Quantité :</span> <b>${a.amount}</b></div>
                    <div class="seller-block">
                        Vendeur&nbsp;: <span style="color:#fff;font-weight:700">${a.seller_name || a.seller_identifier}</span>
                        ${badgeHTML}
                    </div>
                    ${a.description ? `<div style="margin:10px 0 0 0;color:#b2b2b2;font-size:1em;font-weight:400;">${a.description}</div>` : ''}
                    <div style="display:flex;gap:17px;width:100%;justify-content:center;margin-top:22px;">
                        <button onclick="buyAnnonce(${a.id})">Acheter</button>
                        <button onclick="closePopupAnnonce()">Fermer</button>
                    </div>
                </div>
            `;
            document.getElementById('popup-annonce').innerHTML = html;
            document.getElementById('popup-bg').style.display = 'flex';
        });
    });
};



window.closePopupAnnonce = function() {
    document.getElementById('popup-bg').style.display = 'none';
};

window.buyAnnonce = function(id) {
    fetch(`https://${GetParentResourceName()}/buyAnnonce`, {
        method: 'POST',
        body: JSON.stringify({ id })
    })
    .then(res => res.json())
    .then(res => {
        if (res && res.success) {
            showNotify('Achat réussi !', 'success');
            fetchAnnonces();
            closePopupAnnonce();
        } else {
            showNotify(res && res.message ? res.message : "Achat impossible", 'error');
        }
    });
};

// =================== FORMULAIRE VENTE ======================
document.addEventListener('DOMContentLoaded', () => {
    document.getElementById('vendre-form').onsubmit = function(e) {
        e.preventDefault();
        let data = {
            item_name: document.getElementById('item_name').value.trim(),
            item_label: document.getElementById('item_label').value.trim(),
            amount: parseInt(document.getElementById('item_amount').value, 10),
            price: parseInt(document.getElementById('item_price').value, 10),
            image_url: document.getElementById('item_img').value.trim(),
            description: document.getElementById('item_desc').value.trim()
        };
        // On envoie la requête, le retour se fait via l'event NUI plus bas
        fetch(`https://${GetParentResourceName()}/createAnnonce`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json; charset=UTF-8' },
            body: JSON.stringify(data)
        });
    };
});

// Retour du serveur : affichage de la notif/retour page
window.addEventListener('message', function(event) {
    if(event.data.action === 'createAnnonceResult'){
        const res = event.data.result;
        if(res && res.success){
            showNotify('Annonce publiée !', 'success');
            gotoHome();
        } else {
            showNotify(res && res.message ? res.message : "Erreur lors de la publication", 'error');
        }
    }
});


// ================== HISTORIQUE ===========================
let histoRawList = []; // stocke l’historique pour filtrer côté client

//    function fetchHistorique() {
//    fetch(`https://${GetParentResourceName()}/getHistorique`, {
//        method: 'POST'
//    })
//    .then(res => res.json())
//    .then(list => {
//        histoRawList = list || [];
//        renderHistoriqueList();
//    });
//}

function fetchHistorique() {
    fetch(`https://${GetParentResourceName()}/getHistorique`, {
        method: 'POST'
    })
    .then(res => res.json())
    .then(list => {
        histoRawList = list || [];
        renderHistoriqueList(); // Affiche direct la bonne vue
    });
}




// INIT Custom Select (call after DOMContentLoaded ou juste avant gotoHome())
function initCustomSelect() {
    const select = document.getElementById('histo-filter-select');
    const selected = select.querySelector('.selected');
    const options = select.querySelector('.custom-options');
    let value = "all";

    select.onclick = function() {
        select.classList.toggle('open');
        options.style.display = select.classList.contains('open') ? 'block' : 'none';
    };

    options.querySelectorAll('.custom-option').forEach(opt => {
        opt.onclick = function(e) {
            e.stopPropagation();
            options.querySelectorAll('.custom-option').forEach(o => o.classList.remove('selected'));
            opt.classList.add('selected');
            selected.textContent = opt.textContent;
            value = opt.dataset.value;
            select.classList.remove('open');
            options.style.display = 'none';
            // Animation feedback
            select.style.animation = 'shineDrop .4s';
            setTimeout(() => select.style.animation = '', 400);
            // Met à jour la liste
            renderHistoriqueList();
        };
    });

    // Pour permettre d'accéder à la value dans renderHistoriqueList
    select.getValue = () => value;
    window.getHistoFilterValue = () => value;

    // Clique hors de la box = ferme
    document.addEventListener('click', function(e){
        if (!select.contains(e.target)) {
            select.classList.remove('open');
            options.style.display = 'none';
        }
    });
}
document.addEventListener('DOMContentLoaded', initCustomSelect);

function formatSqlDate(val) {
    if (!val) return '-';
    if (typeof val === 'string') {
        // Sécurise le parsing pour SQL DATETIME genre "2025-06-24 18:01:38"
        let d = new Date(val.replace(' ', 'T'));
        if (!isNaN(d.getTime())) {
            return d.toLocaleDateString('fr-FR', { day:'2-digit', month:'short', year:'2-digit' }) +
                   ' à ' + d.toLocaleTimeString('fr-FR', { hour:'2-digit', minute:'2-digit' });
        }
        // fallback
        return new Date(val).toLocaleString('fr-FR', { dateStyle: 'short', timeStyle: 'short' });
    }
    if (val instanceof Date) {
        return val.toLocaleString('fr-FR', { dateStyle: 'short', timeStyle: 'short' });
    }
    if (typeof val === 'number') {
        return new Date(val).toLocaleString('fr-FR', { dateStyle: 'short', timeStyle: 'short' });
    }
    return '-';
}




//function renderHistoriqueList() {
//    const filter = window.getHistoFilterValue ? window.getHistoFilterValue() : "all";
//    let html = '';
//
//    let filtered = histoRawList;
//    if (filter === 'sales') {
//        filtered = histoRawList.filter(h => h.seller_identifier === window.playerIdentifier);
//    } else if (filter === 'buys') {
//        filtered = histoRawList.filter(h => h.buyer_identifier === window.playerIdentifier);
//    } else if (filter === 'active') {
//        filtered = window.activeAnnonces || [];
//    }
//
//    if (!filtered || filtered.length === 0) {
//        html = '<div class="no-histo">Aucun résultat.</div>';
//    } else {
//        for (let h of filtered) {
//            const dateStr = formatSqlDate(h.bought_at || h.created_at);
//
//            // Icône selon type
//            let typeIcon = '';
//            if (filter === 'sales') typeIcon = '🟠';
//            else if (filter === 'buys') typeIcon = '🔵';
//            else if (filter === 'active') typeIcon = '🟡';
//            else typeIcon = (h.seller_identifier === window.playerIdentifier) ? '🟠' : '🔵';
//
//            let sellerClass = h.seller_identifier === window.playerIdentifier ? 'seller-me' : '';
//            let buyerClass = h.buyer_identifier === window.playerIdentifier ? 'me' : '';
//
//            // BADGE vendeur certifié affiché automatiquement si dispo
//            let badgeImg = '';
//            if (h.seller_badge_url) {
//                badgeImg = `<img src="${h.seller_badge_url}" class="histo-badge" title="Vendeur certifié">`;
//            }
//
//            html += `
//                <div class="histo-entry">
//                    <div class="histo-date">${dateStr}</div>
//                    <div class="histo-title">
//                        <span class="histo-type">${typeIcon}</span>
//                        ${h.item_label} <span style="font-size:.89em;color:#aaa;font-weight:400;">x${h.amount}</span>
//                    </div>
//                    <div class="histo-row">
//                        <span class="histo-label">💰 Prix :</span>
//                        <span class="histo-value">${h.price} $</span>
//                    </div>
//                    <div class="histo-row">
//                        <span class="histo-label">🧑‍💼 Vendeur :</span>
//                        <span class="histo-value ${sellerClass}">${h.seller_name || h.seller_identifier}${badgeImg}</span>
//                    </div>
//                    <div class="histo-row">
//                        <span class="histo-label">🛒 Acheteur :</span>
//                        <span class="histo-value ${buyerClass}">${(h.buyer_name || h.buyer_identifier) ? (h.buyer_name || h.buyer_identifier) : 'En attente'}</span>
//                    </div>
//                </div>
//            `;
//        }
//    }
//    document.getElementById('historique-list').innerHTML = html;
//}

function renderHistoriqueList() {
    const filter = window.getHistoFilterValue ? window.getHistoFilterValue() : "all";
    let html = '';
    let filtered = histoRawList; // par défaut, toutes les lignes

    if (filter === 'sales') {
        filtered = histoRawList.filter(h => h.seller_identifier === window.playerIdentifier);
    } else if (filter === 'buys') {
        filtered = histoRawList.filter(h => h.buyer_identifier === window.playerIdentifier);
    } else if (filter === 'active') {
        filtered = window.activeAnnonces || [];
    }

    if (!filtered || filtered.length === 0) {
        html = '<div class="no-histo">Aucun résultat.</div>';
    } else {
        for (let h of filtered) {
            const dateStr = formatSqlDate(h.bought_at || h.created_at);

            let typeIcon = '';
            if (filter === 'sales') typeIcon = '🟠';
            else if (filter === 'buys') typeIcon = '🔵';
            else if (filter === 'active') typeIcon = '🟡';
            else typeIcon = (h.seller_identifier === window.playerIdentifier) ? '🟠' : '🔵';

            let sellerClass = h.seller_identifier === window.playerIdentifier ? 'seller-me' : '';
            let buyerClass = h.buyer_identifier === window.playerIdentifier ? 'me' : '';

            let badgeImg = '';
            if (h.seller_badge_url) {
                badgeImg = `<img src="${h.seller_badge_url}" class="histo-badge" title="Vendeur certifié">`;
            }

            html += `
                <div class="histo-entry">
                    <div class="histo-date">${dateStr}</div>
                    <div class="histo-title">
                        <span class="histo-type">${typeIcon}</span>
                        ${h.item_label} <span style="font-size:.89em;color:#aaa;font-weight:400;">x${h.amount}</span>
                    </div>
                    <div class="histo-row">
                        <span class="histo-label">💰 Prix :</span>
                        <span class="histo-value">${h.price} $</span>
                    </div>
                    <div class="histo-row">
                        <span class="histo-label">🧑‍💼 Vendeur :</span>
                        <span class="histo-value ${sellerClass}">${h.seller_name || h.seller_identifier}${badgeImg}</span>
                    </div>
                    <div class="histo-row">
                        <span class="histo-label">🛒 Acheteur :</span>
                        <span class="histo-value ${buyerClass}">${(h.buyer_name || h.buyer_identifier) ? (h.buyer_name || h.buyer_identifier) : 'En attente'}</span>
                    </div>
                </div>
            `;
        }
    }
    document.getElementById('historique-list').innerHTML = html;
}



//function fetchActiveAnnonces() {
//    fetch(`https://${GetParentResourceName()}/getActiveAnnonces`, { method: 'POST' })
//    .then(res => res.json())
//    .then(list => {
//        window.activeAnnonces = list || [];
//        // On peut appeler renderHistoriqueList() si besoin
//    });
//}

function fetchActiveAnnonces(cb) {
    fetch(`https://${GetParentResourceName()}/getActiveAnnonces`, { method: 'POST' })
    .then(res => res.json())
    .then(list => {
        window.activeAnnonces = list || [];
        if (cb) cb();
    });
}



// ================= BOUTONS SPA + FOCUS ===================
document.getElementById('btn-accueil').onclick = gotoHome;
document.getElementById('btn-historique').onclick = openHistorique;
document.getElementById('btn-vendre').onclick = openVendre;
document.getElementById('btn-refresh').onclick = fetchAnnonces;
function closeMarket() {
    const app = document.getElementById('app');
    if (app) app.style.display = 'none';
    const bg = document.getElementById('market-bg');
    if (bg) bg.style.display = 'none';
    fetch(`https://${GetParentResourceName()}/closeMarket`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json; charset=UTF-8' },
        body: JSON.stringify({})
    }).catch(() => {});
}

document.getElementById('btn-fermer').onclick = closeMarket;

document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape' || e.key === 'Esc') {
        const app = document.getElementById('app');
        if (app && app.style.display !== 'none') {
            e.preventDefault();
            closeMarket();
        }
    }
});

document.getElementById('popup-bg').onclick = function(e) {
    if (e.target.id === 'popup-bg') closePopupAnnonce();
};

// ================= EVENT MESSAGE NUI =====================
window.addEventListener('message', function(event) {
    if(event.data.action === 'setPlayerIdentifier'){
        window.playerIdentifier = event.data.identifier;
    }
    if (event.data.action === 'openMarket') {
        const app = document.getElementById('app');
        const bg = document.getElementById('market-bg');
        if (bg) bg.style.display = '';
        app.style.display = 'flex';
        fetch(`https://${GetParentResourceName()}/getPlayerIdentifier`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json; charset=UTF-8' },
            body: JSON.stringify({})
        });
        gotoHome();
    }
    if (event.data.action === 'closeMarket') {
        const app = document.getElementById('app');
        const bg = document.getElementById('market-bg');
        if (app) app.style.display = 'none';
        if (bg) bg.style.display = 'none';
    }
});

// ================== BADGE UTILISATEUR ===================
document.getElementById('btn-badges').onclick = openBadges;
function openBadges() {
    hideAllPages();
    document.getElementById('badges-section').style.display = 'block';
    fetchNui('lbc:getUserBadges').then(badges => {
        let html = '';
        if (!badges || badges.length === 0) {
            html = "<div>Aucun badge obtenu pour l'instant.</div>";
        } else {
            for (let b of badges) {
                html += `
                    <div class="badge-card">
                        <img src="${b.image_url || 'assets/badge_default.png'}" class="badge-logo">
                        <div class="badge-name">${b.name}</div>
                        <div class="badge-desc">${b.description || ''}</div>
                    </div>
                `;
            }
        }
        document.getElementById('badges-list').innerHTML = html;
    });
}

//--------------------Liste d'aide badge
document.getElementById('btn-badges').onclick = openBadges;
document.getElementById('btn-allbadges').onclick = openAllBadges;

function openBadges() {
    hideAllPages();
    document.getElementById('badges-section').style.display = 'block';
    fetch(`https://${GetParentResourceName()}/getUserBadges`, {
        method: 'POST'
    })
    .then(res => res.json())
    .then(badges => {
        let html = '';
        if (!badges || badges.length === 0) {
            html = "<div>Aucun badge obtenu pour l'instant.</div>";
        } else {
            for (let b of badges) {
                html += `
                    <div class="badge-card">
                        <img src="${b.image_url || 'assets/badge_default.png'}" class="badge-logo">
                        <div class="badge-name">${b.name}</div>
                        <div class="badge-desc">${b.description || ''}</div>
                    </div>
                `;
            }
        }
        document.getElementById('badges-list').innerHTML = html;
    });
}



function openAllBadges() {
    hideAllPages();
    document.getElementById('allbadges-section').style.display = 'block';
    fetch(`https://${GetParentResourceName()}/getAllBadges`, {
        method: 'POST'
    })
    .then(res => res.json())
    .then(badges => {
        let html = '';
        if (!badges || badges.length === 0) {
            html = "<div>Aucun badge enregistré sur le serveur.</div>";
        } else {
            for (let b of badges) {
                html += `
                    <div class="badge-card">
                        <img src="${b.image_url || 'assets/badge_default.png'}" class="badge-logo">
                        <div class="badge-name">${b.name}</div>
                        <div class="badge-desc">${b.description || ''}</div>
                    </div>
                `;
            }
        }
        document.getElementById('allbadges-list').innerHTML = html;
    });
}

document.querySelectorAll('.market-title .title-text').forEach(el => {
    el.setAttribute('data-text', el.textContent);
});


document.getElementById('vendre-form').addEventListener('submit', function(e) {
    let valid = true;
    // Pour tous les champs requis :
    this.querySelectorAll('[required]').forEach(field => {
        // Remove any previous error
        let error = field.parentNode.querySelector('.field-error');
        if (error) error.classList.remove('active');

        if (!field.value.trim()) {
            valid = false;
            if (error) {
                error.textContent = "Ce champ est requis !";
                error.classList.add('active');
            }
            // Optionnel : focus le premier champ en erreur
            if (valid) field.focus();
        }
    });
    if (!valid) e.preventDefault();
});


// ================== PREMIER CHARGEMENT ===================
gotoHome();