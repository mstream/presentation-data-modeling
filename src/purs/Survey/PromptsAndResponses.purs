module Survey.PromptsAndResponses (Survey) where

import Data.Maybe (Maybe)

type Survey =
  { prompts ∷ Array String
  , responses ∷ Array (Maybe String)
  }

