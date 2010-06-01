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

class Array
  def to_h(key_definition)
    result_hash = Hash.new()
    
    counter = 0
    key_definition.each do |definition|
      if not self[counter] == nil then
        result_hash[definition] = self[counter].to_s.strip
      else
        # Insert the key definition with a empty value.
        # Because we probably still want the hash to contain the key.
        result_hash[definition] = nil
      end
      # For some reason counter.next didn't work here....
      counter = counter + 1
    end
    
    return result_hash
  end
end

class Rainbowdb
def initialize(name)
	@filename=name
end

def getRainbow
	if(File.exist?(@filename))
		ourdb=File.new(@filename,"r")
		hash=Hash.new
		keys=Array["name","url","regexp","post"]
		hashes=Array.new()
		ourdb.each_line do |linea|
			attr=linea.to_s.split("$$")
			hash=attr.to_h(keys)
			hashes.push(hash)
		end
		return hashes
	else
		return -1
	end
end

end
