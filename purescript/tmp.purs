module Main where

import Prelude

import Data.Array ((..))
import Data.String (joinWith)
import Effect (Effect)

import Effect.Console (log)

fizzbuzz :: Int -> String
fizzbuzz n
    | n `mod` 15 == 0 = "FizzBuzz"
    | n `mod` 5 == 0 = "Buzz"
    | n `mod` 3 == 0 = "Fizz"
    | otherwise = show n

runner :: Int -> Array String
runner n = map fizzbuzz $ 1 .. n

main :: Effect Unit
main = do
  log $ joinWith "\n" $ map fizzbuzz $ 1 .. 20
