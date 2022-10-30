module Main.Survey.QuestionIndex.Invalid (main) where

import Prelude

import Data.Argonaut.Core (stringifyWithIndent)
import Data.Argonaut.Encode (encodeJson)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Class.Console (info)
import Survey.QuestionIndex (Question, Survey)

main ∷ Effect Unit
main = info $ stringifyWithIndent 2 $ encodeJson survey

survey ∷ Survey
survey =
  { currentQuestionIndex: 4
  , questions:
      [ question1
      , question2
      , question3
      ]
  }

question1 ∷ Question
question1 = { prompt: "prompt1", response: Just "response1" }

question2 ∷ Question
question2 = { prompt: "prompt2", response: Just "response2" }

question3 ∷ Question
question3 = { prompt: "prompt3", response: Just "response3" }

