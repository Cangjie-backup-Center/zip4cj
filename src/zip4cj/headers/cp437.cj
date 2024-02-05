package zip4cj.headers

let encode_arr: Array<Char> = [
    '\u{00}', //  0x0000 -> NULL
    '\u{01}', //  0x0001 -> START OF HEADING
    '\u{02}', //  0x0002 -> START OF TEXT
    '\u{03}', //  0x0003 -> END OF TEXT
    '\u{04}', //  0x0004 -> END OF TRANSMISSION
    '\u{05}', //  0x0005 -> ENQUIRY
    '\u{06}', //  0x0006 -> ACKNOWLEDGE
    '\u{07}', //  0x0007 -> BELL
    '\u{08}', //  0x0008 -> BACKSPACE
    '\t', //  0x0009 -> HORIZONTAL TABULATION
    '\n', //  0x000a -> LINE FEED
    '\u{0b}', //  0x000b -> VERTICAL TABULATION
    '\u{0c}', //  0x000c -> FORM FEED
    '\r', //  0x000d -> CARRIAGE RETURN
    '\u{0e}', //  0x000e -> SHIFT OUT
    '\u{0f}', //  0x000f -> SHIFT IN
    '\u{10}', //  0x0010 -> DATA LINK ESCAPE
    '\u{11}', //  0x0011 -> DEVICE CONTROL ONE
    '\u{12}', //  0x0012 -> DEVICE CONTROL TWO
    '\u{13}', //  0x0013 -> DEVICE CONTROL THREE
    '\u{14}', //  0x0014 -> DEVICE CONTROL FOUR
    '\u{15}', //  0x0015 -> NEGATIVE ACKNOWLEDGE
    '\u{16}', //  0x0016 -> SYNCHRONOUS IDLE
    '\u{17}', //  0x0017 -> END OF TRANSMISSION BLOCK
    '\u{18}', //  0x0018 -> CANCEL
    '\u{19}', //  0x0019 -> END OF MEDIUM
    '\u{1a}', //  0x001a -> SUBSTITUTE
    '\u{1b}', //  0x001b -> ESCAPE
    '\u{1c}', //  0x001c -> FILE SEPARATOR
    '\u{1d}', //  0x001d -> GROUP SEPARATOR
    '\u{1e}', //  0x001e -> RECORD SEPARATOR
    '\u{1f}', //  0x001f -> UNIT SEPARATOR
    ' ', //  0x0020 -> SPACE
    '!', //  0x0021 -> EXCLAMATION MARK
    '"', //  0x0022 -> QUOTATION MARK
    '#', //  0x0023 -> NUMBER SIGN
    '$', //  0x0024 -> DOLLAR SIGN
    '%', //  0x0025 -> PERCENT SIGN
    '&', //  0x0026 -> AMPERSAND
    '\'', //  0x0027 -> APOSTROPHE
    '(', //  0x0028 -> LEFT PARENTHESIS
    ')', //  0x0029 -> RIGHT PARENTHESIS
    '*', //  0x002a -> ASTERISK
    '+', //  0x002b -> PLUS SIGN
    ',', //  0x002c -> COMMA
    '-', //  0x002d -> HYPHEN-MINUS
    '.', //  0x002e -> FULL STOP
    '/', //  0x002f -> SOLIDUS
    '0', //  0x0030 -> DIGIT ZERO
    '1', //  0x0031 -> DIGIT ONE
    '2', //  0x0032 -> DIGIT TWO
    '3', //  0x0033 -> DIGIT THREE
    '4', //  0x0034 -> DIGIT FOUR
    '5', //  0x0035 -> DIGIT FIVE
    '6', //  0x0036 -> DIGIT SIX
    '7', //  0x0037 -> DIGIT SEVEN
    '8', //  0x0038 -> DIGIT EIGHT
    '9', //  0x0039 -> DIGIT NINE
    ':', //  0x003a -> COLON
    ';', //  0x003b -> SEMICOLON
    '<', //  0x003c -> LESS-THAN SIGN
    '=', //  0x003d -> EQUALS SIGN
    '>', //  0x003e -> GREATER-THAN SIGN
    '?', //  0x003f -> QUESTION MARK
    '@', //  0x0040 -> COMMERCIAL AT
    'A', //  0x0041 -> LATIN CAPITAL LETTER A
    'B', //  0x0042 -> LATIN CAPITAL LETTER B
    'C', //  0x0043 -> LATIN CAPITAL LETTER C
    'D', //  0x0044 -> LATIN CAPITAL LETTER D
    'E', //  0x0045 -> LATIN CAPITAL LETTER E
    'F', //  0x0046 -> LATIN CAPITAL LETTER F
    'G', //  0x0047 -> LATIN CAPITAL LETTER G
    'H', //  0x0048 -> LATIN CAPITAL LETTER H
    'I', //  0x0049 -> LATIN CAPITAL LETTER I
    'J', //  0x004a -> LATIN CAPITAL LETTER J
    'K', //  0x004b -> LATIN CAPITAL LETTER K
    'L', //  0x004c -> LATIN CAPITAL LETTER L
    'M', //  0x004d -> LATIN CAPITAL LETTER M
    'N', //  0x004e -> LATIN CAPITAL LETTER N
    'O', //  0x004f -> LATIN CAPITAL LETTER O
    'P', //  0x0050 -> LATIN CAPITAL LETTER P
    'Q', //  0x0051 -> LATIN CAPITAL LETTER Q
    'R', //  0x0052 -> LATIN CAPITAL LETTER R
    'S', //  0x0053 -> LATIN CAPITAL LETTER S
    'T', //  0x0054 -> LATIN CAPITAL LETTER T
    'U', //  0x0055 -> LATIN CAPITAL LETTER U
    'V', //  0x0056 -> LATIN CAPITAL LETTER V
    'W', //  0x0057 -> LATIN CAPITAL LETTER W
    'X', //  0x0058 -> LATIN CAPITAL LETTER X
    'Y', //  0x0059 -> LATIN CAPITAL LETTER Y
    'Z', //  0x005a -> LATIN CAPITAL LETTER Z
    '[', //  0x005b -> LEFT SQUARE BRACKET
    '\\', //  0x005c -> REVERSE SOLIDUS
    ']', //  0x005d -> RIGHT SQUARE BRACKET
    '^', //  0x005e -> CIRCUMFLEX ACCENT
    '_', //  0x005f -> LOW LINE
    '`', //  0x0060 -> GRAVE ACCENT
    'a', //  0x0061 -> LATIN SMALL LETTER A
    'b', //  0x0062 -> LATIN SMALL LETTER B
    'c', //  0x0063 -> LATIN SMALL LETTER C
    'd', //  0x0064 -> LATIN SMALL LETTER D
    'e', //  0x0065 -> LATIN SMALL LETTER E
    'f', //  0x0066 -> LATIN SMALL LETTER F
    'g', //  0x0067 -> LATIN SMALL LETTER G
    'h', //  0x0068 -> LATIN SMALL LETTER H
    'i', //  0x0069 -> LATIN SMALL LETTER I
    'j', //  0x006a -> LATIN SMALL LETTER J
    'k', //  0x006b -> LATIN SMALL LETTER K
    'l', //  0x006c -> LATIN SMALL LETTER L
    'm', //  0x006d -> LATIN SMALL LETTER M
    'n', //  0x006e -> LATIN SMALL LETTER N
    'o', //  0x006f -> LATIN SMALL LETTER O
    'p', //  0x0070 -> LATIN SMALL LETTER P
    'q', //  0x0071 -> LATIN SMALL LETTER Q
    'r', //  0x0072 -> LATIN SMALL LETTER R
    's', //  0x0073 -> LATIN SMALL LETTER S
    't', //  0x0074 -> LATIN SMALL LETTER T
    'u', //  0x0075 -> LATIN SMALL LETTER U
    'v', //  0x0076 -> LATIN SMALL LETTER V
    'w', //  0x0077 -> LATIN SMALL LETTER W
    'x', //  0x0078 -> LATIN SMALL LETTER X
    'y', //  0x0079 -> LATIN SMALL LETTER Y
    'z', //  0x007a -> LATIN SMALL LETTER Z
    '{', //  0x007b -> LEFT CURLY BRACKET
    '|', //  0x007c -> VERTICAL LINE
    '}', //  0x007d -> RIGHT CURLY BRACKET
    '~', //  0x007e -> TILDE
    '\u{7f}', //  0x007f -> DELETE
    '\u{c7}', //  0x0080 -> LATIN CAPITAL LETTER C WITH CEDILLA
    '\u{fc}', //  0x0081 -> LATIN SMALL LETTER U WITH DIAERESIS
    '\u{e9}', //  0x0082 -> LATIN SMALL LETTER E WITH ACUTE
    '\u{e2}', //  0x0083 -> LATIN SMALL LETTER A WITH CIRCUMFLEX
    '\u{e4}', //  0x0084 -> LATIN SMALL LETTER A WITH DIAERESIS
    '\u{e0}', //  0x0085 -> LATIN SMALL LETTER A WITH GRAVE
    '\u{e5}', //  0x0086 -> LATIN SMALL LETTER A WITH RING ABOVE
    '\u{e7}', //  0x0087 -> LATIN SMALL LETTER C WITH CEDILLA
    '\u{ea}', //  0x0088 -> LATIN SMALL LETTER E WITH CIRCUMFLEX
    '\u{eb}', //  0x0089 -> LATIN SMALL LETTER E WITH DIAERESIS
    '\u{e8}', //  0x008a -> LATIN SMALL LETTER E WITH GRAVE
    '\u{ef}', //  0x008b -> LATIN SMALL LETTER I WITH DIAERESIS
    '\u{ee}', //  0x008c -> LATIN SMALL LETTER I WITH CIRCUMFLEX
    '\u{ec}', //  0x008d -> LATIN SMALL LETTER I WITH GRAVE
    '\u{c4}', //  0x008e -> LATIN CAPITAL LETTER A WITH DIAERESIS
    '\u{c5}', //  0x008f -> LATIN CAPITAL LETTER A WITH RING ABOVE
    '\u{c9}', //  0x0090 -> LATIN CAPITAL LETTER E WITH ACUTE
    '\u{e6}', //  0x0091 -> LATIN SMALL LIGATURE AE
    '\u{c6}', //  0x0092 -> LATIN CAPITAL LIGATURE AE
    '\u{f4}', //  0x0093 -> LATIN SMALL LETTER O WITH CIRCUMFLEX
    '\u{f6}', //  0x0094 -> LATIN SMALL LETTER O WITH DIAERESIS
    '\u{f2}', //  0x0095 -> LATIN SMALL LETTER O WITH GRAVE
    '\u{fb}', //  0x0096 -> LATIN SMALL LETTER U WITH CIRCUMFLEX
    '\u{f9}', //  0x0097 -> LATIN SMALL LETTER U WITH GRAVE
    '\u{ff}', //  0x0098 -> LATIN SMALL LETTER Y WITH DIAERESIS
    '\u{d6}', //  0x0099 -> LATIN CAPITAL LETTER O WITH DIAERESIS
    '\u{dc}', //  0x009a -> LATIN CAPITAL LETTER U WITH DIAERESIS
    '\u{a2}', //  0x009b -> CENT SIGN
    '\u{a3}', //  0x009c -> POUND SIGN
    '\u{a5}', //  0x009d -> YEN SIGN
    '\u{20a7}', //  0x009e -> PESETA SIGN
    '\u{0192}', //  0x009f -> LATIN SMALL LETTER F WITH HOOK
    '\u{e1}', //  0x00a0 -> LATIN SMALL LETTER A WITH ACUTE
    '\u{ed}', //  0x00a1 -> LATIN SMALL LETTER I WITH ACUTE
    '\u{f3}', //  0x00a2 -> LATIN SMALL LETTER O WITH ACUTE
    '\u{fa}', //  0x00a3 -> LATIN SMALL LETTER U WITH ACUTE
    '\u{f1}', //  0x00a4 -> LATIN SMALL LETTER N WITH TILDE
    '\u{d1}', //  0x00a5 -> LATIN CAPITAL LETTER N WITH TILDE
    '\u{aa}', //  0x00a6 -> FEMININE ORDINAL INDICATOR
    '\u{ba}', //  0x00a7 -> MASCULINE ORDINAL INDICATOR
    '\u{bf}', //  0x00a8 -> INVERTED QUESTION MARK
    '\u{2310}', //  0x00a9 -> REVERSED NOT SIGN
    '\u{ac}', //  0x00aa -> NOT SIGN
    '\u{bd}', //  0x00ab -> VULGAR FRACTION ONE HALF
    '\u{bc}', //  0x00ac -> VULGAR FRACTION ONE QUARTER
    '\u{a1}', //  0x00ad -> INVERTED EXCLAMATION MARK
    '\u{ab}', //  0x00ae -> LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    '\u{bb}', //  0x00af -> RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    '\u{2591}', //  0x00b0 -> LIGHT SHADE
    '\u{2592}', //  0x00b1 -> MEDIUM SHADE
    '\u{2593}', //  0x00b2 -> DARK SHADE
    '\u{2502}', //  0x00b3 -> BOX DRAWINGS LIGHT VERTICAL
    '\u{2524}', //  0x00b4 -> BOX DRAWINGS LIGHT VERTICAL AND LEFT
    '\u{2561}', //  0x00b5 -> BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    '\u{2562}', //  0x00b6 -> BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    '\u{2556}', //  0x00b7 -> BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    '\u{2555}', //  0x00b8 -> BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    '\u{2563}', //  0x00b9 -> BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    '\u{2551}', //  0x00ba -> BOX DRAWINGS DOUBLE VERTICAL
    '\u{2557}', //  0x00bb -> BOX DRAWINGS DOUBLE DOWN AND LEFT
    '\u{255d}', //  0x00bc -> BOX DRAWINGS DOUBLE UP AND LEFT
    '\u{255c}', //  0x00bd -> BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    '\u{255b}', //  0x00be -> BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    '\u{2510}', //  0x00bf -> BOX DRAWINGS LIGHT DOWN AND LEFT
    '\u{2514}', //  0x00c0 -> BOX DRAWINGS LIGHT UP AND RIGHT
    '\u{2534}', //  0x00c1 -> BOX DRAWINGS LIGHT UP AND HORIZONTAL
    '\u{252c}', //  0x00c2 -> BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    '\u{251c}', //  0x00c3 -> BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    '\u{2500}', //  0x00c4 -> BOX DRAWINGS LIGHT HORIZONTAL
    '\u{253c}', //  0x00c5 -> BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    '\u{255e}', //  0x00c6 -> BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    '\u{255f}', //  0x00c7 -> BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    '\u{255a}', //  0x00c8 -> BOX DRAWINGS DOUBLE UP AND RIGHT
    '\u{2554}', //  0x00c9 -> BOX DRAWINGS DOUBLE DOWN AND RIGHT
    '\u{2569}', //  0x00ca -> BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    '\u{2566}', //  0x00cb -> BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    '\u{2560}', //  0x00cc -> BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    '\u{2550}', //  0x00cd -> BOX DRAWINGS DOUBLE HORIZONTAL
    '\u{256c}', //  0x00ce -> BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    '\u{2567}', //  0x00cf -> BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    '\u{2568}', //  0x00d0 -> BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    '\u{2564}', //  0x00d1 -> BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    '\u{2565}', //  0x00d2 -> BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    '\u{2559}', //  0x00d3 -> BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    '\u{2558}', //  0x00d4 -> BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    '\u{2552}', //  0x00d5 -> BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    '\u{2553}', //  0x00d6 -> BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    '\u{256b}', //  0x00d7 -> BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    '\u{256a}', //  0x00d8 -> BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    '\u{2518}', //  0x00d9 -> BOX DRAWINGS LIGHT UP AND LEFT
    '\u{250c}', //  0x00da -> BOX DRAWINGS LIGHT DOWN AND RIGHT
    '\u{2588}', //  0x00db -> FULL BLOCK
    '\u{2584}', //  0x00dc -> LOWER HALF BLOCK
    '\u{258c}', //  0x00dd -> LEFT HALF BLOCK
    '\u{2590}', //  0x00de -> RIGHT HALF BLOCK
    '\u{2580}', //  0x00df -> UPPER HALF BLOCK
    '\u{03b1}', //  0x00e0 -> GREEK SMALL LETTER ALPHA
    '\u{df}', //  0x00e1 -> LATIN SMALL LETTER SHARP S
    '\u{0393}', //  0x00e2 -> GREEK CAPITAL LETTER GAMMA
    '\u{03c0}', //  0x00e3 -> GREEK SMALL LETTER PI
    '\u{03a3}', //  0x00e4 -> GREEK CAPITAL LETTER SIGMA
    '\u{03c3}', //  0x00e5 -> GREEK SMALL LETTER SIGMA
    '\u{b5}', //  0x00e6 -> MICRO SIGN
    '\u{03c4}', //  0x00e7 -> GREEK SMALL LETTER TAU
    '\u{03a6}', //  0x00e8 -> GREEK CAPITAL LETTER PHI
    '\u{0398}', //  0x00e9 -> GREEK CAPITAL LETTER THETA
    '\u{03a9}', //  0x00ea -> GREEK CAPITAL LETTER OMEGA
    '\u{03b4}', //  0x00eb -> GREEK SMALL LETTER DELTA
    '\u{221e}', //  0x00ec -> INFINITY
    '\u{03c6}', //  0x00ed -> GREEK SMALL LETTER PHI
    '\u{03b5}', //  0x00ee -> GREEK SMALL LETTER EPSILON
    '\u{2229}', //  0x00ef -> INTERSECTION
    '\u{2261}', //  0x00f0 -> IDENTICAL TO
    '\u{b1}', //  0x00f1 -> PLUS-MINUS SIGN
    '\u{2265}', //  0x00f2 -> GREATER-THAN OR EQUAL TO
    '\u{2264}', //  0x00f3 -> LESS-THAN OR EQUAL TO
    '\u{2320}', //  0x00f4 -> TOP HALF INTEGRAL
    '\u{2321}', //  0x00f5 -> BOTTOM HALF INTEGRAL
    '\u{f7}', //  0x00f6 -> DIVISION SIGN
    '\u{2248}', //  0x00f7 -> ALMOST EQUAL TO
    '\u{b0}', //  0x00f8 -> DEGREE SIGN
    '\u{2219}', //  0x00f9 -> BULLET OPERATOR
    '\u{b7}', //  0x00fa -> MIDDLE DOT
    '\u{221a}', //  0x00fb -> SQUARE ROOT
    '\u{207f}', //  0x00fc -> SUPERSCRIPT LATIN SMALL LETTER N
    '\u{b2}', //  0x00fd -> SUPERSCRIPT TWO
    '\u{25a0}', //  0x00fe -> BLACK SQUARE
    '\u{a0}' //  0x00ff -> NO-BREAK SPACE
]

let encode_map: HashMap<Int64, Char> = HashMap<Int64, Char>(
    [
        (0x0080, '\u{00c7}'), //  LATIN CAPITAL LETTER C WITH CEDILLA
        (0x0081, '\u{00fc}'), //  LATIN SMALL LETTER U WITH DIAERESIS
        (0x0082, '\u{00e9}'), //  LATIN SMALL LETTER E WITH ACUTE
        (0x0083, '\u{00e2}'), //  LATIN SMALL LETTER A WITH CIRCUMFLEX
        (0x0084, '\u{00e4}'), //  LATIN SMALL LETTER A WITH DIAERESIS
        (0x0085, '\u{00e0}'), //  LATIN SMALL LETTER A WITH GRAVE
        (0x0086, '\u{00e5}'), //  LATIN SMALL LETTER A WITH RING ABOVE
        (0x0087, '\u{00e7}'), //  LATIN SMALL LETTER C WITH CEDILLA
        (0x0088, '\u{00ea}'), //  LATIN SMALL LETTER E WITH CIRCUMFLEX
        (0x0089, '\u{00eb}'), //  LATIN SMALL LETTER E WITH DIAERESIS
        (0x008a, '\u{00e8}'), //  LATIN SMALL LETTER E WITH GRAVE
        (0x008b, '\u{00ef}'), //  LATIN SMALL LETTER I WITH DIAERESIS
        (0x008c, '\u{00ee}'), //  LATIN SMALL LETTER I WITH CIRCUMFLEX
        (0x008d, '\u{00ec}'), //  LATIN SMALL LETTER I WITH GRAVE
        (0x008e, '\u{00c4}'), //  LATIN CAPITAL LETTER A WITH DIAERESIS
        (0x008f, '\u{00c5}'), //  LATIN CAPITAL LETTER A WITH RING ABOVE
        (0x0090, '\u{00c9}'), //  LATIN CAPITAL LETTER E WITH ACUTE
        (0x0091, '\u{00e6}'), //  LATIN SMALL LIGATURE AE
        (0x0092, '\u{00c6}'), //  LATIN CAPITAL LIGATURE AE
        (0x0093, '\u{00f4}'), //  LATIN SMALL LETTER O WITH CIRCUMFLEX
        (0x0094, '\u{00f6}'), //  LATIN SMALL LETTER O WITH DIAERESIS
        (0x0095, '\u{00f2}'), //  LATIN SMALL LETTER O WITH GRAVE
        (0x0096, '\u{00fb}'), //  LATIN SMALL LETTER U WITH CIRCUMFLEX
        (0x0097, '\u{00f9}'), //  LATIN SMALL LETTER U WITH GRAVE
        (0x0098, '\u{00ff}'), //  LATIN SMALL LETTER Y WITH DIAERESIS
        (0x0099, '\u{00d6}'), //  LATIN CAPITAL LETTER O WITH DIAERESIS
        (0x009a, '\u{00dc}'), //  LATIN CAPITAL LETTER U WITH DIAERESIS
        (0x009b, '\u{00a2}'), //  CENT SIGN
        (0x009c, '\u{00a3}'), //  POUND SIGN
        (0x009d, '\u{00a5}'), //  YEN SIGN
        (0x009e, '\u{20a7}'), //  PESETA SIGN
        (0x009f, '\u{0192}'), //  LATIN SMALL LETTER F WITH HOOK
        (0x00a0, '\u{00e1}'), //  LATIN SMALL LETTER A WITH ACUTE
        (0x00a1, '\u{00ed}'), //  LATIN SMALL LETTER I WITH ACUTE
        (0x00a2, '\u{00f3}'), //  LATIN SMALL LETTER O WITH ACUTE
        (0x00a3, '\u{00fa}'), //  LATIN SMALL LETTER U WITH ACUTE
        (0x00a4, '\u{00f1}'), //  LATIN SMALL LETTER N WITH TILDE
        (0x00a5, '\u{00d1}'), //  LATIN CAPITAL LETTER N WITH TILDE
        (0x00a6, '\u{00aa}'), //  FEMININE ORDINAL INDICATOR
        (0x00a7, '\u{00ba}'), //  MASCULINE ORDINAL INDICATOR
        (0x00a8, '\u{00bf}'), //  INVERTED QUESTION MARK
        (0x00a9, '\u{2310}'), //  REVERSED NOT SIGN
        (0x00aa, '\u{00ac}'), //  NOT SIGN
        (0x00ab, '\u{00bd}'), //  VULGAR FRACTION ONE HALF
        (0x00ac, '\u{00bc}'), //  VULGAR FRACTION ONE QUARTER
        (0x00ad, '\u{00a1}'), //  INVERTED EXCLAMATION MARK
        (0x00ae, '\u{00ab}'), //  LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
        (0x00af, '\u{00bb}'), //  RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
        (0x00b0, '\u{2591}'), //  LIGHT SHADE
        (0x00b1, '\u{2592}'), //  MEDIUM SHADE
        (0x00b2, '\u{2593}'), //  DARK SHADE
        (0x00b3, '\u{2502}'), //  BOX DRAWINGS LIGHT VERTICAL
        (0x00b4, '\u{2524}'), //  BOX DRAWINGS LIGHT VERTICAL AND LEFT
        (0x00b5, '\u{2561}'), //  BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
        (0x00b6, '\u{2562}'), //  BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
        (0x00b7, '\u{2556}'), //  BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
        (0x00b8, '\u{2555}'), //  BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
        (0x00b9, '\u{2563}'), //  BOX DRAWINGS DOUBLE VERTICAL AND LEFT
        (0x00ba, '\u{2551}'), //  BOX DRAWINGS DOUBLE VERTICAL
        (0x00bb, '\u{2557}'), //  BOX DRAWINGS DOUBLE DOWN AND LEFT
        (0x00bc, '\u{255d}'), //  BOX DRAWINGS DOUBLE UP AND LEFT
        (0x00bd, '\u{255c}'), //  BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
        (0x00be, '\u{255b}'), //  BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
        (0x00bf, '\u{2510}'), //  BOX DRAWINGS LIGHT DOWN AND LEFT
        (0x00c0, '\u{2514}'), //  BOX DRAWINGS LIGHT UP AND RIGHT
        (0x00c1, '\u{2534}'), //  BOX DRAWINGS LIGHT UP AND HORIZONTAL
        (0x00c2, '\u{252c}'), //  BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
        (0x00c3, '\u{251c}'), //  BOX DRAWINGS LIGHT VERTICAL AND RIGHT
        (0x00c4, '\u{2500}'), //  BOX DRAWINGS LIGHT HORIZONTAL
        (0x00c5, '\u{253c}'), //  BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
        (0x00c6, '\u{255e}'), //  BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
        (0x00c7, '\u{255f}'), //  BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
        (0x00c8, '\u{255a}'), //  BOX DRAWINGS DOUBLE UP AND RIGHT
        (0x00c9, '\u{2554}'), //  BOX DRAWINGS DOUBLE DOWN AND RIGHT
        (0x00ca, '\u{2569}'), //  BOX DRAWINGS DOUBLE UP AND HORIZONTAL
        (0x00cb, '\u{2566}'), //  BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
        (0x00cc, '\u{2560}'), //  BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
        (0x00cd, '\u{2550}'), //  BOX DRAWINGS DOUBLE HORIZONTAL
        (0x00ce, '\u{256c}'), //  BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
        (0x00cf, '\u{2567}'), //  BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
        (0x00d0, '\u{2568}'), //  BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
        (0x00d1, '\u{2564}'), //  BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
        (0x00d2, '\u{2565}'), //  BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
        (0x00d3, '\u{2559}'), //  BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
        (0x00d4, '\u{2558}'), //  BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
        (0x00d5, '\u{2552}'), //  BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
        (0x00d6, '\u{2553}'), //  BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
        (0x00d7, '\u{256b}'), //  BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
        (0x00d8, '\u{256a}'), //  BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
        (0x00d9, '\u{2518}'), //  BOX DRAWINGS LIGHT UP AND LEFT
        (0x00da, '\u{250c}'), //  BOX DRAWINGS LIGHT DOWN AND RIGHT
        (0x00db, '\u{2588}'), //  FULL BLOCK
        (0x00dc, '\u{2584}'), //  LOWER HALF BLOCK
        (0x00dd, '\u{258c}'), //  LEFT HALF BLOCK
        (0x00de, '\u{2590}'), //  RIGHT HALF BLOCK
        (0x00df, '\u{2580}'), //  UPPER HALF BLOCK
        (0x00e0, '\u{03b1}'), //  GREEK SMALL LETTER ALPHA
        (0x00e1, '\u{00df}'), //  LATIN SMALL LETTER SHARP S
        (0x00e2, '\u{0393}'), //  GREEK CAPITAL LETTER GAMMA
        (0x00e3, '\u{03c0}'), //  GREEK SMALL LETTER PI
        (0x00e4, '\u{03a3}'), //  GREEK CAPITAL LETTER SIGMA
        (0x00e5, '\u{03c3}'), //  GREEK SMALL LETTER SIGMA
        (0x00e6, '\u{00b5}'), //  MICRO SIGN
        (0x00e7, '\u{03c4}'), //  GREEK SMALL LETTER TAU
        (0x00e8, '\u{03a6}'), //  GREEK CAPITAL LETTER PHI
        (0x00e9, '\u{0398}'), //  GREEK CAPITAL LETTER THETA
        (0x00ea, '\u{03a9}'), //  GREEK CAPITAL LETTER OMEGA
        (0x00eb, '\u{03b4}'), //  GREEK SMALL LETTER DELTA
        (0x00ec, '\u{221e}'), //  INFINITY
        (0x00ed, '\u{03c6}'), //  GREEK SMALL LETTER PHI
        (0x00ee, '\u{03b5}'), //  GREEK SMALL LETTER EPSILON
        (0x00ef, '\u{2229}'), //  INTERSECTION
        (0x00f0, '\u{2261}'), //  IDENTICAL TO
        (0x00f1, '\u{00b1}'), //  PLUS-MINUS SIGN
        (0x00f2, '\u{2265}'), //  GREATER-THAN OR EQUAL TO
        (0x00f3, '\u{2264}'), //  LESS-THAN OR EQUAL TO
        (0x00f4, '\u{2320}'), //  TOP HALF INTEGRAL
        (0x00f5, '\u{2321}'), //  BOTTOM HALF INTEGRAL
        (0x00f6, '\u{00f7}'), //  DIVISION SIGN
        (0x00f7, '\u{2248}'), //  ALMOST EQUAL TO
        (0x00f8, '\u{00b0}'), //  DEGREE SIGN
        (0x00f9, '\u{2219}'), //  BULLET OPERATOR
        (0x00fa, '\u{00b7}'), //  MIDDLE DOT
        (0x00fb, '\u{221a}'), //  SQUARE ROOT
        (0x00fc, '\u{207f}'), //  SUPERSCRIPT LATIN SMALL LETTER N
        (0x00fd, '\u{00b2}'), //  SUPERSCRIPT TWO
        (0x00fe, '\u{25a0}'), //  BLACK SQUARE
        (0x00ff, '\u{00a0}') //  NO-BREAK SPACE
    ]
)

let decode_map = HashMap<Char, Char>(
    [
        ('\u{0000}', '\u{0000}'), //  NULL
        ('\u{0001}', '\u{0001}'), //  START OF HEADING
        ('\u{0002}', '\u{0002}'), //  START OF TEXT
        ('\u{0003}', '\u{0003}'), //  END OF TEXT
        ('\u{0004}', '\u{0004}'), //  END OF TRANSMISSION
        ('\u{0005}', '\u{0005}'), //  ENQUIRY
        ('\u{0006}', '\u{0006}'), //  ACKNOWLEDGE
        ('\u{0007}', '\u{0007}'), //  BELL
        ('\u{0008}', '\u{0008}'), //  BACKSPACE
        ('\u{0009}', '\u{0009}'), //  HORIZONTAL TABULATION
        ('\u{000a}', '\u{000a}'), //  LINE FEED
        ('\u{000b}', '\u{000b}'), //  VERTICAL TABULATION
        ('\u{000c}', '\u{000c}'), //  FORM FEED
        ('\u{000d}', '\u{000d}'), //  CARRIAGE RETURN
        ('\u{000e}', '\u{000e}'), //  SHIFT OUT
        ('\u{000f}', '\u{000f}'), //  SHIFT IN
        ('\u{0010}', '\u{0010}'), //  DATA LINK ESCAPE
        ('\u{0011}', '\u{0011}'), //  DEVICE CONTROL ONE
        ('\u{0012}', '\u{0012}'), //  DEVICE CONTROL TWO
        ('\u{0013}', '\u{0013}'), //  DEVICE CONTROL THREE
        ('\u{0014}', '\u{0014}'), //  DEVICE CONTROL FOUR
        ('\u{0015}', '\u{0015}'), //  NEGATIVE ACKNOWLEDGE
        ('\u{0016}', '\u{0016}'), //  SYNCHRONOUS IDLE
        ('\u{0017}', '\u{0017}'), //  END OF TRANSMISSION BLOCK
        ('\u{0018}', '\u{0018}'), //  CANCEL
        ('\u{0019}', '\u{0019}'), //  END OF MEDIUM
        ('\u{001a}', '\u{001a}'), //  SUBSTITUTE
        ('\u{001b}', '\u{001b}'), //  ESCAPE
        ('\u{001c}', '\u{001c}'), //  FILE SEPARATOR
        ('\u{001d}', '\u{001d}'), //  GROUP SEPARATOR
        ('\u{001e}', '\u{001e}'), //  RECORD SEPARATOR
        ('\u{001f}', '\u{001f}'), //  UNIT SEPARATOR
        ('\u{0020}', '\u{0020}'), //  SPACE
        ('\u{0021}', '\u{0021}'), //  EXCLAMATION MARK
        ('\u{0022}', '\u{0022}'), //  QUOTATION MARK
        ('\u{0023}', '\u{0023}'), //  NUMBER SIGN
        ('\u{0024}', '\u{0024}'), //  DOLLAR SIGN
        ('\u{0025}', '\u{0025}'), //  PERCENT SIGN
        ('\u{0026}', '\u{0026}'), //  AMPERSAND
        ('\u{0027}', '\u{0027}'), //  APOSTROPHE
        ('\u{0028}', '\u{0028}'), //  LEFT PARENTHESIS
        ('\u{0029}', '\u{0029}'), //  RIGHT PARENTHESIS
        ('\u{002a}', '\u{002a}'), //  ASTERISK
        ('\u{002b}', '\u{002b}'), //  PLUS SIGN
        ('\u{002c}', '\u{002c}'), //  COMMA
        ('\u{002d}', '\u{002d}'), //  HYPHEN-MINUS
        ('\u{002e}', '\u{002e}'), //  FULL STOP
        ('\u{002f}', '\u{002f}'), //  SOLIDUS
        ('\u{0030}', '\u{0030}'), //  DIGIT ZERO
        ('\u{0031}', '\u{0031}'), //  DIGIT ONE
        ('\u{0032}', '\u{0032}'), //  DIGIT TWO
        ('\u{0033}', '\u{0033}'), //  DIGIT THREE
        ('\u{0034}', '\u{0034}'), //  DIGIT FOUR
        ('\u{0035}', '\u{0035}'), //  DIGIT FIVE
        ('\u{0036}', '\u{0036}'), //  DIGIT SIX
        ('\u{0037}', '\u{0037}'), //  DIGIT SEVEN
        ('\u{0038}', '\u{0038}'), //  DIGIT EIGHT
        ('\u{0039}', '\u{0039}'), //  DIGIT NINE
        ('\u{003a}', '\u{003a}'), //  COLON
        ('\u{003b}', '\u{003b}'), //  SEMICOLON
        ('\u{003c}', '\u{003c}'), //  LESS-THAN SIGN
        ('\u{003d}', '\u{003d}'), //  EQUALS SIGN
        ('\u{003e}', '\u{003e}'), //  GREATER-THAN SIGN
        ('\u{003f}', '\u{003f}'), //  QUESTION MARK
        ('\u{0040}', '\u{0040}'), //  COMMERCIAL AT
        ('\u{0041}', '\u{0041}'), //  LATIN CAPITAL LETTER A
        ('\u{0042}', '\u{0042}'), //  LATIN CAPITAL LETTER B
        ('\u{0043}', '\u{0043}'), //  LATIN CAPITAL LETTER C
        ('\u{0044}', '\u{0044}'), //  LATIN CAPITAL LETTER D
        ('\u{0045}', '\u{0045}'), //  LATIN CAPITAL LETTER E
        ('\u{0046}', '\u{0046}'), //  LATIN CAPITAL LETTER F
        ('\u{0047}', '\u{0047}'), //  LATIN CAPITAL LETTER G
        ('\u{0048}', '\u{0048}'), //  LATIN CAPITAL LETTER H
        ('\u{0049}', '\u{0049}'), //  LATIN CAPITAL LETTER I
        ('\u{004a}', '\u{004a}'), //  LATIN CAPITAL LETTER J
        ('\u{004b}', '\u{004b}'), //  LATIN CAPITAL LETTER K
        ('\u{004c}', '\u{004c}'), //  LATIN CAPITAL LETTER L
        ('\u{004d}', '\u{004d}'), //  LATIN CAPITAL LETTER M
        ('\u{004e}', '\u{004e}'), //  LATIN CAPITAL LETTER N
        ('\u{004f}', '\u{004f}'), //  LATIN CAPITAL LETTER O
        ('\u{0050}', '\u{0050}'), //  LATIN CAPITAL LETTER P
        ('\u{0051}', '\u{0051}'), //  LATIN CAPITAL LETTER Q
        ('\u{0052}', '\u{0052}'), //  LATIN CAPITAL LETTER R
        ('\u{0053}', '\u{0053}'), //  LATIN CAPITAL LETTER S
        ('\u{0054}', '\u{0054}'), //  LATIN CAPITAL LETTER T
        ('\u{0055}', '\u{0055}'), //  LATIN CAPITAL LETTER U
        ('\u{0056}', '\u{0056}'), //  LATIN CAPITAL LETTER V
        ('\u{0057}', '\u{0057}'), //  LATIN CAPITAL LETTER W
        ('\u{0058}', '\u{0058}'), //  LATIN CAPITAL LETTER X
        ('\u{0059}', '\u{0059}'), //  LATIN CAPITAL LETTER Y
        ('\u{005a}', '\u{005a}'), //  LATIN CAPITAL LETTER Z
        ('\u{005b}', '\u{005b}'), //  LEFT SQUARE BRACKET
        ('\u{005c}', '\u{005c}'), //  REVERSE SOLIDUS
        ('\u{005d}', '\u{005d}'), //  RIGHT SQUARE BRACKET
        ('\u{005e}', '\u{005e}'), //  CIRCUMFLEX ACCENT
        ('\u{005f}', '\u{005f}'), //  LOW LINE
        ('\u{0060}', '\u{0060}'), //  GRAVE ACCENT
        ('\u{0061}', '\u{0061}'), //  LATIN SMALL LETTER A
        ('\u{0062}', '\u{0062}'), //  LATIN SMALL LETTER B
        ('\u{0063}', '\u{0063}'), //  LATIN SMALL LETTER C
        ('\u{0064}', '\u{0064}'), //  LATIN SMALL LETTER D
        ('\u{0065}', '\u{0065}'), //  LATIN SMALL LETTER E
        ('\u{0066}', '\u{0066}'), //  LATIN SMALL LETTER F
        ('\u{0067}', '\u{0067}'), //  LATIN SMALL LETTER G
        ('\u{0068}', '\u{0068}'), //  LATIN SMALL LETTER H
        ('\u{0069}', '\u{0069}'), //  LATIN SMALL LETTER I
        ('\u{006a}', '\u{006a}'), //  LATIN SMALL LETTER J
        ('\u{006b}', '\u{006b}'), //  LATIN SMALL LETTER K
        ('\u{006c}', '\u{006c}'), //  LATIN SMALL LETTER L
        ('\u{006d}', '\u{006d}'), //  LATIN SMALL LETTER M
        ('\u{006e}', '\u{006e}'), //  LATIN SMALL LETTER N
        ('\u{006f}', '\u{006f}'), //  LATIN SMALL LETTER O
        ('\u{0070}', '\u{0070}'), //  LATIN SMALL LETTER P
        ('\u{0071}', '\u{0071}'), //  LATIN SMALL LETTER Q
        ('\u{0072}', '\u{0072}'), //  LATIN SMALL LETTER R
        ('\u{0073}', '\u{0073}'), //  LATIN SMALL LETTER S
        ('\u{0074}', '\u{0074}'), //  LATIN SMALL LETTER T
        ('\u{0075}', '\u{0075}'), //  LATIN SMALL LETTER U
        ('\u{0076}', '\u{0076}'), //  LATIN SMALL LETTER V
        ('\u{0077}', '\u{0077}'), //  LATIN SMALL LETTER W
        ('\u{0078}', '\u{0078}'), //  LATIN SMALL LETTER X
        ('\u{0079}', '\u{0079}'), //  LATIN SMALL LETTER Y
        ('\u{007a}', '\u{007a}'), //  LATIN SMALL LETTER Z
        ('\u{007b}', '\u{007b}'), //  LEFT CURLY BRACKET
        ('\u{007c}', '\u{007c}'), //  VERTICAL LINE
        ('\u{007d}', '\u{007d}'), //  RIGHT CURLY BRACKET
        ('\u{007e}', '\u{007e}'), //  TILDE
        ('\u{007f}', '\u{007f}'), //  DELETE
        ('\u{00a0}', '\u{00ff}'), //  NO-BREAK SPACE
        ('\u{00a1}', '\u{00ad}'), //  INVERTED EXCLAMATION MARK
        ('\u{00a2}', '\u{009b}'), //  CENT SIGN
        ('\u{00a3}', '\u{009c}'), //  POUND SIGN
        ('\u{00a5}', '\u{009d}'), //  YEN SIGN
        ('\u{00aa}', '\u{00a6}'), //  FEMININE ORDINAL INDICATOR
        ('\u{00ab}', '\u{00ae}'), //  LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
        ('\u{00ac}', '\u{00aa}'), //  NOT SIGN
        ('\u{00b0}', '\u{00f8}'), //  DEGREE SIGN
        ('\u{00b1}', '\u{00f1}'), //  PLUS-MINUS SIGN
        ('\u{00b2}', '\u{00fd}'), //  SUPERSCRIPT TWO
        ('\u{00b5}', '\u{00e6}'), //  MICRO SIGN
        ('\u{00b7}', '\u{00fa}'), //  MIDDLE DOT
        ('\u{00ba}', '\u{00a7}'), //  MASCULINE ORDINAL INDICATOR
        ('\u{00bb}', '\u{00af}'), //  RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
        ('\u{00bc}', '\u{00ac}'), //  VULGAR FRACTION ONE QUARTER
        ('\u{00bd}', '\u{00ab}'), //  VULGAR FRACTION ONE HALF
        ('\u{00bf}', '\u{00a8}'), //  INVERTED QUESTION MARK
        ('\u{00c4}', '\u{008e}'), //  LATIN CAPITAL LETTER A WITH DIAERESIS
        ('\u{00c5}', '\u{008f}'), //  LATIN CAPITAL LETTER A WITH RING ABOVE
        ('\u{00c6}', '\u{0092}'), //  LATIN CAPITAL LIGATURE AE
        ('\u{00c7}', '\u{0080}'), //  LATIN CAPITAL LETTER C WITH CEDILLA
        ('\u{00c9}', '\u{0090}'), //  LATIN CAPITAL LETTER E WITH ACUTE
        ('\u{00d1}', '\u{00a5}'), //  LATIN CAPITAL LETTER N WITH TILDE
        ('\u{00d6}', '\u{0099}'), //  LATIN CAPITAL LETTER O WITH DIAERESIS
        ('\u{00dc}', '\u{009a}'), //  LATIN CAPITAL LETTER U WITH DIAERESIS
        ('\u{00df}', '\u{00e1}'), //  LATIN SMALL LETTER SHARP S
        ('\u{00e0}', '\u{0085}'), //  LATIN SMALL LETTER A WITH GRAVE
        ('\u{00e1}', '\u{00a0}'), //  LATIN SMALL LETTER A WITH ACUTE
        ('\u{00e2}', '\u{0083}'), //  LATIN SMALL LETTER A WITH CIRCUMFLEX
        ('\u{00e4}', '\u{0084}'), //  LATIN SMALL LETTER A WITH DIAERESIS
        ('\u{00e5}', '\u{0086}'), //  LATIN SMALL LETTER A WITH RING ABOVE
        ('\u{00e6}', '\u{0091}'), //  LATIN SMALL LIGATURE AE
        ('\u{00e7}', '\u{0087}'), //  LATIN SMALL LETTER C WITH CEDILLA
        ('\u{00e8}', '\u{008a}'), //  LATIN SMALL LETTER E WITH GRAVE
        ('\u{00e9}', '\u{0082}'), //  LATIN SMALL LETTER E WITH ACUTE
        ('\u{00ea}', '\u{0088}'), //  LATIN SMALL LETTER E WITH CIRCUMFLEX
        ('\u{00eb}', '\u{0089}'), //  LATIN SMALL LETTER E WITH DIAERESIS
        ('\u{00ec}', '\u{008d}'), //  LATIN SMALL LETTER I WITH GRAVE
        ('\u{00ed}', '\u{00a1}'), //  LATIN SMALL LETTER I WITH ACUTE
        ('\u{00ee}', '\u{008c}'), //  LATIN SMALL LETTER I WITH CIRCUMFLEX
        ('\u{00ef}', '\u{008b}'), //  LATIN SMALL LETTER I WITH DIAERESIS
        ('\u{00f1}', '\u{00a4}'), //  LATIN SMALL LETTER N WITH TILDE
        ('\u{00f2}', '\u{0095}'), //  LATIN SMALL LETTER O WITH GRAVE
        ('\u{00f3}', '\u{00a2}'), //  LATIN SMALL LETTER O WITH ACUTE
        ('\u{00f4}', '\u{0093}'), //  LATIN SMALL LETTER O WITH CIRCUMFLEX
        ('\u{00f6}', '\u{0094}'), //  LATIN SMALL LETTER O WITH DIAERESIS
        ('\u{00f7}', '\u{00f6}'), //  DIVISION SIGN
        ('\u{00f9}', '\u{0097}'), //  LATIN SMALL LETTER U WITH GRAVE
        ('\u{00fa}', '\u{00a3}'), //  LATIN SMALL LETTER U WITH ACUTE
        ('\u{00fb}', '\u{0096}'), //  LATIN SMALL LETTER U WITH CIRCUMFLEX
        ('\u{00fc}', '\u{0081}'), //  LATIN SMALL LETTER U WITH DIAERESIS
        ('\u{00ff}', '\u{0098}'), //  LATIN SMALL LETTER Y WITH DIAERESIS
        ('\u{0192}', '\u{009f}'), //  LATIN SMALL LETTER F WITH HOOK
        ('\u{0393}', '\u{00e2}'), //  GREEK CAPITAL LETTER GAMMA
        ('\u{0398}', '\u{00e9}'), //  GREEK CAPITAL LETTER THETA
        ('\u{03a3}', '\u{00e4}'), //  GREEK CAPITAL LETTER SIGMA
        ('\u{03a6}', '\u{00e8}'), //  GREEK CAPITAL LETTER PHI
        ('\u{03a9}', '\u{00ea}'), //  GREEK CAPITAL LETTER OMEGA
        ('\u{03b1}', '\u{00e0}'), //  GREEK SMALL LETTER ALPHA
        ('\u{03b4}', '\u{00eb}'), //  GREEK SMALL LETTER DELTA
        ('\u{03b5}', '\u{00ee}'), //  GREEK SMALL LETTER EPSILON
        ('\u{03c0}', '\u{00e3}'), //  GREEK SMALL LETTER PI
        ('\u{03c3}', '\u{00e5}'), //  GREEK SMALL LETTER SIGMA
        ('\u{03c4}', '\u{00e7}'), //  GREEK SMALL LETTER TAU
        ('\u{03c6}', '\u{00ed}'), //  GREEK SMALL LETTER PHI
        ('\u{207f}', '\u{00fc}'), //  SUPERSCRIPT LATIN SMALL LETTER N
        ('\u{20a7}', '\u{009e}'), //  PESETA SIGN
        ('\u{2219}', '\u{00f9}'), //  BULLET OPERATOR
        ('\u{221a}', '\u{00fb}'), //  SQUARE ROOT
        ('\u{221e}', '\u{00ec}'), //  INFINITY
        ('\u{2229}', '\u{00ef}'), //  INTERSECTION
        ('\u{2248}', '\u{00f7}'), //  ALMOST EQUAL TO
        ('\u{2261}', '\u{00f0}'), //  IDENTICAL TO
        ('\u{2264}', '\u{00f3}'), //  LESS-THAN OR EQUAL TO
        ('\u{2265}', '\u{00f2}'), //  GREATER-THAN OR EQUAL TO
        ('\u{2310}', '\u{00a9}'), //  REVERSED NOT SIGN
        ('\u{2320}', '\u{00f4}'), //  TOP HALF INTEGRAL
        ('\u{2321}', '\u{00f5}'), //  BOTTOM HALF INTEGRAL
        ('\u{2500}', '\u{00c4}'), //  BOX DRAWINGS LIGHT HORIZONTAL
        ('\u{2502}', '\u{00b3}'), //  BOX DRAWINGS LIGHT VERTICAL
        ('\u{250c}', '\u{00da}'), //  BOX DRAWINGS LIGHT DOWN AND RIGHT
        ('\u{2510}', '\u{00bf}'), //  BOX DRAWINGS LIGHT DOWN AND LEFT
        ('\u{2514}', '\u{00c0}'), //  BOX DRAWINGS LIGHT UP AND RIGHT
        ('\u{2518}', '\u{00d9}'), //  BOX DRAWINGS LIGHT UP AND LEFT
        ('\u{251c}', '\u{00c3}'), //  BOX DRAWINGS LIGHT VERTICAL AND RIGHT
        ('\u{2524}', '\u{00b4}'), //  BOX DRAWINGS LIGHT VERTICAL AND LEFT
        ('\u{252c}', '\u{00c2}'), //  BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
        ('\u{2534}', '\u{00c1}'), //  BOX DRAWINGS LIGHT UP AND HORIZONTAL
        ('\u{253c}', '\u{00c5}'), //  BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
        ('\u{2550}', '\u{00cd}'), //  BOX DRAWINGS DOUBLE HORIZONTAL
        ('\u{2551}', '\u{00ba}'), //  BOX DRAWINGS DOUBLE VERTICAL
        ('\u{2552}', '\u{00d5}'), //  BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
        ('\u{2553}', '\u{00d6}'), //  BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
        ('\u{2554}', '\u{00c9}'), //  BOX DRAWINGS DOUBLE DOWN AND RIGHT
        ('\u{2555}', '\u{00b8}'), //  BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
        ('\u{2556}', '\u{00b7}'), //  BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
        ('\u{2557}', '\u{00bb}'), //  BOX DRAWINGS DOUBLE DOWN AND LEFT
        ('\u{2558}', '\u{00d4}'), //  BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
        ('\u{2559}', '\u{00d3}'), //  BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
        ('\u{255a}', '\u{00c8}'), //  BOX DRAWINGS DOUBLE UP AND RIGHT
        ('\u{255b}', '\u{00be}'), //  BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
        ('\u{255c}', '\u{00bd}'), //  BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
        ('\u{255d}', '\u{00bc}'), //  BOX DRAWINGS DOUBLE UP AND LEFT
        ('\u{255e}', '\u{00c6}'), //  BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
        ('\u{255f}', '\u{00c7}'), //  BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
        ('\u{2560}', '\u{00cc}'), //  BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
        ('\u{2561}', '\u{00b5}'), //  BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
        ('\u{2562}', '\u{00b6}'), //  BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
        ('\u{2563}', '\u{00b9}'), //  BOX DRAWINGS DOUBLE VERTICAL AND LEFT
        ('\u{2564}', '\u{00d1}'), //  BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
        ('\u{2565}', '\u{00d2}'), //  BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
        ('\u{2566}', '\u{00cb}'), //  BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
        ('\u{2567}', '\u{00cf}'), //  BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
        ('\u{2568}', '\u{00d0}'), //  BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
        ('\u{2569}', '\u{00ca}'), //  BOX DRAWINGS DOUBLE UP AND HORIZONTAL
        ('\u{256a}', '\u{00d8}'), //  BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
        ('\u{256b}', '\u{00d7}'), //  BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
        ('\u{256c}', '\u{00ce}'), //  BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
        ('\u{2580}', '\u{00df}'), //  UPPER HALF BLOCK
        ('\u{2584}', '\u{00dc}'), //  LOWER HALF BLOCK
        ('\u{2588}', '\u{00db}'), //  FULL BLOCK
        ('\u{258c}', '\u{00dd}'), //  LEFT HALF BLOCK
        ('\u{2590}', '\u{00de}'), //  RIGHT HALF BLOCK
        ('\u{2591}', '\u{00b0}'), //  LIGHT SHADE
        ('\u{2592}', '\u{00b1}'), //  MEDIUM SHADE
        ('\u{2593}', '\u{00b2}'), //  DARK SHADE
        ('\u{25a0}', '\u{00fe}') //  BLACK SQUARE
    ]
)

public func decodeCp437(arr: Array<Byte>): String {
    var sb = StringBuilder()
    for (a in arr) {
        if (a <= 127) {
            sb.append(encode_arr[Int64(a)])
        } else if (encode_map.contains(Int64(a))) {
            sb.append(encode_map[Int64(a)])
        } else {
            throw ZipException("Cannot convert.")
        }
    }
    return sb.toString()
}

public func encodeCp437(str: String): Array<Byte> {
    let runs = str.toRuneArray()
    let ll = Array<Byte>(runs.size, item: 0)
    for (i in 0..runs.size) {
        ll[i] = UInt8(UInt32(decode_map[runs[i]]))
    }
    ll
}
