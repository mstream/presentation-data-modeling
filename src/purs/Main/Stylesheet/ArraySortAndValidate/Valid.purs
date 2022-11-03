module Main.Stylesheet.ArraySortAndValidate.Valid (main) where

import Prelude

import Data.Either (either)
import Data.Either.Nested (type (\/))
import Effect (Effect)
import Effect.Class.Console (info)
import Stylesheet.Array
  ( Stylesheet
  , ValidationError
  , charset
  , import_
  , namespace
  , render
  , sortAndValidate
  , style
  )
import Stylesheet.Common (color, purple, rgb, stroke, url)

main ∷ Effect Unit
main = either (const $ pure unit) (info <<< render) stylesheet

stylesheet ∷ ValidationError \/ Stylesheet
stylesheet = sortAndValidate
  [ style [ "svg" ] "a"
      [ stroke purple ]
  , namespace [ "svg" ]
      (url "http://www.w3.org/2000/svg")
  , import_ (url "bigscreen.css")
      [ "projection", "tv" ]
  , charset "UTF-8"
  ]

