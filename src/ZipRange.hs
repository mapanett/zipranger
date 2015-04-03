module ZipRange where

import Data.List
import qualified ZipCode as ZC

data ZipRange = ZipRange
    {
        start :: String,
        stop  :: String,
        state :: String
    }

instance Show ZipRange where
    show (ZipRange start stop state) = state ++ " => " ++ start ++ ".." ++ stop

addToRanges :: [ZipRange] -> ZC.ZipCode -> [ZipRange]
addToRanges [] (ZC.ZipCode code state) =  (ZipRange code code state) : []
addToRanges ranges@((ZipRange startCode endCode rangeState) : rest) (ZC.ZipCode newCode codeState)
    | rangeState == codeState = (ZipRange startCode newCode rangeState) : rest
    | otherwise               = (ZipRange newCode newCode codeState) : ranges

buildRange :: [ZC.ZipCode] -> [ZipRange]
buildRange = (foldl addToRanges []) . sort
