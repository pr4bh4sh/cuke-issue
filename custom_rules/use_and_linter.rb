require 'cuke_linter'
class UseAndLinter < CukeLinter::Linter

  def message
    "Step '#{@current_keyword} #{@current_step}' should use 'And' instead of '#{@current_keyword}'"
  end

  def rule(model)

    # INFO: resetting value of previous_keyword as the linter class object is created only once
    @previous_keyword = nil if [CukeModeler::Scenario, CukeModeler::Outline].include?(model.class)

    return false unless model.is_a?(CukeModeler::Step)
    @current_keyword = model.keyword
    @current_step    = model.text

    first_or_and      = @previous_keyword.nil? || @current_keyword =~ /^(And|But|\*)$/
    same              = @previous_keyword == @current_keyword
    @previous_keyword = @current_keyword
    return false if first_or_and

    same
  end
end
