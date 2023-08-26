# cmp-nerdfonts

nvim-cmp source for nerdfonts.

Don't need to go to [www.nerdfonts.com](https://www.nerdfonts.com/cheat-sheet)! Add glyphs straight from nvim.

# Setup

```lua
require'cmp'.setup {
  sources = {
    { name = 'nerdfonts' }
  }
}
```

# Update glyphs

```lua 
require('cmp_nerdfonts').update()
```
