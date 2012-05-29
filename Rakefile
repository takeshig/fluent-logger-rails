require "bundler/gem_tasks"
require "benchmark"
require "rails"
require "fluent-logger-rails"

require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

task :benchmark do
  logger = FluentLoggerRails::Logger.new(:port => 24224, :host => "127.0.0.1", :appname => "rails3_test")
  puts "start"
  lines = %(
    Started GET "/" for 127.0.0.1 at 2012-05-28 13:22:33 +0800
Processing by HomeController#index as HTML
MONGODB (1ms) bitkey_dev['site_configs'].find({:key=>:suggest_categories}).limit(-1).sort([[:_id, :asc]])
  Rendered home/_base.html.erb (125.4ms)
MONGODB (0ms) bitkey_dev['site_configs'].find({:key=>:home_banner_data}).limit(-1).sort([[:_id, :asc]])
MONGODB (1ms) bitkey_dev['site_configs'].find({:key=>:home_sidebar_html}).limit(-1).sort([[:_id, :asc]])
MONGODB (3ms) bitkey_dev['system.namespaces'].find({})
MONGODB (1ms) bitkey_dev['task_categories'].find({:_id=>{"$in"=>[8, 9, 10]}})
MONGODB (4ms) bitkey_dev['system.namespaces'].find({})
MONGODB (4ms) bitkey_dev['topics'].find({:deleted_at=>nil, "task_category_id"=>8}).limit(5)
MONGODB (3ms) bitkey_dev['system.namespaces'].find({})
MONGODB (0ms) bitkey_dev['tasks'].find({:deleted_at=>nil, :state=>{"$in"=>["paid"]}, :topic_id=>221}, {:_id=>1}).limit(-1)
MONGODB (0ms) bitkey_dev['tasks'].find({:deleted_at=>nil, :state=>{"$in"=>["paid"]}, :topic_id=>222}, {:_id=>1}).limit(-1)
MONGODB (1ms) bitkey_dev['tasks'].find({:deleted_at=>nil, :state=>{"$in"=>["paid"]}, :topic_id=>223}, {:_id=>1}).limit(-1)
MONGODB (2ms) bitkey_dev['tasks'].find({:deleted_at=>nil, :state=>{"$in"=>["paid"]}, :topic_id=>224}, {:_id=>1}).limit(-1)
  Rendered app/cells/home/task_category_suggest_tasks.html.erb (16.2ms)
MONGODB [DEBUG] Cursor#close 782484846871735974
MONGODB (7ms) bitkey_dev['topics'].find({:deleted_at=>nil, "task_category_id"=>9}).limit(5)
MONGODB (0ms) bitkey_dev['tasks'].find({:deleted_at=>nil, :state=>{"$in"=>["paid"]}, :topic_id=>225}, {:_id=>1}).limit(-1)
MONGODB (1ms) bitkey_dev['tasks'].find({:deleted_at=>nil, :state=>{"$in"=>["paid"]}, :topic_id=>226}, {:_id=>1}).limit(-1)
MONGODB (1ms) bitkey_dev['tasks'].find({:deleted_at=>nil, :state=>{"$in"=>["paid"]}, :topic_id=>226}).limit(8).sort([["_id", :desc]])
MONGODB (0ms) bitkey_dev['tasks'].find({:deleted_at=>nil, :state=>{"$in"=>["paid"]}, :topic_id=>227}, {:_id=>1}).limit(-1)
MONGODB (0ms) bitkey_dev['tasks'].find({:deleted_at=>nil, :state=>{"$in"=>["paid"]}, :topic_id=>228}, {:_id=>1}).limit(-1)
MONGODB (1ms) bitkey_dev['tasks'].find({:deleted_at=>nil, :state=>{"$in"=>["paid"]}, :topic_id=>229}, {:_id=>1}).limit(-1)
  Rendered app/cells/home/task_category_suggest_tasks.html.erb (38.0ms)
MONGODB (1ms) bitkey_dev['topics'].find({:deleted_at=>nil, "task_category_id"=>10}).limit(5)
MONGODB (0ms) bitkey_dev['tasks'].find({:deleted_at=>nil, :state=>{"$in"=>["paid"]}, :topic_id=>231}, {:_id=>1}).limit(-1)
MONGODB (0ms) bitkey_dev['tasks'].find({:deleted_at=>nil, :state=>{"$in"=>["paid"]}, :topic_id=>232}, {:_id=>1}).limit(-1)
MONGODB (0ms) bitkey_dev['tasks'].find({:deleted_at=>nil, :state=>{"$in"=>["paid"]}, :topic_id=>233}, {:_id=>1}).limit(-1)
  Rendered app/cells/home/task_category_suggest_tasks.html.erb (5.2ms)
  Rendered home/index.html.erb within layouts/application_without_sidebar (399.7ms)
  Rendered layouts/_html_head.html.erb (285.7ms)
  Rendered layouts/_side_nav.html.erb (0.9ms)
  Rendered app/cells/common/user_bar.html.erb (7.6ms)
  Rendered layouts/_notice_center.html.erb (0.5ms)
  Rendered layouts/_header.html.erb (72.1ms)
  Rendered layouts/_sitemap.html.erb (0.3ms)
MONGODB (0ms) bitkey_dev['site_configs'].find({:key=>:footer_html}).limit(-1).sort([[:_id, :asc]])
  Rendered layouts/_footer.html.erb (3.8ms)
  Rendered layouts/_application_js.html.erb (0.9ms)
Completed 200 OK in 909ms (Views: 849.1ms | Solr: 0.0ms)).split("\n")
  Benchmark.bm do|bm|
    bm.report("1 times") do
      1.times do
        lines.each do |line|
          logger.add(1,line)
        end
      end
    end

    bm.report("100 times") do
      100.times do
        lines.each do |line|
          logger.add(1,line)
        end
      end
    end

    bm.report("1000 times") do
      1000.times do
        lines.each do |line|
          logger.add(1,line)
        end
      end
    end
  end
end

