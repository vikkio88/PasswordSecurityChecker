#! /usr/bin/env ruby

# PasswordSecurityChecker
#
# copyleft by vikkio88 <vikkio88@yahoo.it>
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# visit: http://vikkio88.altervista.org
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.

# This script search your password in those md5cracker
# and at the end do a report of this search.

#   md5.hashcracking.com GET DONE
#	http://hashcrack.hellospace.net/collisione/ GET DONE
#	http://www.xmd5.org/md5/getpass.asp?info=MD5 GET DISABLED chinese >.<
#	http://md5crack.com/crackmd5.php POST DONE
#   md5decryption.com POST DONE
#   blacklight.gotdns.org POST DONE
#   www.bigtrapeze.com/md5/ POST DONE
#   opencrack.hashkiller.com POST DONE
#	http://www.md5cracker.altervista.org/search.php?hash= GET DONE

#MULTI SEARCHER:
# http://server4234234.ho.am/v2.5/md5decrypter.php POST disabled...bad HTML


require 'digest/md5'
require './util/search.rb'
require './util/rainbowdb.rb'

tot=0
if (ARGV[0]=="--update")
	puts 
	puts "**********************************"
	puts "* Password Security check        *"
	puts "* by vikkio88                    *"
	puts "* http://vikkio88.altervista.org *"
	puts "**********************************"
	puts
	puts "Seraching for update:"
	remoterev=Req.new("http://vikkio88.altervista.org/passwordcheck/rev.conf").get_html
	minerev=File.new("./data/rev.conf","r")
	minerev=minerev.gets.chomp
	if (remoterev.to_i>minerev.to_i)
		puts "Your HashCracker DB is up to date!"
		puts "~~downloading the updated one ~~>"
		newdb=Req.new("http://vikkio88.altervista.org/passwordcheck/rainbowdb.txt").get_html
		lines=newdb.split("\n")
		temp=File.new("./data/rainbowdb.txt","w")
		lines.each do |line|
			temp.puts line
		end
		temp=File.new("./data/rev.conf","w")
		temp.puts(remoterev)
		temp.close
		puts "Your HashCracker DB is now updated!..."
		puts
	else
		puts "Your HashCracker DB is updated!..."
		puts
	end
elsif (!(ARGV.empty?))
	md5=Digest::MD5.hexdigest(ARGV[0])
	puts 
	puts "**********************************"
	puts "* Password Security check        *"
	puts "* by vikkio88                    *"
	puts "* http://vikkio88.altervista.org *"
	puts "**********************************"
	puts 
	puts "Your password md5 is this: ~~> "+md5
	puts "****************************************"
	puts "Starting searching:"
	puts
	db=Rainbowdb.new("./data/rainbowdb.txt")
	db.getRainbow.each do |hash|
		search=Search.new(hash["name"],parseurl(hash["url"],md5),hash["regexp"],parsepost(str_to_h(hash["post"]),md5))
		tot+=search.result
	end
	num=db.getRainbow.size
	puts "********End of searching******"
	puts
	puts "Final report:"
	puts "______________"
	puts "I search your password simple hash on #{num} search engine"
	puts "I found your password in #{tot} rainbow tables around web"
	puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	insec=(tot.to_f/num.to_f)*100
	puts "YourPassword Insecurity is ~ #{insec.to_i}%"
	if (insec.to_i>65)
		puts "	I suggest to change immediatly your password!"
	elsif (insec.to_i==0)
		puts "	NoOne know your password! congratulation!"
	else
		puts "	Your password isn't the weakest ever, but is a little insecure...change-it!"
	end
	puts "bye!"
	puts
else
	puts "Error no password ARG passed... =(!"
	puts "	usage: ruby #{$0} password"
end
