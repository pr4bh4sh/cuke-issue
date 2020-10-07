#!/usr/bin/env ruby

require 'cuke_linter'
require_relative '../custom_rules/use_and_linter'
class RubyGherkinLint
  def run(files)
    files    = ['features'] if files.empty?
    offences = CukeLinter.lint(file_paths: files, linters: [UseAndLinter.new], formatters: [[CukeLinter::PrettyFormatter.new]])
    offences
  end
end

if $PROGRAM_NAME == __FILE__
  RubyGherkinLint.new.run(ARGV)
end
