module Fraction (Fraction, frac) where

-- Fraction type. ADT maintains the INVARIANT that every fraction Frac n m
-- satisfies m > 0 and gcd n m == 1. For fractions satisfying this invariant
-- equality is the same as literal equality (hence "deriving Eq")

data Fraction = Frac Integer Integer deriving Eq


-- Public constructor: take two integers, n and m, and construct a fraction
-- representing n/m that satisfies the invariant, if possible (the case
-- where this is impossible is when m == 0).
frac :: Integer -> Integer -> Maybe Fraction
frac n m | (gcd n m ==1) && (m>0) = Just (Frac n m )
         | otherwise = Nothing


-- Show instance that outputs Frac n m as n/m
instance Show Fraction where 
   show (Frac n m ) = show n ++ "/" ++ show m
-- Ord instance for Fraction
instance Ord Fraction where 
   compare (Frac n m )(Frac x y) = compare (n * y)(m * x)
-- Num instance for Fraction

{-
ghci> show (Frac 1 5)
"1/5"
ghci> compare (Frac 1 4) (Frac 1 5)
GT
ghci> compare (Frac 1 4) (Frac 1 4)
EQ
ghci> compare (Frac 1 4) (Frac 1 2)
LT
-}
instance Num Fraction where 
   (Frac n m) - (Frac a b) = Frac((n * b) - (m * a)) ( m * b)
   (Frac n m) + (Frac a b) = Frac((n * b) + (m * a)) ( m * b)
   (Frac n m) * (Frac a b) = Frac(n * b) (m * a) 
    
   abs (Frac n m) = Frac (abs n) m 
   
   negate (Frac n m) = Frac (-n) m 
   
   fromInteger a = Frac a 1 
   
   signum (Frac n m) 
      |div n m > 0 = 1
	  |div n m < 0 = -1
	  |otherwise = 0
{-
ghci> show (Frac 1 5)
"1/5"
ghci> compare (Frac 1 4) (Frac 1 5)
GT
ghci> compare (Frac 1 4) (Frac 1 4)
EQ
ghci> compare (Frac 1 4) (Frac 1 2)
LT
ghci> Frac 1 3 + Frac 1 3
6/9
ghci> Frac 2 5 - Frac 1 10
15/50
ghci> Frac 2 6 * Frac 1 15
30/6
ghci> negate (Frac 2 5 )
-2/5
ghci> -Frac 2 5
-2/5
ghci> abs (Frac 1 2)
1/2
ghci> signum (Frac 2 4)
0/1

-}