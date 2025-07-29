## Table of Contents

- [Vim](#vim)
  - [Setup](#setup)
    - [Compiling](#compiling)
    - [Plugins](#plugins)
      - [Nvim-R](#nvim-r)
      - [vim-colors-solarized](#vim-colors-solarized)
      - [coc.nvim](#cocnvim)
      - [vim-gitgutter](#vim-gitgutter)
      - [fugitive.vim](#fugitivevim)
      - [vim-easy-align](#vim-easy-align)
  - [Tips](#tips)
    - [vimtutor](#vimtutor)
    - [Vanilla mode](#vanilla-mode)
    - [Basic word movements](#basic-word-movements)
    - [Execute current line in Bash](#execute-current-line-in-bash)
    - [Selecting entire word that includes dashes](#selecting-entire-word-that-includes-dashes)
    - [Key notation](#key-notation)
    - [Practice](#practice)
      - [Find and till](#find-and-till)
  - [Zone selection](#zone-selection)
  - [Marks](#marks)
  - [Buffers](#buffers)
  - [Splits](#splits)
  - [Line split](#line-split)
  - [Mapping keys](#mapping-keys)
  - [Rust](#rust)
  - [Python code completion](#python-code-completion)
- [Neovim](#neovim)
  - [Transitioning from Vim](#transitioning-from-vim)
  - [Articles](#articles)
- [Language Server Protocol](#language-server-protocol)
  - [Nextflow](#nextflow)

# Vim

Vim for life.

## Setup

To test the setup and `.vimrc` use Docker.

```console
docker run --rm -it -v $(pwd):$(pwd) -w $(pwd) davetang/build:23.04 /bin/bash
```

### Compiling

Install your own version to `${HOME}/.local/bin/vim`.

```console
git clone https://github.com/vim/vim.git
cd vim
./configure --prefix=${HOME}/.local/
make && make install
```

### Plugins

Install [vim-plug](https://github.com/junegunn/vim-plug).

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Add the following to `~/.vimrc`.

```
" https://github.com/junegunn/vim-plug#installation
" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'bronson/vim-trailing-whitespace'
Plug 'altercation/vim-colors-solarized'

call plug#end()
```

Include plugins between `plug#begin()` and `plug#end()`.

```
" install plugins by
" Reloading .vimrc and type :PlugInstall
" Declare the list of plugins.
Plug 'tpope/vim-sensible'
Plug 'junegunn/seoul256.vim'
Plug 'gabrielelana/vim-markdown'
Plug 'godlygeek/tabular'
Plug 'LukeGoodsell/nextflow-vim'
" Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
```

Run

    :PlugInstall
    :PlugUpdate

#### Nvim-R

[Nvim-R](https://github.com/jalvesaq/Nvim-R) improves Vim's support to edit R
scripts; install with `vim-plug`. Requires R to be installed.

Open an R file and type `\rf` for a terminal buffer with an R console; to end
it, hit `\rq`.

* Send :: Entire File \aa
* Send :: Entire Block \bb
* Send :: Entire Function \ff
* Send :: Entire Selection \ss
* Send :: Entire Line \l

Use `\rh` to get help on a function and `\re` to see the examples. Each of
these will open in a split buffer with the relevant information.

See [Turning Vim Into An R
IDE](https://www.freecodecamp.org/news/turning-vim-into-an-r-ide-cd9602e8c217/).

To prevent underscores being converted into `<-` add the following to your .vimrc:

    let R_assign = 0

#### vim-colors-solarized

[Solarized dark](https://github.com/altercation/vim-colors-solarized).

```
call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'

call plug#end()

" -- solarized personal conf
set background=dark
try
    colorscheme solarized
catch
endtry
```

#### coc.nvim

[coc.nvim](https://github.com/neoclide/coc.nvim) is a Nodejs extension host for Vim. Load extensions like VSCode and host language servers. You **have to** install coc extensions or configure language servers for LSP support.

Install extensions like this:

```console
:CocInstall coc-json coc-tsserver
```

[The](https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions) main reason for having extensions is to achieve better user experience. Some language servers provided by the community are less straightforward and easy to use as VS Code extensions. Coc extensions can be forked from VS Code extensions and should provide similar or better user experience.

You can find available coc extensions by searching [coc.nvim on npm](https://www.npmjs.com/search?q=keywords%3Acoc.nvim), or use [coc-marketplace](https://github.com/fannheyward/coc-marketplace), which can search and install extensions in coc.nvim directly.

Or you can configure a language server in your coc-settings.json(open it using :CocConfig) like this:

```
{
  "languageserver": {
    "go": {
      "command": "gopls",
      "rootPatterns": ["go.mod"],
      "trace.server": "verbose",
      "filetypes": ["go"]
    }
  }
}
```

For R, use <https://github.com/REditorSupport/languageserver>, which is an implementation of the Language Server Protocol for R. Installing requires `npm` **and** the {languageserver} package in R; if you just install `coc-r-lsp` it will complain that the {languageserver} package could not be found.

```
:CocInstall coc-r-lsp
```
```r
install.packages("languageserver")
```

For `coc-r-lsp` you can use <tab> to cycle through choices and enter to confirm.

The default is to use C-y to insert and C-n (n for next) and C-p (p for previous) to go through choices.

[Completion with sources](https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources) has instructions for remapping the default.

[Use](https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources#use-cr-to-confirm-completion) `<cr>` (return character) to confirm completion.

```
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
```

[Use](https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources#use-tab-and-s-tab-to-navigate-the-completion-list) `<Tab>` and `<S-Tab>` to navigate the completion list:

```
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
```

Note that the custom settings above (e.g. `<CR>` for completion) do not work when editing certain files like Markdown.

#### vim-gitgutter

A [Vim plugin](https://github.com/airblade/vim-gitgutter) which shows git diff markers in the sign column and stages/previews/undoes hunks and partial hunks.

You can jump between changed lines (hunks) by using:

* jump to next hunk (change): `]c`
* jump to previous hunk (change): `[c`

You can stage or undo an individual hunk when your cursor is in it:

* stage the hunk with `<Leader>hs`
* undo it with `<Leader>hu`

The `<Leader>` key is mapped to `\` by default.

#### fugitive.vim

[Fugitive](https://github.com/tpope/vim-fugitive) is the premier Vim plugin for Git. Or maybe it's the premier Git plugin for Vim? Either way, it's "so awesome, it should be illegal". That's why it's called Fugitive.

The crown jewel of Fugitive is `:Git` (or just `:G`), which calls any arbitrary Git command. If you know how to use Git at the command line, you know how to use `:Git`. It's vaguely akin to `:!git` but with numerous improvements:

* The default behavior is to directly echo the command's output. Quiet commands like `:Git add` avoid the dreaded "Press ENTER or type command to continue" prompt.
* `:Git commit`, `:Git rebase -i`, and other commands that invoke an editor do their editing in the current Vim instance.
* Reset your changes from the latest git commit with `:Gread`.
* Stage your changes with `:Gwrite`.

#### vim-easy-align

[vim-easy-align](https://github.com/junegunn/vim-easy-align) is a simple, easy-to-use Vim alignment plugin.

```
apple =red
grass+=green
sky-= blue
```

Try these commands on the paragraph above :

* `vipga=`
    * visual-select inner paragraph
    * Start EasyAlign command (ga)
    * Align around =
* `gaip=`
    * Start EasyAlign command (ga) for inner paragraph
    * Align around =

Works nicely for Markdown tables too.

## Tips

Read [Vim Tips Wiki](https://vim.fandom.com/wiki/Vim_Tips_Wiki).

Use the following to check format options:

    :set fo?

* A word ends at a non-word character, such as a `.`, `-` or `)`. To change what Vim considers to be a word, see the 'iskeyword' option.
* `33G` puts you on line 33; `50%` moves you halfway the file.

### vimtutor

Open Vim and type `:h vimtutor` (or `:vert h vimtutor` if you perfer a vertical split) to access vimtutor, which is a tutorial built into Vim that you can follow along interactively.

* Use `<CTRL> ww` to switch between the windows.
* Use `<CTRL> ]` when the cursor is under a link to go to the link, e.g. the next chapter

### Vanilla mode

Some modes that are good for debugging.

The argument `-u <vimrc>` (Use <vimrc> instead of any .vimrc) can accept `NONE`, which will start Vim in "vanilla" mode.

```console
vim -u NONE
```

The argument `--noplugin` will stop Vim from loading plugin scripts.

### Basic word movements

* `w` move to beginning of next word
* `b` move to previous beginning of word
* `e` move to end of word
* `W` move to beginning of next word after a whitespace
* `B` move to beginning of previous word before a whitespace
* `E` move to end of word before a whitespace

Test the difference between `w` and `e` with `W` and `E` below.

```
one two three, four,, five,,, six
```

### Execute current line in Bash

[There are several ways](https://stackoverflow.com/questions/19883917/execute-current-line-in-bash-from-vim) to execute the current line in Bash. Personally, the easiest way is `!!bash<CR>` (which is also easy to remember as well: bang-bang-bash). The only downside is that the execute line is replaced but you can always just do `yyp` first before the bang-bang.

### Selecting entire word that includes dashes

Let's say I have the string:

    hello how-ar[]e-you doing

where [] is my cursor. How would I efficiently select how-are-you such that:

    hello [how-are-you] doing

Use `viW`.

    hello how-are-you doing

* the `iw` text-object ("inner word") would cover "are"
* the `iW` text-object ("inner WORD") would cover "how-are-you"

See `:help navigation`.

### Key notation

When reading documentation and tips about Vim, you'll see `<CR>` a lot. [What is the meaning of a `<CR>` at the end of some vim mappings?](https://stackoverflow.com/questions/22142755/what-is-the-meaning-of-a-cr-at-the-end-of-some-vim-mappings).

```console
:help key-notation
```

```
notation    meaning            equivalent  decimal    value(s)
-----------------------------------------------------------------------
<CR>        carriage return        CTRL-M    13       *carriage-return*
<Return>    same as <CR>                              *<Return>*
<Enter>     same as <CR>                              *<Enter>*
```

### Practice

The only way to get good with Vim is by practicing. Here are some new shortcuts that I need to practice.

* Use `"+y` to yank to the clipboard
* Use `<CTRL> F` and `<CTRL> B` to scroll forward and backward a whole screen
* Use `H`, `M`, and `L` to move to the top, middle, and bottom of the current visible page.
* `J` to join two lines together
* `o` insert a new line after the current one
* `O` insert a new line before the current one
* `^` go to first non-blank character (good for indented code)
* `g_` go to the last non-blank character of line

```
          aaaaa
    bbbb    cccccccccc
done          
```

* `*` and `#` go to next and previous occurrence of word under cursor. Use `n`
  and `N` to navigate.
* `fx` go to next occurrence of the letter `x` on **the line**. Then use `;` to find the next or `,` previous occurrence. To do this in reverse or backwards, use `F` instead of `f`.

```
this is the first occurrence of xxxx. Next one is here xxxx.
Another one is here xxxx
xxxx is the last one.
```

* `t,` go to just before the character `,`. Then use `;` and `,` to navigate.

```
this is a sentence, which is for testing, and practicing.
```

* `dt"` (delete till ") to remove everything until `"`. To do this in reverse or backwards, use `T` instead of `t`.
* `di"` deletes inside the quotation marks (works even if cursor is at start of line)
* `ci"` changes inside the quotation marks, then enter insert mode. Also works  with `)`, `}`, and ```.

```
left spacer "This is sentence is between double quotes" right spacer "another"
left spacer (This is sentence is between parenthesises) right spacer (another)
left spacer {This is sentence is between braces} right spacer {another}
left spacer `This is sentence is between braces` right spacer `another`
```

* `guw` make a word lowercase
* `gUw` make a work UPPERCASE

Practice folding.

* `zf` to defind a fold

Start
folding
End

* `zo` to open a fold at the cursor.

Use `r` to make a replacement. This is handy in visual mode, when I want to replace a selection of text with a space.

```
r<space>
```

#### Find and till

[Find and till tips](https://vim.fandom.com/wiki/Tutorial#Find_and_till).

* Find will jump to a character in the same line:
    * `fx` to find the next `x` in the line and `Fx` to find the previous one.

* Till is similar:
    * `tx` to jump till just before the next `x` in the line, and `Tx` to jump
    till just after the previous one.

* Use `,` and `;` to jump to the previous and next occurrence of the character
  found with `t`, `T`, `f`, or `F`.

In the above, `x` is any character, including Tab (press f then Tab to jump to
the next Tab on the current line).

Magic happens when you combine the motions find and till with operators:

* `ctx` change all text till the next 'x' (x is any character; x is not changed).
* `cfx` same, but include the 'x'.
* `dtx` delete all text till the next 'x'.
* `dfx` same, but include the 'x'.

## Zone selection

Example line:

    (map (+) ("foo"))

Suppose the cursor is on the first `o`:

* `vi"` will select `foo`.
* `va"` will select `"foo"`.
* `vi)` will select `"foo"`.
* `va)` will select `("foo")`.
* `v2i)` will select `map (+) ("foo")`.
* `v2a)` will select `(map (+) ("foo"))`.

## Marks

Marks help you bookmark positions in your files for quick navigation.

| Command         | Description                                            |
| --------------- | ------------------------------------------------------ |
| `ma`            | Set mark `a` at current position (local to this file)  |
| `:marks`        | List all defined marks                                 |
| `` `a ``        | Jump to **exact position** (line + column) of mark `a` |
| `'a`            | Jump to **start of line** of mark `a`                  |
| `:delmarks a`   | Delete mark `a`                                        |
| `:delmarks A-Z` | Delete all global marks                                |

Types of marks.

| Mark  | Scope  | Jump Type           | Description                      |
| ----- | ------ | ------------------- | -------------------------------- |
| `a–z` | Local  | Within current file | Custom bookmarks                 |
| `A–Z` | Global | Across files        | Useful for multi-file navigation |

Automatic/internal marks.

| Mark             | Description                            |
| ---------------- | -------------------------------------- |
| `` `. ``         | Last change position                   |
| `''` or ` ` \`\` | Cursor position before last jump       |
| `^`              | Position where you exited insert mode  |
| `"`              | Last exited position in current file   |
| `[`, `]`         | Start and end of last text change      |
| `<`, `>`         | Start and end of last visual selection |

## Buffers

In Vim, a buffer is an in-memory representation of a file. When you open multiple files, each one gets its own buffer. You can switch between these buffers without reloading the files from disk.

```console
nvim file1.txt file2.txt
```

| Task                                        | Command                      |
| ------------------------------------------- | ---------------------------- |
| List open buffers                           | `:ls` or `:buffers`          |
| Switch to another buffer                    | `:b <buffer number or name>` |
| Toggle between current and last used buffer | `Ctrl+^`                     |
| Open buffer in vertical split               | `:vsp <filename>`            |
| Open buffer in horizontal split             | `:sp <filename>`             |
| Delete buffer (keep window)                 | `:bd` or `:bdelete`          |

This allows you to work with multiple files efficiently and to copy/paste between them! Note that when you open a buffer in a split, quitting the split will not remove the buffer. Use the delete buffer command as shown above.

## Splits

Split the window into two! Useful for viewing the same file into two different locations at once or viewing two files at once; see [Buffers](#buffers). Also checkout `:help split` for more information.

* `:split` creates a split.
* `:vsplit` creates a vertical split.
* Use `<C-w><w>` to cycle between splits.
* Use `<C-w><direction>` to move between splits.

To close a split, just quit `:q` it as you normally would.

## Line split

See [Automatic word wrapping](https://vim.fandom.com/wiki/Automatic_word_wrapping).

Default is 79 characters. This needs to be set in order for automatic word
wrapping to work.

    :set tw=79

Wrapping text using textwidth requires "t" in formatoptions, which it is by
default. The following commands display the current setting then add "t" if
needed. The abbreviation fo is used instead of formatoptions. 

    :set fo+=t

A long line is not wrapped when text is added if formatoptions contains "l". If
needed, "l" can be removed so long lines will be wrapped:

    :set fo-=l

Use "v+i+p+J" to [unwarp
lines](https://stackoverflow.com/questions/11039544/how-to-unwrap-text-in-vim).

Then edit and then "g+q+q" to wrap again!

## Mapping keys

[Mapping keys in Vim
tutorial](https://vim.fandom.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_1)).

Key mapping refers to creating a shortcut for repeating a sequence of keys or
commands. You can map keys to execute frequently used key sequences or to
invoke an Ex command or to invoke a Vim function or to invoke external
commands. Using key maps you can define your own Vim commands.

* Use `:map` to display maps that work in normal, visual and select and
  operator pending mode. Use `:map!` to display the maps that work in insert
  and command-line mode.
* `:nmap` - Display normal mode maps
* `:imap` - Display insert mode maps
* `:vmap` - Display visual and select mode maps
* `:smap` - Display select mode maps
* `:xmap` - Display visual mode maps
* `:cmap` - Display command-line mode maps
* `:omap` - Display operator pending mode maps

In my `.vimrc` I have mapped the `F7` key to toggle spell check.

```
" misspelled words will be highlighted
" :set spell spelllang=en_gb
:map <F7> :setlocal spell! spelllang=en_gb<CR>
```

[Difference](https://stackoverflow.com/questions/3776117/what-is-the-difference-between-the-remap-noremap-nnoremap-and-vnoremap-mapping)
between `:map` and `:noremap` is that `:map` and `:noremap` are recursive and
non-recursive versions of the various mapping commands.

Map line splitting.

```
:nnoremap <F5> gqq
:nnoremap <F6> vipJgqq
```

## Rust

Download binary release and put in PATH.

```console
wget https://github.com/rust-lang/rust-analyzer/releases/download/2023-09-25/rust-analyzer-x86_64-unknown-linux-gnu.gz
gunzip rust-analyzer-x86_64-unknown-linux-gnu.gz
chmod 755 rust-analyzer-x86_64-unknown-linux-gnu
mv rust-analyzer-x86_64-unknown-linux-gnu ~/bin/rust-analyzer
```

But this won't work with old C libraries.

```
/home/dtang/bin/rust-analyzer: /lib64/libm.so.6: version `GLIBC_2.27' not found (required by /home/dtang/bin/rust-analyzer)
/home/dtang/bin/rust-analyzer: /lib64/libc.so.6: version `GLIBC_2.25' not found (required by /home/dtang/bin/rust-analyzer)
/home/dtang/bin/rust-analyzer: /lib64/libc.so.6: version `GLIBC_2.18' not found (required by /home/dtang/bin/rust-analyzer)
```

## Python code completion

[Pydiction](https://rkulla.github.io/pydiction/) allows you to tab-complete
Python code in Vim. It does not require installing any dependencies and simply
consists of three main files:

1. `python_pydiction.vim` - Vim plugin that autocompletes Python code.
2. `complete-dict`        - Dictionary file of Python keywords, modules, etc.
3. `pydiction.py`         - Python script to add more words to complete-dict.

Clone the repo.

```console
git clone https://github.com/rkulla/pydiction.git
```

Put `python_pydiction.vim` in `~/.vim/after/ftplugin/`; create this directory
if doesn't yet exist. Vim looks there automatically.

```console
mkdir -p ~/.vim/after/ftplugin/
cp ~/github/pydiction/after/ftplugin/python_pydiction.vim ~/.vim/after/ftplugin/
```

You may install `complete-dict` and `pydiction.py` anywhere but only
`python_pydiction.vim` should be in the `ftplugin` directory because that is
for `.vim` files only.

In your `vimrc` file, first add the following line to enable filetype plugins:

    filetype plugin on

Next make sure you set `g:pydiction_location` to the full path of `complete-dict`.

    let g:pydiction_location = '/path/to/complete-dict'

# Neovim

[Neovim](https://github.com/neovim/neovim/wiki/Introduction) is a project that seeks to aggressively refactor Vim source code in order to achieve the following goals:

* Simplify maintenance to improve the speed that bug fixes and features get merged.
* Split the work among multiple developers.
* Enable the implementation of new/modern user interfaces without any modifications to the core source.
* Improve the extensibility power with a new plugin architecture based on coprocesses. Plugins will be written in any programming language without any explicit support from the editor.

Install on [Debian](https://github.com/neovim/neovim/blob/master/INSTALL.md#debian).

```console
sudo apt update
sudo apt install -y neovim
```

Alternatively, download compiled binaries from the [Neovim repo](https://github.com/neovim/neovim/releases).

Then use `nvim` to start Neovim.

## Transitioning from Vim

Set up vim-plug for [Neovim](https://github.com/junegunn/vim-plug?tab=readme-ov-file#neovim)

```console
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

Follow these [instructions](https://neovim.io/doc/user/nvim.html#nvim-from-vim) to set up the config file.

1. To start the transition, create your `init.vim` (user config) file:

```vim
:exe 'edit '.stdpath('config').'/init.vim'
:write ++p
```

2. When you run the command, it creates and opens `init.vim`; add these contents:

```vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
```

3. Close and re-open `nvim` and then re-install plugins using `:PlugInstall`.

## Articles

* [What is Neovim, and how is it different from Vim?](https://vi.stackexchange.com/questions/34/what-is-neovim-and-how-is-it-different-from-vim).
* [How to share config between Vim and Neovim](https://vi.stackexchange.com/questions/12794/how-to-share-config-between-vim-and-neovim)

# Language Server Protocol

> The [Language Server Protocol](https://en.wikipedia.org/wiki/Language_Server_Protocol) (LSP) is an open, JSON-RPC-based protocol for use between source code editors or integrated development environments (IDEs) and servers that provide "language intelligence tools": programming language-specific features like code completion, syntax highlighting and marking of warnings and errors, as well as refactoring routines. The goal of the protocol is to allow programming language support to be implemented and distributed independently of any given editor or IDE. In the early 2020s, LSP quickly became a "norm" for language intelligence tools providers.
>
> Prior to the design and implementation of the Language Server Protocol for the development of Visual Studio Code, most language services were generally tied to a given IDE or other editor. In the absence of the Language Server Protocol, language services are typically implemented by using a tool-specific extension API. Providing the same language service to another editing tool requires effort to adapt the existing code so that the service may target the second editor's extension interfaces.
When a user edits one or more source code files using a language server protocol-enabled tool, the tool acts as a client that consumes the language services provided by a language server. The tool may be a text editor or IDE and the language services could be refactoring, code completion, etc.
>
> The client informs the server about what the user is doing, e.g., opening a file or inserting a character at a specific text position. The client can also request the server to perform a language service, e.g. to format a specified range in the text document. The server answers a client's request with an appropriate response. For example, the formatting request is answered either by a response that transfers the formatted text to the client or by an error response containing details about the error.
>
> The Language Server Protocol defines the messages to be exchanged between client and language server. They are JSON-RPC preceded by headers similar to HTTP. Messages may originate from the server or client.
>
> The protocol does not make any provisions about how requests, responses and notifications are transferred between client and server. For example, client and server could be components within the same process exchanging JSON strings via method calls. They could also be different processes on the same or on different machines communicating via network sockets.

## Nextflow

Following Samuel Lampa's guide (thanks!) to [Setting up the Nextflow Language Server (LSP) with NeoVim](https://livesys.se/posts/nextflow-lsp-with-neovim/).

Step 1. Add basic syntax highlighting support for Nextflow.

> The [syntax](https://neovim.io/doc/user/syntax.html#_2.-syntax-files) and highlighting commands for one language are normally stored in a syntax file.	The name convention is: "{name}.vim".  Where {name} is the name of the language, or an abbreviation (to fit the name in 8.3 characters, a requirement in case the file is used on a DOS filesystem).
>
> The syntax file can contain any Ex commands, just like a vimrc file.  But the idea is that only commands for a specific language are included.  When a language is a superset of another language, it may include the other one, for example, the cpp.vim file could include the c.vim file:

```console
git clone https://github.com/nextflow-io/vim-language-nextflow.git
cd vim-language-nextflow
mkdir -p ~/.config/nvim/syntax
cp syntax/nextflow.vim ~/.config/nvim/syntax
```

Step 2. Install the Nextflow language server.

```console
VER=25.04.3
mkdir -p ${HOME}/opt/nfls/${VER}
wget -O ${HOME}/opt/nfls/${VER}/language-server-all.jar https://github.com/nextflow-io/language-server/releases/download/v${VER}/language-server-all.jar
```

Step 3. Add the following to `~/.config/nvim/init.lua`.

```
vim.lsp.enable('nextflow')

vim.lsp.config['nextflow'] = {
  cmd = { 'java', '-jar', '/home/dtang/opt/nfls/25.04.3/language-server-all.jar' },
  filetypes = { 'nextflow', 'nf', 'groovy', 'config' },
  root_markers = { 'nextflow.config', '.git' },
  settings = {
    nextflow = {
      files = {
        exclude = { '.git', '.nf-test', 'work' },
      }
    }
  }
}
```

