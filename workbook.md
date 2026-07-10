# Vim Workbook

A set of before/after exercises for deliberate Vim practice. For each exercise:

1. Copy the "Before" block into a scratch buffer (`:enew`).
    * Use `V` to start a line-select then yank it.
    * `:enew` to open an empty scratch buffer.
    * Use `p` to paste the yanked line.
    * Press Ctrl-^ to toggle between the two buffers; use `:bd!` to delete the buffer.
2. Read the **Goal** and try to reach the "After" state.
3. Try to use the motion/operator hinted at in the section title; there is usually more than one valid answer, but the hinted one is usually the shortest or most idiomatic.
4. Expand **Answer** to check your keystrokes.

Prefer fewer keystrokes, but prefer *composable* keystrokes even more. A slightly longer answer that reuses general motions is better than a one-off trick.

The exercises roughly progress from basic to advanced. Revisit the earlier ones often; muscle memory on the basics is what makes the advanced stuff feel effortless.

---

## 1. Change inside quotes (`ci"`)

**Goal:** replace the string literal, cursor starts anywhere on the line.

Before:
```
let name = "old value"
```

After:
```
let name = "new value"
```

<details>
<summary>Answer</summary>

```
ci"new value<Esc>
```

`ci"` = "change inside double quotes". Works from anywhere on the line; Vim finds the surrounding quotes. Works identically for `ci'`, `ci(`, `ci{`, `ci[`, `` ci` ``, and `cit` (inside an HTML/XML tag).

</details>

---

## 2. Change function arguments (`ci(`)

**Goal:** replace the argument list, cursor starts at column 0.

Before:
```
result = calculate(x, y, z)
```

After:
```
result = calculate(a, b, c)
```

<details>
<summary>Answer</summary>

```
ci(a, b, c<Esc>
```

Or `cib` (same thing; `b` is a synonym for `(` in text objects). No need to jump to the parens first; the text object finds them.

</details>

---

## 3. Delete a function body (`di{`)

**Goal:** empty the braces but keep them.

Before:
```
function greet() {
    console.log("hello")
    console.log("world")
}
```

After:
```
function greet() {
}
```

<details>
<summary>Answer</summary>

From anywhere inside the braces:
```
di{
```

`di{` deletes everything between the matching braces, including the newlines, leaving an empty block. Use `da{` if you also want to remove the braces themselves.

</details>

---

## 4. Uppercase a word (`gUiw`)

**Goal:** turn the identifier into SCREAMING_CASE. Cursor anywhere on `pi`.

Before:
```
const pi = 3.14159
```

After:
```
const PI = 3.14159
```

<details>
<summary>Answer</summary>

```
gUiw
```

`gU` = uppercase operator, `iw` = "inner word" text object. `guiw` is the lowercase version. `g~iw` toggles case. Use `gUU` to uppercase the whole line.

</details>

---

## 5. Join lines (`J`)

**Goal:** collapse three lines into one sentence, starting on line 1.

Before:
```
This is a
sentence split
across three lines.
```

After:
```
This is a sentence split across three lines.
```

<details>
<summary>Answer</summary>

```
2J
```

`J` joins the current line with the next. `2J` does it twice. Note that `J` is smart: it inserts a space between the joined parts (unless there's already whitespace or punctuation).

</details>

---

## 6. Add a suffix to every line (`:%norm`)

**Goal:** add `;` to the end of every line.

Before:
```
let x = 1
let y = 2
let z = 3
```

After:
```
let x = 1;
let y = 2;
let z = 3;
```

<details>
<summary>Answer</summary>

```
:%norm A;
```

`:%` = range "every line in the file". `norm` runs the following as normal-mode commands on each line. `A;` = append `;` at end of line. Same pattern for prefixing: `:%norm I# ` to comment every line.

</details>

---

## 7. Indent a block (visual line + `>`)

**Goal:** indent the body of the `if` by one shiftwidth. Cursor starts on the `doSomething();` line.

Before:
```
if (x) {
doSomething();
doSomethingElse();
}
```

After:
```
if (x) {
    doSomething();
    doSomethingElse();
}
```

<details>
<summary>Answer</summary>

```
Vj>
```

`V` enters visual-line mode, `j` extends selection down one line, `>` indents. Alternatively `2>>` (indent two lines starting from cursor) works without entering visual mode. Shiftwidth is controlled by `vim.opt.shiftwidth` (2 in your `init.lua`).

</details>

---

## 8. Swap two words (no built-in; combine motions)

**Goal:** swap `foo` and `bar`, leaving `baz` alone. Cursor on `foo`.

Before:
```
foo bar baz
```

After:
```
bar foo baz
```

<details>
<summary>Answer</summary>

```
dawwP
```

- `daw` deletes a word *including* the trailing space (register now holds `"foo "`), leaving `bar baz` with the cursor on `b`.
- `w` moves forward one word so the cursor lands on the `b` of `baz`.
- `P` pastes `"foo "` *before* the cursor: `bar ` + `foo ` + `baz`.

This idiom relies on `daw` taking the inter-word space with it, so the spacing reconstructs correctly when pasted before the next word. It does **not** work on a two-word line (no "next word" for `w` to land on); for that, fall back to `:s/\v(\S+) (\S+)/\2 \1/`.

</details>

---

## 9. Replace a word everywhere, interactively (`*` + `cgn` + `.`)

**Goal:** replace every `foo` with `bar`. Cursor starts on the first `foo`.

Before:
```
The foo is here. Another foo is there. A final foo appears.
```

After:
```
The bar is here. Another bar is there. A final bar appears.
```

<details>
<summary>Answer</summary>

```
*cgnbar<Esc>n.n.
```

- `*` searches for the word under cursor and jumps to the next match.
- `cgn` = change the next search match. After leaving insert mode this becomes a repeatable edit.
- `n.` jumps to the next match and repeats the change. Repeat until done.

This pattern is stronger than `:%s/foo/bar/g` when you want to visually inspect each replacement. For unconditional replacement, `:%s/\<foo\>/bar/g` is shorter.

</details>

---

## 10. Wrap every line in quotes (macro)

**Goal:** quote each fruit. Cursor starts on `apple`.

Before:
```
apple
banana
cherry
```

After:
```
"apple"
"banana"
"cherry"
```

<details>
<summary>Answer</summary>

```
qa I"<Esc>A"<Esc>j q
2@a
```

(Spaces added for readability; type without them.)

- `qa` starts recording into register `a`.
- `I"<Esc>` inserts `"` at start of line.
- `A"<Esc>` appends `"` at end of line.
- `j` moves to the next line (so the macro is self-advancing).
- `q` stops recording.
- `2@a` replays the macro twice on the remaining lines.

Non-macro alternative: `:%norm I"<Esc>A"` (one pass, runs on all lines).

</details>

---

## 11. Number the lines (`:normal` with an expression)

**Goal:** prefix each line with its line number.

Before:
```
apple
banana
cherry
```

After:
```
1. apple
2. banana
3. cherry
```

<details>
<summary>Answer</summary>

```
:%s/^/\=line('.').'. '/
```

- `:%s` substitutes on every line.
- `^` matches the start of line (zero-width).
- `\=` in the replacement means "evaluate as a Vim expression".
- `line('.')` returns the current line number; `.'. '` concatenates `. ` (dot-space).

This is one of the moments where Vim's command line becomes a tiny programming environment. Any Vimscript function can be used in the replacement.

</details>

---

## 12. Fix a list of files with the quickfix list

**Goal:** suppose `:grep TODO **/*.md` has populated the quickfix list with 30 matches across 10 files, and you want to replace each `TODO` with `DONE` after inspecting it.

<details>
<summary>Answer</summary>

```
:copen              " open the quickfix window
:cfirst             " jump to the first match
*cgnDONE<Esc>       " replace the word (cgn is repeatable)
:cnext              " jump to next match (or :cn)
.                   " repeat the change
:cnext              " and so on
```

Variation: `:cdo s/TODO/DONE/g | update` does the replacement across every quickfix entry in one command, saving each buffer. Use `:cfdo` for file-wide (one replace per file).

The general principle: the quickfix list + `cgn` + `.` + `:cnext` is a devastating combination for codebase-wide edits.

</details>

---

## 13. Repeat last change (`.`)

**Goal:** prefix each line with `// TODO: `. Cursor starts on line 1.

Before:
```
line one
line two
line three
```

After:
```
// TODO: line one
// TODO: line two
// TODO: line three
```

<details>
<summary>Answer</summary>

```
I// TODO: <Esc>
j.
j.
```

`.` repeats the last change (in this case, the whole insertion). Most Vim workflows are built around making each edit *repeatable with* `.`, then moving and repeating. This is why `cgn` (change next search match) is so powerful: it's designed to be `.`-friendly.

</details>

---

## 14. Visual block for column editing (`Ctrl-v`)

**Goal:** comment out three consecutive lines by prepending `// ` to each. Cursor starts at the start of the first line.

Before:
```
foo()
bar()
baz()
```

After:
```
// foo()
// bar()
// baz()
```

<details>
<summary>Answer</summary>

```
<Ctrl-v>jjI// <Esc>
```

- `Ctrl-v` enters visual block (columnar) mode.
- `jj` extends the block down two lines.
- `I// ` inserts `// ` at the block's left edge.
- On `<Esc>`, the insertion replicates to every line in the block.

Visual block is also how you delete a column (`d`), change a column (`c`), or append to a ragged column (`A`). Try `<Ctrl-v>jj$A;<Esc>` to append `;` to the end of three lines regardless of their length.

</details>

---

## 15. Increment a number (`Ctrl-a`)

**Goal:** bump the version number. Cursor anywhere on the line.

Before:
```
version = 42
```

After:
```
version = 43
```

<details>
<summary>Answer</summary>

```
<Ctrl-a>
```

`Ctrl-a` finds the next number on the line and increments it; `Ctrl-x` decrements. `5<Ctrl-a>` adds 5. With a visual block selection, `g<Ctrl-a>` creates an *incrementing sequence* (1, 2, 3, ...) which is magical for generating enumerated lists.

</details>

---

## 16. Jump to matching bracket (`%`)

**Goal:** delete the parenthesised argument list (with its nested call inside) but keep the function name. Cursor starts on the outer `(`.

Before:
```
result = outer(inner(a, b), c)
```

After:
```
result = outer
```

<details>
<summary>Answer</summary>

From the `(`:
```
d%
```

`%` jumps to the matching bracket (handles `()`, `[]`, `{}`, and nests correctly). `d%` deletes from the current bracket to its match, inclusive. Works from either side: start on the closing `)` and `d%` does the same delete in reverse.

`%` is also a useful motion on its own: land inside a messy block and press `%` to bounce between the opening and closing braces to see what's matched.

To delete the *whole* call (including `outer`), combine: `db` to step back over the name, then `dW` — or just `daW` from anywhere on `outer` if there's no whitespace inside the parens.

</details>

---

## 17. Delete every line matching a pattern (`:g`)

**Goal:** strip debug noise from a log.

Before:
```
info: server started
DEBUG: connection pool = 10
warn: slow query
DEBUG: cache miss
error: out of memory
DEBUG: gc triggered
```

After:
```
info: server started
warn: slow query
error: out of memory
```

<details>
<summary>Answer</summary>

```
:g/DEBUG/d
```

`:g/pattern/cmd` runs `cmd` on every line matching `pattern`. Here the command is `d` (delete). The inverse is `:v/pattern/d` (sometimes written `:g!/pattern/d`): delete every line *not* matching, i.e. keep only matches.

Other commands compose too: `:g/TODO/norm A (fixme)` appends ` (fixme)` to every line containing `TODO`.

</details>

---

## 18. Sort lines (`:sort`)

**Goal:** alphabetize the list and remove duplicates.

Before:
```
cherry
apple
banana
apple
date
```

After:
```
apple
banana
cherry
date
```

<details>
<summary>Answer</summary>

```
:sort u
```

`:sort` sorts the whole file (or a range); `u` makes it unique. Useful variants:
- `:sort n` sorts numerically (so `2` comes before `10`).
- `:sort!` reverses.
- `:sort /regex/` sorts by matching against a regex instead of the full line.
- Apply to a range: visually select lines then `:sort u` operates on just the selection.

</details>

---

## 19. Delete without clobbering the yank (`"_dd`)

**Goal:** You've just yanked `keep_me` (line 1) and want to paste it over line 3. But line 2 is in the way and needs to be deleted first without losing the yank.

Before (assume `"keep_me` is already in the default register from an earlier `yy`):
```
keep_me
delete_this
replace_me
```

After:
```
keep_me
keep_me
```

<details>
<summary>Answer</summary>

On line 2:
```
"_dd
```
Then on what was line 3 (now line 2):
```
Vp
```

`"_` is the black hole register: reads/writes here are discarded. `"_dd` deletes line 2 without touching the default register, so your yanked `keep_me` is still available. `Vp` selects a line and pastes over it.

Without `"_`, the `dd` would overwrite the default register with `delete_this` and you'd lose your yank. Think of `"_` as "shut up and just delete this".

</details>

---

## 20. Paragraph text objects (`dip`, `dap`)

**Goal:** delete the middle paragraph but keep the blank-line structure.

Before:
```
First paragraph line one.
First paragraph line two.

Second paragraph line one.
Second paragraph line two.

Third paragraph.
```

After:
```
First paragraph line one.
First paragraph line two.


Third paragraph.
```

<details>
<summary>Answer</summary>

Position cursor anywhere in the middle paragraph, then:
```
dip
```

`ip` = "inner paragraph" (the lines, not the surrounding blank lines). `ap` = "around paragraph" (includes one trailing blank line), which would have collapsed the spacing instead.

Paragraph text objects work on anything separated by blank lines, so they're useful for blocks of prose, config stanzas, and logically grouped code.

</details>

---

## 21. Count + motion (`4dw` vs `d4w`)

**Goal:** delete the first four words of the sentence. Cursor at column 0.

Before:
```
delete these four words and keep the rest of the sentence
```

After:
```
and keep the rest of the sentence
```

<details>
<summary>Answer</summary>

```
d4w
```

Or equivalently `4dw`. Counts can go before the operator, before the motion, or both (their product): `2d3w` deletes 6 words. This generalises everywhere: `5j` moves 5 lines down, `3yy` yanks 3 lines, `10x` deletes 10 characters.

A very common pattern is `<Ctrl-a>` preceded by a count: `10<Ctrl-a>` adds 10 to the next number.

</details>

---

## 22. Marks for navigation (`ma`, `` `a ``)

**Goal:** you're on line 500 of a file, need to check something on line 50, then come back.

<details>
<summary>Answer</summary>

On line 500:
```
ma
```
Jump away to line 50 (`:50`, `/pattern`, or whatever), do whatever you need, then:
```
`a
```

- `ma` sets mark `a` at the current position.
- `` `a `` (backtick) jumps to the exact position of mark `a`.
- `'a` (apostrophe) jumps to the line of mark `a` (column 0).

Marks `a-z` are per-file; marks `A-Z` are global and jump across files. Useful built-in marks you get for free:
- `` `` `` (two backticks) jumps to the position before the last jump. Pair it with `Ctrl-o` / `Ctrl-i` (jump list back/forward) for powerful navigation without setting anything explicitly.
- `` `. `` jumps to the position of your last edit.
- `` `^ `` jumps to the last insert-mode position.

</details>

---

## 23. Find a character on the line (`f`, `t`, `;`)

**Goal:** uppercase the third word. Cursor at column 0.

Before:
```
apple banana cherry date
```

After:
```
apple banana CHERRY date
```

<details>
<summary>Answer</summary>

```
fcgUiw
```

- `fc` jumps forward to the next `c` on the current line — the start of `cherry`.
- `gUiw` uppercases the inner word.

`f`/`F`/`t`/`T` are the workhorse intra-line motions:
- `fX` lands *on* the next `X`; `FX` searches backwards.
- `tX` lands one char *before* the next `X` — pairs naturally with operators (`dt"`, `ct,`).
- `;` repeats the last `f`/`F`/`t`/`T`; `,` repeats it in the opposite direction.
- `2fc` jumps directly to the second `c` on the line — count + motion.

Also valid here: `2wgUiw`. The `f`-version is shorter and works regardless of word count, which is why it's worth burning into muscle memory.

</details>

---

## 24. Substitute with confirmation (`:s//gc`)

**Goal:** replace `cat` with `dog`, but leave the regex pattern on line 2 untouched.

Before:
```
the cat sat on the mat
the regex is /cat/
another cat appears
```

After:
```
the dog sat on the mat
the regex is /cat/
another dog appears
```

<details>
<summary>Answer</summary>

```
:%s/cat/dog/gc
```

Then for each highlighted match, press:
- `y` to replace this one,
- `n` to skip,
- `a` to accept this and all remaining,
- `q` to quit,
- `l` to replace this one and stop.

The `c` flag turns `:s` into a guided edit instead of a blind sweep — the right tool when the regex is *almost* correct but you want to eyeball each match. Compare with Exercise 9 (`*` + `cgn` + `.`): `cgn` is best when you're navigating between matches and may want to make different edits; `:s//gc` is best when the edit is uniform but the *decision* per match isn't.

</details>

---

## Further practice

- `practice.md` in this repo has reference tips and shorter drills, plus the LSP and Telescope keymaps wired up in `init.lua` (`gd`, `K`, `gr`, `<leader>rn`, `<leader>ff`, `<leader>fg`, etc.) — those are interactive and don't fit the before/after format here, but they reward the same deliberate practice.
- `two_for_one.md` covers compound commands (`C`, `A`, `S`, `I`, etc.) that collapse two steps into one.
- [VimGolf](https://www.vimgolf.com) for golf-style before/after challenges scored by keystroke count.
- Run `:Tutor` in Neovim for the built-in interactive lesson (~30 min).
- `:Practice` (defined in `init.lua`) opens `practice.md` in a vsplit for quick reference while you drill in another window.

## How to get the most from this file

- Don't peek at answers on the first try. Struggle for at least a minute; that's where the learning happens.
- Once you find *an* answer, peek anyway. There's usually a shorter or more idiomatic one worth knowing.
- Redo each exercise a week later. Real competence is when you can do it without thinking, not when you've done it once.
- When an answer uses an unfamiliar command, run `:help <command>` and read the section. Five minutes of docs beats an hour of guessing.
