module Main.Stylesheet.Record (main) where

import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Class.Console (info)
import Stylesheet.Common (color, purple, rgb, stroke, url)
import Stylesheet.Record (Stylesheet, import_, namespace, render, style)

main ∷ Effect Unit
main = info $ render stylesheet

stylesheet ∷ Stylesheet
stylesheet =
  { charset: Just "UTF-8"
  , imports:
      [ import_ (url "dotmatrix.css")
          [ "print" ]
      , import_ (url "bigscreen.css")
          [ "projection", "tv" ]
      ]
  , namespaces:
      [ namespace []
          (url "http://www.w3.org/1999/xhtml")
      , namespace [ "svg" ]
          (url "http://www.w3.org/2000/svg")
      ]
  , styles:
      [ style [] "body"
          [ color (rgb 11 22 33) ]
      , style [ "svg" ] "a"
          [ stroke purple ]
      ]
  }
