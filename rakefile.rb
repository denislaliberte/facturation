
desc 'Generate invoice'
task :generate do |task|
  puts :generate
  system('yaml-lint data/client-2016-05.yaml')
  system('mustache data/client-2016-05.yaml invoice.mustache | tee md/client-2016-05.md');
  system('pandoc md/client-2016-05.md -o pdf/client-2016-05.pdf')
  system('open pdf/client-2016-05.pdf')
end

desc 'Destroy generated documents'
task :destroy do |task|
  puts :destroy
  system('rm md/*')
  system('rm pdf/*')
end

desc 'list all task'
task :default do
  system('rake -T')
end
