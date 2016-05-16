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
  system("cp #{WORKSPACE}/data/invoice-template.yaml #{WORKSPACE}/data/invoices/#{client}-#{date}.yaml")
end

desc 'Generate invoice'
task :generate do |task|
  system("yaml-lint #{WORKSPACE}/data/invoices")
  invoices_data = Rake::FileList[WORKSPACE + "/data/invoices/*.yaml"]
  invoices_data.each do |invoice_path|
    name = File.basename(invoice_path, '.yaml')
    pdf_path = "#{WORKSPACE}/pdf/#{name}.pdf"
    md_path = "#{WORKSPACE}/md/#{name}.md"
    if File.exist?(pdf_path)
      puts "#{name} already generated"
    else
      puts "#{name} generated"
      system("mustache #{invoice_path} #{WORKSPACE}/invoice.mustache > #{md_path}");
      system("pandoc #{md_path} -o #{pdf_path}")
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
