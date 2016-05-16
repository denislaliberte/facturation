
desc 'Generate invoice'
task :generate do |task|
  system('yaml-lint data/invoices')
  invoices_data = Rake::FileList["data/invoices/*.yaml"]
  invoices_data.each do |invoice_path|
    name = File.basename(invoice_path, '.yaml')
    puts "Generate invoice #{name}"
    system("mustache #{invoice_path} invoice.mustache | tee md/#{name}.md");
    system("pandoc md/#{name}.md -o pdf/#{name}.pdf")
    system("open pdf/#{name}.pdf")
  end
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
