/* Human Programming Language Implemented in Jison */


/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
\n                    return 'NEWLINE'
\.                    return 'DOT'
[0-9]+                return 'NUMBER'
[A-Z][a-z]*           return 'CLASS'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex


%start expressions

%% /* language grammar */

expressions : instantiate_a_data_structure EOF
    {
      console.log($1);
      return $1;
    }
    ;

instantiate_a_data_structure: NUMBER DOT CLASS DOT
  {
    $$ = {
      count: parseInt($1),
      name: $3
    }
  }
  ;
