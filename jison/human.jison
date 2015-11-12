/* Human Programming Language Implemented in Jison */


/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
\n                    return 'NEWLINE'
\.                    return 'DOT'
\$                    return 'DOLLAR'
\:                    return 'COLON'
[0-9]+                return 'NUMBER'
[A-Z][a-z]*           return 'CLASS'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex


%start expressions

%% /* language grammar */

expressions:
    statements EOF
    {
      console.log("# Current Class definitions: =>", global.class_definitions, "\n");
      console.log($1);
      return $1;
    }
    ;


statements:
  statement
  {
    $$ = $1;
  }
  |
  statement statements
  {
    $$ = $2;
  }
  ;


statement:
  define_class
  |
  instantiate_class
  ;


define_class:
    DOLLAR CLASS COLON
    {
      global.class_definitions = global.class_definitions || {};
      global.class_definitions[$2] = {};
      $$ = global.class_definitions;
    }
    ;


instantiate_class:
  NUMBER DOT CLASS DOT
  {
    if ($3 in global.class_definitions) {
      $$ = {
        count: parseInt($1),
        class: $3
      }
    } else {
      throw Error("undefined class \"" + $3 + "\", maybe you want to use one of classes " +
                  JSON.stringify(Object.keys(global.class_definitions)) + " ...");
    }
  }
  ;
