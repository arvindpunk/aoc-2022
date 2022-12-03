import System.IO
import Data.List

main :: IO ()
main = do
    contents <- readFile "input"
    (print . solve) contents
    (print . solve') contents

-- P01
solve :: String -> Int
solve contents = snd $ foldr subSolve (0, 0) $ lines contents

subSolve :: String -> (Int, Int) -> (Int, Int)
subSolve "" (currSum, maxSum) = (0, maxSum)
subSolve el (currSum, maxSum) = (\x -> (x + currSum, max maxSum (x + currSum))) (read el :: Int)

-- P02
solve' :: String -> Int
solve' contents = do
    let (finalSum, sums) = foldr subSolve' (0, []) $ lines contents
    sum $ take 3 $ reverse $ sort $ [finalSum] ++ sums

subSolve' :: String -> (Int, [Int]) -> (Int, [Int])
subSolve' "" (currSum, sums) = (0, [currSum] ++ sums)
subSolve' el (currSum, sums) = (\x -> (x + currSum, sums)) (read el :: Int)
