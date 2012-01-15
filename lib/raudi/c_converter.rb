module CConverter

  def result_to_c(result)
    case result
    when Hash
      c_result = ""
      c_result << "static " if result[:static]
      c_result << result[:type]
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

end