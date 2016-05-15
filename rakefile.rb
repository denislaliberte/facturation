
desc 'Generate invoice'
task :generate do |task|
  puts :generate
end

desc 'list all task'
task :default do
  system('rake -T')
end
