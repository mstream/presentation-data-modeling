module Survey.QuestionIndex (Question, Survey) where

import Data.Maybe (Maybe)

type Survey =
  { currentQuestionIndex ∷ Int
  , questions ∷ Array Question
  }

type Question =
  { prompt ∷ String
  , response ∷ Maybe String
  }

