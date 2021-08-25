## CSI sequences
Code          | Name                                  | Effect
-----         | -----                                 | -----
CSI n A       | CUU – Cursor Up                       | Moves the cursor n (default 1) cells in the given direction. If the cursor is already at the edge of the screen, this has no effect.
CSI n B       | CUD – Cursor Down                     |
CSI n C       | CUF – Cursor Forward                  |
CSI n D       | CUB – Cursor Back                     |
CSI n E       | CNL – Cursor Next Line                | Moves cursor to beginning of the line n (default 1) lines down. (not ANSI.SYS)
CSI n F       | CPL – Cursor Previous Line            | Moves cursor to beginning of the line n (default 1) lines up. (not ANSI.SYS)
CSI n G       | CHA – Cursor Horizontal Absolute      | Moves the cursor to column n (default 1). (not ANSI.SYS)
CSI n ; m H   | CUP – Cursor Position                 | Moves the cursor to row n, column m. The values are 1-based, and default to 1 (top left corner) if omitted. A sequence such as CSI ;5H is a synonym for CSI 1;5H as well as CSI 17;H is the same as CSI 17H and CSI 17;1H
CSI n J       | ED – Erase in Display                 | Clears part of the screen. If n is 0 (or missing), clear from cursor to end of screen. If n is 1, clear from cursor to beginning of the screen. If n is 2, clear entire screen (and moves cursor to upper left on DOS ANSI.SYS). If n is 3, clear entire screen and delete all lines saved in the scrollback buffer (this feature was added for xterm and is supported by other terminal applications).
CSI n K       | EL – Erase in Line                    | Erases part of the line. If n is 0 (or missing), clear from cursor to the end of the line. If n is 1, clear from cursor to beginning of the line. If n is 2, clear entire line. Cursor position does not change.
CSI n S       | SU – Scroll Up                        | Scroll whole page up by n (default 1) lines. New lines are added at the bottom. (not ANSI.SYS)
CSI n T       | SD – Scroll Down                      | Scroll whole page down by n (default 1) lines. New lines are added at the top. (not ANSI.SYS)
CSI n ; m f   | HVP – Horizontal Vertical Position    | Same as CUP
CSI n m       | SGR – Select Graphic Rendition        | Sets the appearance of the following characters, see SGR parameters below.
CSI 5i        | AUX Port On                           | Enable aux serial port usually for local serial printer
CSI 4i        | AUX Port Off                          | Disable aux serial port usually for local serial printer
CSI 6n        | DSR – Device Status Report            | Reports the cursor position (CPR) to the application as (as though typed at the keyboard) ESC[n;mR, where n is the row and m is the column.)
CSI s         | SCP – Save Cursor Position            | Saves the cursor position/state.
CSI u         | RCP – Restore Cursor Position         | Restores the cursor position/state.

## Some popular private sequences
Code            | Effect
-----           | -----
CSI ? 25 h      | DECTCEM Shows the cursor, from the VT320.
CSI ? 25 l      | DECTCEM Hides the cursor.
CSI ? 1049 h    | Enable alternative screen buffer
CSI ? 1049 l    | Disable alternative screen buffer
CSI ? 2004 h    | Turn on bracketed paste mode. Text pasted into the terminal will be surrounded by ESC [200~ and ESC [201~, and characters in it should not be treated as commands (for example in Vim).[20] From Unix terminal emulators.
CSI ? 2004 l    | Turn off bracketed paste mode.

## SGR parameters
Code    | Effect                                                        | Note
-----   | -----                                                         | -----
0       | Reset / Normal                                                | all attributes off
1       | Bold or increased intensity                                   |
2       | Faint (decreased intensity)                                   |
3       | Italic                                                        | Not widely supported. Sometimes treated as inverse.
4       | Underline                                                     |
5       | Slow Blink                                                    | less than 150 per minute
6       | Rapid Blink                                                   | MS-DOS ANSI.SYS; 150+ per minute; not widely supported
7       | reverse video                                                 | swap foreground and background colors
8       | Conceal                                                       | Not widely supported.
9       | Crossed-out                                                   | Characters legible, but marked for deletion.
10      | Primary(default) font                                         |
11–19   | Alternative font                                              | Select alternative font {\displaystyle n-10} {\displaystyle n-10}
20      | Fraktur                                                       | Rarely supported
21      | Doubly underline or Bold off                                  | Double-underline per ECMA-48.[22] See discussion
22      | Normal color or intensity                                     | Neither bold nor faint
23      | Not italic, not Fraktur                                       |
24      | Underline off                                                 | Not singly or doubly underlined
25      | Blink off                                                     |
27      | Inverse off                                                   |
28      | Reveal                                                        | conceal off
29      | Not crossed out                                               |
30–37   | Set foreground color                                          | See color table below
38      | Set foreground color                                          | Next arguments are 5;n or 2;r;g;b, see below
39      | Default foreground color                                      | implementation defined (according to standard)
40–47   | Set background color                                          | See color table below
48      | Set background color                                          | Next arguments are 5;n or 2;r;g;b, see below
49      | Default background color                                      | implementation defined (according to standard)
51      | Framed                                                        |
52      | Encircled                                                     |
53      | Overlined                                                     |
54      | Not framed or encircled                                       |
55      | Not overlined                                                 |
60      | ideogram underline or right side line                         | Rarely supported
61      | ideogram double underline or double line on the right side    | Rarely supported
62      | ideogram overline or left side line                           | Rarely supported
63      | ideogram double overline or double line on the left side      | Rarely supported
64      | ideogram stress marking                                       | Rarely supported
65      | ideogram attributes off                                       | reset the effects of all of 60–64
90–97   | Set bright foreground color                                   | aixterm (not in standard)
100–107 | Set bright background color                                   | aixterm (not in standard)

## Color code
### Foreground
Black: \u001b[30m
Red: \u001b[31m
Green: \u001b[32m
Yellow: \u001b[33m
Blue: \u001b[34m
Magenta: \u001b[35m
Cyan: \u001b[36m
White: \u001b[37m
Bright Black: \u001b[30;1m
Bright Red: \u001b[31;1m
Bright Green: \u001b[32;1m
Bright Yellow: \u001b[33;1m
Bright Blue: \u001b[34;1m
Bright Magenta: \u001b[35;1m
Bright Cyan: \u001b[36;1m
Bright White: \u001b[37;1m

### Background
Background Black: \u001b[40m
Background Red: \u001b[41m
Background Green: \u001b[42m
Background Yellow: \u001b[43m
Background Blue: \u001b[44m
Background Magenta: \u001b[45m
Background Cyan: \u001b[46m
Background White: \u001b[47m
Background Bright Black: \u001b[40;1m
Background Bright Red: \u001b[41;1m
Background Bright Green: \u001b[42;1m
Background Bright Yellow: \u001b[43;1m
Background Bright Blue: \u001b[44;1m
Background Bright Magenta: \u001b[45;1m
Background Bright Cyan: \u001b[46;1m
Background Bright White: \u001b[47;1m

### Reset
Reset: \u001b[0m
