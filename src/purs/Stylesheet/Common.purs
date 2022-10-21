module Stylesheet.Common
  ( Color
  , Prefix
  , Property
  , Selector
  , Url
  , color
  , purple
  , renderColor
  , renderPrefix
  , renderProperty
  , renderUrl
  , rgb
  , stroke
  , url
  ) where

import Prelude

import Data.Array (uncons)
import Data.Maybe (Maybe(..))

newtype Url = Url String

derive newtype instance Eq Url
derive newtype instance Ord Url

type Prefix = Array String
type Selector = String

data Property
  = Color Color
  | Stroke Color

derive instance Eq Property
derive instance Ord Property

data Color = Rgb Int Int Int | ColorName String

derive instance Eq Color
derive instance Ord Color

url ∷ String → Url
url = Url

rgb ∷ Int → Int → Int → Color
rgb r g b = Rgb r g b

purple ∷ Color
purple = ColorName "purple"

color ∷ Color → Property
color = Color

stroke ∷ Color → Property
stroke = Stroke

renderPrefix ∷ Prefix → String
renderPrefix = uncons >>> case _ of
  Nothing →
    ""

  Just { head } →
    head

renderUrl ∷ Url → String
renderUrl (Url s) = "url(\"" <> s <> "\")"

renderProperty ∷ Property → String
renderProperty = case _ of
  Color c →
    "color: " <> renderColor c

  Stroke c →
    "stoke: " <> renderColor c

renderColor ∷ Color → String
renderColor = case _ of
  Rgb r g b →
    "rgb(" <> show r <> "," <> show g <> "," <> show b <> ")"

  ColorName s →
    s
