describe docker.version do
  its('Server.Version') { should cmp >= '1.12'}
  its('Client.Version') { should cmp >= '1.12'}
end
