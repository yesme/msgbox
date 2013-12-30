grammar MessageBox;
import LiteralParser;

// mb: header_def (enum_def | message_def | service_def)*;
mb: header_def (enum_def | message_def)*;

// ----- Header -----
header_def: package_def import_def;

package_def: regular_package_def? override_package_def*;
regular_package_def: package_literal mixed_identifier SEMICOLON;
override_package_def: override_package_literal mixed_identifier SEMICOLON;

import_def: (reqular_import_def | additional_import_def)*;
reqular_import_def: import_literal STRING_LITERAL SEMICOLON;
additional_import_def: additional_import_literal STRING_LITERAL SEMICOLON;

// ----- Message -----
message_def: MESSAGE_LITERAL unqualified_message_name BRACE_OPEN (options_def | message_field_def)* BRACE_CLOSE;

message_field_def: field_rule_literal type_def message_field_name EQUALS message_field_idx options_def? SEMICOLON;
message_field_name: unqualified_lower_identifier;
message_field_idx: POSITIVE_DECIMAL_LITERAL;

message_name: caped_identifier;
unqualified_message_name: unqualified_caped_identifier;

// ----- Enum -----
enum_def: ENUM_LITERAL unqualified_enum_name BRACE_OPEN (options_def | enum_field_def)* BRACE_CLOSE;

enum_name: caped_identifier;
unqualified_enum_name: unqualified_caped_identifier;

enum_field_def: enum_field_name EQUALS enum_field_value options_def? SEMICOLON;
enum_field_name: unqualified_upper_identifier;
enum_field_value: literal_value;

// ----- Option -----
options_def: BRACKET_OPEN option_def (COMMA option_def)* BRACKET_CLOSE;
option_def: option_name EQUALS option_value;
option_name: predefined_option_name | customized_option_name;
predefined_option_name: unqualified_lower_identifier;
customized_option_name: PAREN_OPEN unqualified_lower_identifier PAREN_CLOSE;
option_value: literal_value | enum_value | fields_collection_value;
enum_value: enum_field_name;
fields_collection_value: PAREN_OPEN message_field_name (COMMA message_field_name)* PAREN_CLOSE;

// ----- Type -----
type_def: type_scalar | type_list | type_set | type_map;
type_scalar: type_scalar_literal | message_name | enum_name;
type_list: TYPE_LIST ANGLE_OPEN type_scalar ANGLE_CLOSE;
type_set: TYPE_SET ANGLE_OPEN type_scalar ANGLE_CLOSE;
type_map: TYPE_MAP ANGLE_OPEN type_scalar COMMA type_scalar ANGLE_CLOSE;
