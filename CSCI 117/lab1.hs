-- CSci 117, Lab 1:  Introduction to Haskell

---------------- Part 1 ----------------

-- WORK through Chapters 1 - 3 of LYaH. Type in the examples and make
-- sure you understand the results.  Ask questions about anything you
-- don't understand! This is your chance to get off to a good start
-- understanding Haskell.
{-
1.)ghci> a = 5 + 4
ghci> a
9

2.)
ghci> 2 * 8
16

3.)
ghci> 5/2
2.5

4.)
ghci>  not True
False

5.)
ghci> True && True
True

6.)
ghci> "test" == "Test"
False

7.)
ghci> 8 - 2.5
5.5

8.)
ghci> min 11 (-1)
-1

9.) ghci> max 121 (101)
121

10.)ghci> succ 10
11

11.)ghci> 20 / 3
6.666666666666667

12.)ghci> doubleMe 3
6

13.)ghci> doubleUs 4 5
18

14.) ghci> doubleSmallNumber 30
60

15.)ghci> let lostNumbers = [4,8,15,16,23,42]
ghci> lostnumbers

<interactive>:5:1: error:
    * Variable not in scope: lostnumbers
    * Perhaps you meant `lostNumbers' (line 4)
ghci> lostNumbers
[4,8,15,16,23,42]

16.) ghci> [1,3,5] ++ [2,4,6]
[1,3,5,2,4,6]

17.) ghci> 'A' : "big dog"
"Abig dog"

18.)"TOM BRADY" !! 5
'R'

19.) [10, 12 , 13] < [20, 30 , 40]
True

20.) ghci> tail [ 5,3,2,1]
[3,2,1]

21.) ghci> null [3,4,5]
False

22.) ghci> reverse [1,3,5,7]
[7,5,3,1]

23.)ghci> take 3 [1,2,3,4,5,6,7]
[1,2,3]

24.)ghci> product [1,2,3]
6

25.)ghci> [2,4..20]
[2,4,6,8,10,12,14,16,18,20]
-}
---------------- Part 2 ----------------

-- The Haskell Prelude has a lot of useful built-in functions related
-- to numbers and lists.  In Part 2 of this lab, you will catalog many
-- of these functions.

-- Below is the definition of a new Color type (also called an
-- "enumeration type").  You will be using this, when you can, in
-- experimenting with the functions and operators below.
data Color = Red | Orange | Yellow | Green | Blue | Violet
     deriving (Show, Eq, Ord, Enum)

-- For each of the Prelude functions listed below, give its type,
-- describe briefly in your own words what the function does, answer
-- any questions specified, and give several examples of its use,
-- including examples involving the Color type, if appropriate (note
-- that Color, by the deriving clause, is an Eq, Ord, and Enum type).
-- Include as many examples as necessary to illustration all of the
-- features of the function.  Put your answers inside {- -} comments.
-- I've done the first one for you (note that "λ: " is my ghci prompt).


-- succ, pred ----------------------------------------------------------------

{- 
succ :: Enum a => a -> a
pred :: Enum a => a -> a

For any Enum type, succ gives the next element of the type after the
given one, and pred gives the previous. Asking for the succ of the
last element of the type, or the pred of the first element of the type
results in an error.

λ: succ 5
6
λ: succ 'd'
'e'
λ: succ False
True
λ: succ True
*** Exception: Prelude.Enum.Bool.succ: bad argument
λ: succ Orange
Yellow
λ: succ Violet
*** Exception: succ{Color}: tried to take `succ' of last tag in enumeration
CallStack (from HasCallStack):
  error, called at lab1.hs:18:31 in main:Main
λ: pred 6
5
λ: pred 'e'
'd'
λ: pred True
False
λ: pred False
*** Exception: Prelude.Enum.Bool.pred: bad argument
λ: pred Orange
Red
λ: pred Red
*** Exception: pred{Color}: tried to take `pred' of first tag in enumeration
CallStack (from HasCallStack):
  error, called at lab1.hs:18:31 in main:Main
-}


-- toEnum, fromEnum, enumFrom, enumFromThen, enumFromTo, enumFromThenTo -------
{-


1.)
ghci> toEnum 3 :: Color
Green

2.)
ghci> toEnum 5 :: Color
Violet

-Description
toEnum takes the number postion from a list and outputs the result so if you were to ask fot toenum 5 it would you the 5 result from the list.
//
-fromEnum

1.)ghci> fromEnum Violet
5

2.)ghci> fromEnum Blue
4
-Description 
fromEnum take the item from the list and gives you the position in which it sits in the list.
//
-enumFrom

1.)ghci> enumFrom Blue
[Blue,Violet]

2.)ghci> enumFrom Red
[Red,Orange,Yellow,Green,Blue,Violet]

-Description 
enumFrom take the input from the user and gives you the range from that input to the last element in the list
//
-enumFromThen

1.)ghci> enumFromThen Orange Blue
[Orange,Blue]

2.) ghci> enumFromThen Orange Violet
[Orange,Violet]

-Description 
enumFromThen checks to see if both user inputs are in the list and if so outputs then in the list. 
//

-enumFromTo
ghci> enumFromTo Red Green
[Red,Orange,Yellow,Green]

-Description
enumFromTo takes the to inputs from the user and gives every object in the list from the first user inputed object to the 2nd user inputed object.
//
-enumFromThenTo

1.)
ghci> enumFromThenTo Red Violet Green
[Red]
2.)
ghci> enumFromThenTo Red Blue Green
[Red]
3.)
ghci> enumFromThenTo Red Green Violet
[Red,Green]
-Description 
enumFromThenTo takes the first element the user inputs then the second input and finally the third input and gives and if they are in consecutive order
then it will give you the order it travled. If you go backwards from the first or second input then it would only print out the first input.
-}


-- ==, /= ---------------------------------------------------------------------
{-
ghci> 1 == 1
True
ghci> 1 /=2
True
ghci> True == True
True
ghci> False /= False
False
-Description 
== is when comparing to element to check if they are the same.
/= is for comparing to elemts to check if they are no the same.
-}
-- quot, div (Q: what is the difference? Hint: negative numbers) --------------
{-
quot :: Integral a => a -> a -> a
div :: Integral a => a -> a -> a
ghci> div 5 3
1
ghci> quot 5 3
1
ghci> div 2 5
0
ghci> quot 2 5
0
ghci> div 25 3
8
ghci> quot 25 3
8
ghci> div (-25) 4
-7
ghci> quot (-25) 4
-6
-Description
Quotient divides the numbers and leaves out the remainder while Div tells you the number of times the value cna be divided
-}
-- rem, mod  (Q: what is the difference? Hint: negative numbers) --------------
{-
rem :: Integral a => a -> a -> a
mod :: Integral a => a -> a -> a

ghci> mod 10 (-3)
-2
ghci> rem 10 (-3)
1 
-Description 
Rem return the remainder of the given input while mod gives the same except when negative numbers are used.

-}
-- quotRem, divMod ------------------------------------------------------------
{-
quotRem :: Integral a => a -> a -> (a, a)
divMod :: Integral a => a -> a -> (a, a)

ghci> divMod 5 2
(2,1)
ghci> quotRem 5 2
(2,1)
ghci> quotRem 5(- 2)
(-2,1)
ghci> divMod 5(- 2)
(-3,-1)
ghci> divMod (-5) (-2)
(2,-1)
ghci> quotRem (-5) (-2)
(2,-1)
-Description 
DivMod gives you answer to your problem in the form of a touple of both div and mod. QuotRem gives you somthing similar except the first part of the tuple is the the divion without the remainder.
-}
-- &&, || ---------------------------------------------------------------------
{-
and :: Foldable t => t Bool -> Bool
or :: Foldable t => t Bool -> Bool
ghci> True && True
True
ghci> True && False
False
ghci> True || True
True
ghci> False || True
True
ghci> False || False
False
-Description
logical AND and OR from other high level languages.

-}
-- ++ -------------------------------------------------------------------------
{-
ghci> ['a', 'b'] ++ ['c', 'd']
"abcd"
ghci> [1,2,3,4] ++ [5,6,7,8]
[1,2,3,4,5,6,7,8]
-Description
++ Combines two or more list into one list.
-}
-- compare --------------------------------------------------------------------
{-
ghci> :type compare
compare :: Ord a => a -> a -> Ordering
ghci> compare 5 3
GT
ghci> comapre 1 1

<interactive>:16:1: error:
    * Variable not in scope: comapre :: t0 -> t1 -> t
    * Perhaps you meant `compare' (imported from Prelude)
ghci> compare 1 1
EQ
ghci> compare 'a' 'c'
LT
ghci>
-Description 
It compares two values and tells you if the first vaule is less then, equal, or less than the second value.
-}
-- <, > -----------------------------------------------------------------------
{-
ghci> 6 < 2
False
ghci> 6 > 2
True
ghci> 6 < 6
False
-Description 
< is less than, while > is greater than. They are used to compare 2 different ints to see if its greater or less than the first element.


-}
-- max, min -------------------------------------------------------------------

{-
max :: Ord a => a -> a -> a
min :: Ord a => a -> a -> a

ghci> max 12 3
12
ghci> min 3 14
3
ghci> max 4 4
4
ghci> min (-2) 2
-2
- Description 
Max and min compares 2 values to one another gives back the deisred max or min of the 2.

-}
-- ^ --------------------------------------------------------------------------
{-
ghci> 3^5
243
ghci> 2^3
8
-Description
^ is the power of, like used in math problems.
-}
-- concat ---------------------------------------------------------------------
{-

ghci> :type concat
concat :: Foldable t => t [a] -> [a]
ghci> concate [['a', 'b'],['c', 'd']

<interactive>:32:31: error:
    parse error (possibly incorrect indentation or mismatched brackets)
ghci> concate [['a', 'b'],['c', 'd']]

<interactive>:33:1: error:
    * Variable not in scope: concate :: [[Char]] -> t
    * Perhaps you meant one of these:
        `concat' (imported from Prelude), `mconcat' (imported from Prelude)
ghci> concat [['a', 'b'],['c', 'd']]
"abcd"
ghci> concat [[1, 2],[3, 4]]
[1,2,3,4]
-Description 
It comnines two lists into 1 list in order inputed.

-}

-- const ----------------------------------------------------------------------
{-
ghci> :type const
const :: a -> b -> a
ghci> const 3 8
3
ghci> const 1/2 6
ghci> const (1/2) 8
0.5
-Description 
It seems to give the lesser int of the 2 elements.


-}
-- cycle ----------------------------------------------------------------------
{-
ghci> cycle [1,2,3]
[1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3
Description
This a loops system the loops a given list infintly. 
-}
-- drop, take -----------------------------------------------------------------
{-

drop :: Int -> [a] -> [a]

take :: Int -> [a] -> [a]
ghci> drop 5 [1,2,3,4,5,6,7,8,9,10]
[6,7,8,9,10]
ghci> take 2 ['w', 'o', 'r', 'l', 'd']
"wo"
Description 
Drop cuts off all elements from the specfified elemtent and before. Take will show number of elements from the list that are specified.
-}
-- elem -----------------------------------------------------------------------
{-
elem :: (Foldable t, Eq a) => a -> t a -> Bool
ghci> elem 'a' ['b','a','d','e']
True
ghci> elem 15 [1,2,3,4,5]
False
-Description 
Elem checks the given list to see if the element given is also in the list.

-}
-- even -----------------------------------------------------------------------
{-
even :: Integral a => a -> Bool
ghci> even 27
False
ghci> even 30
True
-Description
This checks to see if a given number is even or not.
-}
-- fst ------------------------------------------------------------------------
{-
fst :: (a, b) -> a
ghci> fst (9, 27)
9
ghci> fst ('abc', 'cde')

<interactive>:14:6: error:
    * Syntax error on 'abc'
      Perhaps you intended to use TemplateHaskell or TemplateHaskellQuotes
    * In the Template Haskell quotation 'abc'
ghci> fst ("abc", "cde")
"abc"
-Description 
Gives the first element of the tuple.
-}
-- gcd ------------------------------------------------------------------------
{-
gcd :: Integral a => a -> a -> a
ghci> gcd 9 3
3
ghci> gcd 22 3
1
-Description
It gives you the greatest common divisor.


-}
-- head -----------------------------------------------------------------------
{-
head :: [a] -> a
ghci> head ['a','b','d','r']
'a'
ghci> head [12,34,45,67,89]
12
-Description 
It gives the first element of any list.
-}
-- id -------------------------------------------------------------------------
{-
id :: a -> a
ghci> id [15]
[15]
ghci> id "CSCI 1234"
"CSCI 1234"
Description 
It takes the identity of the element given 
-}
-- init -----------------------------------------------------------------------
{-
ghci> init [1,2,3,4,5,6]
[1,2,3,4,5]
ghci> int ["abc"]

<interactive>:27:1: error:
    * Variable not in scope: int :: [String] -> t
    * Perhaps you meant one of these:
        `init' (imported from Prelude), `Ghci1.it' (imported from Ghci1),
        `Ghci2.it' (imported from Ghci2)
ghci> init ["abc","abab"]
["abc"]
-Description
Init chops off the lest element in the given list.

-}
-- last -----------------------------------------------------------------------
{-
ghci> last [1,2,3,4,5]
5
ghci> last ["Hello", "World"]
"World"
-Description 
It only shows the last element in a given list.
-}
-- lcm ------------------------------------------------------------------------
{-

ghci> lcm 16 2
16
ghci> lcm 4 3
12
ghci> lcm (-2) 3
6

-Description 
Its the least common multiple between the two elements.
-}
-- length ---------------------------------------------------------------------
{-
ghci> length $ take 100 [1..]
100
ghci> length [1,2,3,4,5]
5
-Description 
This returns the number of elements in the given list.
-}
-- null -----------------------------------------------------------------------
{-
ghci> null []
True
ghci> null [1,2,3]
False

-Description
Checks to see if the elemnts in the list are empty.
-}
-- odd ------------------------------------------------------------------------
{-
ghci> odd 35
True
ghci> odd 34
False
-Description
Checks to see if the int is odd or not.
-}
-- repeat ---------------------------------------------------------------------
{- ghci> repeat 'D'
"DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD..."
ghci> repeat 25
[25,25,25,25,25,25,25,25,25,25,25,25,25...]
-Description
This is also like a loop where it will repeat them infintly
-}
-- replicate ------------------------------------------------------------------
{-
ghci> replicate 2 "Hello World"
["Hello World","Hello World"]
ghci> replicate 20 3
[3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3]
-Description
It replicates the last item in your list whatever specified amount of times you specify.
-}
-- reverse --------------------------------------------------------------------
{-
ghci> reverse [1,2,3,4,5]
[5,4,3,2,1]
ghci> reverse ['a'..'j']
"jihgfedcba"
-Description
It reverses whatever list you give.
-}
-- snd ------------------------------------------------------------------------
{-
ghci> snd (13, 45)
45
ghci> snd ('a','z')
'z'
-Description
It returns the second item in the tuple 

-}
-- splitAt --------------------------------------------------------------------
{-

ghci> splitAt 4 [1,2,3,4,5,6,7,8]
([1,2,3,4],[5,6,7,8])
ghci> splitAt 6 [2,4,6,8,10]
([2,4,6,8,10],[])
-Description 
Splits the list at whatever elemnet point specified.
-}
-- zip ------------------------------------------------------------------------
{-
ghci> zip [1,2,3] [4,5,6]
[(1,4),(2,5),(3,6)]
ghci> zip ['a','b','e'] ['q','w','t']
[('a','q'),('b','w'),('e','t')]
-Description
It creates a new list of tuples from the given lists by placing each element in its given place.
-}

-- The rest of these are higher-order, i.e., they take functions as
-- arguments. This means that you'll need to "construct" functions to
-- provide as arguments if you want to test them.

-- all, any -------------------------------------------------------------------
{-
all :: Foldable t => (a -> Bool) -> t a -> Bool
any :: Foldable t => (a -> Bool) -> t a -> Bool
ghci> all (>12) [13,14,15,16]
True
ghci> all (>22) [13,14,15,16]
False
ghci> any (>8) [6,7,8,9]
True
ghci> all (==1) [1,2,3,4]
False
ghci> any even [1,3,5,7]
False
-Description 
All check to see if the user inputed element is less than or greater than all of the elements in the list.
Any is similar to all except only one element of the list needs to be less than or greater than.
-}
-- break ----------------------------------------------------------------------
{-
ghci> :type break
break :: (a -> Bool) -> [a] -> ([a], [a])
ghci> break (==3) [1,2,3,4,5]
([1,2],[3,4,5])
 break (=='t') ['w','a','t','c','h']
("wa","tch")
-Description
Break makes a break point in the list specfifed by the user by breaking the list into a tuple at the specified point.

-}
-- dropWhile, takeWhile -------------------------------------------------------
{-
dropWhile :: (a -> Bool) -> [a] -> [a]
takeWhile :: (a -> Bool) -> [a] -> [a]
ghci> dropWhile (>5) [11,5,17,23,34]
[5,17,23,34]
ghci> dropWhile (>5) [11,5,17,23,34]
[5,17,23,34]
ghci> takeWhile even [2,4,6,8,11]
[2,4,6,8]
ghci> takeWhile odd [1,2,3,5,6]
[1]
-Description 
dropWhile checks the condition set by the first argument and accordingly
acts to meet those conditions. takeWhile does a similar thing but stops once 
the condition is not met. 
-}
-- filter ---------------------------------------------------------------------
{-
ghci> :type filter
filter :: (a -> Bool) -> [a] -> [a]
ghci> filter even [1,2,3,4,5,6,7,8,9]
[2,4,6,8]
ghci> filter odd [1,2,3,4,5,6,7,8,9]
[1,3,5,7,9]
-Description
Filter filters out a list for the sepcefied type of elements wanted.


-}
-- iterate --------------------------------------------------------------------
{-
ghci> iterate (*2) (1)
[1,2,4,8,16,32,64,128,256,512,1024

ghci> iterate (8+)(1)
[1,9,17,25,33,41,49,57,65,73,81,89
-Description
Iterate will infintely create a list where the first argument in the function
applies to the second argument.

-}
-- map ------------------------------------------------------------------------
{-
ghci> map (3*) [1,2,3,4]
[3,6,9,12]
ghci> map (+12) [10,20,30,40,50]
[22,32,42,52,62]
-Description
Map is like iterate except its done over a finite amount of times specified and not infintely. 
-}
-- span -----------------------------------------------------------------------
{-
ghci> span (<5) [3,4,5,6,7,8]
([3,4],[5,6,7,8])
ghci> span even [1,2,3,4,5,6,7]
([],[1,2,3,4,5,6,7])
-Description 
Span takes the list given and breakes it on the specfifed condition.

-}
