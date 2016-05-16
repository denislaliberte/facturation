WORKSPACE = Dir.home + '/facturation'


desc 'Initialise home directory'
task :init do |task|
  if File.exist?(WORKSPACE)
    puts "#{WORKSPACE} already exist"
  else
    puts "Generate workspace #{WORKSPACE}"
    system("cp -r template #{WORKSPACE}")
  end
end

desc 'Create new invoice'
task :new, [:client] do |task, args|
  client = args[:client]
  date = Time.now.strftime("%d-%m-%Y")
  system("cp data/invoice-template.yaml data/invoices/#{client}-#{date}.yaml")
end

desc 'Generate invoice'
task :generate do |task|
  system('yaml-lint data/invoices')
  invoices_data = Rake::FileList["data/invoices/*.yaml"]
  invoices_data.each do |invoice_path|
    name = File.basename(invoice_path, '.yaml')
    pdf_path = "pdf/#{name}.pdf"
    if File.exist?(pdf_path)
      puts "#{name} already generated"
    else
      puts "#{name} generated"
      system("mustache #{invoice_path} invoice.mustache > md/#{name}.md");
      system("pandoc md/#{name}.md -o #{pdf_path}")
    end
  end
end

desc 'Destroy generated documents'
task :destroy do |task|
  puts :destroy
  system('rm md/*')
  system('rm pdf/*')
  system('rm data/invoices/*.yaml')
end

desc 'list all task'
task :default do
  system('rake -T')
end
