UM = {}

// ? Main Settings
UM.MainSettings = {
    color: '#3558CC', // Todo: https://www.color-hex.com/
    opacity: 1, // 0 close background opacity, | 0.7 low background opacity,
    logo: "assets/images/logo2.png",
    logowidth: 10,
    extra: {
        autoRGB: false,
        autoSnow: false,
    },
}

UM.BackgroundSettings = {

    musicBackground: {
        enabled: true,
        link: "assets/audio/audio.mp3",
        volume: 0.3
    },

    videoBackground: {
        defaultVID: {
            enabled: false,                 
            link: "assets/video/video.mp4", // ? if you want the video in the showcase download it here and put it in the assets > video folder
                                            // ? https://cdn.discordapp.com/attachments/627254815252152331/1077573043771166810/video.mp4
        },                                  // ? youtubeVID is recommended instead because the file size is high (100MB)
        youtubeVID: {
            enabled: false,
            link: "https://www.youtube.com/watch?v=NK5WxKd6kC4",
        },
    },

    imageBackground: {
        defaultIMG: {
            link: "assets/images/bg/bg.jpg",
        },
        randomIMG: {
            enabled: false,
            imglist: ['bg1.jpg','bg2.png','bg3.jpg'],
        },
    }
}

// ? Cards
UM.Store = {
    title: 'SITE WEB',
    description: '',
    button: 'VOIR notre site web',
    character_image: 'assets/images/characters/char-girl.png',
    url: "https://cloud.anthony-it-solutions.fr/",
}

UM.AboutUs = {
    enabled: false, // ? If you want to cancel the store, set it to true.
    title: 'ABOUT US',
    description: '',
    button: 'VIEW ABOUT',
    character_image: 'assets/images/characters/char-girl.png',
    content: '',
}

UM.ChangeLog = {
    title: 'NOUVEAUTES',
    description: '',
    button: 'VOIR LES NOUVEAUTES',
    character_image: 'assets/images/characters/char-man.png',
    page: {
        content: '',
        // ? If you want the content part as multiple lines, you need to enable it in the lines section.
        content: [
            "[ 🍕 ] Nouveau HUD",
            "[ 🔥 ] Ajout d'un script de camping / feux, tante et plein de détail sympa",
            "[ 🍺 ] Ajout d'un script qui permet d'être bourré en buvant de l'alcool",
            "[ 🦾 ] Ajout du bras de fer ",
            "[ 💥 ] Ajout du cassage de voiture réaliste",
            "[ 🤽‍♂️ ] Ajout du water parc à la plage",
            "[ 😀 ] Changement de l'économie ",
            "[ ⏸️ ] Changement Menu pause",
            "[ 💰 ] Changement total boutique",
            "[ 🧩 ] Ajout nouveau système de report",
        ],
    },
    // ? if you want to use github, you need to enable it in the github section 
    // ! Attention: Make sure you enter the information you created in your github account correctly
    // Todo: https://streamable.com/nsv7dx
    github: {
        enabled: false,
        username: 'alp1x',
        repository: 'um-loadingscreen',
        branch: 'main',
        path: 'newupdates',
    },
    url: {
        enabled: false,
        link: "https://discord.com/terms",
    }
}

UM.PlayerOfTheMonth = {
    enabled: false,
    title: "PLAYER OF THE MONTH",
    playerimg: "assets/images/player/playerbest.png",
    playername: "Rosalind Norris"
}

UM.UserSocial = {
    discord: false,
    steam: false,
}

UM.Settings = {
    title: "REGLAGES",
    loading: "CHARGEMENT....",
}

UM.RandomInfo = {
    time: 3000,
    text: [
        // "🎉[1] ",
        // "🥳[2] ",
        // "🥳[3] ",
        // "🎉[4] ",
        // "🥳[5] ",
        // "🎉[6] ",
        // "🥳[7] ",
        // "🎉[8] ",
        // "🥳[9] ",
    ]
}