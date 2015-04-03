module ZipRange where

data ZipRange = ZipRange
    {
        start :: String,
        stop  :: String,
        state :: String
    }

instance Show ZipRange where
    show (ZipRange start stop state) = state ++ " => " ++ start ++ ".." ++ stop

