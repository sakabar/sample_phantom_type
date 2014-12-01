{-# LANGUAGE GADTs #-}
module Main where
import Prelude hiding (head, tail, foldr)

-- 自然数のような構造を持った型であることを表す型クラス
-- ここも、拡張によってクラスの中身がなくていい?
class Nat n where

data Zero
data Succ n

instance Nat Zero where
instance Nat n => Nat (Succ n) where

data SafeList n a where
  Nil  :: SafeList Zero a
  Cons :: Nat n => a -> SafeList n a -> SafeList (Succ n) a

head :: Nat n => SafeList (Succ n) a -> a
head (Cons x _) = x

tail :: Nat n => SafeList (Succ n) a -> SafeList n a
tail (Cons _ xs) = xs

main = do
  print $ head (Cons "hoge" Nil)
  --print $ head (Cons "hoge" Nil) --この行をアンコメントするとコンパイルエラー
  --print $ head (tail (Cons "hoge" Nil)) --この行をアンコメントするとコンパイルエラー
