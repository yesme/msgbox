Message Box
======

Message Box (msgbox) is a serialization / deserialization lib.

Its major usages includes:
- serves as wire format for RPC system between different programming languages;
- boxes the data into binary buffer so they can be cached or stored.

Bearing the above usages in mind, the major design principles of msgbox are:
- compatible across languages:
  - static typing and dynamic typing
  - server side and client side
  - language limitation (e.g.: JavaScript doesn't support 64bits integer)
- byte-wise efficient
- fast
  - lazy data access
  - filtering fields
- extendable (for optional fields)

Therefore, it's:
- rich typed: list, set, map, message (struct), enum
- varification supported:
  - scope: required, optional
  - format: url (with schema), phone, email, identifier (a-z, with 0-9, with A-Z, with _, with -, with .), ip
- options supported: default value (for optional field), compressed (for string field), incremental packed (for integer list)
- header file generation supported (not necessary)



