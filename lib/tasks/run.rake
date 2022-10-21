namespace :run do
    desc "run application"
    task run_application: :environment do
        menu = Menu.new
        menu.run
    end
end