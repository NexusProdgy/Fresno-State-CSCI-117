-- CSci 117, Lab 3:  ADTs and Type Classes

import Data.List (sort)
import Queue1
--import Queue2
import Fraction

---------------- Part 1: Queue client

-- Queue operations (A = add, R = remove)
data Qops a = A a | R

-- Perform a list of queue operations on an emtpy queue,
-- returning the list of the removed elements
perf :: [Qops a] -> [a]
perf ops = go ops mtq where 
go [] _ = []
go (A x : ops) queue = go ops (addq x queue)
go (R : ops) queue = let (removedElement, updatedQueue) = remq queue in removedElement : go ops updatedQueue

-- Test the above functions thouroughly. For example, here is one test:
-- perf [A 3, A 5, R, A 7, R, A 9, A 11, R, R, R] ---> [3,5,7,9,11]
{-

-}


---------------- Part 2: Using typeclass instances for fractions

-- Construct a fraction, producing an error if it fails
fraction :: Integer -> Integer -> Fraction
fraction a b = case frac a b of
             Nothing -> error "Illegal fraction"
             Just fr -> fr


-- Calculate the average of a list of fractions
-- Give the error "Empty average" if xs is empty
average :: [Fraction] -> Fraction
average [] = error "Empty average " 
average xs = sum xs * fraction 1(fractions_length xs 0) where
fractions_length [] count = count 
fractions_length (x:xs) count = fractions_length xs (count + 1)

-- Some lists of fractions

list1 = [fraction n (n+1) | n <- [1..20]]
list2 = [fraction 1 n | n <- [1..20]]
list3 = zipWith (+) list1 list2
list4 = [fraction n 1 | n <- [1..20]]
list5 = [fraction (n*3)| n <- [1..20]]
list6 = [fraction 0 n |n <-[1..20]]


-- Make up several more lists for testing


-- Show examples testing the functions sort, sum, product, maximum, minimum,
-- and average on a few lists of fractions each. Think about how these library
-- functions can operate on Fractions, even though they were written long ago
{-
ghci> sort list1
[1/2,2/3,3/4,4/5,5/6,6/7,7/8,8/9,9/10,10/11,11/12,12/13,13/14,14/15,15/16,16/17,17/18,18/19,19/20,20/21]
ghci> sort list2
[1/20,1/19,1/18,1/17,1/16,1/15,1/14,1/13,1/12,1/11,1/10,1/9,1/8,1/7,1/6,1/5,1/4,1/3,1/2,1/1]
ghci> sort list3
[421/420,381/380,343/342,307/306,273/272,241/240,211/210,183/182,157/156,133/132,111/110,91/90,73/72,57/56,43/42,31/30,21/20,13/12,7/6,3/2]
ghci> sort list4
[1/1,2/1,3/1,4/1,5/1,6/1,7/1,8/1,9/1,10/1,11/1,12/1,13/1,14/1,15/1,16/1,17/1,18/1,19/1,20/1]
ghci> sort list5

<interactive>:12:1: error:
    * No instance for (Ord (Integer -> Fraction))
        arising from a use of `sort'
        (maybe you haven't applied a function to enough arguments?)
    * In the expression: sort list5
      In an equation for `it': it = sort list5
ghci> sort list6
*** Exception: Illegal fraction
CallStack (from HasCallStack):
  error, called at lab3.hs:33:25 in main:Main
ghci> sim list1

<interactive>:14:1: error:
    * Variable not in scope: sim :: [Fraction] -> t
    * Perhaps you meant one of these:
        `sum' (imported from Prelude), `sin' (imported from Prelude)
ghci> sum list1
886664974825728000000/51090942171709440000
ghci> sum list2
8752948036761600000/2432902008176640000
ghci> sum list3
2604365359811568181583674343424000000000/124299255809188481393766275481600000000
ghci> sum list4
210/1
ghci> sum list5

<interactive>:19:1: error:
    * No instance for (Num (Integer -> Fraction))
        arising from a use of `sum'
        (maybe you haven't applied a function to enough arguments?)
    * In the expression: sum list5
      In an equation for `it': it = sum list5
ghci> sum list6
*** Exception: Illegal fraction
CallStack (from HasCallStack):
  error, called at lab3.hs:33:25 in main:Main
ghci> product list1
51090942171709440000/2432902008176640000
ghci> product list2
2432902008176640000/1
ghci> product list3
124299255809188481393766275481600000000/287791705661843947251538184300022124341
ghci> max list1

<interactive>:24:1: error:
    * No instance for (Show ([Fraction] -> [Fraction]))
        arising from a use of `print'
        (maybe you haven't applied a function to enough arguments?)
    * In a stmt of an interactive GHCi command: print it
ghci> maximum list1
20/21
ghci> maximum list2
1/1
ghci> maximum list3
3/2
ghci> minmum list1

<interactive>:28:1: error:
    * Variable not in scope: minmum :: [Fraction] -> t
    * Perhaps you meant `minimum' (imported from Prelude)
ghci> minimum list1
1/2
ghci> minimum list2
1/20
ghci> minimum list3
421/420
ghci> average list1
17733299496514560000000/51090942171709440000
ghci> average list2
175058960735232000000/2432902008176640000
ghci> average list3
52087307196231363631673486868480000000000/124299255809188481393766275481600000000
-}