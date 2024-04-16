%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%token PUBLIC PRIVATE INT CHAR DOUBLE BOOLEAN STRING VOID IDENTIFIER
%token <s> CLASS_NAME
%token <s> VARIABLE_NAME METHOD_NAME
%token <s> DATA_TYPE RETURN_TYPE MODIFIER

%left '+' '-'
%left '*' '/'

%%

class_declaration : PUBLIC CLASS_NAME '{' optional_variable_declaration optional_method_declaration '}'
                  ;

optional_variable_declaration : variable_declaration
                              | /* ε */
                              ;

optional_method_declaration : method_declaration
                            | /* ε */
                            ;

class_name_suffix : LETTER
                  | LETTER class_name_suffix
                  | DIGIT class_name_suffix
                  ;

variable_declaration : modifier DATA_TYPE VARIABLE_NAME ';'
                      ;

modifier : PUBLIC
         | PRIVATE
         ;

data_type : INT
          | CHAR
          | DOUBLE
          | BOOLEAN
          | STRING
          ;

method_declaration : modifier return_type METHOD_NAME '(' optional_parameter_list ')' '{' optional_variable_declaration statements '}'
                    ;

return_type : data_type
            | VOID
            ;

optional_parameter_list : parameter_list
                        | /* ε */
                        ;

parameter_list : data_type VARIABLE_NAME
               | parameter_list ',' data_type VARIABLE_NAME
               ;

statements : /* empty for now, you can add production rules for statements */
          ;

%%
