{-# LANGUAGE OverloadedStrings #-}

import Control.Applicative
import qualified Data.ByteString.Lazy as BL
import Data.Csv
import qualified Data.Vector as V
import Data.List
import Data.Foldable

import qualified ZipCode as ZC
import qualified ZipRange as ZR

instance FromNamedRecord ZC.ZipCode where
    parseNamedRecord r = ZC.ZipCode <$> r .: "code" <*> r .: "state"

processCodes = ZR.buildRange . V.toList

main :: IO ()
main = do
    csvData <- BL.readFile "../zipcode.csv"
    case decodeByName csvData of
        Left err -> putStrLn err
        Right (_, v) -> forM_ (processCodes v) $ \ p ->
            putStrLn $ show p