grammar LiteralParser;
import LiteralLexer;


// ----- Integer -----
decimal_literal: '0' | MINUS? POSITIVE_DECIMAL_LITERAL;
integer_literal: HEX_LITERAL | OCTAL_LITERAL | decimal_literal;

// ----- Literal Value -----
float_literal: FLOAT_LITERAL;
bool_value: BOOL_LITERAL;
number_value: integer_literal | float_literal;
string_value: STRING_LITERAL;
literal_value: bool_value | number_value | string_value;

// ----- Identifier -----
unqualified_lower_identifier: (LOWER_WORD (UNDERSCORE LOWER_WORD)*) | special_unqualified_lower_identifier;
unqualified_upper_identifier: UPPER_WORD (UNDERSCORE UPPER_WORD)*;
unqualified_caped_identifier: CAPED_WORD;
unqualified_mixed_identifier: unqualified_lower_identifier | unqualified_upper_identifier | unqualified_caped_identifier | MIXED_WORD;

qualified_prefix: unqualified_mixed_identifier (DOT unqualified_mixed_identifier)* DOT;

lower_identifier: unqualified_lower_identifier | qualified_prefix unqualified_lower_identifier;
upper_identifier: unqualified_upper_identifier | qualified_prefix unqualified_upper_identifier;
caped_identifier: unqualified_caped_identifier | qualified_prefix unqualified_caped_identifier;
mixed_identifier: unqualified_mixed_identifier | qualified_prefix unqualified_mixed_identifier;

// ----- Keywords -----
type_scalar_literal: TYPE_FLOAT | TYPE_DOUBLE | TYPE_INT16 | TYPE_INT32 | TYPE_INT64 | TYPE_FIX16 | TYPE_FIX32 | TYPE_FIX64 | TYPE_BOOL | TYPE_STRING | TYPE_BYTES;
type_collection_literal: TYPE_LIST | TYPE_SET | TYPE_MAP;
field_rule_literal: REQUIRED_LITERAL | OPTIONAL_LITERAL;
keyword_literal: PACKAGE_LITERAL | IMPORT_LITERAL | ENUM_LITERAL | MESSAGE_LITERAL;
special_unqualified_lower_identifier: type_scalar_literal | type_collection_literal | field_rule_literal | keyword_literal | BOOL_LITERAL;

package_literal: PACKAGE_LITERAL;
override_package_literal: LOWER_WORD UNDERSCORE PACKAGE_LITERAL;

import_literal: IMPORT_LITERAL;
additional_import_literal: LOWER_WORD UNDERSCORE IMPORT_LITERAL;
