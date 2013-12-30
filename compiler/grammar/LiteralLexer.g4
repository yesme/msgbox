lexer grammar LiteralLexer;

// ----- Stopwords -----
EOL: ('\n' | '\r' | EOF) -> skip;
COMMENT: '//' ~('\n' | '\r')* -> skip;
WHITESPACE: ('\t' | ' ' | EOL)+ -> skip;

// ----- Punctuations -----
BRACE_OPEN: '{';
BRACE_CLOSE: '}';
PAREN_OPEN: '(';
PAREN_CLOSE: ')';
BRACKET_OPEN: '[';
BRACKET_CLOSE: ']';
ANGLE_OPEN: '<';
ANGLE_CLOSE: '>';
EQUALS: '=';
COMMA: ',';
SEMICOLON: ';';
DOT: '.';
UNDERSCORE: '_';
SINGLE_QUOTE: '\'';
DOUBLE_QUOTE: '"';
MINUS: '-';
PLUS: '+';


// ----- Integer -----
fragment DIGIT: [0-9];
fragment HEX_DIGIT: [0-9a-fA-F];
fragment OCTAL_DIGIT: [0-7];
HEX_LITERAL: MINUS? '0' ('x' | 'X') HEX_DIGIT+;
OCTAL_LITERAL: MINUS? '0' OCTAL_DIGIT+;
POSITIVE_DECIMAL_LITERAL: [1-9] DIGIT*;

// ----- Float -----
fragment EXPONENT: ('e' | 'E') (PLUS | MINUS)? DIGIT+ ;
FLOAT_LITERAL: MINUS? DIGIT+ DOT DIGIT* EXPONENT? | MINUS? DOT DIGIT+ EXPONENT? | MINUS? DIGIT+ EXPONENT;

// ----- String -----
fragment ESCAPE_SEQUENCE: '\\' [btnfr"'\\] | OCTAL_ESCAPE | UNICODE_ESCAPE;
fragment OCTAL_ESCAPE: '\\' (([0-3] [0-7] [0-7]) | [0-7] | ([0-7] [0-7]));
fragment UNICODE_ESCAPE: '\\u' HEX_DIGIT HEX_DIGIT HEX_DIGIT HEX_DIGIT;
fragment STRING_GUTS : (ESCAPE_SEQUENCE | ~[\\"])*;

STRING_LITERAL: '"' STRING_GUTS '"';

// ----- Boolean -----
BOOL_LITERAL: 'TRUE' | 'True' | 'true' | 'FALSE' | 'False' | 'false';

// ----- Keywords -----
TYPE_FLOAT: 'float';
TYPE_DOUBLE: 'double';
TYPE_VINT: 'vint';
TYPE_FIX16: 'fix16';
TYPE_FIX32: 'fix32';
TYPE_FIX64: 'fix64';
TYPE_BOOL: 'bool';
TYPE_STRING: 'string';
TYPE_BYTES: 'bytes';
TYPE_LIST: 'list';
TYPE_SET: 'set';
TYPE_MAP: 'map';

PACKAGE_LITERAL: 'package';
IMPORT_LITERAL: 'import';
ENUM_LITERAL: 'enum';
MESSAGE_LITERAL: 'message';
REQUIRED_LITERAL: 'required';
OPTIONAL_LITERAL: 'optional';

// ----- Identifier -----
fragment LOWER_CHAR: [a-z];
fragment UPPER_CHAR: [A-Z];

LOWER_WORD: LOWER_CHAR (LOWER_CHAR | DIGIT)*;
UPPER_WORD: UPPER_CHAR (UPPER_CHAR | DIGIT)*;
CAPED_WORD: UPPER_CHAR (LOWER_CHAR | UPPER_CHAR | DIGIT)*;
MIXED_WORD: (LOWER_CHAR | UPPER_CHAR) (LOWER_CHAR | UPPER_CHAR | DIGIT)*;
