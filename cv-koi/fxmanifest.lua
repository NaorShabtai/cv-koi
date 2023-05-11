fx_version 'cerulean'
game 'gta5'

author 'Core Version'
description 'KOI Resturent'

lua54 "yes"

files {
    "stream/*.ydr",
}

data_file "DLC_ITYP_REQUEST" "stream/sushi_board.ytyp"


shared_scripts {
    "config.lua",
}

client_scripts {
 "client/*.lua",
}

server_scripts {
    "server/*.lua",
}
   

