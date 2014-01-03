grammar Literal;

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
fragment HEX_DIGIT: [0-9a-fA-F];
HEX_LITERAL: MINUS? '0' ('x' | 'X') HEX_DIGIT+;
OCTAL_LITERAL: MINUS? '0' [0-7]+;
POSITIVE_DECIMAL_LITERAL: [1-9] [0-9]*;
OTHER_DIGITS: '0' [0-9]+;  // e.g.: 0880

// ----- Float -----
fragment EXPONENT: ('e' | 'E') (PLUS | MINUS)? [0-9]+ ;
FLOAT_LITERAL: MINUS? [0-9]+ DOT [0-9]* EXPONENT? | MINUS? DOT [0-9]+ EXPONENT? | MINUS? [0-9]+ EXPONENT;

// ----- String -----
fragment ESCAPE_SEQUENCE: '\\' [btnfr"'\\] | OCTAL_ESCAPE | UNICODE_ESCAPE;
fragment OCTAL_ESCAPE: '\\' (([0-3] [0-7] [0-7]) | [0-7] | ([0-7] [0-7]));
fragment UNICODE_ESCAPE: '\\u' HEX_DIGIT HEX_DIGIT HEX_DIGIT HEX_DIGIT;
fragment STRING_GUTS : (ESCAPE_SEQUENCE | ~[\\"])*;

STRING_LITERAL: '"' STRING_GUTS '"';

// ----- Boolean -----
BOOL_LITERAL: 'true' | 'false';

// ----- Keywords -----
TYPE_FLOAT: 'float';
TYPE_DOUBLE: 'double';
TYPE_VINT16: 'vint16';
TYPE_VINT32: 'vint32';
TYPE_VINT64: 'vint64';
TYPE_FIXED16: 'fixed16';
TYPE_FIXED32: 'fixed32';
TYPE_FIXED64: 'fixed64';
TYPE_BOOL: 'bool';
TYPE_STRING: 'string';
TYPE_BYTES: 'bytes';
TYPE_LIST: 'list';
TYPE_SET: 'set';
TYPE_MAP: 'map';

PACKAGE_LITERAL: 'package';
IMPORT_LITERAL: 'import';
CONST_LITERAL: 'const';
ENUM_LITERAL: 'enum';
MESSAGE_LITERAL: 'message';
REQUIRED_LITERAL: 'required';
OPTIONAL_LITERAL: 'optional';

// ----- Identifier -----
LOWER_WORD: [a-z] [a-z0-9]*;
UPPER_WORD: [A-Z] [A-Z0-9]*;
CAPED_WORD: [A-Z] [a-zA-Z0-9]*;
MIXED_WORD: [a-zA-Z] [a-zA-Z0-9]*;

// ----- Integer -----
nature_decimal_literal: '0' | POSITIVE_DECIMAL_LITERAL;
decimal_literal: '0' | MINUS? POSITIVE_DECIMAL_LITERAL;
integer_literal: HEX_LITERAL | OCTAL_LITERAL | decimal_literal;
all_digits: nature_decimal_literal | OCTAL_LITERAL | OTHER_DIGITS;

// ----- Literal Value -----
float_literal: FLOAT_LITERAL;
bool_value: BOOL_LITERAL;
number_value: integer_literal | float_literal;
string_value: STRING_LITERAL;
literal_value: bool_value | number_value | string_value;

// ----- Identifier -----
unqualified_lower_identifier: LOWER_WORD (UNDERSCORE (LOWER_WORD | all_digits))* | special_unqualified_lower_identifier;
unqualified_upper_identifier: UPPER_WORD (UNDERSCORE (UPPER_WORD | all_digits))*;
unqualified_caped_identifier: CAPED_WORD;
unqualified_mixed_identifier: unqualified_lower_identifier | unqualified_upper_identifier | unqualified_caped_identifier | MIXED_WORD;

qualified_prefix: unqualified_mixed_identifier (DOT unqualified_mixed_identifier)* DOT;

lower_identifier: unqualified_lower_identifier | qualified_prefix unqualified_lower_identifier;
upper_identifier: unqualified_upper_identifier | qualified_prefix unqualified_upper_identifier;
caped_identifier: unqualified_caped_identifier | qualified_prefix unqualified_caped_identifier;
mixed_identifier: unqualified_mixed_identifier | qualified_prefix unqualified_mixed_identifier;

// ----- Keywords -----
type_scalar_literal: TYPE_FLOAT | TYPE_DOUBLE | TYPE_VINT16 | TYPE_VINT32 | TYPE_VINT64 | TYPE_FIXED16 | TYPE_FIXED32 | TYPE_FIXED64 | TYPE_BOOL | TYPE_STRING | TYPE_BYTES;
type_collection_literal: TYPE_LIST | TYPE_SET | TYPE_MAP;
field_rule_literal: REQUIRED_LITERAL | OPTIONAL_LITERAL;
keyword_literal: PACKAGE_LITERAL | IMPORT_LITERAL | CONST_LITERAL | ENUM_LITERAL | MESSAGE_LITERAL;
special_unqualified_lower_identifier: type_scalar_literal | type_collection_literal | field_rule_literal | keyword_literal | BOOL_LITERAL;

package_literal: PACKAGE_LITERAL;
override_package_literal: LOWER_WORD UNDERSCORE PACKAGE_LITERAL;

import_literal: IMPORT_LITERAL;
additional_import_literal: LOWER_WORD UNDERSCORE IMPORT_LITERAL;
