if vim.fn.filereadable('config/routes.rb') == 1 then -- This looks like a Rails project.
  vim.g.projectionist_heuristics = {
    ['config/routes.rb'] = {
      ['app/views/*.json.jbuilder'] = {
        type = 'builder',
        alternate = 'app/controllers/{dirname}_controller.rb',
      },
      ['app/controllers/*_controller.rb'] = {
        type = 'controller',
        alternate = 'app/models/{singular}.rb',
      },
      ['app/jobs/*_job.rb'] = {
        type = 'job',
        alternate = 'test/jobs/{}_job_test.rb',
      },
      ['app/services/*.rb'] = {
        type = 'service',
        alternate = 'test/services/{}_test.rb',
      },
      ['app/helpers/*_helper.rb'] = {
        type = 'helper',
        alternate = 'app/controllers/{}_controller.rb',
      },
      ['config/initializers/*.rb'] = {
        type = 'initializer',
      },
      ['app/javascript/*.js'] = {
        type = 'javascript',
      },
      ['app/models/*.rb'] = {
        type = 'model',
        alternate = 'app/controllers/{plural}_controller.rb',
      },
      ['app/workers/*.rb'] = {
        type = 'worker',
        alternate = 'test/workers/{}_test.rb',
      },
      ['app/graphql/types/*_type.rb'] = {
        type = 'type',
      },
      ['app/graphql/mutations/*.rb'] = {
        type = 'mutation',
      },
      ['app/javascript/stylesheets/*.scss'] = {
        type = 'stylesheets',
      },
      ['spec/*.rb'] = {
        type = 'spec',
      },
      ['app/views/*.html.erb'] = {
        type = 'view',
        alternate = 'app/controllers/{dirname}_controller.rb',
      },
    },
  }
elseif vim.fn.filereadable('src/App.js') == 1 then -- This looks like a React project.
  vim.g.projectionist_heuristics = {
    ['src/App.js'] = {
      ['src/components/*.js'] = {
        type = 'component',
        alternate = 'src/__tests__/components/{}.test.js',
      },
      ['src/__tests__/components/*.test.js'] = {
        type = 'test',
        alternate = 'src/components/{}.js',
      },
      ['src/styles/*.css'] = {
        type = 'stylesheet',
        alternate = 'src/components/{}.js',
      },
    },
  }
end
