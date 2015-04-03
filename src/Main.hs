{-# LANGUAGE OverloadedStrings #-}

import Control.Applicative
import qualified Data.ByteString.Lazy as BL
import Data.Csv
import qualified Data.Vector as V
import Data.Foldable

import System.Environment
import System.IO

import qualified ZipCode as ZC
import qualified ZipRange as ZR

instance FromNamedRecord ZC.ZipCode where
    parseNamedRecord r = ZC.ZipCode <$> r .: "code" <*> r .: "state"

processCodes :: V.Vector(ZC.ZipCode) -> [ZR.ZipRange]
processCodes = ZR.buildRange . V.toList

readZipCodes :: String -> IO ()
readZipCodes fileName = do
    csvData <- BL.readFile fileName
    case decodeByName csvData of
        Left err -> putStrLn err
        Right (_, v) -> forM_ (processCodes v) $ \ p ->
            putStrLn $ show p

main :: IO ()
main = do
    args <- getArgs
    case args of
        (fileName:_) -> readZipCodes fileName
        _            -> putStrLn "You need to supply a filename"



