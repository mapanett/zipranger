module ZipCode where

data ZipCode = ZipCode
    { code   :: !Int
    , state  :: !String
    } deriving (Show, Eq)

instance Ord ZipCode where
    compare (ZipCode a _) (ZipCode b _) = compare a b
