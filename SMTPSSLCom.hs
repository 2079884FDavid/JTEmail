{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
module JTEmail.SMTPSSLCom
( SMTPSSLCom (..)
, sendMsg
) where

import JTEmail.ComInterface

import Data.Aeson
import qualified Data.Text as T
import qualified Data.Text.Lazy as L
import GHC.Generics
import Network.HaskellNet.SMTP.SSL

data SMTPSSLCom =
  SMTPSSLCom { url      :: String -- SMTP Server address
             , usr      :: String -- Authentication user
             , password :: String -- Authentication password
             , origin   :: String -- Originating email address
             , dest     :: String -- Destination email address
             } deriving (Generic)

instance FromJSON SMTPSSLCom

instance ComInterface SMTPSSLCom where
  sendMsg specs s b xs =
    sendMsg' specs s (L.pack b) ys
    where
      ys = map (\(x, p) -> (T.pack x, p)) xs

sendMsg' :: SMTPSSLCom 
         -> String 
         -> L.Text 
         -> [(T.Text, FilePath)] 
         -> IO ()
sendMsg' specs sub body xs =
  doSMTPSSL (url specs) f 
  where
    f conn = do 
      auth <- authenticate LOGIN u p conn
      if auth
        then
          sendMimeMail d o sub body body xs conn
        else
          fail "SMTP authentication failed."
    u = usr specs
    p = password specs
    o = origin specs
    d = dest specs
