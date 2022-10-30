module ContactDetails.WeakModel (Contact) where

type Contact =
  { firstName ∷ String
  , lastName ∷ String
  , middleNameInitial ∷ String
  , email ∷ String
  , isEmailConfirmed ∷ Boolean
  }
