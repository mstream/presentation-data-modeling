module Main.Survey.PromptsAndResponses.Invalid (main) where

import Prelude

import Data.Argonaut.Core (stringifyWithIndent)
import Data.Argonaut.Encode (encodeJson)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Class.Console (info)
import Survey.PromptsAndResponses (Survey)

main ∷ Effect Unit
main = info $ stringifyWithIndent 2 $ encodeJson survey

survey ∷ Survey
survey =
  { prompts: []
  , responses: [ Just "response" ]
  }

