module Stylesheet.Array
  ( Declaration
  , Stylesheet
  , ValidationError
  , charset
  , import_
  , namespace
  , render
  , sortAndValidate
  , style
  ) where

import Prelude

import Data.Array (filter, length, null, sort)
import Data.Either (Either(..))
import Data.Either.Nested (type (\/))
import Data.String (joinWith)
import Stylesheet.Common
  ( Prefix
  , Property
  , Selector
  , Url
  , renderPrefix
  , renderProperty
  , renderUrl
  )

type Stylesheet = Array Declaration

data ValidationError = MultipleCharsetElements

sortAndValidate ∷ Stylesheet → ValidationError \/ Stylesheet
sortAndValidate stylesheet =
  if hasMultiples then Left MultipleCharsetElements
  else Right $ sort stylesheet
  where
  hasMultiples =
    length
      ( filter
          ( case _ of
              Charset _ → true
              _ → false
          )
          stylesheet
      ) > 1

data Declaration
  = Charset String
  | Import Url (Array String)
  | Namespace (Array String) Url
  | Style Prefix Selector (Array Property)

derive instance Eq Declaration
derive instance Ord Declaration

charset ∷ String → Declaration
charset = Charset

import_ ∷ Url → Array String → Declaration
import_ url mediaQueries = Import url mediaQueries

namespace ∷ Prefix → Url → Declaration
namespace prefix url = Namespace prefix url

style ∷ Prefix → Selector → Array Property → Declaration
style prefix selector properties = Style prefix selector properties

render ∷ Stylesheet → String
render = joinWith "\n" <<< map renderDeclaration

renderDeclaration ∷ Declaration → String
renderDeclaration = case _ of
  Charset s →
    "@charset " <> s <> ";"

  Import url mediaQueries →
    "@import "
      <> renderUrl url
      <> " "
      <> joinWith ", " mediaQueries
      <> ";"

  Namespace prefix url →
    "@namespace "
      <> renderPrefix prefix
      <> (if null prefix then "" else "|")
      <> renderUrl url
      <> ";"

  Style prefix selector properties →
    renderPrefix prefix
      <> (if null prefix then "" else "|")
      <> selector
      <> " {\n  "
      <> (joinWith "\n  " $ renderProperty <$> properties)
      <> "\n}"

