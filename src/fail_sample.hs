data PhantomType x a = PhantomType a

-- なぜか、ブログの通りのコードだとコンパイルエラーになってくれる
-- main = do
--   print $ head []
--   print $ tail []

empty :: [Int]
empty = []
main = do
  print $ head empty
  print $ tail empty
