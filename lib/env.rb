require File.join(File.dirname(__FILE__), 'env_all')

$env.merge!({
    :couchdb_url => 'http://localhost:5984/markupmorphic_test',
    :web_port => 4001,
    :site_root => 'http://localhost:4001/'
})