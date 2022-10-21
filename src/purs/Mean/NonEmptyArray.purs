module Mean.NonEmptyArray (mean) where

import Prelude

import Data.Array (foldl, length)
import Data.Int (toNumber)

type NonEmptyArray a =
  { first ∷ a
  , others ∷ Array a
  }

mean ∷ NonEmptyArray Number → Number
mean { first, others } = sum / n
  where
  sum = foldl (+) first others
  n = toNumber $ length others + 1
