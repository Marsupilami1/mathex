{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_mathex (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/martin/.cabal/bin"
libdir     = "/home/martin/.cabal/lib/x86_64-linux-ghc-8.10.5/mathex-0.1.0.0-inplace-mathex"
dynlibdir  = "/home/martin/.cabal/lib/x86_64-linux-ghc-8.10.5"
datadir    = "/home/martin/.cabal/share/x86_64-linux-ghc-8.10.5/mathex-0.1.0.0"
libexecdir = "/home/martin/.cabal/libexec/x86_64-linux-ghc-8.10.5/mathex-0.1.0.0"
sysconfdir = "/home/martin/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "mathex_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "mathex_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "mathex_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "mathex_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "mathex_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "mathex_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
