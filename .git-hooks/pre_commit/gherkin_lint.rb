require 'overcommit/hook/base'
require_relative '../../util/ruby_gherkin_lint'
module Overcommit::Hook::PreCommit
  class GherkinLint < Base
    def run
      messages = []
      result   = RubyGherkinLint.new.run(applicable_files)

      result.each do |error|
        file, line = error[:location].split(':')
        messages << Overcommit::Hook::Message.new(:error, file, line, error[:problem])
      end
      messages
    end
  end
end