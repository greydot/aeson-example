{-# LANGUAGE ScopedTypeVariables #-}
module Main where

import Control.DeepSeq (force)
import Control.Exception (evaluate)
import Data.Aeson
import Data.Map (Map)
import Data.Text (Text)
import System.Environment (getArgs)
import System.Mem (performGC)

type TextMap = Map Text [Text]

main :: IO ()
main = do [p] <- getArgs
          putStrLn "Reading file."
          Just m :: Maybe TextMap <- decodeFileStrict p
          putStrLn "Evaluating data."
          evaluate (force m)
          putStrLn "Performing GC."
          performGC
          putStrLn "Done."
