require 'rubygems'
require 'jabbot'
require "rexml/document"
require 'net/http'
require 'open-uri'

configure do |conf|
  conf.login = "t3bot@jabber.ccc.de"
  conf.server = "conference.jabber.robertlemke.de"
  conf.channel = "t3px"
  conf.nick = "issuebot"
  conf.password = "aloha"
end

message /#([0-9]+)/ do |message, params|
    bugId = params[0]
    # post "http://forge.typo3.org/issues/#{bugId}"
    handle = open("http://forge.typo3.org/issues/#{bugId}.atom")
    doc = REXML::Document.new handle
	title = REXML::XPath.first( doc, "/feed/entry/title" ).text
    post "http://forge.typo3.org/issues/#{bugId} #{title}"
 end
