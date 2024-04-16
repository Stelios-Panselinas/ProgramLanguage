%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%token PUBLIC PRIVATE CLASS INT CHAR DOUBLE BOOLEAN STRING VOID IF ELSE FOR DO WHILE RETURN BREAK OUT_PRINT TRUE FALSE

%token <identifier> IDENTIFIER
%token <integer_literal> INTEGER_LITERAL
%token <char_literal> CHAR_LITERAL
%token <double_literal> DOUBLE_LITERAL
%token <string_literal> STRING_LITERAL

%left '+' '-'
%left '*' '/'
%right '='

%%

program: class_declaration
       | class_declaration program
       ;

class_declaration: PUBLIC CLASS IDENTIFIER '{' optional_variable_declaration optional_method_declaration '}'
                  ;

optional_variable_declaration: variable_declaration
                             | /* empty */
                             ;

optional_method_declaration: method_declaration
                           | /* empty */
                           ;

variable_declaration: modifier data_type IDENTIFIER ';'
                     ;

modifier: PUBLIC
        | PRIVATE
        | /* empty */
        ;

data_type: INT
         | CHAR
         | DOUBLE
         | BOOLEAN
         | STRING
         ;

method_declaration: modifier return_type IDENTIFIER '(' optional_parameter_list ')' '{' optional_variable_declaration statements '}'
                  ;

return_type: data_type
           | VOID
           ;

optional_parameter_list: parameter_list
                        | /* empty */
                        ;

parameter_list: data_type IDENTIFIER
               | data_type IDENTIFIER ',' parameter_list
               ;

statements: statement
          | statement statements
          ;

statement: assignment_statement
         | loop_statement
         | conditional_statement
         | print_statement
         | return_statement
         | break_statement
         ;

assignment_statement: IDENTIFIER '=' expression ';'
                     ;

loop_statement: DO '{' statements '}' WHILE '(' expression ')' ';'
              | FOR '(' expression ';' expression ';' expression ')' '{' statements '}'
              ;

conditional_statement: IF '(' expression ')' '{' statements '}'
                      | IF '(' expression ')' '{' statements '}' ELSE '{' statements '}'
                      ;

print_statement: OUT_PRINT '(' STRING_LITERAL ')' ';'
               ;

return_statement: RETURN expression ';'
                ;

break_statement: BREAK ';'
               ;

expression: IDENTIFIER
          | literal
          | method_call
          | expression '+' expression
          | expression '-' expression
          | expression '*' expression
          | expression '/' expression
          ;

literal: INTEGER_LITERAL
       | CHAR_LITERAL
       | DOUBLE_LITERAL
       | BOOLEAN_LITERAL
       | STRING_LITERAL
       ;

method_call: IDENTIFIER '.' IDENTIFIER '(' optional_argument_list ')'
           ;

optional_argument_list: argument_list
                      | /* empty */
                      ;

argument_list: expression
             | expression ',' argument_list
             ;

%%

int main() {
    // Call yyparse to start parsing
    yyparse();
    return 0;
}

// Flex will provide this function
extern int yylex();

// Error handling function
void yyerror(const char *s) {
    fprintf(stderr, "Parser error: %s\n", s);
}

