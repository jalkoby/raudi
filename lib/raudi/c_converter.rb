module CConverter

  def result_to_c(result)
    case result
    when Hash
      c_result = ""
      c_result << "static " if result[:static]
      c_result << result[:type].to_s
      if result[:array]
        result[:array] = 1 unless result[:array].is_a?(Integer)
        c_result << ("*" * result[:array])
      end
      c_result
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
      argument_line << params.map{|param| result_to_c(param) + param[:name]}.join(", ")
    end
    argument_line << ")"
  end

end