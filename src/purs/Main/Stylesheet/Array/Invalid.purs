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
import Stylesheet.Common (color, purple, rgb, stroke, url)

main ∷ Effect Unit
main = info $ render stylesheet

stylesheet ∷ Stylesheet
stylesheet =
  [ style [] "body"
      [ color (rgb 11 22 33) ]
  , style [ "svg" ] "a"
      [ stroke purple ]
  , namespace []
      (url "http://www.w3.org/1999/xhtml")
  , import_ (url "dotmatrix.css")
      [ "print" ]
  , namespace [ "svg" ]
      (url "http://www.w3.org/2000/svg")
  , import_ (url "bigscreen.css")
      [ "projection", "tv" ]
  , charset "UTF-8"
  , charset "UTF-9000"
  ]
