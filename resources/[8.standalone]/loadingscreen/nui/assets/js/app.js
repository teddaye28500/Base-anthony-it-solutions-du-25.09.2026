let count = 0;
let thisCount = 0;

const handlers = {
    startInitFunctionOrder(data) {
        count = data.count;
    },

    initFunctionInvoking(data) {
        document.querySelector(".loadingbar").style.left = "0%";
        document.querySelector(".loadingbar").style.width = (data.idx / count) * 100 + "%";
    },

    startDataFileEntries(data) {
        count = data.count;
    },

    performMapLoadFunction(data) {
        ++thisCount;

        document.querySelector(".loadingbar").style.left = "0%";
        document.querySelector(".loadingbar").style.width = (thisCount / count) * 100 + "%";
    },
};

const loadingScreenV3 = Vue.createApp({
    data() {
        return {
            pagestore: false,
            pageaboutus: false,
            randomtext: UM.RandomInfo.text[1],
            music: null,
            mute: false,
            muteicon: false,
            steam: {
                name: "no steam",
                avatar: "",
            },
            discord: {
                name: "https://discord.gg/2K4zRTHbrq",
                avatar: "https://cdn.discordapp.com/attachments/1125090040779907234/1126205488892227684/PAUSE_MENU_LOGOv2.png",
                banner: "https://cdn.discordapp.com/attachments/1125090040779907234/1126205627350384740/ete.png",
                badges: "",
            },
            changeLog: UM.ChangeLog,
            mainSettings: UM.MainSettings,
            page: {
                storecard: UM.Store,
                aboutus: UM.AboutUs,
                social: UM.UserSocial,
                playermonth: UM.PlayerOfTheMonth,
                settings: UM.Settings,
                video: UM.BackgroundSettings,
            },
            RGButton: false,
            clearinvrgb: null,
            clearinvrgbA: null,
            popup: false,
            url: '',
        }
    },
    methods: {
        async getGithubChangeLog() {
            if (!UM.ChangeLog.github.enabled) return;
            const response = await fetch(`https://raw.githubusercontent.com/${UM.ChangeLog.github.username}/${UM.ChangeLog.github.repository}/${UM.ChangeLog.github.branch}/${UM.ChangeLog.github.path}`);
            const data = await response.text();
            UM.ChangeLog.page.content = data;
        },
        randomText() {
            setInterval(() => {
                let random = Math.floor(UM.RandomInfo.text.length * Math.random())
                this.randomtext = UM.RandomInfo.text[random];
             }, UM.RandomInfo.time);
        },
        randomRGB() {
            if (this.mainSettings.extra.autoRGB) {
                this.clearinvrgbA = setInterval(() => {
                    this.rgbColor()
                }, 1000);
            }
        },
        randomRGButton() {
            this.RGButton = !this.RGButton
            if (this.clearinvrgbA) {
                clearInterval(this.clearinvrgbA)
                this.clearinvrgbA = null
                this.RGButton = false
            }
            if (this.RGButton) {
                this.clearinvrgb = setInterval(() => {
                this.rgbColor()
                }, 800);
             } else {
                clearInterval(this.clearinvrgb)
            }
        },
        changeColor(variable, color) {
            document.documentElement.style.setProperty(variable, color);
         },
        rgbColor() {
            let color1 = Math.floor(Math.random() * 255) + 1;
            let color2 = Math.floor(Math.random() * 255) + 1;
            let color3 = Math.floor(Math.random() * 255) + 1;
            this.changeColor('--main', 'rgb(' + color1 + ',' + color2 + ',' + color3 + ')')
        },
        musicPlay() {
            this.music = document.getElementById("music");
            this.music.volume = this.page.video.musicBackground.volume;
            this.music.play();
        },
        musicMute() {
            this.mute = !this.mute;
            this.muteicon = !this.muteicon
            if (this.mute) {
                    this.music.pause();
            } else {
                    this.music.play();
            }
        },
        randomBG() {
            let images = UM.BackgroundSettings.imageBackground.randomIMG.imglist
            let randomImage = Math.floor((Math.random() * images.length));
            this.page.video.imageBackground.defaultIMG = `assets/images/bg/${images[randomImage]}`
        },
        backgroundMain() {
            document.documentElement.style.setProperty('--opactitynum', this.mainSettings.opacity);
            if (UM.BackgroundSettings.videoBackground.youtubeVID.enabled) {
                    new VideoBackgrounds('[data-vbg]');
            } else if (UM.BackgroundSettings.imageBackground.randomIMG.enabled) {
                setInterval(() => {
                    this.randomBG()
                }, 4000);
            }
        },
        StoreAboutUS() {
            if (!UM.AboutUs.enabled) {
                this.url = this.page.storecard.url
                this.popup = !this.popup
            } else {
                this.pageaboutus = !this.pageaboutus
            }
        },
        ChangeLogURL() {
                this.url = this.changeLog.url.link
                this.popup = !this.popup
        },
    },
    mounted() {
        window.addEventListener('DOMContentLoaded', () => {
            const steamData = window.nuiHandoverData.steam === "steam" && JSON.parse(window.nuiHandoverData.steamJson).response.players[0]
            if(steamData) {
                this.steam.name = steamData.personaname
                this.steam.avatar = steamData.avatarfull
            } else {
                this.steam.avatar = "assets/images/no-image.jpg"
            }
            const discordID = window.nuiHandoverData.discordID
            if(discordID){
                fetch(`https://discordlookup.mesavirep.xyz/v1/user/${discordID}`)
                .then(response => response.json())
                .then((data) => {
                    this.discord.badges = data.badges
                    this.discord.avatar = data.avatar.link
                    this.discord.banner = data.banner.link
                    this.discord.name = data.tag
                })
                .catch(() => {
                    this.discord.avatar = "https://cdn.discordapp.com/attachments/1125090040779907234/1126205488892227684/PAUSE_MENU_LOGOv2.png"
                    this.discord.banner = "https://cdn.discordapp.com/attachments/1125090040779907234/1126205627350384740/ete.png"
                    this.discord.name = ".gg/blacklife"
                });
            }
       });
       window.addEventListener("message", function(e) {
            (handlers[e.data.eventName] || function() {})(e.data);
         });
        this.getGithubChangeLog();
        this.backgroundMain();
        this.changeColor('--main', this.mainSettings.color);
        this.musicPlay();
        this.randomText();
        this.randomRGB();
    },
    beforeUnmount() {
        window.removeEventListener('message', this.eventHandler);
        document.removeEventListener('keyup', this.keyupHandler);
    },
}).mount('body');