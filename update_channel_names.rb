require "uri"
require "net/http"
require 'csv'
require 'json'


class UpdateChannelNames

    attr_accessor :org, :load_file
    attr_reader :api_key

    def initialize(user_token, org_external, load_file_path)
        @api_key = user_token
        @org_id = org_external
        @load_file = load_file_path
    end 

    def make_request(channel_to_update, new_name)
        begin
        url = URI("https://app.salsify.com/api/orgs/#{@org_id}/channels/#{channel_to_update}?serialize_system_ids=true")

        https = Net::HTTP.new(url.host, url.port);
        https.use_ssl = true

        request = Net::HTTP::Put.new(url)
        request["Content-Type"] = "application/json"
        request["Authorization"] = "Bearer #{@api_key}"
        request.body = "{\"channel\": {\"name\": \"#{new_name}\"}}"

        response = https.request(request)
        puts response.read_body
        puts response.code
        
        rescue => e 
            puts "failed #{e}"
            nil
        end 
    end
    
    def file_run
        CSV.foreach(@load_file, headers: true).map { |row| 
            sleep(0.2)
            make_request(row[0], row[1])
        }
    end 

end 

test_call = UpdateChannelNames.new('e6b30f3b779693421e6cd013a782fbfc71332b3bb09bcba99bc9f06793941cd1', 's-ad7fef34-3bc9-4661-a9e1-c8af40c78ea2', 'input_files/channel_renaming.csv')
puts test_call.file_run