module ZipRange where

import Data.List
import qualified ZipCode as ZC

data ZipRange = ZipRange
    {
        start :: String,
        stop  :: String,
        state :: String
    } deriving Eq

instance Show ZipRange where
    show (ZipRange start stop state) = state ++ " => " ++ start ++ ".." ++ stop

instance Ord ZipRange where
    compare a b = compare (state a) (state b)

addToRanges :: [ZipRange] -> ZC.ZipCode -> [ZipRange]
addToRanges [] (ZC.ZipCode code state) = (ZipRange code code state) : []
addToRanges ranges@((ZipRange startCode endCode rangeState) : rest) (ZC.ZipCode newCode newState)
    | rangeState == newState = (ZipRange startCode newCode rangeState) : rest
    | otherwise              = (ZipRange newCode newCode newState) : ranges

buildRange :: [ZC.ZipCode] -> [ZipRange]
buildRange = sort . (foldl addToRanges []) . sort
