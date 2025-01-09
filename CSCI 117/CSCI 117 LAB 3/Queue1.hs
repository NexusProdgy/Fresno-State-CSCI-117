module Queue1 (Queue, mtq, ismt, addq, remq) where

---- Interface ----------------
mtq  :: Queue a                  -- empty queue
ismt :: Queue a -> Bool          -- is the queue empty?
addq :: a -> Queue a -> Queue a  -- add element to front of queue
remq :: Queue a -> (a, Queue a)  -- remove element from back of queue;
                                 --   produces error "Can't remove an element
                                 --   from an empty queue" on empty

---- Implementation -----------

{- In this implementation, a queue is represented as an ordinary list.
The "front" of the queue is at the head of the list, and the "back" of
the queue is at the end of the list.
-}

data Queue a = Queue1 [a]  deriving Show

mtq = Queue1 []
ismt (Queue1 xs) = null xs
addq x (Queue1 xs) = Queue1 (x:xs)
remq (Queue1 xs) | ismt (Queue1 xs) = error "No element left to remove"
                 | otherwise = let (y,ys) = split xs in (y,Queue1 ys)
				 
split [x] = (x,[])
split (x:xs) = (y, x:ys) where (y,ys) = split xs

{-
ghci> ismt (Queue1 [])
True
ghci> ismt (Queue1 [1])
False
ghci> ismt (Queue1 [1..8])
False

ghci> addq 3 mtq
Queue1 [3]
ghci> a = addq 7 (Queue1 [1..6])
ghci> a
Queue1 [7,1,2,3,4,5,6]
ghci> b = addq 8 a
ghci> b
Queue1 [8,7,1,2,3,4,5,6]
ghci>
ghci> (x,a) = remq (Queue1 [2..8])
ghci>
ghci> (x,a)
(8,Queue1 [2,3,4,5,6,7])
-}