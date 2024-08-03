
## Keyboard Layout

**Portuguese Brazil ABNT2 with intl. keyboard**:

Set-up: Set F12 to change keyboard language, install [quick-lang-switch extension](https://extensions.gnome.org/extension/4559/quick-lang-switch) for GNOME to remove the animation and swich the language more quickly and configure macros for pipe (|) and \ (back-slash).


**English (intl. with AltGr dead keys)**:
An alternative option for intl. keyboards is using AltGr dead keys.
```
ALTGR + A = áááááááááá
ALTGR + O = óóóóóóóóóó
ALTGR + I = íííííííííí
ALTGR + U = úúúúúúúúúú
ALTGR + , = ççççççççç
ALTGR + ' + c = ççççççç

ALTGR + 6 + Space ou ALTGR + 6 + 6 = ^^^^^^^^^
ALTGR + 6 + E/A/O = êêê âââ

ALTGR + C = ©©©©©©©
ALTGR + ; = ¶¶¶¶¶¶¶¶¶
ALTGR + V = ®®®®®®®

ALTGR + \ = ¬¬ ¬¬
ALTGR + ] = »»»»»»»»
ALTGR + [ = «««««««
ALTGR + q = ääääää
ALTGR + n = ñññññññññ

ALTGR + ' (2x) = ´´´´´´´´
ALTGR + ` (2x) = ``````````
ALTGR + ` + a = àààààà
ALTGR + ' + a = áááááá
ALTGR + Shift + ` + a = ããããã
Shift + \ = |||||||||||||||
```

#### Fix cedilla (ç)
When using an international keyboard layout, run the following script and then log out:
```sh
chmod +x ~/.dotfiles/keyboard/fix-cedilla && ~/.dotfiles/keyboard/fix-cedilla
```


