module PMonad where

import Control.Monad.State
import Data.Word

type PState = ( [Word8] -- remaining bytes
              , String  -- remaining string
              )

-- The monad in which all the computations are done
type P a = StateT PState (Either String) a

-- Run the lexer/parser/converter on the given string
runP :: P a -> String -> Either String a
runP p s = evalStateT p ([], s)


data Value
  = Special String
  | Value String
  deriving Show
