module ContactDetails.OptionalValues
  ( Contact
  , Email
  , Name
  ) where

import Data.Maybe (Maybe)

type Contact =
  { name ∷ Name
  , email ∷ Email
  }

type Name =
  { firstName ∷ String
  , lastName ∷ String
  , middleNameInitial ∷ Maybe String
  }

type Email =
  { address ∷ String
  , isConfirmed ∷ Boolean
  }

