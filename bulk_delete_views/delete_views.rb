require "uri"
require "net/http"
require 'csv'
require 'json'

class DeleteViews

    attr_accessor :org, :load_file
    attr_reader :api_key

    def initialize(user_token, org_external, load_file_path)
        @api_key = user_token
        @org_id = org_external
        @load_file = load_file_path
    end 

    def make_request(view_to_delete)
        begin
        url = URI("https://app.salsify.com/api/orgs/#{@org_id}/perspectives/#{view_to_delete}")

        https = Net::HTTP.new(url.host, url.port);
        https.use_ssl = true

        request = Net::HTTP::Delete.new(url)
        request["Content-Type"] = "application/json"
        request["Authorization"] = "Bearer #{@api_key}"

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
            make_request(row[0])
        }
    end 

end 

test_call = DeleteViews.new('<api_key>', '<org_id>', '<input_file>')
puts test_call.file_run