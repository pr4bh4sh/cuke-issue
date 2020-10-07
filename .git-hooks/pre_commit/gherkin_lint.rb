require 'overcommit/hook/base'
require_relative '../../util/ruby_gherkin_lint'
module Overcommit::Hook::PreCommit
  class GherkinLint < Base
    def run
      messages = []
      result   = RubyGherkinLint.new.run(applicable_files)

      result.each do |error|
        file, line = error[:location].split(':')
        msg        = "#{file}:#{line} #{error[:problem]}"
        messages << Overcommit::Hook::Message.new(:error, file, line, msg)
      end
      messages
    end
  end
end