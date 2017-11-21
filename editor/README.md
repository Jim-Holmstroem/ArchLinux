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
* [syntastic](https://vimawesome.com/plugin/syntastic)
* [fugitive](https://vimawesome.com/plugin/fugitive-vim)
* [jedi](https://vimawesome.com/plugin/jedi-vim)
* [youcompleteme](https://vimawesome.com/plugin/youcompleteme)
* [vim-snippets](https://vimawesome.com/plugin/vim-snippets)
* [supertab](https://vimawesome.com/plugin/supertab)
* [sensible.vim](https://vimawesome.com/plugin/sensible-vim)
