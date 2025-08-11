## Practice

The only way to get good with Vim is by practicing. Here are some new shortcuts that I need to practice.

* Use `"+y` to yank to the clipboard
* Use `<CTRL> F` and `<CTRL> B` to scroll forward and backward a whole screen
* Use `H`, `M`, and `L` to move to the top, middle, and bottom of the current visible page.
* `J` to join two lines together
* `o` insert a new line after the current one
* `O` insert a new line before the current one
* `^` go to first non-blank character (good for indented code)
* `g_` go to the last non-blank character of line
* Use `>` to increase the indentation; for example select lines to indent and press `>`.

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

When using the vim-fugitive plugin `:Gdiffsplit` will show you the previous version in a split window! Use `]c` and `[c` to navigate the changes.

```
:Gdiffsplit
]c        " next change
[c        " previous change
```

`diffsplit` can be used to compare files; open the first file in Vim then:

```
:vert diffsplit otherfile
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
