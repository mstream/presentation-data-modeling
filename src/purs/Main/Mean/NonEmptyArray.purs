module Main.Mean.NonEmptyArray (main) where

import Prelude

import Effect (Effect)
import Effect.Class.Console (info)
import Mean.NonEmptyArray (mean)

main ∷ Effect Unit
main = info $ show result

result ∷ Number
result = mean { first: 1.0, others: [ 2.0, 3.0 ] }

{- 
result = mean $ 1.0 :| [ 2.0, 3.0 ]
-}

