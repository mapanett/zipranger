{-# LANGUAGE OverloadedStrings #-}

import Control.Applicative
import qualified Data.ByteString.Lazy as BL
import Data.Csv
import qualified Data.Vector as V

data ZipCode = ZipCode
    { code   :: !String
    , state  :: !String
    }

instance FromNamedRecord ZipCode where
    parseNamedRecord r = ZipCode <$> r .: "code" <*> r .: "state"

main :: IO ()
main = do
    csvData <- BL.readFile "zipcode.csv"
    case decodeByName csvData of
        Left err -> putStrLn err
        Right (_, v) -> V.forM_ v $ \ p ->
            putStrLn $ code p ++ " => " ++ state p