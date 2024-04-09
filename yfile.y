//  Η υλοποίηση ενός λεξικού και ενός συντακτικού αναλυτή με χρήση των προγραμμάτων Flex και Bison είναι μια αρκετά εκτενής διαδικασία. 
//  Εδώ θα σας παρουσιάσω ένα βασικό παράδειγμα που να δείχνει τον τρόπο με τον οποίο μπορεί να γίνει αυτό, αλλά δεν θα είναι μια πλήρης υλοποίηση. 
//  Θα πρέπει να το προσαρμόσετε στις ανάγκες και την περιγραφή γραμματικής της γλώσσας που έχετε παρέχει.
//  Πρώτα απ' όλα, θα πρέπει να ορίσετε τη γραμματική της ψευδογλώσσας σας σε ένα αρχείο .y, χρησιμοποιώντας το Bison. 
//  Έπειτα, θα πρέπει να ορίσετε τα patterns για τα tokens σας σε ένα αρχείο .l, χρησιμοποιώντας το Flex.
//  Ένα παράδειγμα για το πώς μπορεί να γίνει αυτό είναι το εξής:
//  Ας πούμε ότι έχουμε το ακόλουθο πρόγραμμα σε ψευδογλώσσα:


//public class MyClass {
//    private int myVariable;
//
//    public void myMethod() {
//        out.print("Hello, world!");
//   }
//}


//  Τότε, η αντίστοιχη γραμματική μπορεί να είναι κάπως έτσι:

%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror(const char *s);
%}

%token PUBLIC PRIVATE CLASS VOID INT OUT PRINT
%token <name> IDENTIFIER
%token <value> INTEGER
%token <string> STRING

%%
program : class_declaration
        ;

class_declaration : PUBLIC CLASS IDENTIFIER '{' variable_declaration method_declaration '}'
                  | PRIVATE CLASS IDENTIFIER '{' variable_declaration method_declaration '}'
                  ;

variable_declaration : INT IDENTIFIER ';'
                     ;

method_declaration : PUBLIC VOID IDENTIFIER '(' ')' '{' out_statement '}'
                   ;

out_statement : OUT PRINT '(' STRING ')' ';'
             ;

%%
void yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s filename\n", argv[0]);
        return 1;
    }

    FILE *input_file = fopen(argv[1], "r");
    if (!input_file) {
        perror(argv[1]);
        return 1;
    }

    yyin = input_file;
    yyparse();
    fclose(input_file);

    return 0;
}

