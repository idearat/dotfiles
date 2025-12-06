; CR:UX Syntax Highlighting Queries
;
; CR:UX is a strict subset of JavaScript.
; This highlights forbidden/contextual constructs differently.
;
; FORBIDDEN (always invalid) - @error (red)
; CONTEXTUAL (JSVM-only) - @warning (orange)
; ALLOWED - Standard highlighting

; ========== FORBIDDEN CONSTRUCTS ==========
; Always invalid - highlight as errors

; Forbidden statements and keywords
(forbidden_import_statement) @error
(forbidden_var) @error
(forbidden_void) @error
(forbidden_with_statement) @error
(forbidden_increment) @error
(forbidden_decrement) @error
(forbidden_loose_equality) @error
(forbidden_loose_inequality) @error
(forbidden_in_operator) @error

; ========== CONTEXTUAL CONSTRUCTS ==========
; Valid in JSVM blocks only - highlight as warnings

; Contextual statements and keywords
(contextual_export_statement) @warning
(contextual_function_declaration) @warning
(contextual_function_expression) @warning
(contextual_class_declaration) @warning
(contextual_class_expression) @warning
(contextual_try_statement) @warning
(contextual_catch_clause) @warning
(contextual_finally_clause) @warning
(contextual_throw_statement) @warning
(contextual_debugger_statement) @warning
(contextual_let) @warning
(contextual_function) @warning
(contextual_extends) @warning
(contextual_super) @warning
(contextual_this) @warning
(contextual_arguments) @warning
(contextual_null) @warning
(contextual_undefined) @warning
(contextual_new_expression) @warning
(contextual_delete) @warning
(contextual_typeof) @warning
(contextual_instanceof) @warning

; ========== NORMAL SYNTAX HIGHLIGHTING ==========

; Keywords
[
  "if"
  "else"
  "switch"
  "case"
  "default"
  "for"
  "while"
  "do"
  "break"
  "continue"
  "return"
  "async"
  "await"
  "yield"
  "of"
  "from"
  "get"
  "set"
  "static"
] @keyword

; const is the only allowed variable declaration
"const" @keyword.declaration

; Literals
(true) @boolean
(false) @boolean
(number) @number
(string) @string
(template_string) @string

; Comments
(comment) @comment

; Identifiers
(identifier) @variable
(property_identifier) @property

; Arrow functions (allowed)
(arrow_function) @function

; Operators (allowed) - only include what's in the grammar
[
  "="
  "+"
  "-"
  "*"
  "/"
  "%"
  "&&"
  "||"
  "!"
  "<"
  ">"
  "<="
  ">="
  "==="
  "!=="
  "+="
  "-="
  "*="
  "/="
  "%="
  "?"
  ":"
  "=>"
] @operator

; Punctuation
[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

[
  ","
  ";"
  "."
] @punctuation.delimiter
