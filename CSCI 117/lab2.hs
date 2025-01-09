-- CSci 117, Lab 2:  Functional techniques, iterators/accumulators,
-- and higher-order functions. Make sure you test all of your functions,
-- including key tests and their output in comments after your code.


---- Part 1: Basic structural recursion ----------------

-- 1. Merge sort

-- Deal a list into two (almost) equal-sizes lists by alternating elements
-- For example, deal [1,2,3,4,5,6,7] = ([1,3,5,7], [2,4,6])
-- and          deal   [2,3,4,5,6,7] = ([2,4,6], [3,5,7])
-- Hint: notice what's happening between the answers to deal [2..7] and
-- deal (1:[2..7]) above to get an idea of how to approach the recursion
deal :: [a] -> ([a],[a])
deal [] = ([],[])
deal (x:xs) = let (ys,zs) = deal xs
              in (x:zs,ys)

-- Now implement merge and mergesort (ms), and test with some
-- scrambled lists to gain confidence that your code is correct
merge :: Ord a => [a] -> [a] -> [a]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys)
  | x <= y = (x: merge xs (y:ys))
  | x > y  = (y: merge (x:xs)ys)
 

ms :: Ord a => [a] -> [a]
ms [] = []
ms [x] = [x]
ms xs = merge (ms ys) (ms zs) where (ys, zs) = deal xs
--general case: deal, recursive call, merge
{-
ghci> deal [1,2,3,4,5,6,7,8,9]
([1,3,5,7,9],[2,4,6,8])
ghci> merge [1,2,3,4,5,6] [9,8,7]
[1,2,3,4,5,6,9,8,7]
ghci> ms [12,2,32,5,1]
[1,2,5,12,32]
-}

-- 2. A backward list data structure 

-- Back Lists: Lists where elements are added to the back ("snoc" == rev "cons")
-- For example, the list [1,2,3] is represented as Snoc (Snoc (Snoc Nil 1) 2) 3
data BList a = Nil | Snoc (BList a) a deriving (Show,Eq)

-- Add an element to the beginning of a BList, like (:) does
cons :: a -> BList a -> BList a
cons b Nil = Snoc Nil b 
cons b (Snoc Nil x ) = Snoc (cons b Nil) x 
cons b (Snoc xs x) = Snoc (cons b xs) x 
{-
ghci> a = Nil
ghci> b= cons 1 a
ghci> b
Snoc Nil 1
ghci> c = cons 2 b
ghci> c
Snoc (Snoc Nil 2) 1
ghci> d = cons 3 c
ghci> d
Snoc (Snoc (Snoc Nil 3) 2) 1

-}

-- Convert a usual list into a BList (hint: use cons in the recursive case)
toBList :: [a] -> BList a
toBList [] = Nil
toBList [x] = Snoc Nil x 
toBList (x:xs)= cons x (toBList xs)
{-
ghci> toBList []
Nil
ghci> toBList [1]
Snoc Nil 1
ghci> toBList [1..4]
Snoc (Snoc (Snoc (Snoc Nil 1) 2) 3) 4

-}
-- Add an element to the end of an ordinary list
snoc :: [a] -> a -> [a]
snoc [] b = [b]
snoc [x] b = x : snoc [] b
snoc (x:xs) b = x : snoc xs b
{-
ghci> snoc [] 5
[5]
ghci> snoc [1] 5
[1,5]
ghci> snoc [1..5] 8
[1,2,3,4,5,8]
-}
-- Convert a BList into an ordinary list (hint: use snoc in the recursive case)
fromBList :: BList a -> [a]
fromBList Nil = [] 
fromBList (Snoc Nil x) = [x]
fromBlist (Snoc xs x) = snoc (fromBList xs ) x 
{-
ghci> fromBList (toBList [])
[]
ghci> fromBList (toBList [1])
[1]
ghci> fromBList (toBList [1..8])
*** Exception: lab2-2.hs:(98,1)-(99,28): Non-exhaustive patterns in function fromBList

-}

-- 3. A binary tree data structure
data Tree a = Empty | Node a (Tree a) (Tree a) deriving (Show, Eq)

-- Count number of Empty's in the tree
num_empties :: Tree a -> Int
num_empties Empty = 1
num_empties (Node a t1 t2) = (num_empties t1) + (num_empties t2)
{-
ghci> num_empties Empty
1
ghci> a = Node 2 (Node 3 Empty Empty) (Node 4 Empty Empty)
ghci> a
Node 2 (Node 3 Empty Empty) (Node 4 Empty Empty)

-}

-- Count number of Node's in the tree
num_nodes :: Tree a -> Int
num_nodes Empty = 0
num_nodes (Node _ treeA treeB) = 1 + num_nodes treeA + num_nodes treeB

{-
ghci> num_nodes Empty
0
ghci> num_nodes (Node 1 (Node 3 Empty Empty) (Node 2 Empty Empty))
3
-}


-- Insert a new node in the leftmost spot in the tree
insert_left :: a -> Tree a -> Tree a
insert_left a Empty = Node a Empty Empty 
insert_left a (Node value treeA treeB) = Node value (insert_left a treeA) treeB
{-
ghci> a = Node 2 (Node 3 Empty Empty) (Node 6 Empty Empty)
ghci> b = insert_left 9 a
ghci> b
Node 2 (Node 3 (Node 9 Empty Empty) Empty) (Node 6 Empty Empty)
ghci> b = insert_left 9 Empty
ghci> b
Node 9 Empty Empty

-}

-- Insert a new node in the rightmost spot in the tree
insert_right :: a -> Tree a -> Tree a
insert_right a Empty = Node a Empty Empty
insert_right a (Node value treeA treeB) = Node value treeA (insert_right a treeB)
{-
ghci> a = Node 2 (Node 5 Empty Empty) (Node 6 Empty Empty)
ghci> b = insert_right 9 a
ghci> b
Node 2 (Node 5 Empty Empty) (Node 6 Empty (Node 8 Empty Empty))
ghci> b = insert_right 8 Empty
ghci> b
Node 8 Empty Empty
-}

-- Add up all the node values in a tree of numbers
sum_nodes :: Num a => Tree a -> a
sum_nodes Empty = 0
sum_nodes (Node value treeA treeB) = value + sum_nodes treeA + sum_nodes treeB
{-
ghci> sum_nodes Empty
0
ghci> a = Node 5 (Node 7 Empty Empty) (Node 8 Empty Empty)
ghci> sum_nodes a
20
ghci> a = Node 3 (Node 5 Empty (Node 7 Empty Empty)) (Node 5 (Node 10 Empty Empty) Empty)
ghci> sum_nodes a
30
-}

-- Produce a list of the node values in the tree via an inorder traversal
-- Feel free to use concatenation (++)
inorder :: Tree a -> [a]
inorder Empty = []
inorder (Node value treeA treeB) = inorder treeA ++ [value] ++ inorder treeB
{-
ghci> inorder Empty
[]
ghci> a = Node 2 (Node 3 Empty Empty) (Node 4 Empty Empty)
ghci> inorder a
[3,2,4]
ghci> a = Node 2 (Node 3 Empty (Node 5 Empty Empty)) (Node 4 (Node 8 Empty Empty) Empty)
ghci> inorder a
[3,5,2,8,4]
-}


-- 4. A different, leaf-based tree data structure
data Tree2 a = Leaf a | Node2 a (Tree2 a) (Tree2 a) deriving Show

-- Count the number of elements in the tree (leaf or node)
num_elts :: Tree2 a -> Int
num_elts (Leaf _ ) = 1 
num_elts (Node2 _ treeA treeB ) = 1 + num_elts treeA + num_elts treeB
{-
ghci> num_elts (Leaf 1)
1
ghci> a = Node2 2 (Leaf 3) 
ghci> num_elts a
2
ghci> a = Node2 2 (Node2 3 (Leaf 6) (Leaf 8)) 
ghci> num_elts a
3

-}

-- Add up all the elements in a tree of numbers
sum_nodes2 :: Num a => Tree2 a -> a
sum_nodes2 (Leaf value) = value 
sum_nodes2 (Node2 value treeA treeB) = value + sum_nodes2 treeA + sum_nodes2 treeB
{-
ghci> sum_nodes2 (Leaf 1)
1
ghci> a = Node2 2 (Leaf 4) (Leaf 5)
ghci> sum_nodes2 a
11
-}

-- Produce a list of the elements in the tree via an inorder traversal
-- Again, feel free to use concatenation (++)
inorder2 :: Tree2 a -> [a]
inorder2 (Leaf a) = [a]
inorder2 (Node2 a treeA treeB) = (inorder2 treeA) ++ [a] ++ (inorder2 treeB)
{-
ghci> inorder2 (Leaf 5)
[5]
ghci> a = Node2 4 (Leaf 7 ) (Leaf 9)
ghci> inorder2 a
[7,4,9]
-}

-- Convert a Tree2 into an equivalent Tree1 (with the same elements)
conv21 :: Tree2 a -> Tree a
conv21 (Leaf a) = Node a Empty Empty
conv21 (Node2 a treeA treeB) = Node a (conv21 treeA) (conv21 treeB)
{-
ghci> conv21 (Leaf 5)
Node 5 Empty Empty
ghci> conv21 a
Node 4 (Node 7 Empty Empty) (Node 9 Empty Empty)
-}

---- Part 2: Iteration and Accumulators ----------------


-- Both toBList and fromBList from Part 1 Problem 2 are O(n^2) operations.
-- Reimplement them using iterative helper functions (locally defined using
-- a 'where' clause) with accumulators to make them O(n)
toBList' :: [a] -> BList a
toBList' xs = go xs Nil where 
 go [] bList = bList
 go (x:xs) bList = go xs (Snoc bList x)
{-
ghci> toBList' []
Nil
ghci> toBList' [2]
Snoc Nil 2
ghci> toBList' [2..4]
Snoc (Snoc (Snoc Nil 2) 3) 4
-}
fromBList' :: BList a -> [a]
fromBList' bList = go bList [] where 
 go Nil xs = xs 
 go (Snoc bList x) xs = go bList (x:xs)
{-
ghci> fromBList'( toBList [])
[]
ghci> fromBList'( toBList [3])
[3]
ghci> fromBList'( toBList [3..8])
[3,4,5,6,7,8]
-}

-- Even tree functions that do multiple recursive calls can be rewritten
-- iteratively using lists of trees and an accumulator. For example,
sum_nodes' :: Num a => Tree a -> a
sum_nodes' t = sum_nodes_it [t] 0 where
  sum_nodes_it :: Num a => [Tree a] -> a -> a
  sum_nodes_it [] a = a
  sum_nodes_it (Empty:ts) a = sum_nodes_it ts a
  sum_nodes_it (Node n t1 t2:ts) a = sum_nodes_it (t1:t2:ts) (n+a)

-- Use the same technique to convert num_empties, num_nodes, and sum_nodes2
-- into iterative functions with accumulators

num_empties' :: Tree a -> Int
num_empties' tree = go [tree] 0 where
  go :: [Tree a] -> Int -> Int
  go [] count = count
  go (Empty:trees) count = go trees (count + 1)
  go (Node _ treeA treeB : trees) count = go (treeA:treeB:trees) count
{-
ghci> num_empties' Empty
1
ghci> a = Node 2 (Node 3 Empty (Node 5 Empty Empty)) (Node 4 (Node 8 Empty Empty) Empty)
ghci> num_empties' a
6
-}
num_nodes' :: Tree a -> Int
num_nodes' tree = go [tree] 0 where
 go [] count = count 
 go (Empty:trees) count = go trees count 
 go (Node _ treeA treeB : trees) count = go (treeA:treeB:trees)(count +1)
{-
ghci> num_nodes' Empty
0
ghci> a = Node 2 (Node 3 Empty Empty) (Node 4 Empty Empty)
ghci> num_nodes' a    
3
ghci> a = Node 2 (Node 3 Empty (Node 5 Empty Empty)) (Node 4 (Node 8 Empty Empty) Empty)
ghci> num_nodes' a
5
-}

sum_nodes2' :: Num a => Tree2 a -> a
sum_nodes2' tree = go [tree] 0 where
  go :: Num a => [Tree2 a] -> a -> a
  go [] sum = sum
  go (Leaf value : trees) sum = go trees (sum + value)
  go (Node2 value treeA treeB : trees) sum = go (treeA:treeB:trees) (sum + value)
{-
ghci> sum_nodes2' (Leaf 2)
2
ghci> a = Node2 3 (Leaf 4) (Leaf 5)
ghci> sum_nodes2' a       
12
ghci> a = Node2 2 (Node2 4 (Leaf 7) (Leaf 8)) (Node2 5 (Leaf 9) (Leaf 4))
ghci> sum_nodes2' a
39
-}

-- Use the technique once more to rewrite inorder2 so it avoids doing any
-- concatenations, using only (:).
-- Hint 1: (:) produces lists from back to front, so you should do the same.
-- Hint 2: You may need to get creative with your lists of trees to get the
-- right output.
inorder2' :: Tree2 a -> [a]
inorder2' tree = go tree [] where
  go :: Tree2 a -> [a] -> [a]
  go (Leaf value) list = value : list
  go (Node2 value treeA treeB) list = go treeA (value : go treeB list)
{-
ghci> inorder2' (Leaf 1)
[1]
ghci> a = Node2 2 (Leaf 3) (Leaf 4)
ghci> inorder2' a       
[2,3,4]
ghci> a = Node2 2 (Node2 3 (Leaf 6) (Leaf 7)) (Node2 4 (Leaf 8) (Leaf 3))
ghci> inorder2' a
[2,3,3,4,6,7,8]
-}



---- Part 3: Higher-order functions ----------------

-- The functions map, all, any, filter, dropWhile, takeWhile, and break
-- from the Prelude are all higher-order functions. Reimplement them here
-- as list recursions. break should process each element of the list at
-- most once. All functions should produce the same output as the originals.

my_map :: (a -> b) -> [a] -> [b]
my_map _ [] = []
my_map f (x:xs) = f x : my_map f xs
{-
ghci> my_map even []
[]
ghci> my_map odd [1..5]
[True,False,True,False,True]

-}
my_all :: (a -> Bool) -> [a] -> Bool
my_all _ [] = True 
my_all f (x:xs) | not (f x) = False 
                | otherwise = my_all f xs 
{-
ghci> my_all odd []
True
ghci> my_all odd [1..9]
False
-}
my_any :: (a -> Bool) -> [a] -> Bool
my_any _ [] = False
my_any f (x:xs) | not (f x) = True 
                | otherwise = my_any f xs 
{-
ghci> my_any odd []
False
ghci> my_any odd [1..5]
True
ghci> my_any odd [1,4..12]
True

-}

my_filter :: (a -> Bool) -> [a] -> [a]
my_filter _ [] = []
my_filter f (x:xs) | f x = x : my_filter f xs
                   | otherwise = my_filter f xs 

{-
ghci> my_filter even []
[]
ghci> my_filter even [1..9]
[2,4,6,8]
ghci> my_filter odd [1,8..22]
[1,15]
-}

my_dropWhile :: (a -> Bool) -> [a] -> [a]
my_dropWhile _ [] = []
my_dropWhile f (x:xs) | f x = my_dropWhile f xs
                      | otherwise = x:xs 
{-
ghci> my_dropWhile (4 >) []
[]
ghci> my_dropWhile (4 >) [1..12]
[4,5,6,7,8,9,10,11,12]
ghci> my_dropWhile (4 <) [1..12]
[1,2,3,4,5,6,7,8,9,10,11,12]

-}
my_takeWhile :: (a -> Bool) -> [a] -> [a]
my_takeWhile _ [] = []
my_takeWhile f (x:xs) | f x = x: my_takeWhile f xs
                      | otherwise = []
{-
ghci> my_takeWhile (4 <) []
[]
ghci> my_takeWhile (4 >) [1..15]
[1,2,3]
ghci> my_takeWhile (4 <) [1..5]
[]
ghci> my_takeWhile (4 <) [1..22]
[]

-}

my_break :: (a -> Bool) -> [a] -> ([a], [a])
my_break _ [] = ([],[])
my_break f (x:xs) | not (f x) = (x:ys , zs) where (ys,zs) = my_break f xs
                  
{-
ghci> my_break (5 <)[]
([],[])
ghci> my_break (5 <)[1..10]
([1,2,3,4,5***
-}
-- Implement the Prelude functions and, or, concat using foldr

my_and :: [Bool] -> Bool
my_and xs = foldl (&&) True xs
{-
ghci> my_and []
True
ghci> my_and [True, False, False]
False
ghci> my_and [True]
True
-}

my_or :: [Bool] -> Bool
my_or xs = foldl (||) False xs
{-
ghci> my_or []
False
ghci> my_or [True,True]
True
ghci> my_or [False,False]
False

-}

my_concat :: [[a]] -> [a]
my_concat xs = foldr (++) [] xs
{-
ghci> my_concat [[1..5],[6..11]]
[1,2,3,4,5,6,7,8,9,10,11]
ghci> my_concat [[15],[]]
[15]
-}
-- Implement the Prelude functions sum, product, reverse using foldl

my_sum :: Num a => [a] -> a
my_sum xs = foldr (+) 0 xs
{-

ghci> my_sum [1..7]
28
ghci> my_sum [17]
17
ghci> my_sum [1..4]
10
-}

my_product :: Num a => [a] -> a
my_product xs = foldr(*) 1 xs
{-
ghci> my_product [1,5]
5
ghci>
ghci> my_product [4,5]
20
ghci> my_product [4..8]
6720

-}
my_reverse :: [a] -> [a]
my_reverse xs = foldl (\ys y -> y:ys) [] xs 
{-
ghci> my_reverse [1,2,3,4,5]
[5,4,3,2,1]
ghci> my_reverse [5,3,6,7,8,3,24,87]
[87,24,3,8,7,6,3,5]
-}


---- Part 4: Extra Credit ----------------

-- Convert a Tree into an equivalent Tree2, IF POSSIBLE. That is, given t1,
-- return t2 such that conv21 t2 = t1, if it exists. (In math, this is called
-- the "inverse image" of the function conv21.)  Thus, if conv21 t2 = t1, then
-- it should be that conv 12 t1 = Just t2. If there does not exist such a t2,
-- then conv12 t1 = Nothing. Do some examples on paper first so you can get a
-- sense of when this conversion is possible.
conv12 :: Tree a -> Maybe (Tree2 a)
conv12 = undefined


-- Binary Search Trees. Determine, by making only ONE PASS through a tree,
-- whether or not it's a Binary Search Tree, which means that for every
-- Node a t1 t2 in the tree, every element in t1 is strictly less than a and
-- every element in t2 is strictly greater than a. Complete this for both
-- Tree a and Tree2 a.

-- Hint: use a helper function that keeps track of the range of allowable
-- element values as you descend through the tree. For this, use the following
-- extended integers, which add negative and positvie infintiies to Int:

data ExtInt = NegInf | Fin Int | PosInf deriving Eq

instance Show ExtInt where
  show NegInf     = "-oo"
  show (Fin n) = show n
  show PosInf     = "+oo"

instance Ord ExtInt where
  compare NegInf  NegInf  = EQ
  compare NegInf  _       = LT
  compare (Fin n) (Fin m) = compare n m
  compare (Fin n) PosInf  = LT
  compare PosInf  PosInf  = EQ
  compare _       _       = GT
  -- Note: defining compare automatically defines <, <=, >, >=, ==, /=
  
bst :: Tree Int -> Bool
bst = undefined
    
bst2 :: Tree2 Int -> Bool
bst2 = undefined

