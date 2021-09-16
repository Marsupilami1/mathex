{-# OPTIONS_GHC -w #-}
{-# OPTIONS -XMagicHash -XBangPatterns -XTypeSynonymInstances -XFlexibleInstances -cpp #-}
#if __GLASGOW_HASKELL__ >= 710
{-# OPTIONS_GHC -XPartialTypeSignatures #-}
#endif
module Parser where

import Lexer
import PMonad
import Token
import Expression

import Control.Monad.Except
import Control.Monad.State
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import qualified GHC.Exts as Happy_GHC_Exts
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.20.0

newtype HappyAbsSyn  = HappyAbsSyn HappyAny
#if __GLASGOW_HASKELL__ >= 607
type HappyAny = Happy_GHC_Exts.Any
#else
type HappyAny = forall a . a
#endif
newtype HappyWrap4 = HappyWrap4 (Exp)
happyIn4 :: (Exp) -> (HappyAbsSyn )
happyIn4 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap4 x)
{-# INLINE happyIn4 #-}
happyOut4 :: (HappyAbsSyn ) -> HappyWrap4
happyOut4 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut4 #-}
happyInTok :: (Token) -> (HappyAbsSyn )
happyInTok x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyInTok #-}
happyOutTok :: (HappyAbsSyn ) -> (Token)
happyOutTok x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOutTok #-}


happyExpList :: HappyAddr
happyExpList = HappyA# "\xb0\x02\x06\x00\x00\xc7\x02\x56\xc0\x00\x00\xe0\x58\xc0\xea\xff\xff\xff\x1f\x0b\x00\x00\x00\x00\x00\x00\x00\x2b\x60\x00\x00\x70\x2c\x60\x05\x0c\x00\x00\x8e\x05\xac\x80\x01\x00\xc0\xb1\x80\x15\x30\x00\x00\x38\x16\xb0\x02\x06\x00\x00\xc7\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x20\x00\x58\x01\x03\x00\x80\x63\x01\x00\x00\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x81\xd5\xff\xff\xff\x3f\x16\xb0\x9a\x86\x01\x00\xc7\x02\x56\xc0\x00\x00\xe0\x58\xc0\x0a\x18\x00\x00\x1c\x0b\x58\x01\x03\x00\x80\x63\x01\x2b\x60\x00\x00\x70\x2c\x00\x00\x00\x00\x00\x00\x00\xac\x80\x01\x00\xc0\xb1\x80\x15\x30\x00\x00\x38\x16\xb0\x02\x06\x00\x00\xc7\x02\x56\xc0\x00\x00\xe0\x58\xc0\x0a\x18\x00\x00\x1c\x0b\x58\x01\x03\x00\x80\x63\x01\x2b\x60\x00\x00\x70\x2c\x60\x05\x0c\x00\x00\x8e\x05\xac\x80\x01\x00\xc0\xb1\x80\x15\x30\x00\x00\x38\x16\xb0\x02\x06\x00\x00\xc7\x02\x56\xc0\x00\x00\xe0\x58\xc0\x0a\x18\x00\x00\x1c\x0b\x58\x01\x03\x00\x80\x63\x01\x2b\x60\x00\x00\x70\x2c\x60\x05\x0c\x00\x00\x8e\x05\xac\x80\x01\x00\xc0\xb1\x80\x15\x30\x00\x00\x38\x16\xb0\x02\x06\x00\x00\xc7\x02\x56\xc0\x00\x00\xe0\x58\xc0\x0a\x18\x00\x00\x1c\x0b\x58\x01\x03\x00\x80\x63\x01\x2b\x60\x00\x00\x70\x2c\x60\x05\x0c\x00\x00\x8e\x05\xac\x80\x01\x00\xc0\xb1\x80\x15\x00\x00\x00\x18\x16\xb0\x02\x06\x00\x00\xc7\x02\x56\x00\x00\x00\x60\x58\xc0\x0a\x00\x00\x00\x0c\x0b\x58\xff\xff\xff\xff\x63\x01\xbb\xff\xff\xff\x7f\x2c\xe0\xf5\xff\xff\xff\x8f\x05\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x56\xff\xff\xff\xff\x5a\xc0\xea\xff\xff\xff\x5f\x0b\x58\xfd\xff\xff\xff\x6b\x01\xab\xff\xff\xff\x7f\x2e\x60\xf5\xff\x9f\xff\x8f\x05\xac\xfe\xff\xf3\xff\xb1\x80\xd5\xff\x7f\xfe\x3f\x16\xb0\xfa\xff\xcf\xff\xc7\x02\x56\xf7\x33\x00\xe0\x58\xc0\xea\x7e\x06\x00\x1c\x0b\x58\xdd\xcf\x00\x80\x63\x01\xab\xfb\x19\x00\x70\x2c\x60\x75\x3f\x03\x00\x8e\x05\xac\xee\x67\x00\xc0\xb1\x80\xd5\xff\xff\xff\x3f\x16\xb0\xfa\xff\xff\xff\xc7\x02\x56\xff\xff\xf9\xff\x58\xc0\xea\xff\x3f\xff\x1f\x0b\x58\xfd\xff\xe7\xff\x63\x01\xab\x69\x00\x00\x70\x2c\x60\x35\x0d\x00\x00\x8e\x05\xac\xee\x6f\xf0\xc3\xb1\x80\xd5\xfd\x0c\x7e\x38\x16\xb0\x9a\x86\x01\x00\xc7\x02\x56\xd3\x30\x00\xe0\x58\xc0\x6a\x7a\x06\x00\x1c\x0b\x58\xfd\xff\xe7\xff\x63\x01\xab\xe9\x19\x00\x70\x2c\x60\x05\x0d\x00\x00\x8e\x05\xac\xa0\x01\x00\xc0\xb1\x80\x15\x30\x00\x00\x38\x16\xb0\x02\x06\x00\x00\xc7\x02\x56\xc0\x00\x00\xe0\x58\xc0\x0a\x18\x00\x00\x1c\x0b\x58\xfd\xff\xff\xff\x73\x01\xab\xff\xff\xff\x7f\x2e\x60\xf5\xff\xff\xff\xcf\x05\xac\xfe\xff\xff\xff\xb1\x82\x15\x30\x00\x00\x38\x16\xb0\x02\x06\x00\x00\xc7\x02\x56\xc0\x00\x00\xe0\x58\xc0\x0a\x18\x00\x00\x1c\x0b\x58\xdd\xff\xe0\x87\x63\x01\xab\xfb\x1f\xfc\x70\x2c\x60\x75\xff\x83\x1f\x8e\x05\xac\xfe\xff\xf3\xff\xb1\x00\x00\x00\x00"#

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","Exp","value","'{'","'}'","'('","')'","'['","']'","';'","','","'-'","'~'","'!'","'+'","'+-'","'-+'","'*'","'/'","and","or","'^'","'_'","'=='","'/='","propto","'<=>'","'=>'","'<'","'<<'","'<='","'>'","'>>'","'>='","'='","'~='","'->'","'-->'","fun","integral","not","from","to","of","sum","product","for","lim","as","is","%eof"]
        bit_start = st Prelude.* 53
        bit_end = (st Prelude.+ 1) Prelude.* 53
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..52]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

happyActOffsets :: HappyAddr
happyActOffsets = HappyA# "\xce\x03\xce\x03\x2b\x02\x00\x00\xce\x03\xce\x03\xce\x03\xce\x03\xce\x03\x00\x00\xd9\xff\xce\x03\xd7\xff\xdb\xff\xfa\xff\x01\x00\x54\x03\xce\x03\xce\x03\xce\x03\xce\x03\x00\x00\xce\x03\xce\x03\xce\x03\xce\x03\xce\x03\xce\x03\xce\x03\xce\x03\xce\x03\xce\x03\xce\x03\xce\x03\xce\x03\xce\x03\xce\x03\xce\x03\xce\x03\xce\x03\xce\x03\xce\x03\xce\x03\xce\x03\xce\x03\xce\x03\xce\x03\x91\x03\xce\x03\x91\x03\x91\x03\x5f\x00\x8d\x00\xbb\x00\x00\x00\x00\x00\x00\x00\xe9\x00\x17\x01\x45\x01\x73\x01\x59\x02\x59\x02\x59\x02\x59\x02\x11\x03\x11\x03\x11\x03\x11\x03\x11\x03\x11\x03\x2b\x02\x2b\x02\x59\x02\x59\x02\x59\x02\x82\x03\x82\x03\xb5\x02\xe3\x02\x54\x03\x54\x03\x3f\x03\x59\x02\x3f\x03\xbf\x03\xbf\x03\xce\x03\xce\x03\xce\x03\xce\x03\xa1\x01\xcf\x01\xfd\x01\x2f\x00\xce\x03\xce\x03\xce\x03\xce\x03\x87\x02\x87\x02\x87\x02\x59\x02\x00\x00"#

happyGotoOffsets :: HappyAddr
happyGotoOffsets = HappyA# "\x06\x00\x2a\x00\x2b\x00\x00\x00\x2e\x00\x34\x00\x36\x00\x57\x00\x58\x00\x00\x00\x00\x00\x59\x00\x00\x00\x00\x00\x00\x00\x5c\x00\x5c\x00\x5e\x00\x62\x00\x64\x00\x87\x00\x00\x00\x88\x00\x89\x00\x8c\x00\x90\x00\x94\x00\xb5\x00\xb6\x00\xb7\x00\xba\x00\xc0\x00\xc2\x00\xe3\x00\xe4\x00\xe5\x00\xe8\x00\xec\x00\xee\x00\xf0\x00\x11\x01\x13\x01\x16\x01\x1a\x01\x1c\x01\x1e\x01\x3f\x01\x41\x01\x44\x01\x48\x01\x48\x01\x48\x01\x48\x01\x48\x01\x00\x00\x00\x00\x00\x00\x48\x01\x48\x01\x48\x01\x48\x01\x48\x01\x48\x01\x48\x01\x48\x01\x48\x01\x48\x01\x48\x01\x48\x01\x48\x01\x48\x01\x48\x01\x48\x01\x48\x01\x48\x01\x48\x01\x48\x01\x48\x01\x48\x01\x48\x01\x48\x01\x48\x01\x48\x01\x48\x01\x48\x01\x48\x01\x48\x01\x4a\x01\x4c\x01\x6d\x01\x6f\x01\x72\x01\x72\x01\x72\x01\x72\x01\x76\x01\x78\x01\x7a\x01\x9b\x01\x9c\x01\x9c\x01\x9c\x01\x9c\x01\x00\x00"#

happyAdjustOffset :: Happy_GHC_Exts.Int# -> Happy_GHC_Exts.Int#
happyAdjustOffset off = off

happyDefActions :: HappyAddr
happyDefActions = HappyA# "\x00\x00\x00\x00\x00\x00\xd7\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xd8\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xfe\xff\x00\x00\x00\x00\x00\x00\x00\x00\xe3\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xe2\xff\x00\x00\xe0\xff\xe1\xff\x00\x00\x00\x00\x00\x00\xde\xff\xdf\xff\xdd\xff\x00\x00\x00\x00\x00\x00\x00\x00\xe4\xff\xe5\xff\xe6\xff\xe7\xff\xe8\xff\xe9\xff\xea\xff\xeb\xff\xec\xff\xed\xff\xee\xff\xef\xff\xf0\xff\xf1\xff\xf2\xff\xf3\xff\xf4\xff\xf5\xff\xf6\xff\xf7\xff\xf8\xff\xf9\xff\xfa\xff\xfb\xff\xfc\xff\xfd\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xdb\xff\xda\xff\xd9\xff\xdc\xff"#

happyCheck :: HappyAddr
happyCheck = HappyA# "\xff\xff\x28\x00\x01\x00\x02\x00\x2d\x00\x04\x00\x00\x00\x06\x00\x2d\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x2f\x00\x00\x00\x00\x00\x2b\x00\x2c\x00\x00\x00\x2e\x00\x01\x00\x02\x00\x31\x00\x04\x00\x00\x00\x06\x00\x00\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x00\x00\x00\x00\x00\x00\x2b\x00\x2c\x00\x00\x00\x2e\x00\x00\x00\x30\x00\x01\x00\x02\x00\x00\x00\x04\x00\x00\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x00\x00\x00\x00\x00\x00\x2b\x00\x2c\x00\x00\x00\x2e\x00\x01\x00\x02\x00\x00\x00\x04\x00\x05\x00\x06\x00\x00\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x00\x00\x00\x00\x00\x00\x2b\x00\x2c\x00\x00\x00\x2e\x00\x01\x00\x02\x00\x03\x00\x04\x00\x00\x00\x06\x00\x00\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x00\x00\x00\x00\x00\x00\x2b\x00\x2c\x00\x00\x00\x2e\x00\x01\x00\x02\x00\x00\x00\x04\x00\x00\x00\x06\x00\x00\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x00\x00\x29\x00\x00\x00\x2b\x00\x2c\x00\x00\x00\x2e\x00\x01\x00\x02\x00\x00\x00\x04\x00\x00\x00\x06\x00\x00\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x00\x00\x29\x00\x00\x00\x2b\x00\x2c\x00\x00\x00\x2e\x00\x01\x00\x02\x00\x00\x00\x04\x00\x00\x00\x06\x00\x00\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x00\x00\x29\x00\x00\x00\x2b\x00\x2c\x00\x00\x00\x2e\x00\x01\x00\x02\x00\x00\x00\x04\x00\x00\x00\x06\x00\x00\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x00\x00\x00\x00\x2a\x00\x2b\x00\x2c\x00\xff\xff\x2e\x00\x01\x00\x02\x00\xff\xff\x04\x00\xff\xff\x06\x00\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\xff\xff\xff\xff\x2a\x00\x2b\x00\x2c\x00\xff\xff\x2e\x00\x01\x00\x02\x00\xff\xff\x04\x00\xff\xff\x06\x00\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\xff\xff\xff\xff\x2a\x00\x2b\x00\x2c\x00\xff\xff\x2e\x00\x01\x00\x02\x00\xff\xff\x04\x00\xff\xff\x06\x00\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\xff\xff\xff\xff\x2a\x00\x2b\x00\x2c\x00\xff\xff\x2e\x00\x01\x00\x02\x00\xff\xff\x04\x00\xff\xff\x06\x00\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\xff\xff\xff\xff\xff\xff\x2b\x00\x2c\x00\xff\xff\x2e\x00\x01\x00\x02\x00\xff\xff\x04\x00\xff\xff\x06\x00\xff\xff\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x18\x00\xff\xff\xff\xff\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\xff\xff\xff\xff\xff\xff\x2b\x00\x2c\x00\xff\xff\x2e\x00\x01\x00\x02\x00\xff\xff\x04\x00\xff\xff\x06\x00\xff\xff\x08\x00\x09\x00\x0a\x00\xff\xff\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\xff\xff\xff\xff\xff\xff\xff\xff\x25\x00\x26\x00\x27\x00\xff\xff\xff\xff\xff\xff\x2b\x00\x2c\x00\xff\xff\x2e\x00\x01\x00\x02\x00\xff\xff\x04\x00\xff\xff\x06\x00\xff\xff\x08\x00\x09\x00\x0a\x00\xff\xff\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\xff\xff\x14\x00\x15\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\xff\xff\xff\xff\xff\xff\xff\xff\x25\x00\x26\x00\x27\x00\xff\xff\xff\xff\xff\xff\x2b\x00\x2c\x00\xff\xff\x2e\x00\x01\x00\x02\x00\xff\xff\x04\x00\xff\xff\x06\x00\xff\xff\x08\x00\x09\x00\x0a\x00\xff\xff\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\xff\xff\xff\xff\x14\x00\x15\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\xff\xff\xff\xff\xff\xff\xff\xff\x25\x00\x26\x00\x27\x00\xff\xff\xff\xff\xff\xff\x2b\x00\x2c\x00\xff\xff\x2e\x00\x01\x00\x02\x00\xff\xff\x04\x00\xff\xff\x06\x00\xff\xff\x08\x00\x09\x00\x0a\x00\xff\xff\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\xff\xff\xff\xff\x14\x00\x15\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x25\x00\x26\x00\x27\x00\xff\xff\xff\xff\xff\xff\x2b\x00\x2c\x00\xff\xff\x2e\x00\x01\x00\x02\x00\xff\xff\x04\x00\xff\xff\x06\x00\xff\xff\x08\x00\x09\x00\xff\xff\xff\xff\x0c\x00\xff\xff\x0e\x00\x0f\x00\x10\x00\x11\x00\xff\xff\xff\xff\x14\x00\x15\x00\x01\x00\x02\x00\xff\xff\x04\x00\xff\xff\x06\x00\xff\xff\x08\x00\x09\x00\xff\xff\xff\xff\x0c\x00\xff\xff\x0e\x00\x0f\x00\x25\x00\x26\x00\x27\x00\xff\xff\x14\x00\x15\x00\x2b\x00\x2c\x00\xff\xff\x2e\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x25\x00\x26\x00\x27\x00\xff\xff\xff\xff\xff\xff\x2b\x00\x2c\x00\xff\xff\x2e\x00\x01\x00\x02\x00\xff\xff\x04\x00\xff\xff\x06\x00\xff\xff\x08\x00\x09\x00\xff\xff\xff\xff\x0c\x00\xff\xff\x0e\x00\x0f\x00\x01\x00\x02\x00\xff\xff\x04\x00\xff\xff\x06\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x0c\x00\xff\xff\x0e\x00\x0f\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x25\x00\x26\x00\x27\x00\xff\xff\xff\xff\xff\xff\x2b\x00\x2c\x00\xff\xff\x2e\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x25\x00\x26\x00\x27\x00\xff\xff\xff\xff\xff\xff\x2b\x00\x2c\x00\xff\xff\x2e\x00\x01\x00\x02\x00\xff\xff\x04\x00\xff\xff\x06\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x0c\x00\xff\xff\x0e\x00\x0f\x00\x01\x00\x02\x00\xff\xff\x04\x00\xff\xff\x06\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x0e\x00\x0f\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x25\x00\x26\x00\x27\x00\xff\xff\xff\xff\xff\xff\x2b\x00\x2c\x00\xff\xff\x2e\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x25\x00\x26\x00\x27\x00\xff\xff\xff\xff\xff\xff\x2b\x00\x2c\x00\xff\xff\x2e\x00\xff\xff\xff\xff\xff\xff"#

happyTable :: HappyAddr
happyTable = HappyA# "\x00\x00\x31\x00\x04\x00\x05\x00\x2f\x00\x06\x00\x0f\x00\x07\x00\x2e\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x08\x00\x09\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x0a\x00\x0b\x00\x0c\x00\x2d\x00\x02\x00\x10\x00\x0d\x00\x0e\x00\x35\x00\x0f\x00\x04\x00\x05\x00\xff\xff\x06\x00\x34\x00\x07\x00\x33\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x08\x00\x09\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x0a\x00\x0b\x00\x0c\x00\x32\x00\x31\x00\x2f\x00\x0d\x00\x0e\x00\x10\x00\x0f\x00\x56\x00\x60\x00\x04\x00\x05\x00\x55\x00\x06\x00\x54\x00\x07\x00\x39\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x08\x00\x09\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x0a\x00\x0b\x00\x0c\x00\x53\x00\x52\x00\x51\x00\x0d\x00\x0e\x00\x50\x00\x0f\x00\x04\x00\x05\x00\x4f\x00\x06\x00\x38\x00\x07\x00\x4e\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x08\x00\x09\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x0a\x00\x0b\x00\x0c\x00\x4d\x00\x4c\x00\x4b\x00\x0d\x00\x0e\x00\x4a\x00\x0f\x00\x04\x00\x05\x00\x37\x00\x06\x00\x49\x00\x07\x00\x48\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x08\x00\x09\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x0a\x00\x0b\x00\x0c\x00\x47\x00\x46\x00\x45\x00\x0d\x00\x0e\x00\x44\x00\x0f\x00\x04\x00\x05\x00\x43\x00\x06\x00\x42\x00\x07\x00\x41\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x08\x00\x09\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x0a\x00\x0b\x00\x0c\x00\x40\x00\x5b\x00\x3f\x00\x0d\x00\x0e\x00\x3e\x00\x0f\x00\x04\x00\x05\x00\x3d\x00\x06\x00\x3c\x00\x07\x00\x3b\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x08\x00\x09\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x0a\x00\x0b\x00\x0c\x00\x3a\x00\x5a\x00\x10\x00\x0d\x00\x0e\x00\x39\x00\x0f\x00\x04\x00\x05\x00\x10\x00\x06\x00\x5e\x00\x07\x00\x5d\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x08\x00\x09\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x0a\x00\x0b\x00\x0c\x00\x5c\x00\x59\x00\x5b\x00\x0d\x00\x0e\x00\x10\x00\x0f\x00\x04\x00\x05\x00\x66\x00\x06\x00\x65\x00\x07\x00\x64\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x08\x00\x09\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x0a\x00\x0b\x00\x0c\x00\x63\x00\x10\x00\x58\x00\x0d\x00\x0e\x00\x00\x00\x0f\x00\x04\x00\x05\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x08\x00\x09\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x0a\x00\x0b\x00\x0c\x00\x00\x00\x00\x00\x63\x00\x0d\x00\x0e\x00\x00\x00\x0f\x00\x04\x00\x05\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x08\x00\x09\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x0a\x00\x0b\x00\x0c\x00\x00\x00\x00\x00\x62\x00\x0d\x00\x0e\x00\x00\x00\x0f\x00\x04\x00\x05\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x08\x00\x09\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x0a\x00\x0b\x00\x0c\x00\x00\x00\x00\x00\x61\x00\x0d\x00\x0e\x00\x00\x00\x0f\x00\x04\x00\x05\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x08\x00\x09\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x0a\x00\x0b\x00\x0c\x00\x00\x00\x00\x00\x00\x00\x0d\x00\x0e\x00\x00\x00\x0f\x00\x04\x00\x05\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x08\x00\x09\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x00\x00\x00\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x0a\x00\x0b\x00\x0c\x00\x00\x00\x00\x00\x00\x00\x0d\x00\x0e\x00\x00\x00\x0f\x00\x04\x00\x05\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x12\x00\x13\x00\x14\x00\x00\x00\x16\x00\x17\x00\x08\x00\x09\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0a\x00\x0b\x00\x0c\x00\x00\x00\x00\x00\x00\x00\x0d\x00\x0e\x00\x00\x00\x0f\x00\x04\x00\x05\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x12\x00\x13\x00\x14\x00\x00\x00\x16\x00\x17\x00\x08\x00\x09\x00\x18\x00\x19\x00\x1a\x00\x00\x00\x1c\x00\x1d\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0a\x00\x0b\x00\x0c\x00\x00\x00\x00\x00\x00\x00\x0d\x00\x0e\x00\x00\x00\x0f\x00\x04\x00\x05\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x12\x00\x13\x00\x14\x00\x00\x00\x16\x00\x17\x00\x08\x00\x09\x00\x18\x00\x19\x00\x00\x00\x00\x00\x1c\x00\x1d\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0a\x00\x0b\x00\x0c\x00\x00\x00\x00\x00\x00\x00\x0d\x00\x0e\x00\x00\x00\x0f\x00\x04\x00\x05\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x12\x00\x13\x00\x14\x00\x00\x00\x16\x00\x17\x00\x08\x00\x09\x00\x18\x00\x19\x00\x00\x00\x00\x00\x1c\x00\x1d\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0a\x00\x0b\x00\x0c\x00\x00\x00\x00\x00\x00\x00\x0d\x00\x0e\x00\x00\x00\x0f\x00\x04\x00\x05\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x12\x00\x13\x00\x00\x00\x00\x00\x16\x00\x00\x00\x08\x00\x09\x00\x18\x00\x19\x00\x00\x00\x00\x00\x1c\x00\x1d\x00\x04\x00\x05\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x12\x00\x13\x00\x00\x00\x00\x00\x16\x00\x00\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x00\x00\x1c\x00\x1d\x00\x0d\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0a\x00\x0b\x00\x0c\x00\x00\x00\x00\x00\x00\x00\x0d\x00\x0e\x00\x00\x00\x0f\x00\x04\x00\x05\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x12\x00\x13\x00\x00\x00\x00\x00\x16\x00\x00\x00\x08\x00\x09\x00\x04\x00\x05\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0a\x00\x0b\x00\x0c\x00\x00\x00\x00\x00\x00\x00\x0d\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0a\x00\x0b\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0d\x00\x0e\x00\x00\x00\x0f\x00\x04\x00\x05\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x16\x00\x00\x00\x08\x00\x09\x00\x04\x00\x05\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x09\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0a\x00\x0b\x00\x0c\x00\x00\x00\x00\x00\x00\x00\x0d\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0a\x00\x0b\x00\x0c\x00\x00\x00\x00\x00\x00\x00\x0d\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\x00\x00\x00\x00"#

happyReduceArr = Happy_Data_Array.array (1, 40) [
	(1 , happyReduce_1),
	(2 , happyReduce_2),
	(3 , happyReduce_3),
	(4 , happyReduce_4),
	(5 , happyReduce_5),
	(6 , happyReduce_6),
	(7 , happyReduce_7),
	(8 , happyReduce_8),
	(9 , happyReduce_9),
	(10 , happyReduce_10),
	(11 , happyReduce_11),
	(12 , happyReduce_12),
	(13 , happyReduce_13),
	(14 , happyReduce_14),
	(15 , happyReduce_15),
	(16 , happyReduce_16),
	(17 , happyReduce_17),
	(18 , happyReduce_18),
	(19 , happyReduce_19),
	(20 , happyReduce_20),
	(21 , happyReduce_21),
	(22 , happyReduce_22),
	(23 , happyReduce_23),
	(24 , happyReduce_24),
	(25 , happyReduce_25),
	(26 , happyReduce_26),
	(27 , happyReduce_27),
	(28 , happyReduce_28),
	(29 , happyReduce_29),
	(30 , happyReduce_30),
	(31 , happyReduce_31),
	(32 , happyReduce_32),
	(33 , happyReduce_33),
	(34 , happyReduce_34),
	(35 , happyReduce_35),
	(36 , happyReduce_36),
	(37 , happyReduce_37),
	(38 , happyReduce_38),
	(39 , happyReduce_39),
	(40 , happyReduce_40)
	]

happy_n_terms = 50 :: Prelude.Int
happy_n_nonterms = 1 :: Prelude.Int

happyReduce_1 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_1 = happySpecReduce_2  0# happyReduction_1
happyReduction_1 happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { (HappyWrap4 happy_var_1) -> 
	case happyOut4 happy_x_2 of { (HappyWrap4 happy_var_2) -> 
	happyIn4
		 (BinOp ""    happy_var_1 happy_var_2
	)}}

happyReduce_2 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_2 = happySpecReduce_3  0# happyReduction_2
happyReduction_2 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { (HappyWrap4 happy_var_1) -> 
	case happyOut4 happy_x_3 of { (HappyWrap4 happy_var_3) -> 
	happyIn4
		 (BinOp ";"   happy_var_1 happy_var_3
	)}}

happyReduce_3 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_3 = happySpecReduce_3  0# happyReduction_3
happyReduction_3 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { (HappyWrap4 happy_var_1) -> 
	case happyOut4 happy_x_3 of { (HappyWrap4 happy_var_3) -> 
	happyIn4
		 (BinOp ","   happy_var_1 happy_var_3
	)}}

happyReduce_4 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_4 = happySpecReduce_3  0# happyReduction_4
happyReduction_4 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { (HappyWrap4 happy_var_1) -> 
	case happyOut4 happy_x_3 of { (HappyWrap4 happy_var_3) -> 
	happyIn4
		 (BinOp "-"   happy_var_1 happy_var_3
	)}}

happyReduce_5 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_5 = happySpecReduce_3  0# happyReduction_5
happyReduction_5 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { (HappyWrap4 happy_var_1) -> 
	case happyOut4 happy_x_3 of { (HappyWrap4 happy_var_3) -> 
	happyIn4
		 (BinOp "~"   happy_var_1 happy_var_3
	)}}

happyReduce_6 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_6 = happySpecReduce_3  0# happyReduction_6
happyReduction_6 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { (HappyWrap4 happy_var_1) -> 
	case happyOut4 happy_x_3 of { (HappyWrap4 happy_var_3) -> 
	happyIn4
		 (BinOp "+"   happy_var_1 happy_var_3
	)}}

happyReduce_7 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_7 = happySpecReduce_3  0# happyReduction_7
happyReduction_7 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { (HappyWrap4 happy_var_1) -> 
	case happyOut4 happy_x_3 of { (HappyWrap4 happy_var_3) -> 
	happyIn4
		 (BinOp "*"   happy_var_1 happy_var_3
	)}}

happyReduce_8 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_8 = happySpecReduce_3  0# happyReduction_8
happyReduction_8 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { (HappyWrap4 happy_var_1) -> 
	case happyOut4 happy_x_3 of { (HappyWrap4 happy_var_3) -> 
	happyIn4
		 (BinOp "/"   happy_var_1 happy_var_3
	)}}

happyReduce_9 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_9 = happySpecReduce_3  0# happyReduction_9
happyReduction_9 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { (HappyWrap4 happy_var_1) -> 
	case happyOut4 happy_x_3 of { (HappyWrap4 happy_var_3) -> 
	happyIn4
		 (BinOp "and" happy_var_1 happy_var_3
	)}}

happyReduce_10 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_10 = happySpecReduce_3  0# happyReduction_10
happyReduction_10 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { (HappyWrap4 happy_var_1) -> 
	case happyOut4 happy_x_3 of { (HappyWrap4 happy_var_3) -> 
	happyIn4
		 (BinOp "or"  happy_var_1 happy_var_3
	)}}

happyReduce_11 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_11 = happySpecReduce_3  0# happyReduction_11
happyReduction_11 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { (HappyWrap4 happy_var_1) -> 
	case happyOut4 happy_x_3 of { (HappyWrap4 happy_var_3) -> 
	happyIn4
		 (BinOp "^"   happy_var_1 happy_var_3
	)}}

happyReduce_12 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_12 = happySpecReduce_3  0# happyReduction_12
happyReduction_12 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { (HappyWrap4 happy_var_1) -> 
	case happyOut4 happy_x_3 of { (HappyWrap4 happy_var_3) -> 
	happyIn4
		 (BinOp "_"   happy_var_1 happy_var_3
	)}}

happyReduce_13 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_13 = happySpecReduce_3  0# happyReduction_13
happyReduction_13 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { (HappyWrap4 happy_var_1) -> 
	case happyOut4 happy_x_3 of { (HappyWrap4 happy_var_3) -> 
	happyIn4
		 (BinOp "=="  happy_var_1 happy_var_3
	)}}

happyReduce_14 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_14 = happySpecReduce_3  0# happyReduction_14
happyReduction_14 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { (HappyWrap4 happy_var_1) -> 
	case happyOut4 happy_x_3 of { (HappyWrap4 happy_var_3) -> 
	happyIn4
		 (BinOp "/="  happy_var_1 happy_var_3
	)}}

happyReduce_15 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_15 = happySpecReduce_3  0# happyReduction_15
happyReduction_15 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { (HappyWrap4 happy_var_1) -> 
	case happyOut4 happy_x_3 of { (HappyWrap4 happy_var_3) -> 
	happyIn4
		 (BinOp "propto"  happy_var_1 happy_var_3
	)}}

happyReduce_16 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_16 = happySpecReduce_3  0# happyReduction_16
happyReduction_16 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { (HappyWrap4 happy_var_1) -> 
	case happyOut4 happy_x_3 of { (HappyWrap4 happy_var_3) -> 
	happyIn4
		 (BinOp "<=>"  happy_var_1 happy_var_3
	)}}

happyReduce_17 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_17 = happySpecReduce_3  0# happyReduction_17
happyReduction_17 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { (HappyWrap4 happy_var_1) -> 
	case happyOut4 happy_x_3 of { (HappyWrap4 happy_var_3) -> 
	happyIn4
		 (BinOp "=>"  happy_var_1 happy_var_3
	)}}

happyReduce_18 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_18 = happySpecReduce_3  0# happyReduction_18
happyReduction_18 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { (HappyWrap4 happy_var_1) -> 
	case happyOut4 happy_x_3 of { (HappyWrap4 happy_var_3) -> 
	happyIn4
		 (BinOp "<"   happy_var_1 happy_var_3
	)}}

happyReduce_19 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_19 = happySpecReduce_3  0# happyReduction_19
happyReduction_19 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { (HappyWrap4 happy_var_1) -> 
	case happyOut4 happy_x_3 of { (HappyWrap4 happy_var_3) -> 
	happyIn4
		 (BinOp "<<"  happy_var_1 happy_var_3
	)}}

happyReduce_20 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_20 = happySpecReduce_3  0# happyReduction_20
happyReduction_20 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { (HappyWrap4 happy_var_1) -> 
	case happyOut4 happy_x_3 of { (HappyWrap4 happy_var_3) -> 
	happyIn4
		 (BinOp "<="  happy_var_1 happy_var_3
	)}}

happyReduce_21 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_21 = happySpecReduce_3  0# happyReduction_21
happyReduction_21 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { (HappyWrap4 happy_var_1) -> 
	case happyOut4 happy_x_3 of { (HappyWrap4 happy_var_3) -> 
	happyIn4
		 (BinOp ">"   happy_var_1 happy_var_3
	)}}

happyReduce_22 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_22 = happySpecReduce_3  0# happyReduction_22
happyReduction_22 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { (HappyWrap4 happy_var_1) -> 
	case happyOut4 happy_x_3 of { (HappyWrap4 happy_var_3) -> 
	happyIn4
		 (BinOp ">>"  happy_var_1 happy_var_3
	)}}

happyReduce_23 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_23 = happySpecReduce_3  0# happyReduction_23
happyReduction_23 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { (HappyWrap4 happy_var_1) -> 
	case happyOut4 happy_x_3 of { (HappyWrap4 happy_var_3) -> 
	happyIn4
		 (BinOp ">="  happy_var_1 happy_var_3
	)}}

happyReduce_24 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_24 = happySpecReduce_3  0# happyReduction_24
happyReduction_24 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { (HappyWrap4 happy_var_1) -> 
	case happyOut4 happy_x_3 of { (HappyWrap4 happy_var_3) -> 
	happyIn4
		 (BinOp "="   happy_var_1 happy_var_3
	)}}

happyReduce_25 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_25 = happySpecReduce_3  0# happyReduction_25
happyReduction_25 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { (HappyWrap4 happy_var_1) -> 
	case happyOut4 happy_x_3 of { (HappyWrap4 happy_var_3) -> 
	happyIn4
		 (BinOp "~="  happy_var_1 happy_var_3
	)}}

happyReduce_26 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_26 = happySpecReduce_3  0# happyReduction_26
happyReduction_26 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { (HappyWrap4 happy_var_1) -> 
	case happyOut4 happy_x_3 of { (HappyWrap4 happy_var_3) -> 
	happyIn4
		 (BinOp "->"  happy_var_1 happy_var_3
	)}}

happyReduce_27 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_27 = happySpecReduce_3  0# happyReduction_27
happyReduction_27 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { (HappyWrap4 happy_var_1) -> 
	case happyOut4 happy_x_3 of { (HappyWrap4 happy_var_3) -> 
	happyIn4
		 (BinOp "-->" happy_var_1 happy_var_3
	)}}

happyReduce_28 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_28 = happySpecReduce_2  0# happyReduction_28
happyReduction_28 happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { (HappyWrap4 happy_var_1) -> 
	happyIn4
		 (UnOp "!"   happy_var_1
	)}

happyReduce_29 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_29 = happySpecReduce_2  0# happyReduction_29
happyReduction_29 happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_2 of { (HappyWrap4 happy_var_2) -> 
	happyIn4
		 (UnOp "not" happy_var_2
	)}

happyReduce_30 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_30 = happySpecReduce_2  0# happyReduction_30
happyReduction_30 happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_2 of { (HappyWrap4 happy_var_2) -> 
	happyIn4
		 (UnOp "+-"  happy_var_2
	)}

happyReduce_31 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_31 = happySpecReduce_2  0# happyReduction_31
happyReduction_31 happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_2 of { (HappyWrap4 happy_var_2) -> 
	happyIn4
		 (UnOp "-+"  happy_var_2
	)}

happyReduce_32 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_32 = happySpecReduce_3  0# happyReduction_32
happyReduction_32 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_2 of { (HappyWrap4 happy_var_2) -> 
	happyIn4
		 (Brace "(" ")" happy_var_2
	)}

happyReduce_33 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_33 = happySpecReduce_3  0# happyReduction_33
happyReduction_33 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_2 of { (HappyWrap4 happy_var_2) -> 
	happyIn4
		 (Brace "\\lbrace" "\\rbrace" happy_var_2
	)}

happyReduce_34 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_34 = happySpecReduce_3  0# happyReduction_34
happyReduction_34 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_2 of { (HappyWrap4 happy_var_2) -> 
	happyIn4
		 (Brace "[" "]" happy_var_2
	)}

happyReduce_35 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_35 = happyReduce 7# 0# happyReduction_35
happyReduction_35 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut4 happy_x_3 of { (HappyWrap4 happy_var_3) -> 
	case happyOut4 happy_x_5 of { (HappyWrap4 happy_var_5) -> 
	case happyOut4 happy_x_7 of { (HappyWrap4 happy_var_7) -> 
	happyIn4
		 (Limit happy_var_3 happy_var_5 happy_var_7
	) `HappyStk` happyRest}}}

happyReduce_36 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_36 = happyReduce 7# 0# happyReduction_36
happyReduction_36 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut4 happy_x_3 of { (HappyWrap4 happy_var_3) -> 
	case happyOut4 happy_x_5 of { (HappyWrap4 happy_var_5) -> 
	case happyOut4 happy_x_7 of { (HappyWrap4 happy_var_7) -> 
	happyIn4
		 (Super "\\int" happy_var_3 happy_var_5 happy_var_7
	) `HappyStk` happyRest}}}

happyReduce_37 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_37 = happyReduce 7# 0# happyReduction_37
happyReduction_37 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut4 happy_x_3 of { (HappyWrap4 happy_var_3) -> 
	case happyOut4 happy_x_5 of { (HappyWrap4 happy_var_5) -> 
	case happyOut4 happy_x_7 of { (HappyWrap4 happy_var_7) -> 
	happyIn4
		 (Super "\\sum" happy_var_3 happy_var_5 happy_var_7
	) `HappyStk` happyRest}}}

happyReduce_38 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_38 = happyReduce 7# 0# happyReduction_38
happyReduction_38 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut4 happy_x_3 of { (HappyWrap4 happy_var_3) -> 
	case happyOut4 happy_x_5 of { (HappyWrap4 happy_var_5) -> 
	case happyOut4 happy_x_7 of { (HappyWrap4 happy_var_7) -> 
	happyIn4
		 (Super "\\prod" happy_var_3 happy_var_5 happy_var_7
	) `HappyStk` happyRest}}}

happyReduce_39 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_39 = happySpecReduce_1  0# happyReduction_39
happyReduction_39 happy_x_1
	 =  case happyOutTok happy_x_1 of { (TFun happy_var_1) -> 
	happyIn4
		 (Fun happy_var_1
	)}

happyReduce_40 :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )
happyReduce_40 = happySpecReduce_1  0# happyReduction_40
happyReduction_40 happy_x_1
	 =  case happyOutTok happy_x_1 of { (TValue happy_var_1) -> 
	happyIn4
		 (Const happy_var_1
	)}

happyNewToken action sts stk
	= lexer(\tk -> 
	let cont i = happyDoAction i tk action sts stk in
	case tk of {
	TEOF -> happyDoAction 49# tk action sts stk;
	TValue happy_dollar_dollar -> cont 1#;
	TOB -> cont 2#;
	TCB -> cont 3#;
	TOP -> cont 4#;
	TCP -> cont 5#;
	TOS -> cont 6#;
	TCS -> cont 7#;
	TSemicolon -> cont 8#;
	TComma -> cont 9#;
	TMinus -> cont 10#;
	TTilda -> cont 11#;
	TExclamation -> cont 12#;
	TPlus -> cont 13#;
	TPlusMinus -> cont 14#;
	TMinusPlus -> cont 15#;
	TStar -> cont 16#;
	TSlash -> cont 17#;
	TAnd -> cont 18#;
	TOr -> cont 19#;
	TPower -> cont 20#;
	TUnderscore -> cont 21#;
	TLongEqual -> cont 22#;
	TNotEqual -> cont 23#;
	TPropto -> cont 24#;
	TIff -> cont 25#;
	TImplies -> cont 26#;
	TLower -> cont 27#;
	TLLower -> cont 28#;
	TLowerEq -> cont 29#;
	TGreater -> cont 30#;
	TGGreater -> cont 31#;
	TGreaterEq -> cont 32#;
	TEqual -> cont 33#;
	TTildaEqual -> cont 34#;
	TRightArrow -> cont 35#;
	TLongArrow -> cont 36#;
	TFun happy_dollar_dollar -> cont 37#;
	TIntegral -> cont 38#;
	TNot -> cont 39#;
	TFrom -> cont 40#;
	TTo -> cont 41#;
	TOf -> cont 42#;
	TSum -> cont 43#;
	TProduct -> cont 44#;
	TFor -> cont 45#;
	TLim -> cont 46#;
	TAs -> cont 47#;
	TIs -> cont 48#;
	_ -> happyError' (tk, [])
	})

happyError_ explist 49# tk = happyError' (tk, explist)
happyError_ explist _ tk = happyError' (tk, explist)

happyThen :: () => P a -> (a -> P b) -> P b
happyThen = (Prelude.>>=)
happyReturn :: () => a -> P a
happyReturn = (Prelude.return)
happyParse :: () => Happy_GHC_Exts.Int# -> P (HappyAbsSyn )

happyNewToken :: () => Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )

happyDoAction :: () => Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn )

happyReduceArr :: () => Happy_Data_Array.Array Prelude.Int (Happy_GHC_Exts.Int# -> Token -> Happy_GHC_Exts.Int# -> Happy_IntList -> HappyStk (HappyAbsSyn ) -> P (HappyAbsSyn ))

happyThen1 :: () => P a -> (a -> P b) -> P b
happyThen1 = happyThen
happyReturn1 :: () => a -> P a
happyReturn1 = happyReturn
happyError' :: () => ((Token), [Prelude.String]) -> P a
happyError' tk = (\(tokens, _) -> parseError tokens) tk
parse = happySomeParser where
 happySomeParser = happyThen (happyParse 0#) (\x -> happyReturn (let {(HappyWrap4 x') = happyOut4 x} in x'))

happySeq = happyDontSeq


parseError :: Token -> P a
parseError _ = throwError "Error while parsing."
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- $Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp $













-- Do not remove this comment. Required to fix CPP parsing when using GCC and a clang-compiled alex.
#if __GLASGOW_HASKELL__ > 706
#define LT(n,m) ((Happy_GHC_Exts.tagToEnum# (n Happy_GHC_Exts.<# m)) :: Prelude.Bool)
#define GTE(n,m) ((Happy_GHC_Exts.tagToEnum# (n Happy_GHC_Exts.>=# m)) :: Prelude.Bool)
#define EQ(n,m) ((Happy_GHC_Exts.tagToEnum# (n Happy_GHC_Exts.==# m)) :: Prelude.Bool)
#else
#define LT(n,m) (n Happy_GHC_Exts.<# m)
#define GTE(n,m) (n Happy_GHC_Exts.>=# m)
#define EQ(n,m) (n Happy_GHC_Exts.==# m)
#endif



















data Happy_IntList = HappyCons Happy_GHC_Exts.Int# Happy_IntList








































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is ERROR_TOK, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept 0# tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
        (happyTcHack j (happyTcHack st)) (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action



happyDoAction i tk st
        = {- nothing -}
          case action of
                0#           -> {- nothing -}
                                     happyFail (happyExpListPerState ((Happy_GHC_Exts.I# (st)) :: Prelude.Int)) i tk st
                -1#          -> {- nothing -}
                                     happyAccept i tk st
                n | LT(n,(0# :: Happy_GHC_Exts.Int#)) -> {- nothing -}
                                                   (happyReduceArr Happy_Data_Array.! rule) i tk st
                                                   where rule = (Happy_GHC_Exts.I# ((Happy_GHC_Exts.negateInt# ((n Happy_GHC_Exts.+# (1# :: Happy_GHC_Exts.Int#))))))
                n                 -> {- nothing -}
                                     happyShift new_state i tk st
                                     where new_state = (n Happy_GHC_Exts.-# (1# :: Happy_GHC_Exts.Int#))
   where off    = happyAdjustOffset (indexShortOffAddr happyActOffsets st)
         off_i  = (off Happy_GHC_Exts.+# i)
         check  = if GTE(off_i,(0# :: Happy_GHC_Exts.Int#))
                  then EQ(indexShortOffAddr happyCheck off_i, i)
                  else Prelude.False
         action
          | check     = indexShortOffAddr happyTable off_i
          | Prelude.otherwise = indexShortOffAddr happyDefActions st




indexShortOffAddr (HappyA# arr) off =
        Happy_GHC_Exts.narrow16Int# i
  where
        i = Happy_GHC_Exts.word2Int# (Happy_GHC_Exts.or# (Happy_GHC_Exts.uncheckedShiftL# high 8#) low)
        high = Happy_GHC_Exts.int2Word# (Happy_GHC_Exts.ord# (Happy_GHC_Exts.indexCharOffAddr# arr (off' Happy_GHC_Exts.+# 1#)))
        low  = Happy_GHC_Exts.int2Word# (Happy_GHC_Exts.ord# (Happy_GHC_Exts.indexCharOffAddr# arr off'))
        off' = off Happy_GHC_Exts.*# 2#




{-# INLINE happyLt #-}
happyLt x y = LT(x,y)


readArrayBit arr bit =
    Bits.testBit (Happy_GHC_Exts.I# (indexShortOffAddr arr ((unbox_int bit) `Happy_GHC_Exts.iShiftRA#` 4#))) (bit `Prelude.mod` 16)
  where unbox_int (Happy_GHC_Exts.I# x) = x






data HappyAddr = HappyA# Happy_GHC_Exts.Addr#


-----------------------------------------------------------------------------
-- HappyState data type (not arrays)













-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state 0# tk st sts stk@(x `HappyStk` _) =
     let i = (case Happy_GHC_Exts.unsafeCoerce# x of { (Happy_GHC_Exts.I# (i)) -> i }) in
--     trace "shifting the error token" $
     happyDoAction i tk new_state (HappyCons (st) (sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state (HappyCons (st) (sts)) ((happyInTok (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn 0# tk st sts stk
     = happyFail [] 0# tk st sts stk
happySpecReduce_0 nt fn j tk st@((action)) sts stk
     = happyGoto nt j tk st (HappyCons (st) (sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn 0# tk st sts stk
     = happyFail [] 0# tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@((HappyCons (st@(action)) (_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn 0# tk st sts stk
     = happyFail [] 0# tk st sts stk
happySpecReduce_2 nt fn j tk _ (HappyCons (_) (sts@((HappyCons (st@(action)) (_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn 0# tk st sts stk
     = happyFail [] 0# tk st sts stk
happySpecReduce_3 nt fn j tk _ (HappyCons (_) ((HappyCons (_) (sts@((HappyCons (st@(action)) (_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn 0# tk st sts stk
     = happyFail [] 0# tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k Happy_GHC_Exts.-# (1# :: Happy_GHC_Exts.Int#)) sts of
         sts1@((HappyCons (st1@(action)) (_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (happyGoto nt j tk st1 sts1 r)

happyMonadReduce k nt fn 0# tk st sts stk
     = happyFail [] 0# tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k (HappyCons (st) (sts)) of
        sts1@((HappyCons (st1@(action)) (_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> happyGoto nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn 0# tk st sts stk
     = happyFail [] 0# tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k (HappyCons (st) (sts)) of
        sts1@((HappyCons (st1@(action)) (_))) ->
         let drop_stk = happyDropStk k stk

             off = happyAdjustOffset (indexShortOffAddr happyGotoOffsets st1)
             off_i = (off Happy_GHC_Exts.+# nt)
             new_state = indexShortOffAddr happyTable off_i




          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop 0# l = l
happyDrop n (HappyCons (_) (t)) = happyDrop (n Happy_GHC_Exts.-# (1# :: Happy_GHC_Exts.Int#)) t

happyDropStk 0# l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n Happy_GHC_Exts.-# (1#::Happy_GHC_Exts.Int#)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction


happyGoto nt j tk st = 
   {- nothing -}
   happyDoAction j tk new_state
   where off = happyAdjustOffset (indexShortOffAddr happyGotoOffsets st)
         off_i = (off Happy_GHC_Exts.+# nt)
         new_state = indexShortOffAddr happyTable off_i




-----------------------------------------------------------------------------
-- Error recovery (ERROR_TOK is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist 0# tk old_st _ stk@(x `HappyStk` _) =
     let i = (case Happy_GHC_Exts.unsafeCoerce# x of { (Happy_GHC_Exts.I# (i)) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  ERROR_TOK tk old_st CONS(HAPPYSTATE(action),sts) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        DO_ACTION(action,ERROR_TOK,tk,sts,(saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (action) sts stk =
--      trace "entering error recovery" $
        happyDoAction 0# tk action sts ((Happy_GHC_Exts.unsafeCoerce# (Happy_GHC_Exts.I# (i))) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = Prelude.error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions


happyTcHack :: Happy_GHC_Exts.Int# -> a -> a
happyTcHack x y = y
{-# INLINE happyTcHack #-}


-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `Prelude.seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.


{-# NOINLINE happyDoAction #-}
{-# NOINLINE happyTable #-}
{-# NOINLINE happyCheck #-}
{-# NOINLINE happyActOffsets #-}
{-# NOINLINE happyGotoOffsets #-}
{-# NOINLINE happyDefActions #-}

{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
