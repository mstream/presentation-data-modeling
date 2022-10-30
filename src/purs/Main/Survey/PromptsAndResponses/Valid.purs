module Main.Survey.PromptsAndResponses.Valid (main) where

import Prelude

import Data.Argonaut.Core (stringify, stringifyWithIndent)
import Data.Argonaut.Encode (encodeJson)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Class.Console (info)
import Survey.PromptsAndResponses (Survey)

main ∷ Effect Unit
main = info $ stringifyWithIndent 2 $ encodeJson survey

survey ∷ Survey
survey =
  { prompts:
      [ "prompt1"
      , "prompt2"
      , "prompt3"
      ]
  , responses:
      [ Just "response1"
      , Nothing
      , Nothing
      ]
  }

