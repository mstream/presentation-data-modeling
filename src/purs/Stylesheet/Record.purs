module Stylesheet.Record
  ( Import
  , Namespace
  , Style
  , Stylesheet
  , import_
  , namespace
  , render
  , style
  ) where

import Prelude

import Data.Array (null)
import Data.Maybe (Maybe(..))
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

type Stylesheet =
  { charset ∷ Maybe String
  , imports ∷ Array Import
  , namespaces ∷ Array Namespace
  , styles ∷ Array Style
  }

data Import = Import Url (Array String)

import_ ∷ Url → Array String → Import
import_ url mediaQueries = Import url mediaQueries

data Namespace = Namespace (Array String) Url

namespace ∷ Prefix → Url → Namespace
namespace prefix url = Namespace prefix url

data Style = Style Prefix Selector (Array Property)

style ∷ Prefix → Selector → Array Property → Style
style prefix selector properties = Style prefix selector properties

render ∷ Stylesheet → String
render { charset, imports, namespaces, styles } =
  charsetLine <> otherLines
  where
  charsetLine = case charset of
    Just s →
      "@charset " <> s <> ";\n"

    Nothing →
      ""

  otherLines = joinWith "\n"
    $ (renderImport <$> imports)
        <> (renderNamespace <$> namespaces)
        <> (renderStyle <$> styles)

renderImport ∷ Import → String
renderImport (Import url mediaQueries) =
  "@import "
    <> renderUrl url
    <> " "
    <> joinWith ", " mediaQueries
    <> ";"

renderNamespace ∷ Namespace → String
renderNamespace (Namespace prefix url) =
  "@namespace "
    <> renderPrefix prefix
    <> (if null prefix then "" else "|")
    <> renderUrl url
    <> ";"

renderStyle ∷ Style → String
renderStyle (Style prefix selector properties) =
  renderPrefix prefix
    <> (if null prefix then "" else "|")
    <> selector
    <> " {\n  "
    <> (joinWith "\n  " $ renderProperty <$> properties)
    <> "\n}"

