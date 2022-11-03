module Main.Stylesheet.Array.Invalid (main) where

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
  [ style [ "svg" ] "a"
      [ stroke purple ]
  , import_ (url "dotmatrix.css")
      [ "print" ]
  , namespace [ "svg" ]
      (url "http://www.w3.org/2000/svg")
  , charset "UTF-8"
  , charset "UTF-9000"
  ]
