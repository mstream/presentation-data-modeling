module CardGame
  ( Card
  , Deck
  , Deal
  , Hand
  , Rank
  , ShuffledDeck
  , Suit
  , deal
  , pickUpCard
  , shuffle
  ) where

import Prelude

import Data.List (List, (:))
import Data.List.NonEmpty (NonEmptyList, fromList, head, tail)
import Data.Maybe (Maybe)
import Data.Tuple.Nested (type (/\), (/\))

type Card = Suit /\ Rank

data Suit = Club | Diamond | Heart | Spade

data Rank = Two | Three | Four | Five | Six | Seven | Eight | Nine | Ten | Jack | Queen | King | Ace

newtype Deck = Deck (NonEmptyList Card)

newtype ShuffledDeck = ShuffledDeck (NonEmptyList Card)

type Shuffle = Deck → ShuffledDeck

type Deal = ShuffledDeck → Card /\ Maybe ShuffledDeck

newtype Hand = Hand (List Card)

type PickUpCard = Hand → Card → Hand

type Player = Hand

type Game = { deck ∷ Maybe ShuffledDeck, players ∷ NonEmptyList Player }

deal ∷ Deal
deal (ShuffledDeck cards) =
  let
    topCard = head cards
    remainingCards = fromList $ tail cards
  in
    topCard /\ (ShuffledDeck <$> remainingCards)

pickUpCard ∷ PickUpCard
pickUpCard (Hand cards) card = Hand $ card : cards

shuffle ∷ Shuffle
shuffle (Deck cards) = ShuffledDeck $ fakeShuffle cards
  where
  fakeShuffle = identity
