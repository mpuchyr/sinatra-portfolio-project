require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

User.all.each {|user| user.destroy}
Lego.all.each {|lego| lego.destroy}

use Rack::MethodOverride
run ApplicationController
use UserController
use LegoController
