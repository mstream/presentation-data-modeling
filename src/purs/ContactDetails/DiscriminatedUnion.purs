module ContactDetails.DiscriminatedUnion
  ( Contact
  , Email
  , EmailAddress
  , Name
  , String1
  , String50
  ) where

import Prelude

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

data Email
  = Confirmed ConfirmEmailAddress
  | Unconfirmed UnconfirmedEmailAddress

newtype ConfirmedEmailAddress = ConfirmedEmailAddress EmailAddress
newtype UnconfirmedEmailAddress = UnconfirmedEmailAddress EmailAddress

type ValidateEmailAddress =
  String → EmailAddressViolation \/ UnconfirmedEmailAddress

type ConfirmEmailAddress =
  UnconfirmedEmailAddress
  → ConfirmationCode
  → ConfirmationError \/ ConfirmedEmailAddress

type ResetPassword = ConfirmedEmailAddress → Unit

newtype String1 = String1 String
newtype String50 = String50 String
newtype EmailAddress = EmailAddress String
newtype ConfirmationCode = ConfirmationCode String

newtype EmailAddressViolation = EmailAddressViolation String
newtype ConfirmationError = ConfirmationError String
