module Paths_blog (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch


version :: Version
version = Version {versionBranch = [0,1,0,0], versionTags = []}
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/zhengshuai/dev-dir/hakyll-sandbox/bin"
libdir     = "/Users/zhengshuai/dev-dir/hakyll-sandbox/lib/x86_64-osx-ghc-7.8.3/blog-0.1.0.0"
datadir    = "/Users/zhengshuai/dev-dir/hakyll-sandbox/share/x86_64-osx-ghc-7.8.3/blog-0.1.0.0"
libexecdir = "/Users/zhengshuai/dev-dir/hakyll-sandbox/libexec"
sysconfdir = "/Users/zhengshuai/dev-dir/hakyll-sandbox/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "blog_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "blog_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "blog_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "blog_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "blog_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
