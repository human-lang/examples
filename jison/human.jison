/* Human Programming Language Implemented in Jison */


/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
\n                    return 'NEWLINE'
\.                    return 'DOT'
\$                    return 'DOLLAR'
\,                    return 'COMMA'
\:                    return 'COLON'
\(                    return 'LEFT_PARENTHESIS'
\)                    return 'RIGHT_PARENTHESIS'
\=                    return 'EQUAL'
[0-9]+                return 'NUMBER'
[A-Z][a-z]*           return 'CLASS'
[A-Za-z]+             return 'ATTRIBUTE_NAME'
\"[A-Za-z\ ]*\"       return 'STRING'             /* only support simple form currently */
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex



%{
  global.class_definitions = global.class_definitions || {};

  function check_class_exists(class_name, callback) {
    if (class_name in global.class_definitions) {
      return callback();
    } else {
      throw Error("undefined class \"" + class_name + "\", maybe you want to use one of classes " +
                  JSON.stringify(Object.keys(global.class_definitions)) + " ...");
    }
  };

  function check_init_object_count(count, callback) {
    if (count == 1) {
      return callback();
    } else {
      throw Error("Array hasn't be implemented!");
    }
  };

  function create_an_instance(count, class_name, callback) {
    return check_class_exists(class_name, function() {
      return check_init_object_count(count, callback);
    });
  };


  /* Utility */
  function string(string_with_parenthesis) {
    return string_with_parenthesis.slice(1, string_with_parenthesis.length - 1)
  };

%}




%start expressions

%% /* language grammar */

expressions:
  statements EOF
  {
    console.log(JSON.stringify($1));
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
  instantiate_string
  |
  define_class
  |
  instantiate_class
  ;


instantiate_string:
  STRING DOT
  {
    $$ = {
      value: string($1),
      class: "String"
    }
  }
  ;


define_class:
  /* without attributes */
  DOLLAR CLASS COLON
  {
    global.class_definitions[$2] = {};
    $$ = global.class_definitions;
  }
  /* without attributes */
  /* NOTE: currently must be two attributes */
  |
  DOLLAR CLASS COLON
    ATTRIBUTE_NAME COLON
    ATTRIBUTE_NAME COLON
  {
    global.class_definitions[$2] = {};
    $$ = global.class_definitions;
  }
  ;


instantiate_class:
  /* without parameters */
  NUMBER DOT CLASS DOT
  {
    $$ = create_an_instance($1, $3, function() {
      return {
        "value": null,
        "class": $3
      }
    });
  }
  |
  /* with parameters */
  NUMBER DOT CLASS
    LEFT_PARENTHESIS
      ATTRIBUTE_NAME EQUAL STRING COMMA
      ATTRIBUTE_NAME EQUAL STRING
    RIGHT_PARENTHESIS
  DOT
  {
    var k1 = $5,
        v1 = string($7),
        k2 = $9,
        v2 = string($11);
    $$ = create_an_instance($1, $3, function() {
      var result = {value: {}, class: $3};
      result["value"][k1] = v1;
      result["value"][k2] = v2;
      return result;
    });
  }
  ;
