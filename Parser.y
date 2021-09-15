{
module Parser where

import Lexer
import PMonad
import Token
import Expression

import Control.Monad.Except
import Control.Monad.State
}

%monad { P }
%lexer { lexer } { TEOF }

%name parse
%tokentype { Token }
%error { parseError }

%token
value     { TValue $$    }
'{'       { TOB          }
'}'       { TCB          }
'('       { TOP          }
')'       { TCP          }
'['       { TOS          }
']'       { TCS          }
';'       { TSemicolon   }
','       { TComma       }
'-'       { TMinus       }
'~'       { TTilda       }
'!'       { TExclamation }
'+'       { TPlus        }
'+-'      { TPlusMinus   }
'-+'      { TMinusPlus   }
'*'       { TStar        }
'/'       { TSlash       }
and       { TAnd         }
or        { TOr          }
'^'       { TPower       }
'_'       { TUnderscore  }
'=='      { TLongEqual   }
'/='      { TNotEqual    }
propto    { TPropto      }
'<=>'     { TIff         }
'=>'      { TImplies     }
'<'       { TLower       }
'<<'      { TLLower      }
'<='      { TLowerEq     }
'>'       { TGreater     }
'>>'      { TGGreater    }
'>='      { TGreaterEq   }
'='       { TEqual       }
'~='      { TTildaEqual  }
'->'      { TRightArrow  }
'-->'     { TLongArrow   }
fun       { TFun $$      }
integral  { TIntegral    }
not       { TNot         }
from      { TFrom        }
to        { TTo          }
of        { TOf          }
sum       { TSum         }
product   { TProduct     }
for       { TFor         }
lim       { TLim         }
as        { TAs          }
is        { TIs          }
forall    { TForall      }
in        { TIn          }



%right '<=>' '=>'
%right '=' '~=' '/=' '==' '~' '->' '-->' is propto
%left of
%left or
%left and
%left '<' '<=' '>' '>=' '>>' '<<'
%left '+' '-'
%left '*' '/'
%left '^' '_'
%left ';' ','
%nonassoc '!' not '+-' '-+'
%left '(' ')' '{' '}' '[' ']' integral sum product lim fun value forall in
%%

Exp :: { Exp }
    : Exp Exp %prec '*'      { BinOp ""    $1 $2 }
    | Exp ';'   Exp          { BinOp ";"   $1 $3 }
    | Exp ','   Exp          { BinOp ","   $1 $3 }
    | Exp '-'   Exp          { BinOp "-"   $1 $3 }
    | Exp '~'   Exp          { BinOp "~"   $1 $3 }
    | Exp '+'   Exp          { BinOp "+"   $1 $3 }
    | Exp '*'   Exp          { BinOp "*"   $1 $3 }
    | Exp '/'   Exp          { BinOp "/"   $1 $3 }
    | Exp and   Exp          { BinOp "and" $1 $3 }
    | Exp or    Exp          { BinOp "or"  $1 $3 }
    | Exp '^'   Exp          { BinOp "^"   $1 $3 }
    | Exp '_'   Exp          { BinOp "_"   $1 $3 }
    | Exp '=='  Exp          { BinOp "=="  $1 $3 }
    | Exp '/='  Exp          { BinOp "/="  $1 $3 }
    | Exp propto  Exp        { BinOp "propto"  $1 $3 }
    | Exp '<=>' Exp          { BinOp "<=>"  $1 $3 }
    | Exp '=>'  Exp          { BinOp "=>"  $1 $3 }
    | Exp '<'   Exp          { BinOp "<"   $1 $3 }
    | Exp '<<'  Exp          { BinOp "<<"  $1 $3 }
    | Exp '<='  Exp          { BinOp "<="  $1 $3 }
    | Exp '>'   Exp          { BinOp ">"   $1 $3 }
    | Exp '>>'  Exp          { BinOp ">>"  $1 $3 }
    | Exp '>='  Exp          { BinOp ">="  $1 $3 }
    | Exp '='   Exp          { BinOp "="   $1 $3 }
    | Exp '~='  Exp          { BinOp "~="  $1 $3 }
    | Exp '->'  Exp          { BinOp "->"  $1 $3 }
    | Exp '-->' Exp          { BinOp "-->" $1 $3 }

    | Exp '!'                { UnOp "!"   $1 }
    | not Exp                { UnOp "not" $2 }
    | '+-'  Exp              { UnOp "+-"  $2 }
    | '-+'  Exp              { UnOp "-+"  $2 }

    | '(' Exp ')'            { Brace "(" ")" $2                }
    | '{' Exp '}'            { Brace "\\lbrace" "\\rbrace" $2  }
    | '[' Exp ']'            { Brace "[" "]" $2                }

    | lim as Exp of Exp is Exp        { Limit $3 $5 $7    }
    | integral from Exp to Exp of Exp { Super "\\int" $3 $5 $7 }
    | sum for Exp to Exp of Exp       { Super "\\sum" $3 $5 $7      }
    | product for Exp to Exp of Exp   { Super "\\prod" $3 $5 $7      }
    | forall Exp in Exp               { Forall $2 $4      }

    | fun                             { Fun $1   }
    | value                           { Const $1 }


{
parseError :: Token -> P a
parseError _ = throwError "Error while parsing."
}
