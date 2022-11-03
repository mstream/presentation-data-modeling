module Survey.PromptAndResponsePairs (Question, Survey) where

import Data.Maybe (Maybe)

type Survey = Array Question

type Question =
  { prompt ∷ String
  , response ∷ Maybe String
  }

