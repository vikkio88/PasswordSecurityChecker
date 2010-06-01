# PasswordSecurityChecker
#
# copyleft by vikkio88 <vikkio88@yahoo.it>
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# visit: http://vikkio88.altervista.org
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# This file is part of PasswordSecurityChecker.
#

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
#search.rb
require "./util/req.rb"

def parseurl(unparsed,md5)
	if(unparsed.match(/%md5%/).to_a.empty?)
		return unparsed
	else
		return unparsed.gsub(/%md5%/,md5)
	end
end

def parsepost(unparsed,md5)
	if (!(unparsed.nil?)and(unparsed.class.to_s=="Hash"))
		unparsed.each_key do |key|
			if (!(unparsed[key].match(/%md5%/).to_a.empty?))
				unparsed[key]=unparsed[key].gsub(/%md5%/,md5)
			end
		end
		return unparsed #yeah but is parsed :D
	else
		return unparsed
	end
end

def str_to_h(unparsed)
	if (!(unparsed.nil?))
		parsed = {}
		unparsed.split(',').each do |substr|
			ary = substr.strip.split('=>')
			parsed[ary.first.tr('"','')] = ary.last.tr('"','')
		end
		return parsed
	else
		return unparsed
	end
end


class Search
	def initialize(name=nil,url=nil,regexp=nil,post=nil)
		@name=name
		@url=url
		#puts "regexp dentro il metodo"
		@regexp=regexp
		#puts @regexp
		@post=post
	end
	
	def result
		if (@post.nil?)
			request=Req.new(@url)
		else
			request=Req.new(@url,@post)
		end
	
		res=request.get_html
		notfound=res.match(@regexp)
		if (notfound.to_a.empty?)
			puts "Found your password on #{@name}!"
			return 1
		else
			puts "Your password is not on #{@name} DB!"
			return 0
		end
	end


end
