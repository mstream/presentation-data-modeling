module Survey.PreviousAndNextQuestions (Question, Survey) where

import Data.Maybe (Maybe)

type Survey =
  { currentQuestion ∷ Question
  , nextQuestions ∷ Array Question
  , previousQuestions ∷ Array Question
  }

type Question =
  { prompt ∷ String
  , response ∷ Maybe String
  }

