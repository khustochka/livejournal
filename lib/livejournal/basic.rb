#!/usr/bin/ruby
#--
# ljrb -- LiveJournal Ruby module
# Copyright (c) 2005 Evan Martin <martine@danga.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#++

module LiveJournal
  # A LiveJournal server.  name is currently unused.
  class Server
    attr_accessor :name, :url

    def initialize(name, url)
      @name = name
      @url = url
    end

    def host
      uri.host
    end

    def port
      uri.port
    end

    def use_ssl
      uri.scheme == "https"
    end

    def ==(server)
      host == server.host
    end

    private
    def uri
      URI.parse(url)
    end
  end
  DEFAULT_SERVER = Server.new("LiveJournal.com", "http://www.livejournal.com")

  # A LiveJournal user.  Given a username, password, and server, running a
  # LiveJournal::Request::Login will fill in the other fields.
  class User
    # parameter when creating a User
    attr_accessor :username, :password, :server
    # Set usejournal to log in as user username but act as user usejournal.
    # For example, to work with a community you own.
    attr_accessor :usejournal
    # User's self-reported name, as retrieved by LiveJournal::Request::Login
    attr_accessor :fullname
    # Journals the user has posting access to
    attr_accessor :journals

    def initialize(username=nil, password=nil, server=nil)
      @username = username
      @password = password
      @usejournal = nil
      @server = server || LiveJournal::DEFAULT_SERVER
    end
    def journal
      @usejournal || @username
    end
    def to_s
      "#{@username}: '#{@fullname}'"
    end
    def canonical_journal_name
      journal.tr("_", "-")
    end
    def journal_url
      klass = server.use_ssl ? URI::HTTPS : URI::HTTP
      host = server.host.gsub(/^www\./, "")
      if journal[0] == "_"
        klass.build(host: "users.#{host}", port: server.port, path: "/" + canonical_journal_name).to_s
      else
        klass.build(host: "#{canonical_journal_name}.#{host}", port: server.port).to_s
      end
    end
  end
end

# vim: ts=2 sw=2 et :
