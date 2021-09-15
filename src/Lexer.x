{
module Lexer where

import Token
import PMonad

import Control.Monad.State
import Control.Monad.Except
import Data.Word
import Data.List.Extra (replace)
import Codec.Binary.UTF8.String
}

@fun   = ("cos"|"sin"|"tan"|"acos"|"asin"|"atan"|"log"|"ln"|"exp"
         |"Im"|"Re"|"Ker"|"lim")
$alpha = [a-zA-Z]
$digit = [0-9]

tokens :-
  $white                      ;
  "..."                       { const $ TValue $ Value "\\cdots" }

  "{"                         { const TOB          }
  "}"                         { const TCB          }
  "("                         { const TOP          }
  ")"                         { const TCP          }
  "["                         { const TOS          }
  "]"                         { const TCS          }

  ";"                         { const TSemicolon   }
  ","                         { const TComma       }
  "-"                         { const TMinus       }
  "~"                         { const TTilda       }
  "!"                         { const TExclamation }
  "+"                         { const TPlus        }
  "+-"                        { const TPlusMinus   }
  "-+"                        { const TMinusPlus   }
  "*"                         { const TStar        }
  "/"                         { const TSlash       }
  ("&&"|and)                  { const TAnd         }
  ("||"|or)                   { const TOr          }
  "|"                         { const TPipe        }
  ("^"|"**")                  { const TPower       }
  "_"                         { const TUnderscore  }
  "=="                        { const TLongEqual   }
  ("!="|"/=")                 { const TNotEqual    }
  propto                      { const TPropto      }
  ("<=>"|iff)                 { const TIff         }
  "=>"                        { const TImplies     }
  "<"                         { const TLower       }
  "<<"                        { const TLLower      }
  "<="                        { const TLowerEq     }
  ">"                         { const TGreater     }
  ">>"                        { const TGGreater    }
  ">="                        { const TGreaterEq   }
  "="                         { const TEqual       }
  "~="                        { const TTildaEqual  }
  "->"                        { const TRightArrow  }
  "-->"                       { const TLongArrow   }
  @fun                        { TFun               }
  (int|integral)              { const TIntegral    }
  not                         { const TNot         }
  from                        { const TFrom        }
  to                          { const TTo          }
  of                          { const TOf          }
  sum                         { const TSum         }
  product                     { const TProduct     }
  for                         { const TFor         }
  (limit|lim)                 { const TLim         }
  as                          { const TAs          }
  is                          { const TIs          }
  forall                      { const TForall      }
  in                          { const TIn          }
  ":"$alpha+                  { TValue . Special   }
  "-"?[$alpha $digit]+        { TValue . Value     }
  $digit+"."$digit+           { TValue . Value . replace "." "," }


{
type AlexInput = PState

alexGetByte :: AlexInput -> Maybe (Word8, AlexInput)
alexGetByte ((b:bs), s) = Just (b, (bs, s))
alexGetByte ([], (c:s)) = case encodeChar c of
                            (b:bs) -> Just (b, (bs, s))
alexGetByte ([], []) = Nothing

alexInputPrevChar = undefined

readToken :: P Token
readToken = do
  s <- get
  case alexScan s 0 of
    AlexEOF -> return TEOF
    AlexError inp' -> throwError $ "Error while lexing: " ++ takeWhile (/= ' ') (snd inp')
    AlexSkip inp' _ -> put inp' >> readToken
    AlexToken inp' len action -> do
        let tk = action $ take len (snd s)
        put inp'
        return tk


-- lexing function used by the parser
lexer :: (Token -> P a) -> P a
lexer cont = readToken >>= cont
}
