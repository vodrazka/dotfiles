#!/bin/bash
cp -vr ~/.config/nvim/init.lua .
mkdir lua after
cp -vr ~/.config/nvim/lua/* lua/
cp -vr ~/.config/nvim/after/* after/
