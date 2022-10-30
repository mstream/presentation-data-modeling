module Main.Survey.PromptAndResponsePairs (main) where

import Prelude

import Data.Argonaut.Core (stringifyWithIndent)
import Data.Argonaut.Encode (encodeJson)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Class.Console (info)
import Survey.PromptAndResponsePairs (Survey)

main ∷ Effect Unit
main = info $ stringifyWithIndent 2 $ encodeJson survey

survey ∷ Survey
survey =
  [ { prompt: "prompt1", response: Just "response1" }
  , { prompt: "prompt2", response: Nothing }
  , { prompt: "prompt3", response: Nothing }
  ]

