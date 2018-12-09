# JTEmail
A small Haskell library which makes sending email easier. This library is part of the JTHaskellLibrary collection.

## Getting started
The following instructions will show you how to incorporate this library into your git project using submodules. For more information about the functionality of submodules check out this [link](https://gist.github.com/gitaarik/8735255).

### Prerequisites/Dependencies
Depending on the modules you wish to use:

#### For JTEmail.SMTPSSLCom

    cabal install aeson
    cabal install HaskellNet-SSL

Optional, but recommended: [JTFileUtils](https://github.com/2079884FDavid/JTFileUtils)

#### For JTEmail.MetadataCom

    cabal install hostname

[JTHTML](https://github.com/2079884FDavid/JTHTML), [JTPrettyTime](https://github.com/2079884FDavid/JTPrettyTime).

### Add the library to your project
Scenario: You have an existing git project called `myproject`.

    myproject$ tree -aL 1
    .
    ├── .git
    └── Main.hs

    1 directory, 1 file

To add this library to your `myproject` simply run the following command at the root of your repository (or wherever you keep your source code). *If you have a libraries directory (such as "lib") specifically for your project run the command inside that directory instead.*

    myproject$ git submodule add https://github.com/2079884FDavid/JTEmail.git

To refer to the library from your source code simply use `import JTEmail.[module]`

### Update to latest library release
To update to the latest version of this library run the following commands inside your project.

    cd JTEmail
    git pull
    cd ..
    git add JTEmail
    git commit -m "Updated to latest JTEmail release"

### Checkout your repository
If your checking out your repository `myproject` from a remote origin you need to initalize the submodule(s) (i.e. this library) like this:

    git checkout https://myproject
    git submodule update --init

# Usage Examples

### JTEmail.SMTPSSLCom
You have a JSON file, `~/smtp_specs.json`, with all your connection specifications like this:

```json
{
  "url": "smtp.mailserver.com",
  "usr": "useraccount@mailserver.com",
  "password": "*****",
  "origin": "useraccount@mailserver.com",
  "dest": "myfriend@theirserver.com"
}
```

You can send an email to "myfriend" like this:

    JTEmail.SMTPSSLCom JTFileUtils.JSON> com <- loadJSON "/home/user/smtp_specs.json" :: IO SMTPSSLCom
    JTEmail.SMTPSSLCom JTFileUtils.JSON> sendMsg com "The subject" "Hi, I attached you a nice photo." [("photo", "pic2.jpeg")]

### JTEmail.MetadataCom
This adds additional metadata (definable suffix to subject. Hostname, local time, executable path, program name and program arguments are added to the email body) to messages send through this comunication interface. The metadata can be very useful for debugging automated emails.

```haskell
import JTEmail.SMTPSSLCom
import JTEmail.MetadataCom
import JTFileUtils.JSON

main = do
  com <- loadJSON "/home/user/smtp_specs.json" :: IO SMTPSSLCom
  let m = MetadataCom com "Automate message"
  sendMsg m "Subject" "Body" []
```

# Testing
At the moment there are **no** tests for this library. This is a todo item.

# Style Guide
All source lines of this library should be at most 70 characters long (which can be checked with grep). Moreover, [`hlint`](http://community.haskell.org/~ndm/darcs/hlint/hlint.htm) should be used to assure high quality of the code. Both of this can be done as show below.

    JTEmail$ cabal update
    JTEmail$ cabal install hlint
    JTEmail$
    JTEmail$ hlint .
    JTEmail$ grep -r --include \*.hs -n '.\{70\}' .

# Misc
Developer workflow and release management [as described](https://nvie.com/posts/a-successful-git-branching-model/) by Vincent Driessen.

Please check the [LICENSE](LICENSE) file for legal information.

Please get [in touch](http://www.jacktex.eu/about/contact.php) if you would like to contribute to this project.

### Version
v1.1
