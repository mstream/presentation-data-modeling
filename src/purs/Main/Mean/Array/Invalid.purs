module Main.Mean.Array.Invalid (main) where

import Prelude

import Effect (Effect)
import Effect.Class.Console (info)
import Mean.Array (mean)

main ∷ Effect Unit
main = info $ show result

result ∷ Number
result = mean []

