# LiveJournal API client

This is a clone of the original [livejournal](https://github.com/romanbsd/livejournal) gem. A few minor fixes 
and refactorings made. New functionality includes support for alternative 
servers compatible with LiveJournal API (e.g. Dreamwidth.org).

## How to use

Add to your `Gemfile`:

    gem "livejournal2"

(Please note you can require `livejournal`, or `livejournal2` - both will work).

## Example

    require 'livejournal'

    dreamwidth = LiveJournal::Server.new("Dreamwidth", "https://www.dreamwidth.org")
    user = LiveJournal::User.new('test', 'testkey', dreamwidth)
    login = LiveJournal::Request::Login.new(user)
    login.run

NOTE: For LiveJournal you use your actual password, but for Dreamwidth instead of 
password you need to provide an API key that can be generated here: https://www.dreamwidth.org/manage/emailpost

---

Original README below:

---

# ljrb: LiveJournal Ruby module

Copyright: Copyright (C) 2005 Evan Martin <martine@danga.com>

Website: http://neugierig.org/software/livejournal/ruby

Documentation: http://rubydoc.info/gems/livejournal/

Example usage:
    require 'livejournal/login'

    puts "Logging in..."
    user = LiveJournal::User.new('test', 'test')
    login = LiveJournal::Request::Login.new(user)
    login.run

    puts "Login response:"
    login.dumpresponse

    puts "User's full name: #{user.fullname}"

## LiveJournal Datatypes
* LiveJournal::Server
* LiveJournal::User
* LiveJournal::Entry
* LiveJournal::Comment
* LiveJournal::Friend

## Implemented Requests

### Login Requests
* LiveJournal::Request::Login

### Friend Requests
* LiveJournal::Request::Friends
* LiveJournal::Request::FriendOfs
* LiveJournal::Request::CheckFriends

### Entry Requests
* LiveJournal::Request::PostEvent
* LiveJournal::Request::GetEvents
* LiveJournal::Request::EditEvent

### Comments Requests
* Livejournal::Request::GetComments
* Livejournal::Request::GetRecentComments

## Journal Offline Synchronization
* LiveJournal::Sync::Entries
* LiveJournal::Sync::Comments
See samples/export for an example of how to use these.

## SQLite3 Support
* LiveJournal::Database -- storing/loading entries+comments with SQLite3
Integrates well with syncing.  See samples/export.

## Other Features
* LiveJournal::LogJam -- interface with LogJam (http://logjam.danga.com) 's
  journal exports.  (XXX currently broken)
