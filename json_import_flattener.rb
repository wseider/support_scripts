require 'json'
require 'pry'

class FileFun 

  MAPPINGS = {}

  def initialize(input_file)
    @input_file = input_file
  end 

def transform 
products = JSON.parse(File.read(@input_file))["products"]
transformed = products.map do |product|
  product.each_with_object({}) do |(key, value), hash|
    if key == 'oe_number'
      hash.merge!({
                    'oe_number': value.map { |v| v['oe_number'] },
                    'oem_name': value.map { |i| i['oem_name'] }
                  })
      elsif key == 'competitor_numbers'
        hash.merge!({
            'competitor_number': value.map { |v| v['competitor_number'] },
            'competitor_name': value.map { |i| i['competitor_name'] }
          })
    else
      new_key = MAPPINGS[key] ? MAPPINGS[key] : key
      hash.merge!({new_key => value})
    end
  end
end
end 

def file_write
File.write('updated_zf_import.json', transform.to_json)
end 
end 

run = FileFun.new('/Users/willseider/Downloads/output_file_S-4100 (2).json')
run.file_write