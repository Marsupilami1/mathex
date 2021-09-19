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
convertStdIn = getLine >>= convertString

runTest :: IO ()
runTest = do
  h <- openFile "test/test.txt" ReadMode
  contents <- hGetContents h
  forM_ (lines contents) $ \s ->
    convertString s >> putStrLn ""
  hClose h
  exitWith ExitSuccess

convertString :: String -> IO ()
convertString s =
    case runP (parse >>= texify) s of
      Right t -> putStr t
      Left err -> failWith $ err ++ "\n"

failWith :: String -> IO ()
failWith err = do
  hPutStrLn stderr err
  exitWith $ ExitFailure 1
