module JTEmail.MetadataCom
( MetadataCom (..)
, sendMsg
) where

import JTEmail.ComInterface
import JTHTML.Tables
import JTHTML.Tags
import qualified JTPrettyTime.Fetch as Time

import Network.HostName
import System.Environment

data MetadataCom a = MetadataCom a String

instance (ComInterface a) => ComInterface (MetadataCom a) where
  sendMsg (MetadataCom c suf) s b xs = do
    mb <- addMetadata b
    sendMsg c ms mb xs
    where
      ms = s++" - "++suf

addMetadata :: String -> IO String
addMetadata s = do
  host <- getHostName
  curTime <- Time.getCurrentLocalIso8601
  path <- getExecutablePath
  prog <- getProgName
  args <- show <$> getArgs
  let t = toTable [] [["Sent from:", host],
                      ["Local time:", curTime],
                      ["Executable path:", path],
                      ["Program name:", prog],
                      ["Arguments:", args]]
  return (s++"<br>"++tagItem "i" t)
