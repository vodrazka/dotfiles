#!/bin/bash

docker run -it --rm -v nvim-vol:/root/.local/share/nvim/ -v /Users/thomas/.config/nvim/init.lua:/root/.config/nvim/init.lua:ro -v /Users/thomas/.config/nvim/lua/:/root/.config/nvim/lua/:ro nvim $1
