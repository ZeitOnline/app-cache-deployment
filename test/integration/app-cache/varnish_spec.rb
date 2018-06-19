# encoding: utf-8
# author: Ron Drongowski

describe package('varnish') do
  it { should be_installed }
end

describe processes('varnishd') do
  its('list.length') { should eq 2 }
  its('commands') { should include a_string_matching("-a :8080") }
end
