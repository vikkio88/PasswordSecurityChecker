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


require 'net/http'
require 'uri'

class Req
	def initialize(url=nil,post=nil)
		@url=URI.parse(url) if (url!=nil)
		@post=post if (post!=nil)
	end
	
	def get_html
		if (@post.nil?)
			#puts (Net::HTTP.get(@url)).to_s
			return (Net::HTTP.get(@url)).to_s
		else
			#puts (Net::HTTP.post_form(@url,@post)).body.to_s
			return (Net::HTTP.post_form(@url,@post)).body.to_s
		end
	end
	
	def to_s
		return "url: "+@url.to_s+" \npost: "+@post.to_s
	end
end
