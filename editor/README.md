# Setup code

```json
{
  "window.zoomLevel": 2,
  "editor.formatOnSave": true,
  "[javascript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "keyboard.dispatch": "keyCode"
}
```

- install plugin `asvetliakov.vscode-neovim`
- install `neovim-git`

# Install gvim package

`gvim` has the `+clipboard` feature enabled on `vim`

```bash
sudo pacman -S gvim
```

# Install pathogen.vim

[github/pathogen](https://github.com/tpope/vim-pathogen)

```bash
mkdir -p ~/.vim/{autoload,bundle} && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# or add it manually
echo "execute pathogen#infect()" >> ~/.vimrc
```

# Install plugins

Install them according to the pathogen instructions

- [syntastic](https://vimawesome.com/plugin/syntastic)
- [fugitive](https://vimawesome.com/plugin/fugitive-vim)
- [jedi](https://vimawesome.com/plugin/jedi-vim)
- [youcompleteme](https://vimawesome.com/plugin/youcompleteme)
- [vim-snippets](https://vimawesome.com/plugin/vim-snippets)
- [supertab](https://vimawesome.com/plugin/supertab)
- [sensible.vim](https://vimawesome.com/plugin/sensible-vim)

# Security

set nomodeline

# manually add this gem in `.vimrc`

```
autocmd BufWritePre  *.*  call StripTrailingWhite()

function! StripTrailingWhite()
    let l:winview = winsaveview()
    silent! %s/\s\+$//
    call winrestview(l:winview)
endfunction
```
