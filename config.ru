require './config/environment'
require_all './app/models/helpers'


if ActiveRecord::Migrator.needs_migration?
  raise "Migrations are pending. Run 'rake db:migrate' to resolve the issue."
end

use Rack::MethodOverride
run ApplicationController
use SessionsController
use JobsController
use UsersController
use NotesController
use AppliedController
use MyJobsController

run Sinatra::Application
