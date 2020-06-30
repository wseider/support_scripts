require "uri" 
require "net/http"
require "json"
require "csv"

class auditAssets

    attr_accessor :org, :asset_size_limit, :dpi_limit
    attr_reader :api_key

def initialize(user_token, org_external, asset_size_limit*, dpi_limit*)
    @api_key = user_token
    @org_id = org_external
    @asset_size_limit = asset_size_limit
    @dpi_limit = dpi_limit
end

def call_detailed_assets

end 

def list_dpi_violators(asset_call_body)
#this might be a bit trickier.  need to grab and split first part of detail key, run dpi calc and output asset id
end 

def list_filesize_violators(asset_call_body)
#this should be easy, just split the "details": key at \n and grab the filesize, compare to defined limit, output asset id
end 

end 