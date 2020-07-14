require 'uri'
require 'net/http'
require 'csv'

class DeleteLists
  attr_accessor :org, :load_file
  attr_reader :api_key

  def initialize(user_token, org_external, load_file_path, superuser_org_id = nil)
    @api_key = user_token
    @org_id = org_external
    @load_file = load_file_path
    @superuser_org_id = superuser_org_id
  end

  def make_request(list_to_delete)
    url = URI("https://app.salsify.com/api/orgs/#{@org_id}/lists/#{list_to_delete}")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Delete.new(url)
    request['Content-Type'] = 'application/json'
    request['Authorization'] = "Bearer #{@api_key}"
    if @superuser_org_id != nil 
      request['x-auth-organization-ID'] = "#{@superuser_org_id}"
    else nil 
end 

    response = https.request(request)
    puts response.read_body
    puts response.code
  rescue StandardError => e
    puts "failed #{e}"
    nil
  end

  def file_run
    CSV.foreach(@load_file, headers: true).map do |row|
      sleep(0.2)
      make_request(row[0])
    end
  end
end

user_token = ARGV[0]
org_external = ARGV[1]
load_file_path = ARGV[2]
optional_superuser_org = ARGV[3]
test_call = DeleteLists.new(user_token, org_external, load_file_path, optional_superuser_org)
puts test_call.file_run