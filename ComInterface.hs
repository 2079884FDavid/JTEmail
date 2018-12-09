module JTEmail.ComInterface
( ComInterface (..)
) where

class ComInterface a where
  sendMsg :: a                    -- Interface
          -> String               -- Subject
          -> String               -- Content (HTML)
          -> [(String, FilePath)] -- Attachements (name, path)
          -> IO ()                -- sending the message
