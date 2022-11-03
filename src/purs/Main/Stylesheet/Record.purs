module Main.Stylesheet.Record (main) where

import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Class.Console (info)
import Stylesheet.Common (purple, stroke, url)
import Stylesheet.Record (Stylesheet, import_, namespace, render, style)

main ∷ Effect Unit
main = info $ render stylesheet

stylesheet ∷ Stylesheet
stylesheet =
  { charset: Just "UTF-8"
  , imports:
      [ import_ (url "bigscreen.css")
          [ "projection", "tv" ]
      ]
  , namespaces:
      [ namespace [ "svg" ]
          (url "http://www.w3.org/2000/svg")
      ]
  , styles:
      [ style [ "svg" ] "a"
          [ stroke purple ]
      ]
  }
