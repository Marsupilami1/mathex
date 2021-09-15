module Token where

import PMonad

data Token
  = TSpec String
  | TValue Value
  | TOB
  | TCB
  | TOP
  | TCP
  | TOS
  | TCS
  | TSemicolon
  | TComma
  | TMinus
  | TTilda
  | TExclamation
  | TPlus
  | TPlusMinus
  | TMinusPlus
  | TStar
  | TSlash
  | TDots
  | TAnd
  | TOr
  | TPipe
  | TPower
  | TUnderscore
  | TLongEqual
  | TNotEqual
  | TPropto
  | TIff
  | TImplies
  | TLower
  | TLLower
  | TLowerEq
  | TGreater
  | TGGreater
  | TGreaterEq
  | TEqual
  | TTildaEqual
  | TRightArrow
  | TLongArrow
  | TFun String
  | TIntegral
  | TNot
  | TFrom
  | TTo
  | TOf
  | TSum
  | TProduct
  | TFor
  | TLim
  | TAs
  | TIs
  | TForall
  | TIn
  | TEOF
  deriving Show

