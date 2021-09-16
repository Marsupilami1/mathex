module Main where

import Expression
import Parser
import PMonad

import Control.Monad (forM_)
import System.IO
import System.Environment (getArgs)
import System.Exit (exitWith, ExitCode(..))


main :: IO ()
main = do
  args <- getArgs
  forM_ args $ \arg ->
    case arg of
      "-t" -> runTest
      _    -> failWith "Unknown command line argument."

  convertStdIn


convertStdIn :: IO ()
convertStdIn = do
  contents <- getLine
  let result = parse >>= texify
  case runP result contents of
    Right formula -> putStr formula
    Left err -> failWith err

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
  exitWith ExitSuccess

failWith :: String -> IO ()
failWith err = do
  hPutStrLn stderr err
  exitWith $ ExitFailure 1
