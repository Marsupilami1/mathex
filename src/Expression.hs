module Expression where

import qualified Data.Map as Map
import Control.Monad.Except
import PMonad
import Token

data Exp
  = Const Value

  | BinOp String Exp Exp
  | UnOp String Exp

  | Brace String String Exp
  | Fun String

  | Super String Exp Exp Exp
  | Limit Exp Exp Exp
  | Forall Exp Exp
  deriving Show

binOps :: String -> String -> Map.Map String String
binOps a b = Map.fromList
  [ ("+",  a ++ "+"        ++ b)
  , ("-",  a ++ "-"        ++ b)
  , ("*",  a ++ "\\cdot "  ++ b)
  , (" ",  a               ++ b)
  , ("/",  "\\dfrac{" ++ a ++ "}{" ++ b ++ "}")
  , ("^",  a ++ "^{"       ++ b ++ "}")
  , ("_",  a ++ "_{"       ++ b ++ "}")
  , ("and", a ++ "\\wedge " ++ b)
  , ("or",  a ++ "\\vee "    ++ b)
  , ("=",  a ++ "="        ++ b)
  , ("==", a ++ "\\equiv " ++ b)
  , (">",  a ++ ">"        ++ b)
  , ("<",  a ++ "<"        ++ b)
  , ("~",  a ++ "\\sim "   ++ b)
  , (">=", a ++ "\\geqslant " ++ b)
  , ("<=", a ++ "\\leqslant " ++ b)
  , (">>", a ++ "\\gg " ++ b)
  , ("<<", a ++ "\\ll " ++ b)
  , ("/=", a ++ "\\neq "      ++ b)
  , ("~=", a ++ "\\approx "   ++  b)
  , ("propto", a ++ "\\propto " ++  b)
  , ("<=>", a ++ "\\iff "  ++  b)
  , ("=>",  a ++ "\\implies "        ++  b)
  , ("->",  a ++ "\\rightarrow "     ++  b)
  , ("-->", a ++ "\\longrightarrow " ++  b)
  , ("",    a ++  b)
  , (";",   a ++ ";" ++  b)
  , (",",   a ++ "," ++  b)
  ]

unOps :: String -> Map.Map String String
unOps a = Map.fromList
  [ ("!", a ++ "!")
  , ("not", "\\neg " ++ a)
  , ("+-", "\\pm "   ++ a)
  , ("-+", "\\mp "   ++ a)
  ]

special :: Map.Map String String
special = Map.fromList
  -- Greek letters
  [ ("al", "\\alpha "), ("be", "\\beta "), ("ga", "\\gamma "), ("de", "\\delta ")
  , ("ep", "\\epsilon "), ("ze", "\\zeta "), ("et", "\\eta "), ("th", "\\theta ")
  , ("io", "\\iota "), ("ka", "\\kappa "), ("la", "\\lambda "), ("mu", "\\mu ")
  , ("nu", "\\nu "), ("xi", "\\xi "), ("oo", "\\omicron "), ("pi", "\\pi ")
  , ("rh", "\\rho "), ("si", "\\sigma "), ("ta", "\\tau "), ("up", "\\upsilon ")
  , ("ph", "\\phi "), ("ch", "\\chi "), ("ps", "\\psi "), ("om", "\\omega ")
  , ("Al", "A"), ("Be", "B"), ("Ga", "\\Gamma "), ("De", "\\Delta ")
  , ("Ep", "E"), ("Ze", "Z"), ("Et", "H"), ("Th", "\\Theta ")
  , ("Io", "I"), ("Ka", "K"), ("La", "\\Lambda "), ("Mu", "M")
  , ("Nu", "N"), ("Xi", "\\Xi "), ("Oo", "O"), ("Pi", "\\Pi ")
  , ("Rh", "P"), ("Si", "\\Sigma "), ("Ta", "T"), ("Up", "\\Upsilon ")
  , ("Ph", "\\Phi "), ("Ch", "X"), ("Ps", "\\Psi "), ("Om", "\\Omega ")
  -- Maths symbols
  , ("inf", "\\infty"), ("pinf", "+\\infty"), ("minf", "-\\infty")
  ]


unpar :: Exp -> Exp -- remove the parenthesis around a
unpar (Brace _ _ a) = a
unpar a = a

texify :: Exp -> P String
texify (Const (Value a)) = return a
texify (Const (Special a)) =
  case Map.lookup (tail a) special of
    Nothing -> throwError $ "Unknown special character: " ++ a
    Just s -> return s
texify (BinOp o a b) = do
  ta <- texify a
  tb <- texify b
  case Map.lookup o (binOps ta tb) of
    Nothing -> throwError $ "Unknown operator: " ++ o
    Just f  -> return f
texify (UnOp o a) = do
  ta <- texify a
  case Map.lookup o (unOps ta) of
    Nothing -> throwError $ "Unknown operator: " ++ o
    Just f  -> return f
texify (Brace ob cb a) = do
  ta <- texify a
  return $ "\\left" ++ ob ++ ta ++ "\\right" ++ cb
texify (Fun f) = return $ "\\" ++ f
texify (Super s a b f) = do
  ta <- texify a
  tb <- texify b
  tf <- texify f
  return $ s ++ "_{" ++ ta ++ "}^{" ++ tb ++ "}" ++ tf
texify (Limit x f l) = do
  tx <- texify x
  tf <- texify f
  tl <- texify l
  return $ tf ++ "\\xrightarrow[" ++ tx ++ "]" ++ "{} " ++ tl
texify (Forall x e) = do
  tx <- texify x
  te <- texify e
  return $ "\\forall " ++ tx ++ "\\in " ++ te
