; Variables
;----------

(identifier) @variable

; Properties
;-----------

(property_identifier) @property

; Function and method definitions
;--------------------------------

(function_expression
  name: (identifier) @function)
(function_declaration
  name: (identifier) @function)
(method_definition
  name: (property_identifier) @function.method)

(pair
  key: (property_identifier) @function.method
  value: [(function_expression) (arrow_function)])

(assignment_expression
  left: (member_expression
    property: (property_identifier) @function.method)
  right: [(function_expression) (arrow_function)])

(variable_declarator
  name: (identifier) @function
  value: [(function_expression) (arrow_function)])

(assignment_expression
  left: (identifier) @function
  right: [(function_expression) (arrow_function)])

; Function and method calls
;--------------------------

(call_expression
  function: (identifier) @function)

(call_expression
  function: (member_expression
    property: (property_identifier) @function.method))

; Special identifiers
;--------------------

((identifier) @constructor
 (#match? @constructor "^[A-Z]"))

([
    (identifier)
    (shorthand_property_identifier)
    (shorthand_property_identifier_pattern)
 ] @constant
 (#match? @constant "^[A-Z_][A-Z\\d_]+$"))

((identifier) @variable.builtin
 (#match? @variable.builtin "^(arguments|module|console|window|document)$"))

((identifier) @function.builtin
 (#eq? @function.builtin "require"))

; Literals
;---------

(this) @variable.builtin
(super) @variable.builtin

[
  (true)
  (false)
  (null)
  (undefined)
] @constant.builtin

(comment) @comment

[
  (string)
  (template_string)
] @string

(regex) @string.special
(number) @number

; Tokens
;-------

[
  ";"
  (optional_chain)
  "."
  ","
] @punctuation.delimiter

[
  "-"
  ; "--" - aliased to forbidden_decrement
  "-="
  "+"
  ; "++" - aliased to forbidden_increment
  "+="
  "*"
  "*="
  "**"
  "**="
  "/"
  "/="
  "%"
  "%="
  "<"
  "<="
  "<<"
  "<<="
  "="
  ; "==" - aliased to forbidden_loose_eq
  "==="
  "!"
  ; "!=" - aliased to forbidden_loose_neq
  "!=="
  "=>"
  ">"
  ">="
  ">>"
  ">>="
  ">>>"
  ">>>="
  "~"
  "^"
  "&"
  "|"
  "^="
  "&="
  "|="
  "&&"
  "||"
  "??"
  "&&="
  "||="
  "??="
] @operator

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
]  @punctuation.bracket

(template_substitution
  "${" @punctuation.special
  "}" @punctuation.special) @embedded

[
  "as"
  "async"
  "await"
  "break"
  "case"
  ; "catch" - aliased to contextual_catch
  ; "class" - aliased to contextual_class
  "const"
  "continue"
  "debugger"
  "default"
  ; "delete" - aliased to contextual_delete
  "do"
  "else"
  ; "export" - aliased to contextual_export
  ; "extends" - aliased to contextual_extends
  ; "finally" - aliased to contextual_finally
  "for"
  "from"
  ; "function" - aliased to contextual_function
  "get"
  "if"
  ; "import" - aliased to forbidden_import
  ; "in" - aliased to forbidden_in
  ; "instanceof" - aliased to contextual_instanceof
  ; "let" - aliased to contextual_let
  ; "new" - aliased to contextual_new
  "of"
  "return"
  "set"
  "static"
  "switch"
  "target"
  ; "throw" - aliased to contextual_throw
  ; "try" - aliased to contextual_try
  ; "typeof" - aliased to contextual_typeof
  ; "var" - aliased to forbidden_var
  ; "void" - aliased to forbidden_void
  "while"
  ; "with" - aliased to contextual_with
  "yield"
] @keyword

; CR:UX: Forbidden constructs (RED)
(forbidden_var) @error
(forbidden_void) @error
(forbidden_in) @error
(forbidden_loose_eq) @error
(forbidden_loose_neq) @error
(forbidden_increment) @error
(forbidden_decrement) @error
(forbidden_spread) @error

; CR:UX: Forbidden import statements - mark entire statement as error
(import_statement) @error

; CR:UX: Special labels (RED - forbidden in normal code)
(labeled_statement
  label: (statement_identifier) @error
  (#match? @error "^(JSVM|GLOBALS)$"))

; CR:UX: Contextual constructs (ORANGE)
(contextual_let) @warning
(contextual_function) @warning
(contextual_class) @warning
(contextual_extends) @warning
(contextual_this) @warning
(contextual_super) @warning
(contextual_null) @warning
(contextual_undefined) @warning
(contextual_typeof) @warning
(contextual_delete) @warning
(contextual_instanceof) @warning
(contextual_new) @warning
(contextual_try) @warning
(contextual_catch) @warning
(contextual_finally) @warning
(contextual_throw) @warning
(contextual_with) @warning

; CR:UX: Contextual export statements - highlight 'export' keyword
(export_statement "export" @warning)

; CR:UX: Empty object/array literals (ORANGE - contextual)
; Use lua predicate to check node text
((object) @_obj
 (#lua-match? @_obj "^%{%}$")
 (#set! "priority" 105)) @warning

((array) @_arr
 (#lua-match? @_arr "^%[%]$")
 (#set! "priority" 105)) @warning
