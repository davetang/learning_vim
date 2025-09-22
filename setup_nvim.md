# README

Notes on setting up Nvim on a new machine.

1. Install Nvim.
2. Install Lua.
3. Copy Lua headers to include.

```console
mkdir -p $HOME/include/lua/5.4/
cp $HOME/bin/lua-5.4.8/src/lua.h $HOME/include/lua/5.4/
```

4. Install LuaRocks.
5. Remove `$HOME/.vimrc` and `$HOME/.config/nvim/init.vim` if they exist.
6. Create a symbolic link to `init.lua` in `$HOME/.config/nvim`
7. Install lazy.nvim.

```console
mkdir -p $HOME/.config/nvim/lua/config && cd $_
ln -s $HOME/github/learning_vim/lazy.lua .
```

8. Prepare plugins.

```console
mkdir -p $HOME/.config/nvim/lua/plugins && cd $_
ln -s $HOME/github/learning_vim/spec1.lua .
```

9. Start using Nvim!

## Language Servers

Currently `init.lua` contains configurations for the following language servers:

1. [bash-language-server](https://github.com/bash-lsp/bash-language-server)
2. [pyright](https://github.com/microsoft/pyright)
3. [Nextflow](https://github.com/nextflow-io/language-server)
4. [autotools-language-server](https://autotools-language-server.readthedocs.io/en/latest/index.html)

Install 1., 2., and 3. with the install scripts; for 4. use `pip` to install.

```console
pip install autotools-language-server
```
