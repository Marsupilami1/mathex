module Main where

import Parser
import Expression
import PMonad

import System.IO
import Control.Monad (forM_)

main :: IO ()
-- main = runTest
-- main = do
--   s <- getLine
--   case runP parse s of
--     Right t -> print t
--     Left err -> print err
main = do
  contents <- getLine
  let result = do
        exp' <- parse
        texify exp'
  case runP result contents of
    Right t -> putStr t
    Left err -> do
      hPutStrLn stderr err

runTest :: IO ()
runTest = do
  h <- openFile "test/test.txt" ReadMode
  contents <- hGetContents h
  forM_ (lines contents) $ \s -> do
    let result = do
          exp' <- parse
          texify exp'
    case runP result s of
      Right t -> putStrLn t
      Left err -> do
        hPutStrLn stderr err
        hPutStrLn stderr $ s ++ "\n"
