module Survey.CurrentQuestion (Question, Survey) where

import Data.Maybe (Maybe)

type Survey =
  { currentQuestion ∷ Question
  , questions ∷ Array Question
  }

type Question =
  { prompt ∷ String
  , response ∷ Maybe String
  }

