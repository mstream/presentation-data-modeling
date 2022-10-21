module Mean.Array (mean) where

import Prelude

import Data.Array (foldl, length)
import Data.Int (toNumber)

mean ∷ Array Number → Number
mean xs = sum / n
  where
  sum = foldl (+) zero xs
  n = toNumber $ length xs
