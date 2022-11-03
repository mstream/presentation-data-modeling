module Main.Stylesheet.Array.Valid (main) where

import Prelude

import Effect (Effect)
import Effect.Class.Console (info)
import Stylesheet.Array
  ( Stylesheet
  , charset
  , import_
  , namespace
  , render
  , style
  )
import Stylesheet.Common (purple, stroke, url)

main ∷ Effect Unit
main = info $ render stylesheet

stylesheet ∷ Stylesheet
stylesheet =
  [ charset "UTF-8"
  , import_ (url "bigscreen.css")
      [ "projection", "tv" ]
  , namespace [ "svg" ]
      (url "http://www.w3.org/2000/svg")
  , style [ "svg" ] "a"
      [ stroke purple ]
  ]
