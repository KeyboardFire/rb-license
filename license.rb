#!/usr/bin/env ruby

USAGE_MSG = 'Usage: license [MIT|GPL|Apache] [your name (if not configured in ~/.rb-license)]'

conf_file = File.expand_path '~/.rb-license'
ARGV.push open(conf_file).read.chomp if File.exists? conf_file
abort USAGE_MSG if ARGV.length < 2
args = [ARGV.shift, ARGV.join(' ')]
ARGV.clear

txt = case args[0].downcase
      when 'mit' then <<-HEREDOC
          The MIT License (MIT)

          Copyright (c) {YEAR} {NAME}

          Permission is hereby granted, free of charge, to any person obtaining a copy
          of this software and associated documentation files (the "Software"), to deal
          in the Software without restriction, including without limitation the rights
          to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
          copies of the Software, and to permit persons to whom the Software is
          furnished to do so, subject to the following conditions:

          The above copyright notice and this permission notice shall be included in all
          copies or substantial portions of the Software.

          THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
          IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
          FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
          AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
          LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
          OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
          SOFTWARE.
          HEREDOC
      when 'gpl' then <<-HEREDOC
          Copyright (C) {YEAR}  {NAME}

          This program is free software; you can redistribute it and/or modify
          it under the terms of the GNU General Public License as published by
          the Free Software Foundation; either version 2 of the License, or
          (at your option) any later version.

          This program is distributed in the hope that it will be useful,
          but WITHOUT ANY WARRANTY; without even the implied warranty of
          MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
          GNU General Public License for more details.

          You should have received a copy of the GNU General Public License along
          with this program; if not, write to the Free Software Foundation, Inc.,
          51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
          HEREDOC
      when 'apache' then <<-HEREDOC
          Copyright {YEAR} {NAME}

          Licensed under the Apache License, Version 2.0 (the "License");
          you may not use this file except in compliance with the License.
          You may obtain a copy of the License at

              http://www.apache.org/licenses/LICENSE-2.0

          Unless required by applicable law or agreed to in writing, software
          distributed under the License is distributed on an "AS IS" BASIS,
          WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
          See the License for the specific language governing permissions and
          limitations under the License.
          HEREDOC
      else abort USAGE_MSG
      end.gsub('{YEAR}', Time.new.year.to_s).gsub('{NAME}', args[1])
txt.gsub! /^#{txt[/\A\s*/]}/, ''  # kill indentation

if File.exists? 'LICENSE'
    print 'File LICENSE already exists. Overwrite? [yn] '
    loop {
        case gets
        when /^y/i then break
        when /^n/i then exit
        else print 'Please answer y or n. '
        end
    }
end

File.open 'LICENSE', 'w' do |f|
    f.puts txt
end
