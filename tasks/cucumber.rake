require "cucumber/rake/task"

Cucumber::Rake::Task.new "test:cucumber" do |t|
  t.fork = true
  t.cucumber_opts = "--format progress"
end

 task "cucumber" => ["test:cucumber"]
