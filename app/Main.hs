module Main where

import System.Exit(die)
import System.Environment(getArgs, getProgName)
import qualified Data.Map.Strict as Map

import BCsequential
import BCparallel

main :: IO ()
main = do args <- getArgs
          case args of
            [version,filename] -> do
              contents <- readFile filename
              let inputMap = Map.fromList rawList
                  rawList = map transfromSingleLine rawLines
                  rawLines = lines contents -- [String] -> [(int,[int])] 
              case version of
                   "sequential" -> do print version
                                      print $ length $ bcSolver inputMap
                   "parallel" -> do print version
                                    print $ length $ bcSolverPar inputMap
                   _ -> die $ "Usage: Choose correct version (sequential / parallel)"
            _ -> do pn <- getProgName
                    die $ "Usage: "++pn++"<version> <filename>"


transfromSingleLine :: String -> (Int,[Int])
transfromSingleLine str = (read node, map read neighbors)
    where
      (node:neighbors) = words str