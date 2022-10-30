module ContactDetails.ConsistencyBoundaries
  ( Contact
  , Email
  , Name
  ) where

type Contact =
  { name ∷ Name
  , email ∷ Email
  }

type UpdateName = Contact → Name → Contact

type UpdateEmail = Contact → Email → Contact

type Name =
  { firstName ∷ String
  , lastName ∷ String
  , middleNameInitial ∷ String
  }

type Email =
  { address ∷ String
  , isConfirmed ∷ Boolean
  }

