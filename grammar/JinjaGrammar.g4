parser grammar JinjaGrammar;

options {
    tokenVocab=JinjaLexer;
}

start : expressions;

expression
    : inline_statement
    ;

expressions     : expression*;

statement_include_template_list
    : STRING_LITERAL
    ;

statement_include_context
    : STATEMENT_INCLUDE_WITH_CONTEXT
    | STATEMENT_INCLUDE_WITHOUT_CONTEXT
    ;

statement_include
    : STATEMENT_ID_INCLUDE (SP statement_include_template_list)?
    ;

block_statement_id
    : STATEMENT_ID_BLOCK
    | STATEMENT_ID_SET
    ;

block_statement_with_parameters
    : block_statement_id
    | block_statement_id
    ;

block_statement_without_parameters
    : block_statement_id
    ;

block_statement_start_content
    : block_statement_without_parameters
    | block_statement_with_parameters
    ;

inline_statement_content
    : statement_include
    ;

inline_statement            : STATEMENT_OPEN inline_statement_content STATEMENT_CLOSE;

block_statement_start       : STATEMENT_OPEN block_statement_start_content STATEMENT_CLOSE;
block_statement_end         : STATEMENT_OPEN END_STATEMENT_ID_PREFIX block_statement_id STATEMENT_CLOSE;

block_statement             : block_statement_start expressions block_statement_end;