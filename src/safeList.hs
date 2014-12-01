{-# LANGUAGE ExistentialQuantification #-}
module Main where
import Prelude hiding (head)

-- 右辺がないデータ型(幽霊型、Empty Data Decls)
data Empty
data NonEmpty

-- 型安全なリストの定義
-- ブログの記述だと、deriving(Show)でこける
-- と思ったら、修正版の記事だとderiving(Show)がなくなっていた
-- data SafeList x a = forall y. Cons a (SafeList y a)
--                               | Nil deriving(Show)

-- data Show a => SafeList x a where
--   show :: a -> String

data SafeList x a = forall y. Cons a (SafeList y a)
                            | Nil

-- SafeListをShowクラスに入れたい
-- かつ、aはShowクラスに属するという制約を入れたい
-- と思ったけど、いらなそう

-- 補助関数を定義
nil :: SafeList Empty a
nil = Nil

cons :: a -> SafeList x a -> SafeList NonEmpty a
cons x xs = Cons x xs


head :: SafeList NonEmpty a -> a
head (Cons x _) = x

main :: IO()
main = do
  print $ head (cons "hoge" nil) --これはコンパイルできる
--  print $ head nil --この行をアンコメントするとコンパイルエラー
