require 'yaml'

module YAML
  
  def self.load_config_file(path)
    process_yaml = lambda do |node|
      case node
      when String
        node.split
      when Hash
        new_node = {}
        node.each do |key, child|
          new_node[key] = process_yaml.call(child)
        end
        new_node
      else
        node
      end
    end

    process_yaml.call(load_file(path))
  end

end