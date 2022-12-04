import System.IO
import Data.List
import qualified Data.ByteString as BS
import qualified Data.ByteString.Char8 as BSC

main :: IO ()
main = do
    contents <- readFile "input"
    (print . solve) contents
    (print . solve') contents

-- A X - Rock
-- B Y - Paper
-- C Z - Scissor

data Hand = Rock | Paper | Scissor
    deriving (Eq, Ord)

data Outcome = Win | Lose | Draw
    deriving (Eq)

-- Rock < Paper
-- Paper < Scissor
-- but Rock < Scissor, should be other way around

-- parsing
toHand :: Char -> Hand
toHand h
    | h == 'A' || h == 'X' = Rock
    | h == 'B' || h == 'Y' = Paper
    | h == 'C' || h == 'Z' = Scissor

toOutcome :: Char -> Outcome
toOutcome 'X' = Lose
toOutcome 'Y' = Draw
toOutcome 'Z' = Win

outcomeScore :: Hand -> Hand -> Int
outcomeScore Rock Scissor = 6 -- win
outcomeScore Scissor Rock = 0 -- lose
outcomeScore a b = score $ compare a b
    where score EQ = 3
          score GT = 6
          score LT = 0

handValue :: Hand -> Int
handValue Rock = 1
handValue Paper = 2
handValue Scissor = 3

handForOutcome :: Outcome -> Hand -> Hand
handForOutcome Win Scissor = Rock
handForOutcome Win Rock = Paper
handForOutcome Win Paper = Scissor
handForOutcome Lose Scissor = Paper
handForOutcome Lose Rock = Scissor
handForOutcome Lose Paper = Rock
handForOutcome Draw oppHand = oppHand

-- P01
solve :: String -> Int
solve contents = sum $ map calculateScore $ lines contents

calculateScore :: String -> Int
calculateScore s = outcomeScore ((toHand . last) s) ((toHand . head) s)
    + handValue ((toHand . last) s)
    

-- P02
solve' :: String -> Int
solve' contents = sum $ map calculateScore' $ lines contents

calculateScore' :: String -> Int
calculateScore' s = outcomeScore handToPlay ((toHand . head) s)
    + handValue handToPlay
    where handToPlay = handForOutcome ((toOutcome . last) s) ((toHand . head) s) 
    
