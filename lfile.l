//Στη συνέχεια, θα πρέπει να ορίσετε τα patterns των tokens σας σε ένα αρχείο .l, χρησιμοποιώντας το Flex. Για παράδειγμα:


%{
#include "y.tab.h"
%}

%%

"public"    { return PUBLIC; }
"private"   { return PRIVATE; }
"class"     { return CLASS; }
"void"      { return VOID; }
"int"       { return INT; }
"out.print" { return PRINT; }

[a-zA-Z][a-zA-Z0-9]*    { yylval.name = strdup(yytext); return IDENTIFIER; }
[0-9]+                  { yylval.value = atoi(yytext); return INTEGER; }
\".*\"                  { yylval.string = strdup(yytext); return STRING; }

[ \t\n]                 ; // Skip whitespace
.                       { printf("Unrecognized character '%c'\n", yytext[0]); }

%%


//Αφού ορίσετε αυτά τα δύο αρχεία, μπορείτε να τα συνδέσετε μαζί και να δημιουργήσετε τον compiler σας:

//bison -d your_file.y
//flex your_file.l
//gcc lex.yy.c your_file.tab.c -o your_compiler
