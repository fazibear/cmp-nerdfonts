#!/usr/bin/env bash

wget -q https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/glyphnames.json -O glyphnames.json
$EDITOR +"lua require('cmp_nerdfonts').update(); vim.cmd('q!')"

