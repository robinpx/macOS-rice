command: """
IFS='|' read -r applicationName state trackname artistname trackduration playerposition albumart <<<"$(osascript <<< 'set spotifyApp to "Spotify"
set applicationName to ""
set state to "not-playing"
set trackname to ""
set artistname to ""
set albumart to ""
set trackduration to 0
set playerposition to 0

# Spotify
if application spotifyApp is running then
	tell application "Spotify"
		if the player state is playing then
		  set applicationName to spotifyApp
			set state to "playing"
			set trackname to " " & the name of current track
			set artistname to " " & the artist of current track
			set trackduration to the (duration of current track) / 1000
      set albumart to " " & the artwork url of current track
			set playerposition to the player position
		end if
	end tell
end if

return applicationName & "|" &  state  & "|" & trackname  & "|" &  artistname  & "|" & trackduration & "|" &  playerposition & "|" &  albumart')" 
echo $applicationName
echo "~"
echo $state
echo "~"
echo $trackname
echo "~"
echo $artistname
echo "~"
echo $playerposition
echo "~"
echo $trackduration
echo "~"
echo $albumart
"""

refreshFrequency: 1000

style: """
  width:100vw
  color:transparent
  height:100vh

  button
    padding:0.5em

  .light-theme button 
    color:#444
    background:#f5f5f5
  
  .dark-theme button
    color:#eee
    background:#444

  .menu
    top:2.5em
    left:2.5em
    width:7em
    height:2em
    position:fixed
    z-index:9999999
    color:#000
    transition:0.5s
  
  #menubutton 
    border-radius:100%
    margin-bottom:1em
  
  #menu-opts
    float:right
    cursor:pointer
    display:none

  .menu-item
    display:block
    cursor:pointer
    margin-right:0.5em
    padding:0.5em 0.5em
    width:10em
    opacity:0.5
  
  .menu-main-item
    display:block
    cursor:pointer
    padding:0.5em 0.5em
    width:2.5em
    border-radius:100%

  #player-off
    opacity:0.5

  #player-on
    opacity:1!important

  .menu-on 
    display:block!important
  
  .menu-off
    display:none

  .full-screen
    height:100vh
    width:100vw
    position:absolute
    left:0
    top:0
    font-family:SF Pro
    font-weight: 200
    font-size:14px

  .full-screen .duration, .full-screen .played-duration
    border-radius:0.3em

  .full-screen .duration
    width:86%
    background:#d4d4d4
    height:0.2em
    left:calc(50% - 86%/2)
    bottom:calc(1em + 1.5em / 2)
    position:absolute

  .full-screen .played-duration
    position:absolute
    z-index:99
    height:0.3em
    margin-top:-0.05em

  .playing .full-screen, .playing #menuopts
    display:block

  .player-on 
    display:block!important
  
  .not-playing .fullscreen, .not-playing #menuopts
    display:none

  .player-off 
    display:none!important
  
  .u-d #u-d-layout,.l-r #l-r-layout, .tv-on #tv-size, .min  #min-layout, .min  #min-layout, .player-on #playertoggle, .dark-theme #dlthm
    opacity:1!important

  .album-art
    top:0
    left:0
    position:absolute
    height:100vh
    width:80vw
    margin-left:calc(15vw - 1em)
    object-fit:scale-down

  .album-art img
    width:50%
    border-radius:0.3em
  
  .track-content
    height:100%
   
  .full-screen .track-content 
    width:50%
    text-align:center

  .full-screen .track 
    font-family:SF Pro Medium
    margin-bottom:0.5em

  .full-screen .played-text, .full-screen .duration-text
    width:calc((100% - 86%) / 2)
    text-align:center
    position:absolute
    bottom:1.5em

  .full-screen .played-text
    left:0em

  .full-screen .duration-text
    right:0em

  .light-theme .full-screen
    background:rgba(255,255,255,1)
    color:#333
  .light-theme .album-art img
    -moz-box-shadow: 0 0 5px 5px rgba(0,0,0,0.2)
    -webkit-box-shadow: 0 0 5px 5px rgba(0,0,0,0.2)
    box-shadow: 0 0 5px 5px rgba(0,0,0,0.2)
  .light-theme .played-duration
    background:#444
  .light-theme .duration
    background:#d5d5d5
    
  .dark-theme .full-screen
    background:rgba(0,0,0,1)
    color:#eeeeee
  .dark-theme .album-art img
    -moz-box-shadow: 0 0 5px 5px rgba(0,0,0,0.5)
    -webkit-box-shadow: 0 0 5px 5px rgba(0,0,0,0.5)
    box-shadow: 0 0 5px 5px rgba(0,0,0,0.5)
  .dark-theme .played-duration
    background:#eeeeee
  .dark-theme .duration
    background:#999999

  .l-r .album-art 
    display:flex
    margin-top:-1em
    justify-content:center
    align-items:center

  .l-r .album-art img
    border-radius:0.3em
    margin-left:-10%
    flex:0 1 auto
   
  .l-r .full-screen .track-content 
    flex:0 1 auto
    text-align:center
    margin-top:100vh

  .u-d .album-art
    text-align:center
    margin:10%
    margin-top:calc(50% - 10% - 50vh - 1em)

  .u-d .album-art img
    margin-right:0

  .u-d .track-content
    margin-top:1em
    left:0
    width:100%
    position:absolute
  
  .min .album-art
    width:calc(100% - 4vw)
    min-height:5em
    height:5em
    position:absolute
    left:0
    top:auto
    margin:2em 2vw
    bottom:3em
  
  .tv-on .album-art 
    bottom:2em

  .min .album-art img
    width:5em
    display:inline-block

  .min .track-content
    width:calc(100vw - 5em)
    position:absolute
    text-align:left
    margin-left:8em
    margin-top:-4em
  
  .tv-on .full-screen
    font-size:1.5vw

 .tv-on .duration, .tv-on .played-text, .tv-on .duration-text
    font-size:1.1vw
  
  #bg-player
    position:fixed
    left:0
    top:0
    width:100%
    height:100%
  
  #bg-player img
    z-index:-1
    width:100%
    height:100%
    
"""
hms : (time) -> 
      hms=new Date(time * 1000).toISOString().substr(11, 8);
      hmsnohour=new Date(time * 1000).toISOString().substr(14, 5);
      hmsshortmin=new Date(time * 1000).toISOString().substr(15, 4);
      res = if (time < 3600) then hms else hmsnohour
      res = if (time > 600) then res else hmsshortmin
      res
render: (info) -> """
  #{

    props=info.split("~")
    musicplayer=props[0]
    isplaying=props[1]
    albumart=props[6]
    trackname=props[2]
    artistname=props[3]
    playedposition=parseFloat(props[4])
    trackduration=parseFloat(props[5])
    wid=playedposition/trackduration*100
    playedposition=this.hms(playedposition)
    trackduration=this.hms(trackduration)

    thm = localStorage["sound-widget-theme"]
    layout = localStorage["sound-widget-layout"]
    tvset = localStorage["sound-widget-tv"]
    playershow = localStorage["sound-widget-player"]
    menushow = localStorage["sound-widget-menu"]
    togglethm = () -> if (thm == 'light-theme') then localStorage["sound-widget-theme"] = 'dark-theme' else localStorage["sound-widget-theme"] = 'light-theme';
    toggletv = () -> if (tvset == 'tv-on') then localStorage["sound-widget-tv"] = 'tv-off' else localStorage["sound-widget-tv"] = 'tv-on';
    toggleplayer = () => if (playershow == 'player-on') then localStorage["sound-widget-player"] = 'player-off' else localStorage["sound-widget-player"] = 'player-on'
    togglemenu = () => if (menushow == 'menu-on') then localStorage["sound-widget-menu"] = 'menu-off' else localStorage["sound-widget-menu"] = 'menu-on'


    $(document).on 'click', '#dlthm', -> togglethm()
    $(document).on 'click', "#u-d-layout", -> localStorage["sound-widget-layout"] = "u-d"
    $(document).on 'click', "#l-r-layout", -> localStorage["sound-widget-layout"] = "l-r"
    $(document).on 'click', "#min-layout", -> localStorage["sound-widget-layout"] = "min"
    $(document).on 'click', "#tv-size", -> toggletv()
    $(document).on 'click', "#playertoggle", -> toggleplayer()
    $(document).on 'click', "#menubutton", -> togglemenu()

  }
  <div id="mods" class="#{isplaying} #{thm} #{layout} #{tvset}">
  <div id="sound-theme">
  <div class="menu">
    <div class="menu-container">
    <button id="menubutton">
    ♫♪
    </button>
    <div id="menu-opts" class="#{menushow}"> 
    <button class="menu-main-item" id="playertoggle">
    <div id="#{playershow}">
    <svg version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
	 viewBox="0 0 30.143 30.143" style="enable-background:new 0 0 30.143 30.143;" xml:space="preserve">
    <g>
      <path style="fill:#030104;" d="M20.034,2.357v3.824c3.482,1.798,5.869,5.427,5.869,9.619c0,5.98-4.848,10.83-10.828,10.83
        c-5.982,0-10.832-4.85-10.832-10.83c0-3.844,2.012-7.215,5.029-9.136V2.689C4.245,4.918,0.731,9.945,0.731,15.801
        c0,7.921,6.42,14.342,14.34,14.342c7.924,0,14.342-6.421,14.342-14.342C29.412,9.624,25.501,4.379,20.034,2.357z"/>
      <path style="fill:#030104;" d="M14.795,17.652c1.576,0,1.736-0.931,1.736-2.076V2.08c0-1.148-0.16-2.08-1.736-2.08
        c-1.57,0-1.732,0.932-1.732,2.08v13.496C13.062,16.722,13.225,17.652,14.795,17.652z"/>
    </g>
    </svg>
    </div>
    </button>
    <button class="menu-item" id="dlthm">
    Dark theme
    </button>
    <button class="menu-item" id="u-d-layout">
    Up-Down layout
    </button>
    <button class="menu-item" id="l-r-layout">
    Left-Right Layout
    </button>
    <button class="menu-item" id="min-layout">
    Minimal Layout
    </button>
    <button class="menu-item" id="tv-size">
    Toggle TV Size
    </button>
    </div>
    </div>
  </div>
  <div class="full-screen #{playershow}">
    <div class=#{musicplayer}>
    </div>
    <div class="album-art" >
    <img src ="#{albumart}"/>
      <div class="track-content">
        <div class="track">
        #{trackname}
        </div>
        <div class="artist">
        #{artistname}
        </div>
      </div>
    </div>
    <div class="duration">
    <div class="played-duration" style="width:#{wid}%;"></div>
    </div>
    <div class="played-text">
    #{playedposition}
    </div>
    <div class="duration-text">
    #{trackduration}
    </div>
    </div>
  </div>
  </div>

"""

