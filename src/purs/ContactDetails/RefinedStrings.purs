module ContactDetails.RefinedStrings
  ( Contact
  , Email
  , EmailAddress
  , Name
  , String1
  , String50
  ) where

import Data.Either.Nested (type (\/))
import Data.Maybe (Maybe)

type Contact =
  { name ∷ Name
  , email ∷ Email
  }

type Name =
  { firstName ∷ String50
  , lastName ∷ String50
  , middleNameInitial ∷ Maybe String1
  }

type Email =
  { address ∷ EmailAddress
  , isConfirmed ∷ Boolean
  }

newtype String1 = String1 String
newtype String50 = String50 String
newtype EmailAddress = EmailAddress String

type ValidateEmailAddress =
  String → EmailAddressViolation \/ EmailAddress

newtype EmailAddressViolation = EmailAddressViolation String
