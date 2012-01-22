module CConverter

  def result_to_c(result)
    case result
    when Hash
      c_result = ""
      c_result << "static " if result[:static]
      c_result << result[:type].to_s
    when nil
      "void"
    else
      result.to_s
    end + " "
  end

  def arguments_to_c(params)
    argument_line = "("
    if params
      params = [params] unless params.is_a? Array
      argument_line << params.map do |param|
        argument = result_to_c(param)
        if param[:array]
          param[:array] = 1 unless param[:array].is_a?(Integer)
          argument << ('*' * param[:array])
        end
        argument << param[:name].to_s
      end.join(", ")
    end
    argument_line << ")"
  end

end